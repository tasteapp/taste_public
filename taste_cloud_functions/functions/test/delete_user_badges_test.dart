import 'utilities.dart';

void main() {
  group('deleteUserBadgesTest', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('delete user badges', () async {
      final user = await Fixture().user;
      await updateBadges();
      expect((await CollectionType.badges.coll.get()).documents, isNotEmpty);
      await user.deleteSelf();
      expect(
          await waitForEquals(
              0,
              () async =>
                  (await CollectionType.badges.coll.get()).documents.length),
          isTrue);
    });
  });
}
