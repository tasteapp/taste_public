import 'utilities.dart';

void main() {
  group('utilities', () {
    test('dotFlatten', () async {
      final testInput = {
        'a': 1,
        'b': {'c': 2, 'd': 3},
        'e.f': 4,
      };
      expect(dotFlatten(testInput), {'a': 1, 'b.c': 2, 'b.d': 3, 'e.f': 4});
    });
  });
}
