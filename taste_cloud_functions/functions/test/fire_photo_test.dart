import 'utilities.dart';

void main() {
  group('fire-photo', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('resto', () async {
      final resto = await Fixture().restaurant;
      await resto.updateSelf({'profile_pic_external_url': 'hi'});
    });
  });
}
