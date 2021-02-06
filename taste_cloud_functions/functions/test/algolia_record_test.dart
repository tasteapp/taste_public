import 'package:taste_protos/gen/algolia.pbenum.dart';
import 'package:taste_protos/taste_protos.dart' show DiscoverReviewRecord;

import 'utilities.dart';

void main() {
  group('algolia-record', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('delete', () async {
      final user = await Fixture().user;
      await eventually(AlgoliaRecords.get, isNotEmpty);
      await user.deleteSelf();
      await eventually(AlgoliaRecords.get, isEmpty);
    });
    test('review', () async {
      final fixture = Fixture();
      final photo = await fixture.photo;
      final restoLoc = GeoPoint(1, 2);
      final resto = await fixture.createRestaurant(
          location: restoLoc, restoName: 'super-duper-resto-name');
      final reviewLoc = LatLng(3, 4);
      final user = await fixture.user;
      final review = await fixture.createReview(
          location: reviewLoc,
          restaurant: resto,
          emojis: {'🥪', '🇬🇷'},
          photo: photo,
          dish: 'super-dish-name',
          text: 'some-cool🍝 asdfasdfas🍆asdfasdfas🍆',
          attributes: {'burger'});
      await eventually(
          () async => (await AlgoliaRecords.get(
                  queryFn: (q) =>
                      q.where('index', isEqualTo: AlgoliaIndex.reviews.name)))
              .firstOrNull
              ?.proto
              ?.location
              ?.geoPoint,
          GeoPoint(1, 2),
          message: (i) => i,
          duration: const Duration(minutes: 1));
      await eventually(
          () async => (await AlgoliaRecords.get(
                  queryFn: (q) => q.where('record_type',
                      isEqualTo: AlgoliaRecordType.review_discover.name)))
              .firstOrNull
              ?.proto
              ?.payload
              ?.asMap
              ?.ensureAs(DiscoverReviewRecord()),
          {
            'display_text':
                '🥪 🇬🇷 💡burger some-cool🍝 asdfasdfas🍆asdfasdfas🍆',
            'review': review.ref,
            'user': user.name,
            'user_photo': user.thumbnail,
            'dish': 'super-dish-name',
            'restaurant_name': 'super-duper-resto-name',
            'photo': photo.firebaseStoragePath,
            'search_text': 'sandwich greece spaghetti eggplant',
          },
          message: (i) => i,
          duration: const Duration(minutes: 1));
    });

    test('update cache', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final restaurant = await fixture.restaurant;
      final review = await fixture.review;
      Future scoreIs(int score) async {
        expect(
            await waitForEquals(
                score, () async => (await review.refetch).score),
            isTrue);
      }

      await scoreIs(200);
      expect(
          (await (await restaurant.refetch).restaurantMarkerPayload).asJson,
          equals({
            'name': anything,
            'num_favorites': 0,
            'top_review': {
              'user': {'thumbnail': startsWith('http')},
              'photo': 'fakepath',
              'score': 200,
            },
            'reviewers': [user.path],
            'reviews': [
              {
                'reference': {
                  'path': review.path,
                },
                'user': {'path': user.path},
                'photo': 'fakepath',
                'user_photo': startsWith('http'),
                'score': 200,
              }
            ]
          }));
      final algoliaRecordSnapshot = await first(CollectionType
          .algolia_records.coll
          .where('payload.top_review.score', isGreaterThan: 0));
      expect(algoliaRecordSnapshot, isNotNull);
      final record = AlgoliaRecords.make(algoliaRecordSnapshot, quickTrans);
      expect(
          record.algoliaJSON,
          equals({
            '_geoloc': {'lat': 2, 'lng': 3},
            '_tags': ['restaurant_marker'],
            'objectID': 'restaurant_marker ${restaurant.path}',
            'record_type': 'restaurant_marker',
            'reference': restaurant.path,
            'num_favorites': 0,
            'name': anything,
            'top_review': {
              'user': {'thumbnail': startsWith('http')},
              'photo': 'fakepath',
              'score': 200,
            },
            'reviewers': [user.path],
            'reviews': [
              {
                'reference': {
                  'path': review.path,
                },
                'user': {'path': user.path},
                'photo': 'fakepath',
                'user_photo': startsWith('http'),
                'score': 200,
              }
            ]
          }));
    });
  });
}
