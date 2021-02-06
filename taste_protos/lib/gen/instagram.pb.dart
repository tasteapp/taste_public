///
//  Generated code. Do not modify.
//  source: instagram.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'firestore.pb.dart' as $5;
import 'google/protobuf/timestamp.pb.dart' as $0;

import 'review.pbenum.dart' as $2;
import 'instagram.pbenum.dart';

export 'instagram.pbenum.dart';

class ImageInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ImageInfo', package: const $pb.PackageName('instagram'), createEmptyInstance: create)
    ..a<$core.int>(1, 'width', $pb.PbFieldType.O3)
    ..a<$core.int>(2, 'height', $pb.PbFieldType.O3)
    ..aOS(3, 'url')
    ..hasRequiredFields = false
  ;

  ImageInfo._() : super();
  factory ImageInfo() => create();
  factory ImageInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ImageInfo clone() => ImageInfo()..mergeFromMessage(this);
  ImageInfo copyWith(void Function(ImageInfo) updates) => super.copyWith((message) => updates(message as ImageInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageInfo create() => ImageInfo._();
  ImageInfo createEmptyInstance() => create();
  static $pb.PbList<ImageInfo> createRepeated() => $pb.PbList<ImageInfo>();
  @$core.pragma('dart2js:noInline')
  static ImageInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageInfo>(create);
  static ImageInfo _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => clearField(3);
}

class ImageLabel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ImageLabel', package: const $pb.PackageName('instagram'), createEmptyInstance: create)
    ..aOS(1, 'label')
    ..a<$core.double>(2, 'confidence', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ImageLabel._() : super();
  factory ImageLabel() => create();
  factory ImageLabel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageLabel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ImageLabel clone() => ImageLabel()..mergeFromMessage(this);
  ImageLabel copyWith(void Function(ImageLabel) updates) => super.copyWith((message) => updates(message as ImageLabel));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageLabel create() => ImageLabel._();
  ImageLabel createEmptyInstance() => create();
  static $pb.PbList<ImageLabel> createRepeated() => $pb.PbList<ImageLabel>();
  @$core.pragma('dart2js:noInline')
  static ImageLabel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageLabel>(create);
  static ImageLabel _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get confidence => $_getN(1);
  @$pb.TagNumber(2)
  set confidence($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasConfidence() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfidence() => clearField(2);
}

class ImageAnnotations_PersonDetection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ImageAnnotations.PersonDetection', package: const $pb.PackageName('instagram'), createEmptyInstance: create)
    ..a<$core.double>(1, 'confidence', $pb.PbFieldType.OD)
    ..a<$core.double>(2, 'bboxArea', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ImageAnnotations_PersonDetection._() : super();
  factory ImageAnnotations_PersonDetection() => create();
  factory ImageAnnotations_PersonDetection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageAnnotations_PersonDetection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ImageAnnotations_PersonDetection clone() => ImageAnnotations_PersonDetection()..mergeFromMessage(this);
  ImageAnnotations_PersonDetection copyWith(void Function(ImageAnnotations_PersonDetection) updates) => super.copyWith((message) => updates(message as ImageAnnotations_PersonDetection));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageAnnotations_PersonDetection create() => ImageAnnotations_PersonDetection._();
  ImageAnnotations_PersonDetection createEmptyInstance() => create();
  static $pb.PbList<ImageAnnotations_PersonDetection> createRepeated() => $pb.PbList<ImageAnnotations_PersonDetection>();
  @$core.pragma('dart2js:noInline')
  static ImageAnnotations_PersonDetection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageAnnotations_PersonDetection>(create);
  static ImageAnnotations_PersonDetection _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get confidence => $_getN(0);
  @$pb.TagNumber(1)
  set confidence($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConfidence() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfidence() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get bboxArea => $_getN(1);
  @$pb.TagNumber(2)
  set bboxArea($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBboxArea() => $_has(1);
  @$pb.TagNumber(2)
  void clearBboxArea() => clearField(2);
}

class ImageAnnotations extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ImageAnnotations', package: const $pb.PackageName('instagram'), createEmptyInstance: create)
    ..a<$core.double>(1, 'isFood', $pb.PbFieldType.OD)
    ..a<$core.double>(2, 'isDrink', $pb.PbFieldType.OD)
    ..pc<ImageAnnotations_PersonDetection>(3, 'personDetections', $pb.PbFieldType.PM, subBuilder: ImageAnnotations_PersonDetection.create)
    ..hasRequiredFields = false
  ;

  ImageAnnotations._() : super();
  factory ImageAnnotations() => create();
  factory ImageAnnotations.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageAnnotations.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ImageAnnotations clone() => ImageAnnotations()..mergeFromMessage(this);
  ImageAnnotations copyWith(void Function(ImageAnnotations) updates) => super.copyWith((message) => updates(message as ImageAnnotations));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageAnnotations create() => ImageAnnotations._();
  ImageAnnotations createEmptyInstance() => create();
  static $pb.PbList<ImageAnnotations> createRepeated() => $pb.PbList<ImageAnnotations>();
  @$core.pragma('dart2js:noInline')
  static ImageAnnotations getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageAnnotations>(create);
  static ImageAnnotations _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get isFood => $_getN(0);
  @$pb.TagNumber(1)
  set isFood($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsFood() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsFood() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get isDrink => $_getN(1);
  @$pb.TagNumber(2)
  set isDrink($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsDrink() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsDrink() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<ImageAnnotations_PersonDetection> get personDetections => $_getList(2);
}

class InstagramImage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InstagramImage', package: const $pb.PackageName('instagram'), createEmptyInstance: create)
    ..aOM<ImageInfo>(1, 'thumbnail', subBuilder: ImageInfo.create)
    ..aOM<ImageInfo>(2, 'lowRes', subBuilder: ImageInfo.create)
    ..aOM<ImageInfo>(3, 'standardRes', subBuilder: ImageInfo.create)
    ..aOB(4, 'isFoodOrDrink')
    ..pc<ImageLabel>(5, 'mlLabels', $pb.PbFieldType.PM, subBuilder: ImageLabel.create)
    ..aOM<$1.DocumentReferenceProto>(6, 'photo', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<ImageAnnotations>(7, 'imageAnnotations', subBuilder: ImageAnnotations.create)
    ..aOB(8, 'hasPerson')
    ..hasRequiredFields = false
  ;

  InstagramImage._() : super();
  factory InstagramImage() => create();
  factory InstagramImage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstagramImage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InstagramImage clone() => InstagramImage()..mergeFromMessage(this);
  InstagramImage copyWith(void Function(InstagramImage) updates) => super.copyWith((message) => updates(message as InstagramImage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InstagramImage create() => InstagramImage._();
  InstagramImage createEmptyInstance() => create();
  static $pb.PbList<InstagramImage> createRepeated() => $pb.PbList<InstagramImage>();
  @$core.pragma('dart2js:noInline')
  static InstagramImage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstagramImage>(create);
  static InstagramImage _defaultInstance;

  @$pb.TagNumber(1)
  ImageInfo get thumbnail => $_getN(0);
  @$pb.TagNumber(1)
  set thumbnail(ImageInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasThumbnail() => $_has(0);
  @$pb.TagNumber(1)
  void clearThumbnail() => clearField(1);
  @$pb.TagNumber(1)
  ImageInfo ensureThumbnail() => $_ensure(0);

  @$pb.TagNumber(2)
  ImageInfo get lowRes => $_getN(1);
  @$pb.TagNumber(2)
  set lowRes(ImageInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLowRes() => $_has(1);
  @$pb.TagNumber(2)
  void clearLowRes() => clearField(2);
  @$pb.TagNumber(2)
  ImageInfo ensureLowRes() => $_ensure(1);

  @$pb.TagNumber(3)
  ImageInfo get standardRes => $_getN(2);
  @$pb.TagNumber(3)
  set standardRes(ImageInfo v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStandardRes() => $_has(2);
  @$pb.TagNumber(3)
  void clearStandardRes() => clearField(3);
  @$pb.TagNumber(3)
  ImageInfo ensureStandardRes() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get isFoodOrDrink => $_getBF(3);
  @$pb.TagNumber(4)
  set isFoodOrDrink($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsFoodOrDrink() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsFoodOrDrink() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<ImageLabel> get mlLabels => $_getList(4);

  @$pb.TagNumber(6)
  $1.DocumentReferenceProto get photo => $_getN(5);
  @$pb.TagNumber(6)
  set photo($1.DocumentReferenceProto v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhoto() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhoto() => clearField(6);
  @$pb.TagNumber(6)
  $1.DocumentReferenceProto ensurePhoto() => $_ensure(5);

  @$pb.TagNumber(7)
  ImageAnnotations get imageAnnotations => $_getN(6);
  @$pb.TagNumber(7)
  set imageAnnotations(ImageAnnotations v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasImageAnnotations() => $_has(6);
  @$pb.TagNumber(7)
  void clearImageAnnotations() => clearField(7);
  @$pb.TagNumber(7)
  ImageAnnotations ensureImageAnnotations() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get hasPerson => $_getBF(7);
  @$pb.TagNumber(8)
  set hasPerson($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasHasPerson() => $_has(7);
  @$pb.TagNumber(8)
  void clearHasPerson() => clearField(8);
}

class InstagramLocation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InstagramLocation', package: const $pb.PackageName('instagram'), createEmptyInstance: create)
    ..aOM<$1.LatLng>(1, 'location', subBuilder: $1.LatLng.create)
    ..aOS(2, 'name')
    ..aOS(3, 'id')
    ..aOS(4, 'address')
    ..pPS(5, 'postCodes')
    ..aOM<FacebookLocation>(6, 'fbLocation', subBuilder: FacebookLocation.create)
    ..aOB(7, 'queriedLocation')
    ..a<$core.int>(8, 'numRequests', $pb.PbFieldType.O3)
    ..aOB(9, 'foundMatch')
    ..hasRequiredFields = false
  ;

  InstagramLocation._() : super();
  factory InstagramLocation() => create();
  factory InstagramLocation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstagramLocation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InstagramLocation clone() => InstagramLocation()..mergeFromMessage(this);
  InstagramLocation copyWith(void Function(InstagramLocation) updates) => super.copyWith((message) => updates(message as InstagramLocation));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InstagramLocation create() => InstagramLocation._();
  InstagramLocation createEmptyInstance() => create();
  static $pb.PbList<InstagramLocation> createRepeated() => $pb.PbList<InstagramLocation>();
  @$core.pragma('dart2js:noInline')
  static InstagramLocation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstagramLocation>(create);
  static InstagramLocation _defaultInstance;

  @$pb.TagNumber(1)
  $1.LatLng get location => $_getN(0);
  @$pb.TagNumber(1)
  set location($1.LatLng v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocation() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocation() => clearField(1);
  @$pb.TagNumber(1)
  $1.LatLng ensureLocation() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get id => $_getSZ(2);
  @$pb.TagNumber(3)
  set id($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasId() => $_has(2);
  @$pb.TagNumber(3)
  void clearId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get address => $_getSZ(3);
  @$pb.TagNumber(4)
  set address($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearAddress() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get postCodes => $_getList(4);

  @$pb.TagNumber(6)
  FacebookLocation get fbLocation => $_getN(5);
  @$pb.TagNumber(6)
  set fbLocation(FacebookLocation v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasFbLocation() => $_has(5);
  @$pb.TagNumber(6)
  void clearFbLocation() => clearField(6);
  @$pb.TagNumber(6)
  FacebookLocation ensureFbLocation() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.bool get queriedLocation => $_getBF(6);
  @$pb.TagNumber(7)
  set queriedLocation($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasQueriedLocation() => $_has(6);
  @$pb.TagNumber(7)
  void clearQueriedLocation() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get numRequests => $_getIZ(7);
  @$pb.TagNumber(8)
  set numRequests($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasNumRequests() => $_has(7);
  @$pb.TagNumber(8)
  void clearNumRequests() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get foundMatch => $_getBF(8);
  @$pb.TagNumber(9)
  set foundMatch($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFoundMatch() => $_has(8);
  @$pb.TagNumber(9)
  void clearFoundMatch() => clearField(9);
}

class FacebookLocation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FacebookLocation', package: const $pb.PackageName('instagram'), createEmptyInstance: create)
    ..aOS(1, 'fbPlaceId')
    ..aOS(2, 'name')
    ..aOM<$1.LatLng>(3, 'location', subBuilder: $1.LatLng.create)
    ..aOM<$5.Restaurant_Attributes_Address>(4, 'address', subBuilder: $5.Restaurant_Attributes_Address.create)
    ..pPS(5, 'categories')
    ..aOS(6, 'phone')
    ..aOS(7, 'website')
    ..aOM<$5.Restaurant_Hours>(8, 'hours', subBuilder: $5.Restaurant_Hours.create)
    ..hasRequiredFields = false
  ;

  FacebookLocation._() : super();
  factory FacebookLocation() => create();
  factory FacebookLocation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FacebookLocation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FacebookLocation clone() => FacebookLocation()..mergeFromMessage(this);
  FacebookLocation copyWith(void Function(FacebookLocation) updates) => super.copyWith((message) => updates(message as FacebookLocation));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FacebookLocation create() => FacebookLocation._();
  FacebookLocation createEmptyInstance() => create();
  static $pb.PbList<FacebookLocation> createRepeated() => $pb.PbList<FacebookLocation>();
  @$core.pragma('dart2js:noInline')
  static FacebookLocation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FacebookLocation>(create);
  static FacebookLocation _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fbPlaceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fbPlaceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFbPlaceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFbPlaceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $1.LatLng get location => $_getN(2);
  @$pb.TagNumber(3)
  set location($1.LatLng v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocation() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocation() => clearField(3);
  @$pb.TagNumber(3)
  $1.LatLng ensureLocation() => $_ensure(2);

  @$pb.TagNumber(4)
  $5.Restaurant_Attributes_Address get address => $_getN(3);
  @$pb.TagNumber(4)
  set address($5.Restaurant_Attributes_Address v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearAddress() => clearField(4);
  @$pb.TagNumber(4)
  $5.Restaurant_Attributes_Address ensureAddress() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.List<$core.String> get categories => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get phone => $_getSZ(5);
  @$pb.TagNumber(6)
  set phone($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhone() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhone() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get website => $_getSZ(6);
  @$pb.TagNumber(7)
  set website($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasWebsite() => $_has(6);
  @$pb.TagNumber(7)
  void clearWebsite() => clearField(7);

  @$pb.TagNumber(8)
  $5.Restaurant_Hours get hours => $_getN(7);
  @$pb.TagNumber(8)
  set hours($5.Restaurant_Hours v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasHours() => $_has(7);
  @$pb.TagNumber(8)
  void clearHours() => clearField(8);
  @$pb.TagNumber(8)
  $5.Restaurant_Hours ensureHours() => $_ensure(7);
}

class InstaPost extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InstaPost', package: const $pb.PackageName('instagram'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(2, 'postId')
    ..aOS(3, 'username')
    ..pc<InstagramImage>(4, 'images', $pb.PbFieldType.PM, subBuilder: InstagramImage.create)
    ..aOS(5, 'caption')
    ..aOM<InstagramLocation>(6, 'instagramLocation', subBuilder: InstagramLocation.create)
    ..aOM<FacebookLocation>(7, 'fbLocation', subBuilder: FacebookLocation.create)
    ..aOB(8, 'isHomecooked')
    ..aOM<$0.Timestamp>(9, 'createdTime', subBuilder: $0.Timestamp.create)
    ..aOS(10, 'userId')
    ..a<$core.int>(11, 'likes', $pb.PbFieldType.O3)
    ..pPS(12, 'tags')
    ..aOB(13, 'isManual')
    ..aOS(14, 'link')
    ..e<$2.Reaction>(15, 'reaction', $pb.PbFieldType.OE, defaultOrMaker: $2.Reaction.UNDEFINED, valueOf: $2.Reaction.valueOf, enumValues: $2.Reaction.values)
    ..aOB(16, 'hasReview')
    ..aOS(17, 'dish')
    ..aOB(18, 'triedExtraInfo')
    ..a<$core.int>(19, 'numUpdateAttempts', $pb.PbFieldType.O3)
    ..a<$core.int>(20, 'numFollowers', $pb.PbFieldType.O3)
    ..aOB(21, 'hidden')
    ..aOB(22, 'doNotUpdate')
    ..aOM<$1.Extras>(23, 'Extras', subBuilder: $1.Extras.create)
    ..aOB(24, 'photosLabeled')
    ..pc<ImageAnnotations>(25, 'imageAnnotations', $pb.PbFieldType.PM, subBuilder: ImageAnnotations.create)
    ..hasRequiredFields = false
  ;

  InstaPost._() : super();
  factory InstaPost() => create();
  factory InstaPost.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstaPost.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InstaPost clone() => InstaPost()..mergeFromMessage(this);
  InstaPost copyWith(void Function(InstaPost) updates) => super.copyWith((message) => updates(message as InstaPost));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InstaPost create() => InstaPost._();
  InstaPost createEmptyInstance() => create();
  static $pb.PbList<InstaPost> createRepeated() => $pb.PbList<InstaPost>();
  @$core.pragma('dart2js:noInline')
  static InstaPost getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstaPost>(create);
  static InstaPost _defaultInstance;

  @$pb.TagNumber(1)
  $1.DocumentReferenceProto get user => $_getN(0);
  @$pb.TagNumber(1)
  set user($1.DocumentReferenceProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  $1.DocumentReferenceProto ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get postId => $_getSZ(1);
  @$pb.TagNumber(2)
  set postId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPostId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPostId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get username => $_getSZ(2);
  @$pb.TagNumber(3)
  set username($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsername() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<InstagramImage> get images => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get caption => $_getSZ(4);
  @$pb.TagNumber(5)
  set caption($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCaption() => $_has(4);
  @$pb.TagNumber(5)
  void clearCaption() => clearField(5);

  @$pb.TagNumber(6)
  InstagramLocation get instagramLocation => $_getN(5);
  @$pb.TagNumber(6)
  set instagramLocation(InstagramLocation v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasInstagramLocation() => $_has(5);
  @$pb.TagNumber(6)
  void clearInstagramLocation() => clearField(6);
  @$pb.TagNumber(6)
  InstagramLocation ensureInstagramLocation() => $_ensure(5);

  @$pb.TagNumber(7)
  FacebookLocation get fbLocation => $_getN(6);
  @$pb.TagNumber(7)
  set fbLocation(FacebookLocation v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasFbLocation() => $_has(6);
  @$pb.TagNumber(7)
  void clearFbLocation() => clearField(7);
  @$pb.TagNumber(7)
  FacebookLocation ensureFbLocation() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get isHomecooked => $_getBF(7);
  @$pb.TagNumber(8)
  set isHomecooked($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsHomecooked() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsHomecooked() => clearField(8);

  @$pb.TagNumber(9)
  $0.Timestamp get createdTime => $_getN(8);
  @$pb.TagNumber(9)
  set createdTime($0.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedTime() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedTime() => clearField(9);
  @$pb.TagNumber(9)
  $0.Timestamp ensureCreatedTime() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get userId => $_getSZ(9);
  @$pb.TagNumber(10)
  set userId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasUserId() => $_has(9);
  @$pb.TagNumber(10)
  void clearUserId() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get likes => $_getIZ(10);
  @$pb.TagNumber(11)
  set likes($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasLikes() => $_has(10);
  @$pb.TagNumber(11)
  void clearLikes() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<$core.String> get tags => $_getList(11);

  @$pb.TagNumber(13)
  $core.bool get isManual => $_getBF(12);
  @$pb.TagNumber(13)
  set isManual($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIsManual() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsManual() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get link => $_getSZ(13);
  @$pb.TagNumber(14)
  set link($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasLink() => $_has(13);
  @$pb.TagNumber(14)
  void clearLink() => clearField(14);

  @$pb.TagNumber(15)
  $2.Reaction get reaction => $_getN(14);
  @$pb.TagNumber(15)
  set reaction($2.Reaction v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasReaction() => $_has(14);
  @$pb.TagNumber(15)
  void clearReaction() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get hasReview => $_getBF(15);
  @$pb.TagNumber(16)
  set hasReview($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasHasReview() => $_has(15);
  @$pb.TagNumber(16)
  void clearHasReview() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get dish => $_getSZ(16);
  @$pb.TagNumber(17)
  set dish($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasDish() => $_has(16);
  @$pb.TagNumber(17)
  void clearDish() => clearField(17);

  @$pb.TagNumber(18)
  $core.bool get triedExtraInfo => $_getBF(17);
  @$pb.TagNumber(18)
  set triedExtraInfo($core.bool v) { $_setBool(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasTriedExtraInfo() => $_has(17);
  @$pb.TagNumber(18)
  void clearTriedExtraInfo() => clearField(18);

  @$pb.TagNumber(19)
  $core.int get numUpdateAttempts => $_getIZ(18);
  @$pb.TagNumber(19)
  set numUpdateAttempts($core.int v) { $_setSignedInt32(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasNumUpdateAttempts() => $_has(18);
  @$pb.TagNumber(19)
  void clearNumUpdateAttempts() => clearField(19);

  @$pb.TagNumber(20)
  $core.int get numFollowers => $_getIZ(19);
  @$pb.TagNumber(20)
  set numFollowers($core.int v) { $_setSignedInt32(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasNumFollowers() => $_has(19);
  @$pb.TagNumber(20)
  void clearNumFollowers() => clearField(20);

  @$pb.TagNumber(21)
  $core.bool get hidden => $_getBF(20);
  @$pb.TagNumber(21)
  set hidden($core.bool v) { $_setBool(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasHidden() => $_has(20);
  @$pb.TagNumber(21)
  void clearHidden() => clearField(21);

  @$pb.TagNumber(22)
  $core.bool get doNotUpdate => $_getBF(21);
  @$pb.TagNumber(22)
  set doNotUpdate($core.bool v) { $_setBool(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasDoNotUpdate() => $_has(21);
  @$pb.TagNumber(22)
  void clearDoNotUpdate() => clearField(22);

  @$pb.TagNumber(23)
  $1.Extras get extras => $_getN(22);
  @$pb.TagNumber(23)
  set extras($1.Extras v) { setField(23, v); }
  @$pb.TagNumber(23)
  $core.bool hasExtras() => $_has(22);
  @$pb.TagNumber(23)
  void clearExtras() => clearField(23);
  @$pb.TagNumber(23)
  $1.Extras ensureExtras() => $_ensure(22);

  @$pb.TagNumber(24)
  $core.bool get photosLabeled => $_getBF(23);
  @$pb.TagNumber(24)
  set photosLabeled($core.bool v) { $_setBool(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasPhotosLabeled() => $_has(23);
  @$pb.TagNumber(24)
  void clearPhotosLabeled() => clearField(24);

  @$pb.TagNumber(25)
  $core.List<ImageAnnotations> get imageAnnotations => $_getList(24);
}

class InstagramScrapeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InstagramScrapeRequest', package: const $pb.PackageName('instagram'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..aOM<$1.DocumentReferenceProto>(2, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..a<$core.int>(3, 'index', $pb.PbFieldType.O3)
    ..a<$core.int>(4, 'priority', $pb.PbFieldType.O3)
    ..aOB(5, 'ignoreMostRecent')
    ..aOB(6, 'failed')
    ..aOS(7, 'failureStack')
    ..hasRequiredFields = false
  ;

  InstagramScrapeRequest._() : super();
  factory InstagramScrapeRequest() => create();
  factory InstagramScrapeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstagramScrapeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InstagramScrapeRequest clone() => InstagramScrapeRequest()..mergeFromMessage(this);
  InstagramScrapeRequest copyWith(void Function(InstagramScrapeRequest) updates) => super.copyWith((message) => updates(message as InstagramScrapeRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InstagramScrapeRequest create() => InstagramScrapeRequest._();
  InstagramScrapeRequest createEmptyInstance() => create();
  static $pb.PbList<InstagramScrapeRequest> createRepeated() => $pb.PbList<InstagramScrapeRequest>();
  @$core.pragma('dart2js:noInline')
  static InstagramScrapeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstagramScrapeRequest>(create);
  static InstagramScrapeRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  $1.DocumentReferenceProto get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($1.DocumentReferenceProto v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => clearField(2);
  @$pb.TagNumber(2)
  $1.DocumentReferenceProto ensureUser() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get index => $_getIZ(2);
  @$pb.TagNumber(3)
  set index($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearIndex() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get priority => $_getIZ(3);
  @$pb.TagNumber(4)
  set priority($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPriority() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriority() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get ignoreMostRecent => $_getBF(4);
  @$pb.TagNumber(5)
  set ignoreMostRecent($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIgnoreMostRecent() => $_has(4);
  @$pb.TagNumber(5)
  void clearIgnoreMostRecent() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get failed => $_getBF(5);
  @$pb.TagNumber(6)
  set failed($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFailed() => $_has(5);
  @$pb.TagNumber(6)
  void clearFailed() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get failureStack => $_getSZ(6);
  @$pb.TagNumber(7)
  set failureStack($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFailureStack() => $_has(6);
  @$pb.TagNumber(7)
  void clearFailureStack() => clearField(7);
}

class InstagramNetworkScrapeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InstagramNetworkScrapeRequest', package: const $pb.PackageName('instagram'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..a<$core.int>(2, 'index', $pb.PbFieldType.O3)
    ..a<$core.int>(3, 'priority', $pb.PbFieldType.O3)
    ..a<$core.int>(4, 'numFollowers', $pb.PbFieldType.O3)
    ..a<$core.int>(5, 'numPosts', $pb.PbFieldType.O3)
    ..aOB(6, 'failed')
    ..hasRequiredFields = false
  ;

  InstagramNetworkScrapeRequest._() : super();
  factory InstagramNetworkScrapeRequest() => create();
  factory InstagramNetworkScrapeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstagramNetworkScrapeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InstagramNetworkScrapeRequest clone() => InstagramNetworkScrapeRequest()..mergeFromMessage(this);
  InstagramNetworkScrapeRequest copyWith(void Function(InstagramNetworkScrapeRequest) updates) => super.copyWith((message) => updates(message as InstagramNetworkScrapeRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InstagramNetworkScrapeRequest create() => InstagramNetworkScrapeRequest._();
  InstagramNetworkScrapeRequest createEmptyInstance() => create();
  static $pb.PbList<InstagramNetworkScrapeRequest> createRepeated() => $pb.PbList<InstagramNetworkScrapeRequest>();
  @$core.pragma('dart2js:noInline')
  static InstagramNetworkScrapeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstagramNetworkScrapeRequest>(create);
  static InstagramNetworkScrapeRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get index => $_getIZ(1);
  @$pb.TagNumber(2)
  set index($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndex() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get priority => $_getIZ(2);
  @$pb.TagNumber(3)
  set priority($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPriority() => $_has(2);
  @$pb.TagNumber(3)
  void clearPriority() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get numFollowers => $_getIZ(3);
  @$pb.TagNumber(4)
  set numFollowers($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNumFollowers() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumFollowers() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get numPosts => $_getIZ(4);
  @$pb.TagNumber(5)
  set numPosts($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNumPosts() => $_has(4);
  @$pb.TagNumber(5)
  void clearNumPosts() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get failed => $_getBF(5);
  @$pb.TagNumber(6)
  set failed($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFailed() => $_has(5);
  @$pb.TagNumber(6)
  void clearFailed() => clearField(6);
}

class RejectedInstagramUsers extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RejectedInstagramUsers', package: const $pb.PackageName('instagram'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..aOS(2, 'fullName')
    ..e<RejectedInstagramUsers_RejectionReason>(3, 'reason', $pb.PbFieldType.OE, defaultOrMaker: RejectedInstagramUsers_RejectionReason.rejection_reason_undefined, valueOf: RejectedInstagramUsers_RejectionReason.valueOf, enumValues: RejectedInstagramUsers_RejectionReason.values)
    ..a<$core.int>(4, 'numFollowers', $pb.PbFieldType.O3)
    ..a<$core.int>(5, 'numPosts', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  RejectedInstagramUsers._() : super();
  factory RejectedInstagramUsers() => create();
  factory RejectedInstagramUsers.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RejectedInstagramUsers.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RejectedInstagramUsers clone() => RejectedInstagramUsers()..mergeFromMessage(this);
  RejectedInstagramUsers copyWith(void Function(RejectedInstagramUsers) updates) => super.copyWith((message) => updates(message as RejectedInstagramUsers));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RejectedInstagramUsers create() => RejectedInstagramUsers._();
  RejectedInstagramUsers createEmptyInstance() => create();
  static $pb.PbList<RejectedInstagramUsers> createRepeated() => $pb.PbList<RejectedInstagramUsers>();
  @$core.pragma('dart2js:noInline')
  static RejectedInstagramUsers getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RejectedInstagramUsers>(create);
  static RejectedInstagramUsers _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fullName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fullName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFullName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFullName() => clearField(2);

  @$pb.TagNumber(3)
  RejectedInstagramUsers_RejectionReason get reason => $_getN(2);
  @$pb.TagNumber(3)
  set reason(RejectedInstagramUsers_RejectionReason v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get numFollowers => $_getIZ(3);
  @$pb.TagNumber(4)
  set numFollowers($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNumFollowers() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumFollowers() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get numPosts => $_getIZ(4);
  @$pb.TagNumber(5)
  set numPosts($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNumPosts() => $_has(4);
  @$pb.TagNumber(5)
  void clearNumPosts() => clearField(5);
}

