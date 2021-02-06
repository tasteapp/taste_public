import 'utilities.dart';

void main() {
  group('partial-review', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('partial-review', () async {
      for (final noPhoto in {false, true}) {
        for (final isHome in {false, true}) {
          print({'no photo': noPhoto, 'is home': isHome});
          final fixture = Fixture();
          final user = await fixture.user;
          expect(user.score, 0);
          final review = await fixture.createReview(
              noPhoto: noPhoto, home: isHome, score: 0);
          expect(
              await waitForEquals(
                  noPhoto ? 0 : 200, () async => (await review.refetch).score,
                  earlyExit: !noPhoto,
                  duration: Duration(seconds: noPhoto ? 6 : 12)),
              isTrue);
          await review.updateSelf({'photo': (await fixture.photo).ref});
          expect(
              await waitForEquals(
                  200, () async => (await review.refetch).score),
              isTrue);
        }
      }
    });
  });
}
