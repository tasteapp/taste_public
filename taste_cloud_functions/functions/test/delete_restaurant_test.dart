import 'utilities.dart';

void main() {
  group('delete-restaurant', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('delete restaurant algolia', () async {
      final restaurant = await Fixture().restaurant;
      final query = CollectionType.algolia_records.coll
          .where('reference', isEqualTo: restaurant.ref);
      expect(
          await waitForEquals(
              2, () async => (await query.get()).documents.length),
          isTrue);
      await restaurant.deleteSelf();
      expect(
          await waitForEquals(
              0, () async => (await query.get()).documents.length),
          isTrue);
    });
  });
}
