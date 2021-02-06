import 'utilities.dart';

void main() {
  group('comment like update', () {
    Fixture fixture;

    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    setUp(() => fixture = Fixture());
    test('like update', () async {
      final like = await fixture.commentLike;
      final comment = await fixture.reviewComment;
      final user = await fixture.user;
      expect(
          (await like.allSnapshotsToUpdate).map((s) => s.ref).toSet(),
          equals({
            comment.ref,
            user.ref,
          }));
    });
  });
}
