///
//  Generated code. Do not modify.
//  source: query.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const FirestoreQuery$json = const {
  '1': 'FirestoreQuery',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'is_collection_group', '3': 2, '4': 1, '5': 8, '10': 'isCollectionGroup'},
    const {'1': 'where_clauses', '3': 3, '4': 3, '5': 11, '6': '.firestore_query.FirestoreQuery.WhereClause', '10': 'whereClauses'},
    const {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'order_clauses', '3': 5, '4': 3, '5': 11, '6': '.firestore_query.FirestoreQuery.OrderClause', '10': 'orderClauses'},
  ],
  '3': const [FirestoreQuery_WhereClause$json, FirestoreQuery_OrderClause$json],
};

const FirestoreQuery_WhereClause$json = const {
  '1': 'WhereClause',
  '2': const [
    const {'1': 'where_field', '3': 1, '4': 1, '5': 9, '10': 'whereField'},
    const {'1': 'comparator', '3': 2, '4': 1, '5': 14, '6': '.firestore_query.FirestoreQuery.WhereClause.Comparator', '10': 'comparator'},
    const {'1': 'string_value', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'stringValue'},
    const {'1': 'reference_value', '3': 4, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '9': 0, '10': 'referenceValue'},
    const {'1': 'timestamp_value', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '9': 0, '10': 'timestampValue'},
    const {'1': 'int_value', '3': 6, '4': 1, '5': 5, '9': 0, '10': 'intValue'},
    const {'1': 'double_value', '3': 7, '4': 1, '5': 1, '9': 0, '10': 'doubleValue'},
  ],
  '4': const [FirestoreQuery_WhereClause_Comparator$json],
  '8': const [
    const {'1': 'where_value'},
  ],
};

const FirestoreQuery_WhereClause_Comparator$json = const {
  '1': 'Comparator',
  '2': const [
    const {'1': 'COMPARATOR_UNDEFINED', '2': 0},
    const {'1': 'is_equal_to', '2': 1},
  ],
};

const FirestoreQuery_OrderClause$json = const {
  '1': 'OrderClause',
  '2': const [
    const {'1': 'order_field', '3': 1, '4': 1, '5': 9, '10': 'orderField'},
    const {'1': 'descending', '3': 2, '4': 1, '5': 8, '10': 'descending'},
  ],
};

