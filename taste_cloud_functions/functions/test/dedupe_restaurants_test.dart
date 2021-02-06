import 'utilities.dart';

void main() {
  group('dedupe-restaurant', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    Future<Restaurant> createRestaurant(Fixture fixture, String name) async {
      final resto =
          await fixture.createRestaurant(restoName: name, fbPlaceId: name);
      await resto.updateSelf({'attributes.google_place_id': 'a'},
          changeUpdatedAt: false);
      return resto;
    }

    Future restoHasValidCounts(Restaurant restaurant, int ups) async =>
        expect(await waitForEquals(ups, () => restaurant.numUps), isTrue);

    test('Simple Dedupe Test', () async {
      final fixture = Fixture();

      final resto1 = await createRestaurant(fixture, 'a');
      final resto2 = await createRestaurant(fixture, 'b');
      for (final resto in [resto1, resto1, resto2]) {
        await fixture.createReview(restaurant: resto);
      }

      await restoHasValidCounts(resto1, 2);
      await restoHasValidCounts(resto2, 1);

      await dedupe();

      expect((await resto1.reviews).length, equals(3));
      expect((await resto2.reviews).length, equals(0));

      expect((await resto2.ref.get()).exists, isFalse);

      expect((await resto1.refetch).proto.attributes.allFbPlaceIds,
          containsExactly(['a', 'b']));

      await (await resto1.reviews).futureMap((r) async {
        expect(await r.restaurant, equals(resto1));
        expect(r.restaurantLocation, equals(resto1.geoPoint));
      });
    });

    test('Favorites Dedupe Test', () async {
      final fixture = Fixture();

      final resto1 = await createRestaurant(fixture, 'resto1');
      final resto2 = await createRestaurant(fixture, 'resto2');

      final user1 = await fixture.newUser;
      final user2 = await fixture.newUser;
      final user3 = await fixture.newUser;
      for (final pair in [
        [resto1, user1],
        [resto1, user2],
        [resto2, user3]
      ]) {
        await fixture.createReview(
          restaurant: pair[0] as Restaurant,
          user: pair[1] as TasteUser,
          photo: await fixture.createPhoto(photoUser: pair[1] as TasteUser),
        );
      }

      await restoHasValidCounts(resto1, 2);
      await restoHasValidCounts(resto2, 1);

      await fixture.favorite(user1, resto1);
      await fixture.favorite(user1, resto2);
      await fixture.favorite(user2, resto2);
      Future<List<List>> favorites() async =>
          await (await resto1.wrapQuery(Favorites.collection, Favorites.make))
              .futureMap((f) async => [await f.restaurant, await f.user]);

      expect(
          await favorites(),
          containsExactly([
            [resto1, user1],
            [resto2, user1],
            [resto2, user2],
          ]));

      await dedupe();

      expect(
          await favorites(),
          containsExactly([
            [resto1, user1],
            [resto1, user2],
          ]));
    });

    test('Favorites No Reviews Test', () async {
      final fixture = Fixture();

      final resto1 = await createRestaurant(fixture, 'resto1');
      final resto2 = await createRestaurant(fixture, 'resto2');
      final resto3 = await createRestaurant(fixture, 'resto3');

      final user1 = await fixture.newUser;
      final user2 = await fixture.newUser;
      final user3 = await fixture.newUser;

      await fixture.favorite(user1, resto1);
      await fixture.favorite(user2, resto2);
      await fixture.favorite(user3, resto3);

      Future<List<List>> favorites() async =>
          await (await resto1.wrapQuery(Favorites.collection, Favorites.make))
              .futureMap((f) async => [await f.restaurant, await f.user]);

      expect(
          await favorites(),
          containsExactly([
            [resto1, user1],
            [resto2, user2],
            [resto3, user3],
          ]));

      await dedupe();
      expect((await CollectionType.restaurants.coll.get()).documents,
          hasLength(1));

      expect(
          await favorites(),
          containsExactly([
            [resto1, user1],
            [resto1, user2],
            [resto1, user3],
          ]));
    });
  });
}

Future dedupe() => autoBatch(batchDedupeRestos);
