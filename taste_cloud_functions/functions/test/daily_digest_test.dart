import 'utilities.dart';

void main() {
  group('daily-digest', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('daily-digest', () async {
      final fixture = Fixture();
      final userA = await fixture.createUser(name: 'user-a');
      final userB = await fixture.createUser(name: 'user-b');
      final review = await fixture.createReview(user: userB);
      final notes = () => TasteNotifications.get(trans: quickTrans);
      Future digest() async {
        await (await notes()).futureMap((t) => t.deleteSelf());
        expect(await notes(), isEmpty);
        await dailyDigest();
        return notes();
      }

      dynamic hasUsers(List<String> users) => [
            allOf(
              predicate<TasteNotification>((t) => t.userReference == userA.ref),
              predicate<TasteNotification>(
                  (t) => t.body == 'New posts from ${users.join(', ')}'),
            )
          ];

      expect(await digest(), isEmpty);
      await userA.follow(userB, true);
      expect(await digest(), isEmpty);
      await review.like(userA, true);
      expect(await digest(), hasUsers(['user-b']));
      final userC = await fixture.createUser(name: 'user-c');
      final cReview = await fixture.createReview(user: userC);
      await userA.follow(userC, true);
      await fixture.bookmark(userA, review: cReview);
      await cReview.like(userA, true);
      expect(await digest(), hasUsers(['user-c', 'user-b']));
      await cReview
          .changeDate(DateTime.now().subtract(const Duration(days: 1)));
      expect(await digest(), hasUsers(['user-b']));
      await review.changeDate(DateTime.now().subtract(const Duration(days: 1)));
      expect(await digest(), isEmpty);
    });
  });
}
