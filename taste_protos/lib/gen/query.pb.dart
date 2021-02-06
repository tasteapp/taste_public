///
//  Generated code. Do not modify.
//  source: query.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'google/protobuf/timestamp.pb.dart' as $0;

import 'query.pbenum.dart';

export 'query.pbenum.dart';

enum FirestoreQuery_WhereClause_WhereValue {
  stringValue, 
  referenceValue, 
  timestampValue, 
  intValue, 
  doubleValue, 
  notSet
}

class FirestoreQuery_WhereClause extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, FirestoreQuery_WhereClause_WhereValue> _FirestoreQuery_WhereClause_WhereValueByTag = {
    3 : FirestoreQuery_WhereClause_WhereValue.stringValue,
    4 : FirestoreQuery_WhereClause_WhereValue.referenceValue,
    5 : FirestoreQuery_WhereClause_WhereValue.timestampValue,
    6 : FirestoreQuery_WhereClause_WhereValue.intValue,
    7 : FirestoreQuery_WhereClause_WhereValue.doubleValue,
    0 : FirestoreQuery_WhereClause_WhereValue.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FirestoreQuery.WhereClause', package: const $pb.PackageName('firestore_query'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6, 7])
    ..aOS(1, 'whereField')
    ..e<FirestoreQuery_WhereClause_Comparator>(2, 'comparator', $pb.PbFieldType.OE, defaultOrMaker: FirestoreQuery_WhereClause_Comparator.COMPARATOR_UNDEFINED, valueOf: FirestoreQuery_WhereClause_Comparator.valueOf, enumValues: FirestoreQuery_WhereClause_Comparator.values)
    ..aOS(3, 'stringValue')
    ..aOM<$1.DocumentReferenceProto>(4, 'referenceValue', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$0.Timestamp>(5, 'timestampValue', subBuilder: $0.Timestamp.create)
    ..a<$core.int>(6, 'intValue', $pb.PbFieldType.O3)
    ..a<$core.double>(7, 'doubleValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  FirestoreQuery_WhereClause._() : super();
  factory FirestoreQuery_WhereClause() => create();
  factory FirestoreQuery_WhereClause.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FirestoreQuery_WhereClause.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FirestoreQuery_WhereClause clone() => FirestoreQuery_WhereClause()..mergeFromMessage(this);
  FirestoreQuery_WhereClause copyWith(void Function(FirestoreQuery_WhereClause) updates) => super.copyWith((message) => updates(message as FirestoreQuery_WhereClause));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FirestoreQuery_WhereClause create() => FirestoreQuery_WhereClause._();
  FirestoreQuery_WhereClause createEmptyInstance() => create();
  static $pb.PbList<FirestoreQuery_WhereClause> createRepeated() => $pb.PbList<FirestoreQuery_WhereClause>();
  @$core.pragma('dart2js:noInline')
  static FirestoreQuery_WhereClause getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FirestoreQuery_WhereClause>(create);
  static FirestoreQuery_WhereClause _defaultInstance;

  FirestoreQuery_WhereClause_WhereValue whichWhereValue() => _FirestoreQuery_WhereClause_WhereValueByTag[$_whichOneof(0)];
  void clearWhereValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get whereField => $_getSZ(0);
  @$pb.TagNumber(1)
  set whereField($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWhereField() => $_has(0);
  @$pb.TagNumber(1)
  void clearWhereField() => clearField(1);

  @$pb.TagNumber(2)
  FirestoreQuery_WhereClause_Comparator get comparator => $_getN(1);
  @$pb.TagNumber(2)
  set comparator(FirestoreQuery_WhereClause_Comparator v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasComparator() => $_has(1);
  @$pb.TagNumber(2)
  void clearComparator() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get stringValue => $_getSZ(2);
  @$pb.TagNumber(3)
  set stringValue($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStringValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearStringValue() => clearField(3);

  @$pb.TagNumber(4)
  $1.DocumentReferenceProto get referenceValue => $_getN(3);
  @$pb.TagNumber(4)
  set referenceValue($1.DocumentReferenceProto v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasReferenceValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearReferenceValue() => clearField(4);
  @$pb.TagNumber(4)
  $1.DocumentReferenceProto ensureReferenceValue() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.Timestamp get timestampValue => $_getN(4);
  @$pb.TagNumber(5)
  set timestampValue($0.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimestampValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestampValue() => clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureTimestampValue() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.int get intValue => $_getIZ(5);
  @$pb.TagNumber(6)
  set intValue($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIntValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearIntValue() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get doubleValue => $_getN(6);
  @$pb.TagNumber(7)
  set doubleValue($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDoubleValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearDoubleValue() => clearField(7);
}

class FirestoreQuery_OrderClause extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FirestoreQuery.OrderClause', package: const $pb.PackageName('firestore_query'), createEmptyInstance: create)
    ..aOS(1, 'orderField')
    ..aOB(2, 'descending')
    ..hasRequiredFields = false
  ;

  FirestoreQuery_OrderClause._() : super();
  factory FirestoreQuery_OrderClause() => create();
  factory FirestoreQuery_OrderClause.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FirestoreQuery_OrderClause.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FirestoreQuery_OrderClause clone() => FirestoreQuery_OrderClause()..mergeFromMessage(this);
  FirestoreQuery_OrderClause copyWith(void Function(FirestoreQuery_OrderClause) updates) => super.copyWith((message) => updates(message as FirestoreQuery_OrderClause));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FirestoreQuery_OrderClause create() => FirestoreQuery_OrderClause._();
  FirestoreQuery_OrderClause createEmptyInstance() => create();
  static $pb.PbList<FirestoreQuery_OrderClause> createRepeated() => $pb.PbList<FirestoreQuery_OrderClause>();
  @$core.pragma('dart2js:noInline')
  static FirestoreQuery_OrderClause getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FirestoreQuery_OrderClause>(create);
  static FirestoreQuery_OrderClause _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderField => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderField($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrderField() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderField() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get descending => $_getBF(1);
  @$pb.TagNumber(2)
  set descending($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescending() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescending() => clearField(2);
}

class FirestoreQuery extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FirestoreQuery', package: const $pb.PackageName('firestore_query'), createEmptyInstance: create)
    ..aOS(1, 'path')
    ..aOB(2, 'isCollectionGroup')
    ..pc<FirestoreQuery_WhereClause>(3, 'whereClauses', $pb.PbFieldType.PM, subBuilder: FirestoreQuery_WhereClause.create)
    ..a<$core.int>(4, 'limit', $pb.PbFieldType.O3)
    ..pc<FirestoreQuery_OrderClause>(5, 'orderClauses', $pb.PbFieldType.PM, subBuilder: FirestoreQuery_OrderClause.create)
    ..hasRequiredFields = false
  ;

  FirestoreQuery._() : super();
  factory FirestoreQuery() => create();
  factory FirestoreQuery.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FirestoreQuery.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FirestoreQuery clone() => FirestoreQuery()..mergeFromMessage(this);
  FirestoreQuery copyWith(void Function(FirestoreQuery) updates) => super.copyWith((message) => updates(message as FirestoreQuery));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FirestoreQuery create() => FirestoreQuery._();
  FirestoreQuery createEmptyInstance() => create();
  static $pb.PbList<FirestoreQuery> createRepeated() => $pb.PbList<FirestoreQuery>();
  @$core.pragma('dart2js:noInline')
  static FirestoreQuery getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FirestoreQuery>(create);
  static FirestoreQuery _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isCollectionGroup => $_getBF(1);
  @$pb.TagNumber(2)
  set isCollectionGroup($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsCollectionGroup() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsCollectionGroup() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<FirestoreQuery_WhereClause> get whereClauses => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<FirestoreQuery_OrderClause> get orderClauses => $_getList(4);
}

