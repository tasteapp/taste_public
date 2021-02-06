import 'utilities.dart';

void main() {
  group('review-score', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('score', () async {
      final _fixture = Fixture();
      final user = await _fixture.user;
      final otherUser = await _fixture.otherUser;
      final review = await _fixture.review;
      Future scoreIs(int score) async {
        expect(await review.computeScore, equals(score));
        expect(
            await waitForEquals(
                score, () async => (await review.refetch).score),
            isTrue);
      }

      await scoreIs(200);

      await _fixture.bookmark(user);
      await scoreIs(200);
      await _fixture.bookmark(otherUser);
      await scoreIs(200 + 60);
      for (final bookmark in (await review.bookmarks)) {
        await bookmark.deleteSelf();
      }
      await scoreIs(200);
      await _fixture.bookmark(otherUser);
      await _fixture.like(otherUser);
      await scoreIs(200 + 60 + 10);
      await _fixture.comment(user);
      await _fixture.comment(otherUser);
      await scoreIs(200 + 60 + 10 + 50 * 1);
      await scoreIs(200 + 60 + 10 * 1 + 50 * 1);
    });
  });
}
