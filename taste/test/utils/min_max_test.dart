import 'package:flutter_test/flutter_test.dart';
import 'package:taste/utils/extensions.dart';

void main() {
  test("group by", () {
    expect({0, 1, 2, 3}.groupBy((i) => i.isEven), {
      true: [0, 2],
      false: [1, 3]
    });
  });
  test("min max", () {
    expect([5, 2352, 532, 2].minSelf, equals(2));
    expect([5, 2352, 532, 2].min((i) => i), equals(2));
    expect([5, 2352, 532, 2].min((i) => -i), equals(2352));

    expect([5, 2352, 532, 2].maxSelf, equals(2352));
    expect([5, 2352, 532, 2].max((i) => i), equals(2352));
    expect([5, 2352, 532, 2].max((i) => -i), equals(2));
  });
}
