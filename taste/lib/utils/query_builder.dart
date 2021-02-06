import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste_protos/gen/query.pb.dart';
import 'extensions.dart';

Query queryFromProto(FirestoreQuery input) {
  Query query = input.isCollectionGroup
      ? Firestore.instance.collectionGroup(input.path)
      : Firestore.instance.collection(input.path);
  if (input.limit > 0) {
    query = query.limit(input.limit);
  }
  input.whereClauses.forEach((whereClause) {
    query = query.where(whereClause.whereField, isEqualTo: whereClause.value);
  });
  input.orderClauses.forEach((orderClause) {
    query = query.orderBy(orderClause.orderField,
        descending: orderClause.descending);
  });
  return query;
}

extension ExtWhere on FirestoreQuery_WhereClause {
  dynamic get value {
    final value = {
      FirestoreQuery_WhereClause_WhereValue.intValue: intValue,
      FirestoreQuery_WhereClause_WhereValue.doubleValue: doubleValue,
      FirestoreQuery_WhereClause_WhereValue.stringValue: stringValue,
      FirestoreQuery_WhereClause_WhereValue.referenceValue: referenceValue.ref,
      FirestoreQuery_WhereClause_WhereValue.timestampValue:
          timestampValue.firestoreTimestamp,
    }[whichWhereValue()];
    return value;
  }
}
