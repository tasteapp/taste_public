import 'dart:math';

import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

class IgInfo {
  const IgInfo(this.likes, this.numFollowers);
  final int likes;
  final int numFollowers;
}

class _RestaurantInfo {
  _RestaurantInfo._(
      this.restoPath,
      this.foodTypes,
      this.numGmReviews,
      this.gmAvg,
      this.numYelpReviews,
      this.yelpAvg,
      this.numReviews,
      this.numVisibleReviews,
      this.igInfo,
      this.photoStorage,
      this.photoReference,
      this.photoHeight,
      this.photoWidth);
  static _RestaurantInfo parse(List<String> s) => _RestaurantInfo._(
      s[0],
      s[1].isNotEmpty ? s[1].split(',') : [],
      int.parse(s[2]),
      double.parse(s[3]),
      int.parse(s[4]),
      double.parse(s[5]),
      int.parse(s[6]),
      int.parse(s[7]),
      parseIgInfos(s[8]),
      s[9],
      s[10],
      int.parse(s[11]),
      int.parse(s[12]));

  static List<IgInfo> parseIgInfos(String info) {
    final infos = info?.split(',')?.withoutEmpties ?? [];
    return infos
        .map((i) =>
            IgInfo(int.parse(i.split('|')[0]), int.parse(i.split('|')[1])))
        .toList();
  }

  final String restoPath;
  final List<String> foodTypes;
  final int numGmReviews;
  final double gmAvg;
  final int numYelpReviews;
  final double yelpAvg;
  final int numReviews;
  final int numVisibleReviews;
  final List<IgInfo> igInfo;
  final String photoStorage;
  final String photoReference;
  final int photoHeight;
  final int photoWidth;
}

