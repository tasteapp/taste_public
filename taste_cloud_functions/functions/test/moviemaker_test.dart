import 'utilities.dart';

void main() {
  group('moviemaker', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('moviemaker', () async {
      final fixture = Fixture();
      Future createReviews(int nReviews) async =>
          Iterable.generate(nReviews).futureMap((_) => fixture.createReview());
      Future nMoviesCreated(int nMovies) async =>
          expect(await Movies.get(), hasLength(nMovies));
      var totalPosts = 0;
      var totalMovies = 0;
      Future check(int nNewReviews, [bool creates = false]) async {
        totalPosts += nNewReviews;
        totalMovies += creates ? 1 : 0;
        await createReviews(nNewReviews);
        await eventually(DiscoverItems.get, hasLength(totalPosts),
            message: (t) => '${t.length} should be $totalPosts');
        await generateMovies();
        await nMoviesCreated(totalMovies);
      }

      await check(0);
      await check(1);
      await check(1);
      await check(1);
      await check(2, true);
      await check(3);
      await check(3, true);
      await check(0);
      await check(20, true);
      await check(0);
      await check(4, true);
    });
  });
}
