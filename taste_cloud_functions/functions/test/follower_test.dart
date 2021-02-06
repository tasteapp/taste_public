import 'utilities.dart';

void main() {
  group('follower', () {
    TasteUser user;
    TasteUser otherUser;
    Fixture _fixture;
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    setUp(() async {
      _fixture = Fixture();
      user = await _fixture.user;
      otherUser = await _fixture.otherUser;
    });
    test('followers', () async {
      Future countsAre(TasteUser user,
          {int follower = 0, int following = 0}) async {
        expect(await user.followers, hasLength(follower));
        expect(await user.following, hasLength(following));
      }

      await countsAre(user);
      await countsAre(otherUser);
      Future fails(TasteUser requester, TasteUser user,
          {bool unfollow = false}) async {
        expect(() => _fixture.follow(requester, user, unfollow: unfollow),
            throwsA(anything));
      }

      await fails(user, user);
      await countsAre(user);
      await countsAre(otherUser);

      await _fixture.follow(user, otherUser);
      await countsAre(user, following: 1);
      await countsAre(otherUser, follower: 1);

      await fails(user, otherUser);
      await countsAre(user, following: 1);
      await countsAre(otherUser, follower: 1);

      await _fixture.follow(otherUser, user);
      await countsAre(user, following: 1, follower: 1);
      await countsAre(otherUser, follower: 1, following: 1);

      await _fixture.follow(user, otherUser, unfollow: true);
      await countsAre(user, follower: 1);
      await countsAre(otherUser, following: 1);

      await fails(user, otherUser, unfollow: true);
      await countsAre(user, follower: 1);
      await countsAre(otherUser, following: 1);
      await _fixture.follow(otherUser, user, unfollow: true);
      await countsAre(user);
      await countsAre(otherUser);
    });
  });
}
