import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taste/utils/proto_transforms.dart';
import 'package:taste/utils/query_builder.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TasteTransformProvider.initialize();
  test("query", () {
    final now = DateTime.now();
    final proto = {
      'limit': 5,
      'path': 'a/b/c',
      'is_collection_group': false,
      'where_clauses': [
        {
          'where_field': 'v',
          'comparator': 'is_equal_to',
          'int_value': 123,
        },
        {
          'where_field': 'vv',
          'comparator': 'is_equal_to',
          'string_value': 'sgasdga',
        },
        {
          'where_field': 'w',
          'comparator': 'is_equal_to',
          'timestamp_value': $pb.Timestamp.fromDateTime(now),
        },
        {
          'where_field': 'x',
          'comparator': 'is_equal_to',
          'reference_value': {'path': 'real/path'},
        },
        {
          'where_field': 'y',
          'comparator': 'is_equal_to',
          'double_value': 42.2,
        },
      ],
      'order_clauses': [
        {
          'order_field': 'z',
        },
        {
          'order_field': 'zz',
          'descending': true,
        },
      ]
    }.asProto($pb.FirestoreQuery());
    final query = queryFromProto(proto);
    expect(query.reference().path, equals('a/b/c'));
    expect(
        query.buildArguments(),
        equals({
          'where': [
            ['v', '==', 123],
            ['vv', '==', 'sgasdga'],
            ['w', '==', Timestamp.fromDate(now)],
            ['x', '==', Firestore.instance.document('real/path')],
            ['y', '==', 42.2],
          ],
          'orderBy': [
            ['z', false],
            ['zz', true]
          ],
          'limit': 5,
          'path': 'a/b/c'
        }));
  });
}
