import 'utilities.dart';

void main() {
  group('notifications', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('send with notification type', () async {
      final fixture = Fixture();
      expect((await fixture.user).deleteDynamic(null), isNotNull);
    });
  });
}
