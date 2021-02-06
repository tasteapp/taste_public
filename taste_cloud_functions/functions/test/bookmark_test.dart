import 'utilities.dart';

void main() {
  group('bookmarkTest', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('Bookmark notification', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      expect(await user.notifications, isEmpty);
      final bookmark = await fixture.bookmark(await fixture.otherUser);
      expect(
          await bookmark.referencesToUpdate,
          equals([
            (await fixture.review).ref,
            (await fixture.otherUser).ref,
          ]));
      expect(
          await waitForEquals(1, () async => (await user.notifications).length),
          isTrue);
    });
  });
}
