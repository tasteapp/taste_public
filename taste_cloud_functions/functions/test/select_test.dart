import 'utilities.dart';

void main() {
  group('select', () {
    test('select', () async {
      expect({'a': 'b'}.documentData.select('a'), equals('b'));
    });
  });
}
