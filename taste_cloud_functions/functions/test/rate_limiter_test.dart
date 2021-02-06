import 'utilities.dart';

void main() {
  setUp(setupEmulator);
  tearDown(tearDownEmulator);
  test('rate-limit', () async {
    final fixture = Fixture();
    final user = await fixture.user;
    await 150.times.futureMap((i) async {
      await (i.millis * 100).wait;
      await RateLimiter.user_badge(user.ref);
      print(i);
    });
    await 100.seconds.wait;
  });
}
