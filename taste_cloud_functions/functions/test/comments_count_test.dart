import 'utilities.dart';

void main() {
  group('comments count', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('comment counts', () async {
      final fixture = Fixture();
      final comment = await fixture.reviewComment;
      Future hasNLikes(int likes) async =>
          expect(await comment.likes, hasLength(likes));
      await hasNLikes(0);
      await fixture.commentLike;
      await hasNLikes(1);
      await (await fixture.commentLike).deleteSelf();
      await hasNLikes(0);
    });
  });
}
