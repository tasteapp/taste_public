import 'utilities.dart';

void main() {
  group('update-self', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('update self', () async {
      final user = await Fixture().user;
      await user.updateSelf({
        'd': {'a': 1}
      }, changeUpdatedAt: false);
      await user.updateSelf({
        'd': {'b': 2}
      }, changeUpdatedAt: true);
      expect((await user.refetch).data.getNestedData('d').toMap(),
          equals({'a': 1, 'b': 2}));
    });
  });
}
