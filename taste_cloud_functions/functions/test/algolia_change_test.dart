import 'utilities.dart';

void main() {
  group('algolia change', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('algolia change', () async {
      final rec = await AlgoliaRecords.createNew(quickTrans);
      Future countIs(int count, {bool stays = false}) async {
        expect(
            await waitForEquals(
                count, () async => (await testAlgoliaMessages()).length),
            isTrue);
        if (stays) {
          expect(
              await waitFor(
                  () async => (await testAlgoliaMessages()).length != count,
                  const Duration(seconds: 5)),
              isFalse);
        }
      }

      await countIs(1);
      await rec.updateSelf({
        'location': {'latitude': .12, 'longitude': 42},
      });
      await countIs(2);
      await rec.updateSelf({
        'location': {'latitude': .12, 'longitude': 42},
        '_ignore': '2',
      });
      await countIs(2, stays: true);
      await rec.updateSelf({
        'payload': {'newfield': .12},
      });
      await countIs(3);
    });
  });
}
