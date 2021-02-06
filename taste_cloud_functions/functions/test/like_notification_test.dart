import 'utilities.dart';

void main() {
  group('like-notification', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('like-notification', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final otherUser = await fixture.createUser(name: 'Big Liker');
      final comment = await fixture.reviewComment;
      expect(await user.notifications, isEmpty);
      await fixture.like(otherUser, comment);
      await eventually(
          () async =>
              (await user.notifications).map((e) => [e.title, e.body]).toList(),
          [
            ['Comment Liked', 'Your comment was just liked by Big Liker']
          ],
          message: (t) => t);
      await fixture.like(otherUser, await fixture.review);
      await eventually(
          () async =>
              (await user.notifications).map((e) => [e.title, e.body]).toList(),
          containsExactly([
            ['Comment Liked', 'Your comment was just liked by Big Liker'],
            ['Post Liked', 'Your post was just liked by Big Liker']
          ]),
          message: (t) => t);
    });
  });
}
