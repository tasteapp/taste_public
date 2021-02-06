import 'utilities.dart';

void main() {
  group('field-diff', () {
    bool fieldIsDifferent(a, b) => !firestoreEquals(a, b);
    test('field-diff', () async {
      expect(fieldIsDifferent('b', 'c'), isTrue);
      expect(fieldIsDifferent('b', 'b'), isFalse);
      expect(fieldIsDifferent(null, 'b'), isTrue);
      expect(fieldIsDifferent(null, null), isFalse);
      expect(
          fieldIsDifferent({
            'a': {'b': 'c'}
          }, {
            'a': {'b': 'c'}
          }),
          isFalse);
      expect(
          fieldIsDifferent({
            'a': {'b': 'c'}
          }, {
            'a': {'b': 'd'}
          }),
          isTrue);
      expect(
          fieldIsDifferent({
            'a': {'b': 'c'}
          }, {
            'a': {'b': null}
          }),
          isTrue);
      expect(
          fieldIsDifferent({
            'a': {
              'b': {'c': 'd'}
            }
          }, {
            'a': {
              'b': {'c': 'd'}
            }
          }),
          isFalse);
      expect(
          fieldIsDifferent({
            'a': {
              'b': {'c': 'd'}
            }
          }, {
            'a': {'b': 'c'}
          }),
          isTrue);
      expect(fieldIsDifferent('a', ['a']), isTrue);
      expect(fieldIsDifferent(['a'], 'a'), isTrue);
      expect(fieldIsDifferent({'a': 'b'}, ['a']), isTrue);
      expect(fieldIsDifferent(['a'], ['a', 'b']), isTrue);
      expect(fieldIsDifferent(['a', 'b'], ['b', 'a']), isFalse);
    });
  });
}
