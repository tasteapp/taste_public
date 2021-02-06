import 'utilities.dart';

void main() {
  group('unique-user-index', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('unique-user-index', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final like = await fixture.commentLike;
      final bookmark = await fixture.bookmark(user);
      final restaurant = await fixture.restaurant;
      final favorite = await fixture.favorite(user, restaurant);
      final follower = await fixture.follow(user, await fixture.otherUser);
      final indexed = <UniqueUserIndexed>[
        like,
        bookmark,
        favorite,
        follower,
      ];
      Future indexExists({bool exists = true}) async {
        for (final doc in indexed) {
          expect(
              await waitForEquals(exists,
                  () async => (await doc.userIndexReference.get()).exists),
              isTrue,
              reason: [doc.path, doc.userIndexReference.path].toString());
        }
      }

      await indexExists();
      await indexed.futureMap((e) => e.deleteSelf());
      await indexExists(exists: false);
    });
  });
}
