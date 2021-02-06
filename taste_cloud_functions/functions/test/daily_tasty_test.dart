import 'package:taste_cloud_functions/types/daily_tasty.dart';

import 'utilities.dart';

void main() {
  Fixture fixture;
  Future<Review> post(num daysAgo) async =>
      fixture.createReview(daysAgo: daysAgo, user: await fixture.createUser());
  Future<Review> insta(num importDays, num createDays) async =>
      fixture.createReview(
          instaPost: 'a/b'.ref,
          daysAgo: createDays,
          user: await fixture.createUser(),
          importedAt: DateTime.now()
              .subtract(Duration(hours: (24 * importDays).round())));
  Future<Review> previousWinner(num daysAgo) async {
    final p = await post(daysAgo + 1.5);
    await p.updateSelf({
      'awards': {
        'daily_tasty':
            DateTime.now().subtract(Duration(hours: (daysAgo * 24).toInt()))
      }
    });
    return p.refetch;
  }

  Future vote(Review review, double score) => fixture.vote(review, score);
  Future votes(Iterable<ZipTuple<Review, double>> theVotes) =>
      theVotes.futureMap((v) => vote(v.a, v.b));
  Future check(Review winner, Iterable<Review> losers) async {
    await eventually(
        DiscoverItems.get, hasLength((await Reviews.get()).length));
    expect(await awardDailyTasty(), winner?.ref);
    if (winner != null) {
      expect((await winner.refetch).hasDailyTasty, isTrue);
    }
    await losers.futureMap((loser) async {
      expect((await loser.refetch).hasDailyTasty, isFalse);
    });
  }

  setUp(() => fixture = Fixture());
  setUp(setupEmulator);
  tearDown(tearDownEmulator);
  test('0-previous', () async {
    final a = await post(1.5);
    final b = await post(1.5);
    final tooLate = await post(.5);
    await votes([a, b, b, tooLate].zip([3, 2.5, 4, 5]));
    await check(b, {a, tooLate});
    await eventually(() async => (await b.user).notifications, isNotEmpty);
    expect(await (await a.user).notifications, isEmpty);
  });
  test('1-previous', () async {
    await previousWinner(1.1);
    final tooEarly = await post(2.2);
    final valid = await post(2);
    final tooLate = await post(.9);
    await votes([valid, tooEarly, tooLate].zip([1, 2, 3]));
    await check(valid, {tooLate, tooEarly});
  });
  test('many-previous', () async {
    await previousWinner(1);
    await previousWinner(2);
    await previousWinner(3);
    final tooEarly = await post(2.2);
    final low = await post(1.5);
    final high = await post(1.5);
    final tooLate = await post(.9);
    await votes([low, high, tooEarly, tooLate].zip([1, 2, 3, 4]));
    await check(high, {tooLate, tooEarly, low});
  });
  test('tiebreak-on-path', () async {
    final posts = await Iterable.generate(5, (_) => post(1.5)).wait;
    final winner = posts.min((p) => p.path);
    await votes(posts.zipWith((_) => 3));
    await check(winner, posts.toSet().difference({winner}));
  });
  test('min-required-gap', () async {
    await previousWinner(0.3);
    await previousWinner(1.3);
    await previousWinner(2.3);
    final a = await post(1.1);
    await votes([a].zip([3]));
    await check(null, {a});
  });
  test('gap-passed', () async {
    await previousWinner(0.8);
    await previousWinner(1.8);
    await previousWinner(2.8);
    final a = await post(1.6);
    await votes([a].zip([3]));
    await check(a, <Review>{});
  });
  test('import-long-ago', () async {
    await previousWinner(1);
    await previousWinner(2);
    await previousWinner(3);
    final normal = await post(1.5);
    final _insta = await insta(3, 3);
    await votes([normal, _insta].zip([1, 5]));
    await check(normal, {_insta});
  });
  test('import-lose', () async {
    await previousWinner(1);
    await previousWinner(2);
    await previousWinner(3);
    final normal = await post(1.5);
    final _insta = await insta(1.5, 3);
    await votes([normal, _insta].zip([5, 1]));
    await check(normal, {_insta});
  });
  test('import-win', () async {
    await previousWinner(1);
    await previousWinner(2);
    await previousWinner(3);
    final normal = await post(1.5);
    final _insta = await insta(1.5, 3);
    await votes([normal, _insta].zip([1, 5]));
    await check(_insta, {normal});
  });
  test('import-disqualified-by-import-date', () async {
    await previousWinner(1);
    await previousWinner(2);
    await previousWinner(3);
    final normal = await post(1.5);
    final _insta = await insta(0.5, 1.5);
    await votes([normal, _insta].zip([1, 5]));
    await check(normal, {_insta});
  });
}
