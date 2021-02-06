import 'utilities.dart';

void main() {
  group('meal mate', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('meal mate', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final otherUser = await fixture.otherUser;
      final taggedUser = await fixture.createUser();
      final review = await fixture.createReview(
          mealMate: otherUser, user: user, taggedUser: taggedUser);
      Future hasNNotifications(int n, [TasteUser user]) =>
          eventually(() => (user ?? otherUser).notifications, hasLength(n));
      await hasNNotifications(1);
      expect((await otherUser.notifications).map((e) => e.title),
          equals([startsWith('New Meal Mate at')]));
      await hasNNotifications(1, taggedUser);
      expect((await taggedUser.notifications).map((e) => e.title),
          equals([startsWith('Test User tagged you in their post')]));

      await fixture.comment(user, review: review);
      await hasNNotifications(2);
      await hasNNotifications(2, taggedUser);
      final userC = await fixture.newUser;
      await review.updateSelf({
        'meal_mates': Firestore.fieldValues.arrayUnion([userC.ref])
      });
      await hasNNotifications(1, userC);
      expect((await userC.notifications).map((e) => e.title),
          equals([startsWith('New Meal Mate at')]));
      await hasNNotifications(2, otherUser);
      await hasNNotifications(2, taggedUser);
      await fixture.comment(await fixture.newUser, review: review);
      await hasNNotifications(3, otherUser);
      await hasNNotifications(3, taggedUser);
      await hasNNotifications(2, userC);
    });
  });
}
