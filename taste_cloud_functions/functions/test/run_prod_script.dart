import 'dart:math';

import 'package:crypto/crypto.dart';

/// Run `make run-prod-script` to run this code against prod environment.
import 'package:taste_protos/taste_protos.dart' as $pb;
import 'utilities.dart';

void main() async {
  CloudTransformProvider.initialize();
  await setRestoPlaceTypes();
}

Future resetPlaceTypesSet() async {
  final restoRefs = await tasteBQStreaming('''
      SELECT _path
      FROM `firestore_export.restaurants`
      WHERE yelp_match
  ''', (row) => row[0].ref);
  print('Num restos: ${restoRefs.length}');
  var i = 0;
  for (final chunk in restoRefs.chunk(500)) {
    await autoBatch((t) async {
      await chunk.futureMap((ref) async {
        await t.update(ref, {'attributes.place_types_set': false}.updateData);
      });
    });
    i += 1;
    print('Updated batch $i of ${restoRefs.length / 500}');
  }
}

Future fixRestoNumReviews() async {
  final restoRefs = await tasteBQStreaming('''
      SELECT a.resto_ref ref, IFNULL(b.num_reviews, 0) num_reviews
      FROM (
        SELECT _path resto_ref, num_reviews 
        FROM `firestore_export.restaurants`
        WHERE scores_up_to_date
      ) a
      LEFT JOIN (
        SELECT restaurant, COUNT(*) num_reviews
        FROM `firestore_export.reviews`
        GROUP BY 1
      ) b
      ON a.resto_ref = b.restaurant
      WHERE a.num_reviews > b.num_reviews
  ''', (row) => Tuple2(row[0].ref, int.parse(row[1])));
  print('Num bad reviews: ${restoRefs.length}');
  var i = 0;
  for (final chunk in restoRefs.chunk(500)) {
    await autoBatch((t) async {
      await chunk.futureMap((tuple) async {
        final ref = tuple.item1;
        final numReviews = tuple.item2;
        await t.update(ref, {'num_reviews': numReviews}.updateData);
      });
    });
    i += 1;
    print('Updated batch $i of ${restoRefs.length / 500}');
  }
}

Future batchUpdateRestoSpatialIndex() async {
  final restos = (await tasteBQStreaming('''
      SELECT _path, attributes.location.latitude, attributes.location.longitude
      FROM `firestore_export.restaurants`
      WHERE spatial_index.levels IS NULL
      LIMIT 30000
  ''',
      (row) => Tuple3(row[0].ref, double.parse(row[1]), double.parse(row[2]))));
  var i = 0;
  for (final chunk in restos.chunk(500)) {
    await autoBatch((t) async {
      await chunk.futureMap((tuple) async {
        final restoRef = tuple.item1;
        final point = GeoPoint(tuple.item2, tuple.item3);
        await t.update(
          restoRef,
          {'spatial_index': getSpatialIndex(point).asJson}.updateData,
        );
      });
    });
    i += 1;
    print('Updated ${i * 500} of ${restos.length}');
  }
}

Future setRestoPlaceTypes() async {
  final results = (await tasteBQStreaming('''
      SELECT a.category_list, a.path, b.*
      FROM (
        SELECT _path path,
            ARRAY_TO_STRING(attributes.categories, ',', '') category_list
        FROM `firestore_export.restaurants`
        WHERE NOT attributes.place_types_set) a
      LEFT JOIN `views.resto_place_types_materialized` b
      ON a.path = b.place
      LIMIT 30000
    ''', (row) {
    final placeTypes =
        (row[0] ?? '').split(',').map(toPlaceType).withoutNulls.toList();
    final placeTypeScores = placeTypes.map((_) => 1.0).toList();
    final indexOffset = 2; // First enum value of PlaceType (1) is at index 3.
    final restoRefPath = row[1];
    if (row[2] == null) {
      return Tuple3(restoRefPath, placeTypes, placeTypeScores);
    }
    final scrapedPlaceTypeAndScores = <Tuple2<$pb.PlaceType, double>>[];
    for (var i = 1; i < $pb.PlaceType.values.length; i++) {
      final score = double.parse(row[i + indexOffset]);
      if (score > 0) {
        scrapedPlaceTypeAndScores.add(Tuple2($pb.PlaceType.valueOf(i), score));
      }
    }
    scrapedPlaceTypeAndScores
        .tupleSort((t) => [t.item2], desc: true)
        .take(10)
        .forEach((placeTypeAndScore) {
      if (placeTypes.contains(placeTypeAndScore.item1)) {
        return;
      }
      placeTypes.add(placeTypeAndScore.item1);
      placeTypeScores.add(placeTypeAndScore.item2);
    });
    return Tuple3(restoRefPath, placeTypes, placeTypeScores);
  }));
  print('num results: ${results.length}');
  var i = 0;
  final chunks = results.chunk(500);
  for (final chunk in chunks) {
    await autoBatch(
      (transaction) => chunk.futureMap((t) async {
        await transaction.update(
            t.item1.ref,
            {
              'attributes': {
                'place_types': t.item2,
                'place_type_scores': t.item3,
                'place_types_set': true,
              }
            }.ensureAs($pb.Restaurant()).updateData);
      }),
    );
    i += 500;
    print('Updated $i of ${results.length}');
    await 1.seconds.wait;
  }
}

