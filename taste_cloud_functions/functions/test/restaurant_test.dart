import 'utilities.dart';

void main() {
  group('restaurant', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    Restaurant restaurant;
    Fixture fixture;
    setUp(() async {
      fixture = Fixture();
      restaurant = await fixture.restaurant;
    });

    test('update reviews directly', () async {
      final review = await fixture.review;
      await restaurant.updateSelf({
        'attributes': {'location': GeoPoint(5, 6)}
      });
      restaurant = await restaurant.refetch;
      await review.restaurantWasUpdated(restaurant);
      expect((await review.refetch).restaurantLocation, equals(GeoPoint(5, 6)));
    });

    test('update review cache', () async {
      await fixture.createReview();
      await fixture.createReview();
      expect((await Reviews.get()), isNotEmpty);
      Future locationsAreRestaurant() async {
        expect(restaurant.geoPoint, isNotNull);
        await (await Reviews.get()).futureMap((review) async => expect(
            await waitForEquals(restaurant.geoPoint,
                () async => (await review.refetch).restaurantLocation),
            isTrue));
      }

      await locationsAreRestaurant();
      final newPoint = GeoPoint(0.12, .23);
      await restaurant.updateSelf({
        'attributes': {'location': newPoint}
      });
      restaurant = await restaurant.refetch;
      expect(restaurant.geoPoint, equals(newPoint));
      await locationsAreRestaurant();
    });

    test('update-review-counts', () async {
      await fixture.createReview();
      await fixture.createReview();
      expect(
          await waitForEquals(2, () async => (await restaurant.reviews).length),
          isTrue);
      expect(await restaurant.numUps, equals(2));
    });
  });
}
