import 'utilities.dart';

void main() {
  group('favorites', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('add and remove favorites', () async {
      final fixture = Fixture();
      final restaurant = await fixture.restaurant;
      final user = await fixture.user;
      Future countIs(int count) async =>
          expect(await restaurant.numFavorites, equals(count));

      await countIs(0);

      expect(await restaurant.hasFavorite(user), isFalse);
      expect(await restaurant.favorites, isEmpty);
      expect(await restaurant.favorites, isEmpty);
      final favorite = await user.favorite(restaurant, true);
      expect(await favorite.restaurant, equals(restaurant));
      expect(await favorite.user, equals(user));
      expect(await user.favorites, equals([restaurant]));
      expect(await restaurant.favorites, equals([user]));
      expect(await restaurant.hasFavorite(user), isTrue);
      await countIs(1);
      expect(
          () => user.favorite(restaurant, true), throwsA(isA<ArgumentError>()));

      expect(await user.favorites, equals([restaurant]));
      expect(await restaurant.favorites, equals([user]));
      expect(await restaurant.hasFavorite(user), isTrue);
      await countIs(1);
      await favorite.deleteSelf();
      expect(await user.favorites, isEmpty);
      expect(await restaurant.favorites, isEmpty);
      expect(await restaurant.hasFavorite(user), isFalse);
      await countIs(0);
    });
  });
}
