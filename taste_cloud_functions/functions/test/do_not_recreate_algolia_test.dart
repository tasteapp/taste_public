import 'utilities.dart';

void main() {
  group('do-not-recreate-algolia', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('only one record', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      Future countIs1() async {
        expect(
            await waitForEquals(
                1,
                () async => (await CollectionType.algolia_records.coll.get())
                    .documents
                    .length),
            isTrue);
      }

      Future countIsNotNot1() async {
        expect(
            await waitFor(
                () async =>
                    (await CollectionType.algolia_records.coll.get())
                        .documents
                        .length !=
                    1,
                const Duration(seconds: 10)),
            isFalse);
      }

      await countIs1();
      await countIsNotNot1();
      await user.updateSelf({
        'vanity': {'username': 'asdfasdfasd'}
      });
      await countIs1();
      await countIsNotNot1();
      final record = await first(CollectionType.algolia_records.coll);
      expect(record.data.getNestedData('payload').getString('username'),
          equals('asdfasdfasd'));
    });
  });
}
