import 'utilities.dart';

void main() {
  group('discover', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('discover', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final otherUser = await fixture.otherUser;
      final review = await fixture.createReview(
          mealMate: otherUser,
          attributes: {'chicken salad'},
          emojis: {'🥪', '#delivery'});
      expect(await first(DiscoverItems.collection), isNotNull);
      final discover = (await DiscoverItems.get()).first;
      expect(discover.proto.asMap, {
        'awards': {},
        'reference': review.ref,
        'restaurant': {
          'reference': (await fixture.restaurant).ref,
          'name': 'resto',
          'address': {
            'city': 'Cool City',
            'state': 'Cool State',
            'country': 'United States'
          }
        },
        'review': {
          'text': '🥪 #delivery 💡chicken-salad great',
          'raw_text': 'great',
          'emojis': ['🥪', '#delivery'],
          'attributes': ['chicken salad'],
          'delivery_app': 'UNDEFINED',
          'reaction': 'up',
          'meal_mates': {
            'meal_mates': [
              {
                'reference': otherUser.ref,
              }
            ]
          }
        },
        'user': {
          'reference': user.ref,
          'name': 'fakeusername',
          'photo': 'http://test-user-photo'
        },
        'date': anything,
        'meal_type': 'meal_type_restaurant',
        'location': GeoPoint(2, 3),
        'dish': anything,
        'photo': anything,
        'fire_photos': [isNotEmpty],
        'freeze_place': false,
        'is_instagram_post': false,
        'tags': ['chicken-salad', '🥪', 'delivery'],
      });
      expect(discover.proto.reference.ref, equals(review.ref));
      expect(discover.proto.comments, isEmpty);
      final comment = await fixture.comment(user, review: review);
      await eventually(
          () async => (await discover.refetch).proto.comments, hasLength(1),
          message: (c) => c, duration: const Duration(seconds: 45));
      await comment.updateSelf({'text': 'discover-test-text'});
      expect(
          await waitForEquals('discover-test-text',
              () async => (await discover.refetch).proto.comments.first.text),
          isTrue);
      await comment.deleteSelf();
      expect(
          await waitForEquals(
              0, () async => (await discover.refetch).proto.comments.length),
          isTrue);
      expect(await DiscoverItems.get(), hasLength(1));
      await review.deleteSelf();
      expect(
          await waitForEquals(
              0, () async => (await DiscoverItems.get()).length),
          isTrue);
    });
  });
}