Future updateRestaurantInfo(BatchedTransaction transaction) async {
  final restaurantFoodTypes = await tasteBQStreaming('''
  select
    restaurant,
    IFNULL(food_types, ''),
    num_gm_reviews,
    gm_avg,
    num_yelp_reviews,
    yelp_avg,
    IFNULL(num_reviews, 0),
    IFNULL(num_visible_reviews, 0),
    IFNULL(ig_info, ''),
    IF(photo is not null and photo.firebase_storage is not null, photo.firebase_storage, '') as photo_storage,
    IF(photo is not null and photo.photo_reference is not null, photo.photo_reference, '') as photo_reference,
    IF(photo is not null and photo.photo_size.height is not null, photo.photo_size.height, -1) as photo_height,
    IF(photo is not null and photo.photo_size.width is not null, photo.photo_size.width, -1) as photo_width,
  from (
    select
      restaurant,
      num_gm_reviews,
      gm_avg,
      num_yelp_reviews,
      yelp_avg,
      num_reviews,
      num_visible_reviews,
      ARRAY_TO_STRING(ig_info, ',', '') as ig_info,
      ARRAY_TO_STRING(ARRAY(select distinct e from unnest(food_types) e order by e), ',', '') as food_types,
      IF(ARRAY_LENGTH(photo) > 0, photo[OFFSET(0)], null) as photo
    from (
      select
        a.path as restaurant,
        a.num_gm_reviews as num_gm_reviews,
        a.gm_avg as gm_avg,
        a.num_yelp_reviews as num_yelp_reviews,
        a.yelp_avg as yelp_avg,
        a.original_food_types as original_food_types,
        b.num_reviews as num_reviews,
        b.num_visible_reviews as num_visible_reviews,
        b.ig_info as ig_info,
        ARRAY(select p.fire_photo from UNNEST(photos) as p order by p.score desc) as photo,
        ARRAY_CONCAT(b.food_types) as food_types,
      from (
        select
          _path as path,
          IF(google.num_reviews is not null, google.num_reviews, 0) as num_gm_reviews,
          IF(google.avg_rating is not null, google.avg_rating, 0) as gm_avg,
          IF(yelp.num_reviews is not null, yelp.num_reviews, 0) as num_yelp_reviews,
          IF(yelp.avg_rating is not null, yelp.avg_rating, 0) as yelp_avg,
          ARRAY_TO_STRING(ARRAY(select distinct e from unnest(attributes.food_types) e order by e), ',', '') as original_food_types,
        from `FIREBASE_PROD_PROJECT.firestore_export.restaurants`
        where not scores_up_to_date or (num_reviews > 0 and top_review_pic.firebase_storage is null)
      ) a
      left join (
        select
          restaurant,
          ARRAY_AGG(
            IF(
              num_insta_likes is null
              or num_insta_followers is null
              or num_insta_likes = 0
              or num_insta_followers = 0,
              '',
              CONCAT(cast(num_insta_likes as string), '|', cast(num_insta_followers as string))
            )
          ) as ig_info,
          ARRAY_CONCAT_AGG(food_types) as food_types,
          count(*) as num_reviews,
          countif(not hidden) as num_visible_reviews,
          ARRAY_AGG(STRUCT(fire_photos[OFFSET(0)] as fire_photo, score)) as photos,
        from `FIREBASE_PROD_PROJECT.firestore_export.reviews`
        where ARRAY_LENGTH(fire_photos) > 0
        group by restaurant
      ) b
      on a.path = b.restaurant
      limit 50000
    )
  )''', _RestaurantInfo.parse);
  print('Updating ${restaurantFoodTypes.length} restos...');
  await restaurantFoodTypes.futureMap((r) async {
    final updates = <String, dynamic>{
      'attributes.food_types':
          r.foodTypes.isNotEmpty ? r.foodTypes : Firestore.fieldValues.delete(),
      'num_reviews': r.numReviews,
      'num_visible_reviews': r.numVisibleReviews,
    };
    final gmScore = ratingScore(r.gmAvg, r.numGmReviews);
    final yelpScore = ratingScore(r.yelpAvg, r.numYelpReviews);
    if (gmScore > 0 && yelpScore > 0) {
      updates['gm_yelp_score'] = 0.8 * gmScore + yelpScore;
    } else if (gmScore > 0 || yelpScore > 0) {
      updates['gm_yelp_score'] = 1.8 * (gmScore > 0 ? gmScore : yelpScore);
    }
    if (r.igInfo.isNotEmpty) {
      final numPosts = r.igInfo.length;
      final totalLikes = r.igInfo.map((x) => x.likes).sum;
      final totalFollowers = r.igInfo.map((x) => x.numFollowers).sum;
      final igScore = sqrt(numPosts) *
          (totalFollowers == 0
              ? 1
              : totalLikes / (log(totalFollowers) / log(2)));
      updates['instagram_score'] = igScore;
      updates['total_ig_likes'] = totalLikes;
      updates['total_ig_followers'] = totalFollowers;
    }
    updates['num_ig_posts'] = r.igInfo.length;
    updates['scores_up_to_date'] = true;
    if (r.photoStorage.isNotEmpty &&
        r.photoReference.isNotEmpty &&
        r.photoHeight > 0 &&
        r.photoWidth > 0) {
      final size = $pb.Size()
        ..height = r.photoHeight
        ..width = r.photoWidth;
      final photo = $pb.FirePhoto()
        ..firebaseStorage = r.photoStorage
        ..photoReference = r.photoReference.ref.proto
        ..photoSize = size;
      updates['top_review_pic'] = photo.asMap;
    }
    await transaction.update(r.restoPath.ref, UpdateData.fromMap(updates));
  });
}

Future updateRestaurantPlaceTypes(BatchedTransaction transaction) async {
  final results = (await tasteBQStreaming('''
      SELECT a.category_list, a.path, b.*
      FROM (
        SELECT _path path,
            ARRAY_TO_STRING(attributes.categories, ',', '') category_list
        FROM `firestore_export.restaurants`
        WHERE NOT attributes.place_types_set) a
      LEFT JOIN `views.resto_place_types` b
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
  print('updateRestaurantPlaceTypes found ${results.length} new restos to '
      'update.');
  await results.futureMap((t) async {
    await transaction.update(
        t.item1.ref,
        {
          'attributes': {
            'place_types': t.item2,
            'place_type_scores': t.item3,
            'place_types_set': true,
          }
        }.ensureAs($pb.Restaurant()).updateData);
  });
}

final batchUpdateRestaurantInfo = tasteFunctions.pubsub
    .schedule('every 24 hours')
    .onRun((message, context) => autoBatch(updateRestaurantInfo));

final batchUpdateRestaurantPlaceTypes = tasteFunctions.pubsub
    .schedule('every 24 hours')
    .onRun((message, context) => autoBatch(updateRestaurantPlaceTypes));

void register() {
  registerFunction('batchUpdateRestaurantInfo', batchUpdateRestaurantInfo,
      batchUpdateRestaurantInfo);
  registerFunction('batchUpdateRestaurantPlaceTypes',
      batchUpdateRestaurantPlaceTypes, batchUpdateRestaurantPlaceTypes);
}
