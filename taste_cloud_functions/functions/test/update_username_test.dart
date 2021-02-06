import 'utilities.dart';

void main() {
  group('update-username', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('update-username', () async {
      final fixture = Fixture();
      final user = await fixture.createUser(username: 'a');
      final review = await Fixture().createReview(user: user);
      Future usernameIs(String expected) => eventually(
          () async =>
              (await DiscoverItems.get()).firstOrNull?.proto?.user?.name,
          expected,
          message: (i) => i);
      await usernameIs('a');
      await user.updateSelf({
        'vanity': {'username': 'b'}
      });
      await usernameIs('b');
      await fixture.comment(user, review: review);
      Future commentUsernameIs(String expected) => eventually(
          () async => (await DiscoverItems.get())
              .firstOrNull
              ?.proto
              ?.comments
              ?.firstOrNull
              ?.user
              ?.name,
          expected,
          message: (i) => i);
      await commentUsernameIs('b');
      await user.updateSelf({
        'vanity': {'username': 'c'}
      });
      await commentUsernameIs('c');
      final otherUser = await fixture.createUser(username: 'other');
      await fixture.comment(otherUser, review: review);
      Future otherUsernameIs(String expected) => eventually(
          () async => (await DiscoverItems.get())
              .firstOrNull
              ?.proto
              ?.comments
              ?.lastOrNull
              ?.user
              ?.name,
          expected,
          message: (i) => i);
      await otherUsernameIs('other');
      await otherUser.updateSelf({
        'vanity': {'username': 'changeother'}
      });
      await otherUsernameIs('changeother');
    });
  });
}
