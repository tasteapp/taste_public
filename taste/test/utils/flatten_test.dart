import 'package:flutter_test/flutter_test.dart';
import 'package:taste/utils/extensions.dart';

void main() {
  test("flatten", () {
    expect(['b', 'c', 'e'].enumerate.map((e) => [e.key, e.value]).toList(), [
      [0, 'b'],
      [1, 'c'],
      [2, 'e'],
    ]);
    final x = [
      [3, 4, 2],
      [6, 2, 2]
    ];
    expect(x.flatten.toList(), equals([3, 4, 2, 6, 2, 2]));
  });
}
