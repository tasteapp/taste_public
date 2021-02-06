import 'package:flutter_test/flutter_test.dart';
import 'package:taste/utils/extensions.dart';

void main() {
  test("sort", () {
    expect(
        ['fdsa', 'asdf'].tupleSort((x) => [x]),
        equals([
          'asdf',
          'fdsa',
        ]));
    expect(
        ['fdsa', 'asdf'].tupleSort((x) => [x.length, x]),
        equals([
          'asdf',
          'fdsa',
        ]));
    expect(
        ['fdsa', 'asdff'].tupleSort((x) => [x.length, x]),
        equals([
          'fdsa',
          'asdff',
        ]));
  });
}
