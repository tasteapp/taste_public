import 'utilities.dart';

void main() {
  Future notificationsIs(SnapshotHolder s, dynamic matcher) => eventually(
      () => TasteNotifications.get(
          queryFn: (q) => q.where('document_link', isEqualTo: s.ref)),
      matcher,
      duration: const Duration(minutes: 1),
      message: (i) => i);
  group('deleteUserTest', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('delete user', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final otherUser = await fixture.otherUser;
      final restaurant = await fixture.restaurant;
      final review = await fixture.review;
      final comment = await fixture.reviewComment;
      final like = await fixture.like(user, await fixture.comment(otherUser));
      final bookmark = await fixture.bookmark(user);
      final following = await fixture.follow(user, otherUser);
      final follower = await fixture.follow(otherUser, user);
      final favorite = await Favorite.createForRestaurantUser(restaurant, user);
      final convo = await fixture.conversation;
      expect((await review.ref.get()).exists, isTrue);
      expect((await comment.ref.get()).exists, isTrue);
      expect((await like.ref.get()).exists, isTrue);
      expect((await bookmark.ref.get()).exists, isTrue);
      expect((await following.ref.get()).exists, isTrue);
      expect((await follower.ref.get()).exists, isTrue);
      expect((await favorite.ref.get()).exists, isTrue);
      expect((await user.private.get()).exists, isTrue);
      expect((await convo.refetch).exists, isTrue);
      await notificationsIs(user, isNotEmpty);
      await notificationsIs(like, isNotEmpty);
      await user.deleteSelf();
      await eventually(
        () async => (await review.ref.get()).exists,
        isFalse,
        duration: const Duration(minutes: 1),
        message: (i) => i,
      );
      expect((await comment.ref.get()).exists, isFalse);
      expect((await like.ref.get()).exists, isFalse);
      expect((await bookmark.ref.get()).exists, isFalse);
      expect((await following.ref.get()).exists, isFalse);
      expect((await follower.ref.get()).exists, isFalse);
      expect((await favorite.ref.get()).exists, isFalse);
      expect((await user.private.get()).exists, isFalse);
      expect((await convo.ref.get()).exists, isFalse);
      await notificationsIs(user, isEmpty);
      await notificationsIs(like, isEmpty);
    });
  });
}
