import 'utilities.dart';

void main() {
  group('restaurant-counts', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('restaurant-counts', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final restaurant = await fixture.restaurant;
      final otherRestaurant = await fixture.createRestaurant(restoName: 'junk');
      await fixture.createReview(reaction: Reaction.down);
      await fixture.createReview(reaction: Reaction.up);
      await fixture.createReview(reaction: Reaction.up);
      // unrelated
      await fixture.createReview(
          restaurant: otherRestaurant, reaction: Reaction.up);

      await user.favorite(restaurant, true);
      await (await fixture.otherUser).favorite(restaurant, true);
      // unrelated.
      await user.favorite(otherRestaurant, true);
      expect(
          (await restaurant.counts).asMap,
          equals({
            'down': 1,
            'up': 2,
            'love': 0,
            'favorite': 2,
          }));
    });
  });
}
