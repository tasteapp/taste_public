import 'utilities.dart';

void main() {
  group('comment notification', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    Review review;
    TasteUser user;
    TasteUser otherUser;
    Fixture _fixture;
    setUp(() async {
      _fixture = Fixture();
      review = await _fixture.review;
      user = await _fixture.user;
      otherUser = await _fixture.otherUser;
    });

    test('participants', () async {
      expect(await review.participants, {user});
      final userComment = await _fixture.comment(user);
      expect(await review.participants, {user});
      final anotherUserComment = await _fixture.comment(user);
      expect(await review.participants, {user});
      final otherUserComment = await _fixture.comment(otherUser);
      expect(await review.participants, {user, otherUser});
      final tagUser = await _fixture.newUser;
      final tagUserComment = await _fixture.comment(otherUser, tag: tagUser);
      expect(await review.participants, {user, otherUser, tagUser});
      await eventually(
          () async => (await tagUser.notifications).listMap((t) => t.title),
          contains('fakeusername tagged you on dishy'));
      await userComment.deleteSelf();
      await anotherUserComment.deleteSelf();
      expect(await review.participants, {user, otherUser, tagUser});
      await otherUserComment.deleteSelf();
      await tagUserComment.deleteSelf();
      expect(await review.comments, isEmpty);
      expect(await review.participants, {user});
    });

    test('owner gets notification', () async {
      expect(await review.participants, {user});
      final comment = await _fixture.comment(otherUser);
      expect(comment.text, 'great');
      await eventually(() => user.notifications, isNotEmpty);
      {
        final notification = (await user.notifications).first;
        expect(await notification.user, equals(user));
        expect(notification.title, equals('fakeusername commented on dishy'));
        expect(await otherUser.notifications, isEmpty);
        expect(notification.body, stringContainsInOrder(['great']));
        await comment.updateSelf({'text': 'jacko jacko'});
        await eventually(() async => (await notification.refetch).body,
            stringContainsInOrder(['jacko jacko']));
        expect((await notification.refetch).body,
            isNot(stringContainsInOrder(['great'])));
      }

      final ownerComment = await _fixture.comment(user);
      await eventually(() => otherUser.notifications, isNotEmpty);
      final notification = (await otherUser.notifications).first;
      expect(await notification.user, otherUser);
      expect(notification.title, 'fakeusername commented on dishy');
      expect(
          (await user.notificationsQuery
                  .where('document_link', isEqualTo: ownerComment.ref)
                  .get())
              .documents,
          isEmpty);
    });

    test('no-dupe', () async {
      await _fixture.comment(user, tag: otherUser);
      await eventually(() => otherUser.notifications, isNotEmpty);
      expect(await otherUser.notifications, [
        predicate<TasteNotification>(
            (n) => n.title == 'fakeusername tagged you on dishy')
      ]);
    });
  });
}

extension on TasteUser {
  DocumentQuery get notificationsQuery =>
      CollectionType.notifications.coll.where('user', isEqualTo: ref);
}
