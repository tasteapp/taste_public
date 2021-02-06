///
//  Generated code. Do not modify.
//  source: common.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $0;

export 'common.pbenum.dart';

class Extras extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Extras', package: const $pb.PackageName('common'), createEmptyInstance: create)
    ..aOM<$0.Timestamp>(1, 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(2, 'updatedAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Extras._() : super();
  factory Extras() => create();
  factory Extras.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Extras.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Extras clone() => Extras()..mergeFromMessage(this);
  Extras copyWith(void Function(Extras) updates) => super.copyWith((message) => updates(message as Extras));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Extras create() => Extras._();
  Extras createEmptyInstance() => create();
  static $pb.PbList<Extras> createRepeated() => $pb.PbList<Extras>();
  @$core.pragma('dart2js:noInline')
  static Extras getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Extras>(create);
  static Extras _defaultInstance;

  @$pb.TagNumber(1)
  $0.Timestamp get createdAt => $_getN(0);
  @$pb.TagNumber(1)
  set createdAt($0.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCreatedAt() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreatedAt() => clearField(1);
  @$pb.TagNumber(1)
  $0.Timestamp ensureCreatedAt() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.Timestamp get updatedAt => $_getN(1);
  @$pb.TagNumber(2)
  set updatedAt($0.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdatedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdatedAt() => clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureUpdatedAt() => $_ensure(1);
}

class DocumentReferenceProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DocumentReferenceProto', package: const $pb.PackageName('common'), createEmptyInstance: create)
    ..aOS(1, 'path')
    ..hasRequiredFields = false
  ;

  DocumentReferenceProto._() : super();
  factory DocumentReferenceProto() => create();
  factory DocumentReferenceProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DocumentReferenceProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DocumentReferenceProto clone() => DocumentReferenceProto()..mergeFromMessage(this);
  DocumentReferenceProto copyWith(void Function(DocumentReferenceProto) updates) => super.copyWith((message) => updates(message as DocumentReferenceProto));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DocumentReferenceProto create() => DocumentReferenceProto._();
  DocumentReferenceProto createEmptyInstance() => create();
  static $pb.PbList<DocumentReferenceProto> createRepeated() => $pb.PbList<DocumentReferenceProto>();
  @$core.pragma('dart2js:noInline')
  static DocumentReferenceProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DocumentReferenceProto>(create);
  static DocumentReferenceProto _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);
}

class LatLng extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LatLng', package: const $pb.PackageName('common'), createEmptyInstance: create)
    ..a<$core.double>(1, 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(2, 'longitude', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  LatLng._() : super();
  factory LatLng() => create();
  factory LatLng.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LatLng.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LatLng clone() => LatLng()..mergeFromMessage(this);
  LatLng copyWith(void Function(LatLng) updates) => super.copyWith((message) => updates(message as LatLng));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LatLng create() => LatLng._();
  LatLng createEmptyInstance() => create();
  static $pb.PbList<LatLng> createRepeated() => $pb.PbList<LatLng>();
  @$core.pragma('dart2js:noInline')
  static LatLng getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LatLng>(create);
  static LatLng _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => clearField(2);
}

class FirebaseStorage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FirebaseStorage', package: const $pb.PackageName('common'), createEmptyInstance: create)
    ..aOS(1, 'full')
    ..aOS(2, 'medium')
    ..aOS(3, 'thumbnail')
    ..hasRequiredFields = false
  ;

  FirebaseStorage._() : super();
  factory FirebaseStorage() => create();
  factory FirebaseStorage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FirebaseStorage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FirebaseStorage clone() => FirebaseStorage()..mergeFromMessage(this);
  FirebaseStorage copyWith(void Function(FirebaseStorage) updates) => super.copyWith((message) => updates(message as FirebaseStorage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FirebaseStorage create() => FirebaseStorage._();
  FirebaseStorage createEmptyInstance() => create();
  static $pb.PbList<FirebaseStorage> createRepeated() => $pb.PbList<FirebaseStorage>();
  @$core.pragma('dart2js:noInline')
  static FirebaseStorage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FirebaseStorage>(create);
  static FirebaseStorage _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get full => $_getSZ(0);
  @$pb.TagNumber(1)
  set full($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFull() => $_has(0);
  @$pb.TagNumber(1)
  void clearFull() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get medium => $_getSZ(1);
  @$pb.TagNumber(2)
  set medium($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMedium() => $_has(1);
  @$pb.TagNumber(2)
  void clearMedium() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get thumbnail => $_getSZ(2);
  @$pb.TagNumber(3)
  set thumbnail($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasThumbnail() => $_has(2);
  @$pb.TagNumber(3)
  void clearThumbnail() => clearField(3);
}

class AppMetadata extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AppMetadata', package: const $pb.PackageName('common'), createEmptyInstance: create)
    ..aOS(1, 'appId')
    ..aOS(2, 'appName')
    ..aOS(3, 'platformVersion')
    ..aOS(4, 'projectCode')
    ..aOS(5, 'projectVersion')
    ..hasRequiredFields = false
  ;

  AppMetadata._() : super();
  factory AppMetadata() => create();
  factory AppMetadata.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AppMetadata.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AppMetadata clone() => AppMetadata()..mergeFromMessage(this);
  AppMetadata copyWith(void Function(AppMetadata) updates) => super.copyWith((message) => updates(message as AppMetadata));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AppMetadata create() => AppMetadata._();
  AppMetadata createEmptyInstance() => create();
  static $pb.PbList<AppMetadata> createRepeated() => $pb.PbList<AppMetadata>();
  @$core.pragma('dart2js:noInline')
  static AppMetadata getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AppMetadata>(create);
  static AppMetadata _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get appId => $_getSZ(0);
  @$pb.TagNumber(1)
  set appId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAppId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAppId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get appName => $_getSZ(1);
  @$pb.TagNumber(2)
  set appName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAppName() => $_has(1);
  @$pb.TagNumber(2)
  void clearAppName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get platformVersion => $_getSZ(2);
  @$pb.TagNumber(3)
  set platformVersion($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPlatformVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlatformVersion() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get projectCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set projectCode($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProjectCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearProjectCode() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get projectVersion => $_getSZ(4);
  @$pb.TagNumber(5)
  set projectVersion($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProjectVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearProjectVersion() => clearField(5);
}

class Point extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Point', package: const $pb.PackageName('common'), createEmptyInstance: create)
    ..a<$core.double>(1, 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, 'y', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Point._() : super();
  factory Point() => create();
  factory Point.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Point.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Point clone() => Point()..mergeFromMessage(this);
  Point copyWith(void Function(Point) updates) => super.copyWith((message) => updates(message as Point));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Point create() => Point._();
  Point createEmptyInstance() => create();
  static $pb.PbList<Point> createRepeated() => $pb.PbList<Point>();
  @$core.pragma('dart2js:noInline')
  static Point getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Point>(create);
  static Point _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);
}

class Polygon extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Polygon', package: const $pb.PackageName('common'), createEmptyInstance: create)
    ..pc<Point>(1, 'vertices', $pb.PbFieldType.PM, subBuilder: Point.create)
    ..hasRequiredFields = false
  ;

  Polygon._() : super();
  factory Polygon() => create();
  factory Polygon.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Polygon.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Polygon clone() => Polygon()..mergeFromMessage(this);
  Polygon copyWith(void Function(Polygon) updates) => super.copyWith((message) => updates(message as Polygon));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Polygon create() => Polygon._();
  Polygon createEmptyInstance() => create();
  static $pb.PbList<Polygon> createRepeated() => $pb.PbList<Polygon>();
  @$core.pragma('dart2js:noInline')
  static Polygon getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Polygon>(create);
  static Polygon _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Point> get vertices => $_getList(0);
}

class Size extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Size', package: const $pb.PackageName('common'), createEmptyInstance: create)
    ..a<$core.int>(1, 'width', $pb.PbFieldType.O3)
    ..a<$core.int>(2, 'height', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Size._() : super();
  factory Size() => create();
  factory Size.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Size.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Size clone() => Size()..mergeFromMessage(this);
  Size copyWith(void Function(Size) updates) => super.copyWith((message) => updates(message as Size));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Size create() => Size._();
  Size createEmptyInstance() => create();
  static $pb.PbList<Size> createRepeated() => $pb.PbList<Size>();
  @$core.pragma('dart2js:noInline')
  static Size getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Size>(create);
  static Size _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get width => $_getIZ(0);
  @$pb.TagNumber(1)
  set width($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWidth() => $_has(0);
  @$pb.TagNumber(1)
  void clearWidth() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get height => $_getIZ(1);
  @$pb.TagNumber(2)
  set height($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);
}

class FirePhoto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FirePhoto', package: const $pb.PackageName('common'), createEmptyInstance: create)
    ..aOM<DocumentReferenceProto>(1, 'photoReference', subBuilder: DocumentReferenceProto.create)
    ..aOS(2, 'firebaseStorage')
    ..aOM<Point>(3, 'center', subBuilder: Point.create)
    ..aOM<Size>(4, 'photoSize', subBuilder: Size.create)
    ..hasRequiredFields = false
  ;

  FirePhoto._() : super();
  factory FirePhoto() => create();
  factory FirePhoto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FirePhoto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FirePhoto clone() => FirePhoto()..mergeFromMessage(this);
  FirePhoto copyWith(void Function(FirePhoto) updates) => super.copyWith((message) => updates(message as FirePhoto));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FirePhoto create() => FirePhoto._();
  FirePhoto createEmptyInstance() => create();
  static $pb.PbList<FirePhoto> createRepeated() => $pb.PbList<FirePhoto>();
  @$core.pragma('dart2js:noInline')
  static FirePhoto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FirePhoto>(create);
  static FirePhoto _defaultInstance;

  @$pb.TagNumber(1)
  DocumentReferenceProto get photoReference => $_getN(0);
  @$pb.TagNumber(1)
  set photoReference(DocumentReferenceProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhotoReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhotoReference() => clearField(1);
  @$pb.TagNumber(1)
  DocumentReferenceProto ensurePhotoReference() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get firebaseStorage => $_getSZ(1);
  @$pb.TagNumber(2)
  set firebaseStorage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirebaseStorage() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirebaseStorage() => clearField(2);

  @$pb.TagNumber(3)
  Point get center => $_getN(2);
  @$pb.TagNumber(3)
  set center(Point v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCenter() => $_has(2);
  @$pb.TagNumber(3)
  void clearCenter() => clearField(3);
  @$pb.TagNumber(3)
  Point ensureCenter() => $_ensure(2);

  @$pb.TagNumber(4)
  Size get photoSize => $_getN(3);
  @$pb.TagNumber(4)
  set photoSize(Size v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhotoSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhotoSize() => clearField(4);
  @$pb.TagNumber(4)
  Size ensurePhotoSize() => $_ensure(3);
}

class DuplicateFbPlaceIdRecord extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DuplicateFbPlaceIdRecord', package: const $pb.PackageName('common'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'duplicateId', $pb.PbFieldType.OS6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, 'sourceId', $pb.PbFieldType.OS6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  DuplicateFbPlaceIdRecord._() : super();
  factory DuplicateFbPlaceIdRecord() => create();
  factory DuplicateFbPlaceIdRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DuplicateFbPlaceIdRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DuplicateFbPlaceIdRecord clone() => DuplicateFbPlaceIdRecord()..mergeFromMessage(this);
  DuplicateFbPlaceIdRecord copyWith(void Function(DuplicateFbPlaceIdRecord) updates) => super.copyWith((message) => updates(message as DuplicateFbPlaceIdRecord));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DuplicateFbPlaceIdRecord create() => DuplicateFbPlaceIdRecord._();
  DuplicateFbPlaceIdRecord createEmptyInstance() => create();
  static $pb.PbList<DuplicateFbPlaceIdRecord> createRepeated() => $pb.PbList<DuplicateFbPlaceIdRecord>();
  @$core.pragma('dart2js:noInline')
  static DuplicateFbPlaceIdRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DuplicateFbPlaceIdRecord>(create);
  static DuplicateFbPlaceIdRecord _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get duplicateId => $_getI64(0);
  @$pb.TagNumber(1)
  set duplicateId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDuplicateId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDuplicateId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sourceId => $_getI64(1);
  @$pb.TagNumber(2)
  set sourceId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSourceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceId() => clearField(2);
}

class FbPlaceIdDuplicates extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FbPlaceIdDuplicates', package: const $pb.PackageName('common'), createEmptyInstance: create)
    ..pc<DuplicateFbPlaceIdRecord>(1, 'records', $pb.PbFieldType.PM, subBuilder: DuplicateFbPlaceIdRecord.create)
    ..hasRequiredFields = false
  ;

  FbPlaceIdDuplicates._() : super();
  factory FbPlaceIdDuplicates() => create();
  factory FbPlaceIdDuplicates.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FbPlaceIdDuplicates.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FbPlaceIdDuplicates clone() => FbPlaceIdDuplicates()..mergeFromMessage(this);
  FbPlaceIdDuplicates copyWith(void Function(FbPlaceIdDuplicates) updates) => super.copyWith((message) => updates(message as FbPlaceIdDuplicates));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FbPlaceIdDuplicates create() => FbPlaceIdDuplicates._();
  FbPlaceIdDuplicates createEmptyInstance() => create();
  static $pb.PbList<FbPlaceIdDuplicates> createRepeated() => $pb.PbList<FbPlaceIdDuplicates>();
  @$core.pragma('dart2js:noInline')
  static FbPlaceIdDuplicates getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FbPlaceIdDuplicates>(create);
  static FbPlaceIdDuplicates _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<DuplicateFbPlaceIdRecord> get records => $_getList(0);
}

class ScraperResults extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ScraperResults', package: const $pb.PackageName('common'), createEmptyInstance: create)
    ..aOS(1, 'placeId')
    ..aOS(2, 'name')
    ..aOS(3, 'address')
    ..a<$core.int>(4, 'numReviews', $pb.PbFieldType.O3)
    ..a<$core.int>(5, 'numScrapedReviews', $pb.PbFieldType.O3)
    ..a<$core.double>(6, 'avgRating', $pb.PbFieldType.OF)
    ..aOS(7, 'url')
    ..hasRequiredFields = false
  ;

  ScraperResults._() : super();
  factory ScraperResults() => create();
  factory ScraperResults.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScraperResults.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ScraperResults clone() => ScraperResults()..mergeFromMessage(this);
  ScraperResults copyWith(void Function(ScraperResults) updates) => super.copyWith((message) => updates(message as ScraperResults));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScraperResults create() => ScraperResults._();
  ScraperResults createEmptyInstance() => create();
  static $pb.PbList<ScraperResults> createRepeated() => $pb.PbList<ScraperResults>();
  @$core.pragma('dart2js:noInline')
  static ScraperResults getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScraperResults>(create);
  static ScraperResults _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get placeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set placeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlaceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlaceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get address => $_getSZ(2);
  @$pb.TagNumber(3)
  set address($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddress() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get numReviews => $_getIZ(3);
  @$pb.TagNumber(4)
  set numReviews($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNumReviews() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumReviews() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get numScrapedReviews => $_getIZ(4);
  @$pb.TagNumber(5)
  set numScrapedReviews($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNumScrapedReviews() => $_has(4);
  @$pb.TagNumber(5)
  void clearNumScrapedReviews() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get avgRating => $_getN(5);
  @$pb.TagNumber(6)
  set avgRating($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAvgRating() => $_has(5);
  @$pb.TagNumber(6)
  void clearAvgRating() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get url => $_getSZ(6);
  @$pb.TagNumber(7)
  set url($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearUrl() => clearField(7);
}

