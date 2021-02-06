import 'package:flutter_test/flutter_test.dart';
import 'package:taste/utils/extensions.dart';

void main() {
  test("merge", () {
    expect([1, 5, 6].mergeSorted([], (t) => t), equals([1, 5, 6]));
    expect(<int>[].mergeSorted([1, 5, 6], (t) => t), equals([1, 5, 6]));
    expect([1, 5, 6].mergeSorted([-1, 1, 3, 12], (t) => t),
        equals([-1, 1, 1, 3, 5, 6, 12]));
    expect([6, 1].mergeSorted([12, 3], (t) => -t), equals([12, 6, 3, 1]));
  });
}
