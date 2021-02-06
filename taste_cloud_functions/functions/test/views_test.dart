import 'utilities.dart';

void main() {
  group('views', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('view counts', () async {
      final fixture = Fixture();
      final review = await fixture.review;
      Future hasNViews(int views) async =>
          expect(await review.views, hasLength(views));
      await hasNViews(0);
      await fixture.viewReview(await fixture.user, await fixture.review);
      await hasNViews(1);
    });
  });
}
