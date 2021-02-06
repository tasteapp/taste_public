import 'utilities.dart';

void main() {
  group('batch-dump', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('batch-dump', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final users = CollectionType.users;
      final reviews = CollectionType.reviews;
      Future<BatchDump> batch([CollectionType a, CollectionType b]) =>
          BatchDump.fetch(quickTrans, {a, b}.withoutNulls.toSet());
      final emptyBatch = await batch();
      final userBatch = await batch(users);
      expect(emptyBatch.snapshots, isEmpty);
      expect(emptyBatch.users, isEmpty);
      expect(emptyBatch.typed<TasteUser>(), isEmpty);
      expect(userBatch.snapshots.values, [user]);
      expect(userBatch.byType, {
        TasteUser: [user]
      });
      expect(userBatch.typed<TasteUser>(), [user]);
      expect(userBatch.users.values, [user]);
      expect(userBatch.userRecords[user].reviews, isEmpty);
      final review = await fixture.review;
      expect((await batch(users)).byType, {
        TasteUser: [user],
      });
      expect((await batch(users, reviews)).byType, {
        TasteUser: [user],
        Review: [review],
      });
      expect((await batch(users, reviews)).reviews, [review]);
      expect((await batch(users, reviews)).userRecords[user].reviews, [review]);
    });
  });
}
