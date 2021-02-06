import 'package:taste_cloud_functions/taste_functions.dart' hide AlgoliaRecord;
import 'package:taste_protos/taste_protos.dart';
import 'package:test/test.dart';

void main() {
  group('algTest', () {
    CloudTransformProvider.initialize();
    test('any', () {
      final map = {
        'payload': {
          'a': {'b': 234}
        }
      };
      expect(ProtoTransforms.ensureAsMap(AlgoliaRecord(), map), equals(map));
    });
  });
}
