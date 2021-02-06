import 'utilities.dart';

void main() {
  group('diff', () {
    test('restaurant', () {
      expect(
          [
            {
              'attributes': {'location': GeoPoint(2, 3)}
            },
            {
              'attributes': {'location': GeoPoint(.2, 3)}
            }
          ].change.fieldsChanged({'attributes.location', 'attributes.address'}),
          isTrue);
      expect(
          [
            {
              'attributes': {'location': GeoPoint(2, 3)}
            },
            <String, dynamic>{},
          ].change.fieldsChanged({'attributes.location', 'attributes.address'}),
          isTrue);
      expect(
          [
            {
              'attributes': {'location': GeoPoint(2, 3)}
            },
            {
              'attributes': {'location': null}
            },
          ].change.fieldsChanged({'attributes.location', 'attributes.address'}),
          isTrue);
      expect(
          [
            {
              'attributes': {'location': GeoPoint(2, 3)}
            },
            {
              'attributes': {'something': null},
            },
          ].change.fieldsChanged({'attributes.location', 'attributes.address'}),
          isTrue);
      expect(
          [
            {
              'attributes': {'location': GeoPoint(2, 3)}
            },
            {
              'attributes': {'location': GeoPoint(2, 3)}
            }
          ].change.fieldsChanged({'attributes.location', 'attributes.address'}),
          isFalse);
      expect(
          [
            {
              'attributes': {
                'address': {'city': 'a'}
              }
            },
            {
              'attributes': {
                'address': {'city': 'b'}
              }
            },
          ].change.fieldsChanged({'attributes.location', 'attributes.address'}),
          isTrue);
      expect(
          [
            {
              'attributes': {
                'address': {'city': 'a'}
              }
            },
            {
              'attributes': {
                'address': {'city': 'a'}
              }
            },
          ].change.fieldsChanged({'attributes.location', 'attributes.address'}),
          isFalse);
    });
    test('diff', () {
      <List<Map<String, dynamic>>>[
        [
          {'a': 'b'},
          {'a': 'c'}
        ],
        [
          {'a': 'b'},
          {'a': null}
        ],
        [
          {'a': 'b'},
          {}
        ],
        [
          {
            'a': {'b': 'c'}
          },
          {
            'a': {'b': 'd'}
          },
        ],
        [
          {
            'a': {'b': 'c'}
          },
          {
            'a': {'b': null}
          },
        ],
        [
          {
            'a': {'b': 'c'}
          },
          {
            'a': {'c': null}
          },
        ],
      ].forEach((e) =>
          expect(e.change.fieldChanged('a'), isTrue, reason: e.toString()));
    });
  });
}

extension on List<Map<String, dynamic>> {
  Change<DocumentSnapshot> get change => Change(this[0].snap, this[1].snap);
}

extension on Map<String, dynamic> {
  DocumentSnapshot get snap => SimpleSnapshot(documentData, 'a/a'.ref);
}
