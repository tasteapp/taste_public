import 'utilities.dart';

void main() {
  group('update-notifications', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    /// We want to make sure the updated-at field of a comment notification
    /// doesn't change when someone likes the comment.
    test('update-notifications', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final review = await fixture.review;
      final comment =
          await fixture.comment(await fixture.createUser(), review: review);
      await eventually(() => user.notifications, isNotEmpty);
      final notification = (await user.notifications).first;
      final updatedAt = notification.updatedAt;
      expect(updatedAt, notification.createdAt);
      await comment.like(user, true);
      expect(
          await waitForEquals(
              updatedAt, () async => (await notification.refetch).updatedAt,
              earlyExit: false),
          isTrue);
    });
  });
}
