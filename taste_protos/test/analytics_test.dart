import 'package:taste_protos/gen/analytics.pbenum.dart';
import 'package:test/test.dart';

void main() {
  test('check', () {
    for (final event in TAEvent.values) {
      expect(event.name, hasLength(lessThanOrEqualTo(40)));
    }
  });
}
