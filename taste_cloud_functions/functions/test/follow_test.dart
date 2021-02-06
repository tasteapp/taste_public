import 'utilities.dart';

void main() {
  group('follow', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('follow', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final otherUser = await fixture.otherUser;
      Future sizeIs(int size) async =>
          expect((await Followers.get()), hasLength(size));
      await user.followUser(otherUser);
      await sizeIs(1);
      await otherUser.followUser(user);
      await sizeIs(2);
    });
  });
}
