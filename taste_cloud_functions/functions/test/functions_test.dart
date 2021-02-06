import 'utilities.dart';

void main() {
  group('functions', () {
    test('flattenMap', () {
      expect(dotFlatten({'key': null}), {'key': null});
      expect(
          dotFlatten({
            'key': {'key2': 'val', 'key3': null}
          }),
          {'key.key2': 'val', 'key.key3': null});
    });
  });
}
