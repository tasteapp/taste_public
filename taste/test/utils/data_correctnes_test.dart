import 'package:flutter_test/flutter_test.dart';
import 'package:taste/screens/create_review/review/data_correctness.dart';
import 'package:taste/utils/extensions.dart';

void main() {
  test("print", () {
    print(PostVariable.values
        .cartesian([true, false])
        .zipMap((t, s) => [
              t,
              s,
              getImplications({t: s})
            ])
        .toList());
  });
}
