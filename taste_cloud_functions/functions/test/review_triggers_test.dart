import 'utilities.dart';

void main() {
  group('review-triggers', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('review_marker AlgoliaRecord', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      await user.updateSelf({
        'vanity': {'username': 'cool-username'}
      });
      final review = await fixture.review;
      final restaurant = await fixture.restaurant;
      final record = await first(CollectionType.algolia_records.coll
          .where('index', isEqualTo: 'reviews'));
      expect(record, isNotNull);
      expect(
          record.data.toMap(),
          equals({
            'index': 'reviews',
            'object_id': 'review_marker ${review.path}',
            'record_type': 'review_marker',
            'tags': ['review_marker'],
            'reference': review.ref,
            'payload': {
              'emojis': review.emojis.toList(),
              'reaction': 'up',
              'photo': 'fakepath',
              'restaurant_name': restaurant.name,
              'restaurant_ref': restaurant.ref,
              'restaurant_counts': {
                'love': 0,
                'down': 0,
                'up': 1,
                'favorite': 0
              },
              'score': 0,
              'dish': review.dish,
              'text': 'great',
              'user': user.ref,
              'user_photo': 'http://test-user-photo',
              'username': 'cool-username',
              'user_display_name': user.name,
            },
            'location': GeoPoint(2, 3),
            '_extras': anything,
          }));
    });
  });
}