Future backfillShowOnDiscoverFeed() async {
  final items = (await CollectionType.discover_items.coll
          .where('hidden', isEqualTo: false)
          .select(['is_instagram_post', 'meal_type']).get())
      .documents;
  final chunks = items.chunk(200);
  for (final chunkEntry in chunks.enumerate) {
    await autoBatch(
      (transaction) => chunkEntry.value.futureMap(
        (item) async {
          final data = item.data.toMap();
          final showOnFeed = data['meal_type'] != 'meal_type_home' ||
              !(data['is_instagram_post'] as bool);
          transaction.update(
              item.reference, {'show_on_discover_feed': showOnFeed}.updateData);
        },
      ),
    );
    await 1.seconds.wait;
    print('committed batch ${chunkEntry.key + 1} of ${chunks.length}');
  }
}

Future setUserPostsStartingLocation() async {
  return await autoBatch((t) async => (await tasteBQ(
          '''
          SELECT username, lat, lng
          FROM 
          `$projectId.firestore_export.user_posts_starting_location`
        ''',
          (x) => {
                'username': x[0],
                'location': GeoPoint(
                  double.parse(x[1]),
                  double.parse(x[2]),
                )
              }.asProto($pb.UserPostsStartingLocation())))
      .sideEffect((t) =>
          print('num docs: ${t.length}, sample: ${t.first.toDebugString()}'))
      .futureMap((e) async => t.set(
          // Use a hash of the username to ensure we don't create duplicate
          // records for multiple usernames. We can't use usernames since they
          // could potentially have characters not allowed by Firestore as key.
          CollectionType.user_posts_starting_locations.coll
              .document(md5.convert(utf8.encode(e.username)).toString()),
          e.documentData)));
}

Future forceUpdateIGLocations() async {
  final chunks = (await tasteBQ(
    // Get all InstaPost paths that are user uploaded and have food/drink.
    '''
      SELECT _path
      FROM `firestore_export.insta_posts` ip
      CROSS JOIN UNNEST(ip.images) AS images
      WHERE NOT hidden
        AND images.is_food_or_drink
        AND ip.fb_location.fb_place_id IS NULL
        AND ip.instagram_location.found_match IS NULL
      GROUP BY 1
    ''',
    (paths) => paths.map((path) => path.ref),
  ))
      .map((row) => row.first)
      .chunk(90);
  for (final chunkEntry in chunks.enumerate) {
    final chunk = chunkEntry.value;
    await autoBatch(
      (transaction) => chunk.futureMap(
        (post) async => transaction.update(
          post,
          {
            'instagram_location._force_update':
                DateTime.now().millisecondsSinceEpoch
          }.updateData,
        ),
      ),
    );
    print('committed batch ${chunkEntry.key + 1} of ${chunks.length}');
    await 5.minutes.wait;
  }
}

// Old InstaPosts imported through user sign-in didn't have `hidden` field set
// to false.
Future fixHidden() async {
  final posts = (await CollectionType.insta_posts.coll.select(['hidden']).get())
      .documents;
  final nonScrapedPosts =
      posts.where((p) => !(p.data.getBool('hidden') ?? false));
  final chunks = nonScrapedPosts.chunk(100);
  for (final chunkEntry in chunks.enumerate) {
    await autoBatch(
      (transaction) => chunkEntry.value.futureMap(
        (post) async =>
            transaction.update(post.reference, {'hidden': false}.updateData),
      ),
    );
    await 1.seconds.wait;
    print('committed batch ${chunkEntry.key + 1} of ${chunks.length}');
  }
}

// Goog scraper had a bug where it'd set avg rating to inf.
Future fixGoogScraperOutput() async {
  final infRatingRestos = (await CollectionType.restaurants.coll
          .where('google.avg_rating', isEqualTo: 1.0 / 0.0)
          .select([]).get())
      .documents;
  final badRatingRestos = (await CollectionType.restaurants.coll
          .where('google.avg_rating', isGreaterThan: 5.0)
          .select([]).get())
      .documents;
  final restosToFix = infRatingRestos + badRatingRestos;
  print('${restosToFix.length} restos to fix...');
  var i = 0;
  for (final resto in restosToFix) {
    final placePath =
        resto.reference.path.replaceAll('restaurants', 'google_places');
    final reviews = (await firestore
        .collection('google_reviews')
        .where('place', isEqualTo: firestore.document(placePath))
        .select(['rating']).get());
    var ratingSum = 0;
    reviews.documents.forEach((d) {
      ratingSum += int.parse(d.data.toMap()['rating'].toString());
    });
    await resto.reference.updateData(
        {'google.avg_rating': ratingSum / reviews.documents.length}.updateData);
    i += 1;
    if (i % 50 == 0) {
      print('fixed $i of ${restosToFix.length}...');
    }
  }
}

//Update collections and fields before using
Future addFieldToAll() async {
  CloudTransformProvider.initialize();
  final items = (await CollectionType.restaurants.coll
          .where('delivery_scraped', isEqualTo: true)
          .get())
      .documents;
  final chunks = items.chunk(500);
  for (final chunkEntry in chunks.enumerate) {
    await autoBatch(
      (transaction) => chunkEntry.value.futureMap(
        (item) async {
          transaction.update(
              item.reference, {'delivery_scraped': false}.updateData);
        },
      ),
    );
    await 2.seconds.wait;
    print('committed batch ${chunkEntry.key + 1} of ${chunks.length}');
  }
}
