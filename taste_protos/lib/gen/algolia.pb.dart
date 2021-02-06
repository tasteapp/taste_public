///
//  Generated code. Do not modify.
//  source: algolia.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;

import 'common.pbenum.dart' as $1;
import 'review.pbenum.dart' as $2;

export 'algolia.pbenum.dart';

class GeoLoc extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GeoLoc', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..a<$core.double>(1, 'lat', $pb.PbFieldType.OD)
    ..a<$core.double>(2, 'lng', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GeoLoc._() : super();
  factory GeoLoc() => create();
  factory GeoLoc.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GeoLoc.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GeoLoc clone() => GeoLoc()..mergeFromMessage(this);
  GeoLoc copyWith(void Function(GeoLoc) updates) => super.copyWith((message) => updates(message as GeoLoc));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GeoLoc create() => GeoLoc._();
  GeoLoc createEmptyInstance() => create();
  static $pb.PbList<GeoLoc> createRepeated() => $pb.PbList<GeoLoc>();
  @$core.pragma('dart2js:noInline')
  static GeoLoc getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GeoLoc>(create);
  static GeoLoc _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get lat => $_getN(0);
  @$pb.TagNumber(1)
  set lat($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLat() => $_has(0);
  @$pb.TagNumber(1)
  void clearLat() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get lng => $_getN(1);
  @$pb.TagNumber(2)
  set lng($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLng() => $_has(1);
  @$pb.TagNumber(2)
  void clearLng() => clearField(2);
}

class DiscoverCache extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DiscoverCache', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..aOS(2, 'reference')
    ..aOM<GeoLoc>(4, 'Geoloc', subBuilder: GeoLoc.create)
    ..pPS(5, 'Tags')
    ..aOS(6, 'objectID', protoName: 'objectID')
    ..aOS(7, 'recordType')
    ..aOS(8, 'username')
    ..aOS(9, 'restaurantName')
    ..hasRequiredFields = false
  ;

  DiscoverCache._() : super();
  factory DiscoverCache() => create();
  factory DiscoverCache.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscoverCache.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DiscoverCache clone() => DiscoverCache()..mergeFromMessage(this);
  DiscoverCache copyWith(void Function(DiscoverCache) updates) => super.copyWith((message) => updates(message as DiscoverCache));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DiscoverCache create() => DiscoverCache._();
  DiscoverCache createEmptyInstance() => create();
  static $pb.PbList<DiscoverCache> createRepeated() => $pb.PbList<DiscoverCache>();
  @$core.pragma('dart2js:noInline')
  static DiscoverCache getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiscoverCache>(create);
  static DiscoverCache _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => clearField(2);

  @$pb.TagNumber(4)
  GeoLoc get geoloc => $_getN(2);
  @$pb.TagNumber(4)
  set geoloc(GeoLoc v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGeoloc() => $_has(2);
  @$pb.TagNumber(4)
  void clearGeoloc() => clearField(4);
  @$pb.TagNumber(4)
  GeoLoc ensureGeoloc() => $_ensure(2);

  @$pb.TagNumber(5)
  $core.List<$core.String> get tags => $_getList(3);

  @$pb.TagNumber(6)
  $core.String get objectID => $_getSZ(4);
  @$pb.TagNumber(6)
  set objectID($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasObjectID() => $_has(4);
  @$pb.TagNumber(6)
  void clearObjectID() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get recordType => $_getSZ(5);
  @$pb.TagNumber(7)
  set recordType($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasRecordType() => $_has(5);
  @$pb.TagNumber(7)
  void clearRecordType() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get username => $_getSZ(6);
  @$pb.TagNumber(8)
  set username($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasUsername() => $_has(6);
  @$pb.TagNumber(8)
  void clearUsername() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get restaurantName => $_getSZ(7);
  @$pb.TagNumber(9)
  set restaurantName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasRestaurantName() => $_has(7);
  @$pb.TagNumber(9)
  void clearRestaurantName() => clearField(9);
}

class RestaurantMarkerCache_TopReview_User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RestaurantMarkerCache.TopReview.User', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..aOS(1, 'thumbnail')
    ..hasRequiredFields = false
  ;

  RestaurantMarkerCache_TopReview_User._() : super();
  factory RestaurantMarkerCache_TopReview_User() => create();
  factory RestaurantMarkerCache_TopReview_User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RestaurantMarkerCache_TopReview_User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RestaurantMarkerCache_TopReview_User clone() => RestaurantMarkerCache_TopReview_User()..mergeFromMessage(this);
  RestaurantMarkerCache_TopReview_User copyWith(void Function(RestaurantMarkerCache_TopReview_User) updates) => super.copyWith((message) => updates(message as RestaurantMarkerCache_TopReview_User));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RestaurantMarkerCache_TopReview_User create() => RestaurantMarkerCache_TopReview_User._();
  RestaurantMarkerCache_TopReview_User createEmptyInstance() => create();
  static $pb.PbList<RestaurantMarkerCache_TopReview_User> createRepeated() => $pb.PbList<RestaurantMarkerCache_TopReview_User>();
  @$core.pragma('dart2js:noInline')
  static RestaurantMarkerCache_TopReview_User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RestaurantMarkerCache_TopReview_User>(create);
  static RestaurantMarkerCache_TopReview_User _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get thumbnail => $_getSZ(0);
  @$pb.TagNumber(1)
  set thumbnail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasThumbnail() => $_has(0);
  @$pb.TagNumber(1)
  void clearThumbnail() => clearField(1);
}

class RestaurantMarkerCache_TopReview extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RestaurantMarkerCache.TopReview', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..aOM<RestaurantMarkerCache_TopReview_User>(1, 'user', subBuilder: RestaurantMarkerCache_TopReview_User.create)
    ..aOS(2, 'photo')
    ..a<$core.int>(3, 'score', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  RestaurantMarkerCache_TopReview._() : super();
  factory RestaurantMarkerCache_TopReview() => create();
  factory RestaurantMarkerCache_TopReview.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RestaurantMarkerCache_TopReview.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RestaurantMarkerCache_TopReview clone() => RestaurantMarkerCache_TopReview()..mergeFromMessage(this);
  RestaurantMarkerCache_TopReview copyWith(void Function(RestaurantMarkerCache_TopReview) updates) => super.copyWith((message) => updates(message as RestaurantMarkerCache_TopReview));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RestaurantMarkerCache_TopReview create() => RestaurantMarkerCache_TopReview._();
  RestaurantMarkerCache_TopReview createEmptyInstance() => create();
  static $pb.PbList<RestaurantMarkerCache_TopReview> createRepeated() => $pb.PbList<RestaurantMarkerCache_TopReview>();
  @$core.pragma('dart2js:noInline')
  static RestaurantMarkerCache_TopReview getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RestaurantMarkerCache_TopReview>(create);
  static RestaurantMarkerCache_TopReview _defaultInstance;

  @$pb.TagNumber(1)
  RestaurantMarkerCache_TopReview_User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(RestaurantMarkerCache_TopReview_User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  RestaurantMarkerCache_TopReview_User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get photo => $_getSZ(1);
  @$pb.TagNumber(2)
  set photo($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPhoto() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhoto() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get score => $_getIZ(2);
  @$pb.TagNumber(3)
  set score($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearScore() => clearField(3);
}

class RestaurantMarkerCache extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RestaurantMarkerCache', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..a<$core.int>(3, 'numFavorites', $pb.PbFieldType.O3)
    ..aOM<RestaurantMarkerCache_TopReview>(4, 'topReview', subBuilder: RestaurantMarkerCache_TopReview.create)
    ..pPS(5, 'reviewers')
    ..pc<ReviewInfoCache>(6, 'reviews', $pb.PbFieldType.PM, subBuilder: ReviewInfoCache.create)
    ..aOM<GeoLoc>(7, 'Geoloc', subBuilder: GeoLoc.create)
    ..pPS(8, 'Tags')
    ..aOS(9, 'objectID', protoName: 'objectID')
    ..aOS(10, 'reference')
    ..aOS(11, 'recordType')
    ..aOS(12, 'fbPlaceId')
    ..hasRequiredFields = false
  ;

  RestaurantMarkerCache._() : super();
  factory RestaurantMarkerCache() => create();
  factory RestaurantMarkerCache.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RestaurantMarkerCache.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RestaurantMarkerCache clone() => RestaurantMarkerCache()..mergeFromMessage(this);
  RestaurantMarkerCache copyWith(void Function(RestaurantMarkerCache) updates) => super.copyWith((message) => updates(message as RestaurantMarkerCache));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RestaurantMarkerCache create() => RestaurantMarkerCache._();
  RestaurantMarkerCache createEmptyInstance() => create();
  static $pb.PbList<RestaurantMarkerCache> createRepeated() => $pb.PbList<RestaurantMarkerCache>();
  @$core.pragma('dart2js:noInline')
  static RestaurantMarkerCache getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RestaurantMarkerCache>(create);
  static RestaurantMarkerCache _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(3)
  $core.int get numFavorites => $_getIZ(1);
  @$pb.TagNumber(3)
  set numFavorites($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasNumFavorites() => $_has(1);
  @$pb.TagNumber(3)
  void clearNumFavorites() => clearField(3);

  @$pb.TagNumber(4)
  RestaurantMarkerCache_TopReview get topReview => $_getN(2);
  @$pb.TagNumber(4)
  set topReview(RestaurantMarkerCache_TopReview v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTopReview() => $_has(2);
  @$pb.TagNumber(4)
  void clearTopReview() => clearField(4);
  @$pb.TagNumber(4)
  RestaurantMarkerCache_TopReview ensureTopReview() => $_ensure(2);

  @$pb.TagNumber(5)
  $core.List<$core.String> get reviewers => $_getList(3);

  @$pb.TagNumber(6)
  $core.List<ReviewInfoCache> get reviews => $_getList(4);

  @$pb.TagNumber(7)
  GeoLoc get geoloc => $_getN(5);
  @$pb.TagNumber(7)
  set geoloc(GeoLoc v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasGeoloc() => $_has(5);
  @$pb.TagNumber(7)
  void clearGeoloc() => clearField(7);
  @$pb.TagNumber(7)
  GeoLoc ensureGeoloc() => $_ensure(5);

  @$pb.TagNumber(8)
  $core.List<$core.String> get tags => $_getList(6);

  @$pb.TagNumber(9)
  $core.String get objectID => $_getSZ(7);
  @$pb.TagNumber(9)
  set objectID($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasObjectID() => $_has(7);
  @$pb.TagNumber(9)
  void clearObjectID() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get reference => $_getSZ(8);
  @$pb.TagNumber(10)
  set reference($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(10)
  $core.bool hasReference() => $_has(8);
  @$pb.TagNumber(10)
  void clearReference() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get recordType => $_getSZ(9);
  @$pb.TagNumber(11)
  set recordType($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasRecordType() => $_has(9);
  @$pb.TagNumber(11)
  void clearRecordType() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get fbPlaceId => $_getSZ(10);
  @$pb.TagNumber(12)
  set fbPlaceId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(12)
  $core.bool hasFbPlaceId() => $_has(10);
  @$pb.TagNumber(12)
  void clearFbPlaceId() => clearField(12);
}

class RestaurantCache extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RestaurantCache', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..aOS(2, 'fbPlaceId')
    ..aOM<$1.LatLng>(3, 'location', subBuilder: $1.LatLng.create)
    ..a<$core.double>(4, 'popularityScore', $pb.PbFieldType.OD)
    ..a<$core.int>(5, 'numReviews', $pb.PbFieldType.O3)
    ..pc<$1.PlaceType>(6, 'placeTypes', $pb.PbFieldType.PE, valueOf: $1.PlaceType.valueOf, enumValues: $1.PlaceType.values)
    ..p<$core.double>(7, 'placeTypeScores', $pb.PbFieldType.PD)
    ..pc<$1.FoodType>(8, 'foodTypes', $pb.PbFieldType.PE, valueOf: $1.FoodType.valueOf, enumValues: $1.FoodType.values)
    ..pc<$1.PlaceCategory>(9, 'placeCategories', $pb.PbFieldType.PE, valueOf: $1.PlaceCategory.valueOf, enumValues: $1.PlaceCategory.values)
    ..aOM<ScrapeInfo>(10, 'yelpInfo', subBuilder: ScrapeInfo.create)
    ..aOM<ScrapeInfo>(11, 'googleInfo', subBuilder: ScrapeInfo.create)
    ..pPS(12, 'serializedHours')
    ..pPS(13, 'delivery')
    ..aOM<$1.FirePhoto>(14, 'profilePic', subBuilder: $1.FirePhoto.create)
    ..pc<CoverPhotoData>(15, 'coverPhotos', $pb.PbFieldType.PM, subBuilder: CoverPhotoData.create)
    ..aOM<GeoLoc>(16, 'Geoloc', subBuilder: GeoLoc.create)
    ..pPS(17, 'Tags')
    ..aOS(18, 'objectID', protoName: 'objectID')
    ..aOS(19, 'reference')
    ..aOS(20, 'recordType')
    ..pPS(21, 'pickup')
    ..hasRequiredFields = false
  ;

  RestaurantCache._() : super();
  factory RestaurantCache() => create();
  factory RestaurantCache.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RestaurantCache.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RestaurantCache clone() => RestaurantCache()..mergeFromMessage(this);
  RestaurantCache copyWith(void Function(RestaurantCache) updates) => super.copyWith((message) => updates(message as RestaurantCache));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RestaurantCache create() => RestaurantCache._();
  RestaurantCache createEmptyInstance() => create();
  static $pb.PbList<RestaurantCache> createRepeated() => $pb.PbList<RestaurantCache>();
  @$core.pragma('dart2js:noInline')
  static RestaurantCache getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RestaurantCache>(create);
  static RestaurantCache _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fbPlaceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set fbPlaceId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFbPlaceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFbPlaceId() => clearField(2);

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
  $core.double get popularityScore => $_getN(3);
  @$pb.TagNumber(4)
  set popularityScore($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPopularityScore() => $_has(3);
  @$pb.TagNumber(4)
  void clearPopularityScore() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get numReviews => $_getIZ(4);
  @$pb.TagNumber(5)
  set numReviews($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNumReviews() => $_has(4);
  @$pb.TagNumber(5)
  void clearNumReviews() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$1.PlaceType> get placeTypes => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<$core.double> get placeTypeScores => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<$1.FoodType> get foodTypes => $_getList(7);

  @$pb.TagNumber(9)
  $core.List<$1.PlaceCategory> get placeCategories => $_getList(8);

  @$pb.TagNumber(10)
  ScrapeInfo get yelpInfo => $_getN(9);
  @$pb.TagNumber(10)
  set yelpInfo(ScrapeInfo v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasYelpInfo() => $_has(9);
  @$pb.TagNumber(10)
  void clearYelpInfo() => clearField(10);
  @$pb.TagNumber(10)
  ScrapeInfo ensureYelpInfo() => $_ensure(9);

  @$pb.TagNumber(11)
  ScrapeInfo get googleInfo => $_getN(10);
  @$pb.TagNumber(11)
  set googleInfo(ScrapeInfo v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasGoogleInfo() => $_has(10);
  @$pb.TagNumber(11)
  void clearGoogleInfo() => clearField(11);
  @$pb.TagNumber(11)
  ScrapeInfo ensureGoogleInfo() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.List<$core.String> get serializedHours => $_getList(11);

  @$pb.TagNumber(13)
  $core.List<$core.String> get delivery => $_getList(12);

  @$pb.TagNumber(14)
  $1.FirePhoto get profilePic => $_getN(13);
  @$pb.TagNumber(14)
  set profilePic($1.FirePhoto v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasProfilePic() => $_has(13);
  @$pb.TagNumber(14)
  void clearProfilePic() => clearField(14);
  @$pb.TagNumber(14)
  $1.FirePhoto ensureProfilePic() => $_ensure(13);

  @$pb.TagNumber(15)
  $core.List<CoverPhotoData> get coverPhotos => $_getList(14);

  @$pb.TagNumber(16)
  GeoLoc get geoloc => $_getN(15);
  @$pb.TagNumber(16)
  set geoloc(GeoLoc v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasGeoloc() => $_has(15);
  @$pb.TagNumber(16)
  void clearGeoloc() => clearField(16);
  @$pb.TagNumber(16)
  GeoLoc ensureGeoloc() => $_ensure(15);

  @$pb.TagNumber(17)
  $core.List<$core.String> get tags => $_getList(16);

  @$pb.TagNumber(18)
  $core.String get objectID => $_getSZ(17);
  @$pb.TagNumber(18)
  set objectID($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasObjectID() => $_has(17);
  @$pb.TagNumber(18)
  void clearObjectID() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get reference => $_getSZ(18);
  @$pb.TagNumber(19)
  set reference($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasReference() => $_has(18);
  @$pb.TagNumber(19)
  void clearReference() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get recordType => $_getSZ(19);
  @$pb.TagNumber(20)
  set recordType($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasRecordType() => $_has(19);
  @$pb.TagNumber(20)
  void clearRecordType() => clearField(20);

  @$pb.TagNumber(21)
  $core.List<$core.String> get pickup => $_getList(20);
}

class ScrapeInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ScrapeInfo', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..aOB(1, 'match')
    ..aOM<$1.ScraperResults>(2, 'scraperResult', subBuilder: $1.ScraperResults.create)
    ..hasRequiredFields = false
  ;

  ScrapeInfo._() : super();
  factory ScrapeInfo() => create();
  factory ScrapeInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScrapeInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ScrapeInfo clone() => ScrapeInfo()..mergeFromMessage(this);
  ScrapeInfo copyWith(void Function(ScrapeInfo) updates) => super.copyWith((message) => updates(message as ScrapeInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScrapeInfo create() => ScrapeInfo._();
  ScrapeInfo createEmptyInstance() => create();
  static $pb.PbList<ScrapeInfo> createRepeated() => $pb.PbList<ScrapeInfo>();
  @$core.pragma('dart2js:noInline')
  static ScrapeInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScrapeInfo>(create);
  static ScrapeInfo _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get match => $_getBF(0);
  @$pb.TagNumber(1)
  set match($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMatch() => $_has(0);
  @$pb.TagNumber(1)
  void clearMatch() => clearField(1);

  @$pb.TagNumber(2)
  $1.ScraperResults get scraperResult => $_getN(1);
  @$pb.TagNumber(2)
  set scraperResult($1.ScraperResults v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasScraperResult() => $_has(1);
  @$pb.TagNumber(2)
  void clearScraperResult() => clearField(2);
  @$pb.TagNumber(2)
  $1.ScraperResults ensureScraperResult() => $_ensure(1);
}

class CoverPhotoData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CoverPhotoData', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..pPS(1, 'data')
    ..hasRequiredFields = false
  ;

  CoverPhotoData._() : super();
  factory CoverPhotoData() => create();
  factory CoverPhotoData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CoverPhotoData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CoverPhotoData clone() => CoverPhotoData()..mergeFromMessage(this);
  CoverPhotoData copyWith(void Function(CoverPhotoData) updates) => super.copyWith((message) => updates(message as CoverPhotoData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CoverPhotoData create() => CoverPhotoData._();
  CoverPhotoData createEmptyInstance() => create();
  static $pb.PbList<CoverPhotoData> createRepeated() => $pb.PbList<CoverPhotoData>();
  @$core.pragma('dart2js:noInline')
  static CoverPhotoData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CoverPhotoData>(create);
  static CoverPhotoData _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get data => $_getList(0);
}

class CoverPhoto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CoverPhoto', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..aOM<$1.FirePhoto>(1, 'photo', subBuilder: $1.FirePhoto.create)
    ..aOM<$1.DocumentReferenceProto>(2, 'reference', subBuilder: $1.DocumentReferenceProto.create)
    ..hasRequiredFields = false
  ;

  CoverPhoto._() : super();
  factory CoverPhoto() => create();
  factory CoverPhoto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CoverPhoto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CoverPhoto clone() => CoverPhoto()..mergeFromMessage(this);
  CoverPhoto copyWith(void Function(CoverPhoto) updates) => super.copyWith((message) => updates(message as CoverPhoto));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CoverPhoto create() => CoverPhoto._();
  CoverPhoto createEmptyInstance() => create();
  static $pb.PbList<CoverPhoto> createRepeated() => $pb.PbList<CoverPhoto>();
  @$core.pragma('dart2js:noInline')
  static CoverPhoto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CoverPhoto>(create);
  static CoverPhoto _defaultInstance;

  @$pb.TagNumber(1)
  $1.FirePhoto get photo => $_getN(0);
  @$pb.TagNumber(1)
  set photo($1.FirePhoto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhoto() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoto() => clearField(1);
  @$pb.TagNumber(1)
  $1.FirePhoto ensurePhoto() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.DocumentReferenceProto get reference => $_getN(1);
  @$pb.TagNumber(2)
  set reference($1.DocumentReferenceProto v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => clearField(2);
  @$pb.TagNumber(2)
  $1.DocumentReferenceProto ensureReference() => $_ensure(1);
}

class ReviewInfoCache extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ReviewInfoCache', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'reference', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(2, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(3, 'photo')
    ..aOS(4, 'userPhoto')
    ..a<$core.int>(5, 'score', $pb.PbFieldType.O3)
    ..pPS(6, 'morePhotos')
    ..hasRequiredFields = false
  ;

  ReviewInfoCache._() : super();
  factory ReviewInfoCache() => create();
  factory ReviewInfoCache.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReviewInfoCache.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ReviewInfoCache clone() => ReviewInfoCache()..mergeFromMessage(this);
  ReviewInfoCache copyWith(void Function(ReviewInfoCache) updates) => super.copyWith((message) => updates(message as ReviewInfoCache));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReviewInfoCache create() => ReviewInfoCache._();
  ReviewInfoCache createEmptyInstance() => create();
  static $pb.PbList<ReviewInfoCache> createRepeated() => $pb.PbList<ReviewInfoCache>();
  @$core.pragma('dart2js:noInline')
  static ReviewInfoCache getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReviewInfoCache>(create);
  static ReviewInfoCache _defaultInstance;

  @$pb.TagNumber(1)
  $1.DocumentReferenceProto get reference => $_getN(0);
  @$pb.TagNumber(1)
  set reference($1.DocumentReferenceProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => clearField(1);
  @$pb.TagNumber(1)
  $1.DocumentReferenceProto ensureReference() => $_ensure(0);

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
  $core.String get photo => $_getSZ(2);
  @$pb.TagNumber(3)
  set photo($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhoto() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhoto() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userPhoto => $_getSZ(3);
  @$pb.TagNumber(4)
  set userPhoto($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserPhoto() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserPhoto() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get score => $_getIZ(4);
  @$pb.TagNumber(5)
  set score($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasScore() => $_has(4);
  @$pb.TagNumber(5)
  void clearScore() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get morePhotos => $_getList(5);
}

class AlgoliaJSON extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AlgoliaJSON', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..aOM<GeoLoc>(1, 'Geoloc', subBuilder: GeoLoc.create)
    ..pPS(2, 'Tags')
    ..aOS(3, 'objectID', protoName: 'objectID')
    ..aOS(4, 'reference')
    ..aOS(5, 'recordType')
    ..hasRequiredFields = false
  ;

  AlgoliaJSON._() : super();
  factory AlgoliaJSON() => create();
  factory AlgoliaJSON.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AlgoliaJSON.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AlgoliaJSON clone() => AlgoliaJSON()..mergeFromMessage(this);
  AlgoliaJSON copyWith(void Function(AlgoliaJSON) updates) => super.copyWith((message) => updates(message as AlgoliaJSON));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AlgoliaJSON create() => AlgoliaJSON._();
  AlgoliaJSON createEmptyInstance() => create();
  static $pb.PbList<AlgoliaJSON> createRepeated() => $pb.PbList<AlgoliaJSON>();
  @$core.pragma('dart2js:noInline')
  static AlgoliaJSON getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AlgoliaJSON>(create);
  static AlgoliaJSON _defaultInstance;

  @$pb.TagNumber(1)
  GeoLoc get geoloc => $_getN(0);
  @$pb.TagNumber(1)
  set geoloc(GeoLoc v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGeoloc() => $_has(0);
  @$pb.TagNumber(1)
  void clearGeoloc() => clearField(1);
  @$pb.TagNumber(1)
  GeoLoc ensureGeoloc() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.String> get tags => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get objectID => $_getSZ(2);
  @$pb.TagNumber(3)
  set objectID($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasObjectID() => $_has(2);
  @$pb.TagNumber(3)
  void clearObjectID() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get recordType => $_getSZ(4);
  @$pb.TagNumber(5)
  set recordType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRecordType() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecordType() => clearField(5);
}

class ReviewMarker_RestaurantCounts extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ReviewMarker.RestaurantCounts', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..a<$core.int>(1, 'down', $pb.PbFieldType.O3)
    ..a<$core.int>(2, 'love', $pb.PbFieldType.O3)
    ..a<$core.int>(3, 'favorite', $pb.PbFieldType.O3)
    ..a<$core.int>(4, 'up', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ReviewMarker_RestaurantCounts._() : super();
  factory ReviewMarker_RestaurantCounts() => create();
  factory ReviewMarker_RestaurantCounts.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReviewMarker_RestaurantCounts.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ReviewMarker_RestaurantCounts clone() => ReviewMarker_RestaurantCounts()..mergeFromMessage(this);
  ReviewMarker_RestaurantCounts copyWith(void Function(ReviewMarker_RestaurantCounts) updates) => super.copyWith((message) => updates(message as ReviewMarker_RestaurantCounts));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReviewMarker_RestaurantCounts create() => ReviewMarker_RestaurantCounts._();
  ReviewMarker_RestaurantCounts createEmptyInstance() => create();
  static $pb.PbList<ReviewMarker_RestaurantCounts> createRepeated() => $pb.PbList<ReviewMarker_RestaurantCounts>();
  @$core.pragma('dart2js:noInline')
  static ReviewMarker_RestaurantCounts getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReviewMarker_RestaurantCounts>(create);
  static ReviewMarker_RestaurantCounts _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get down => $_getIZ(0);
  @$pb.TagNumber(1)
  set down($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDown() => $_has(0);
  @$pb.TagNumber(1)
  void clearDown() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get love => $_getIZ(1);
  @$pb.TagNumber(2)
  set love($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLove() => $_has(1);
  @$pb.TagNumber(2)
  void clearLove() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get favorite => $_getIZ(2);
  @$pb.TagNumber(3)
  set favorite($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFavorite() => $_has(2);
  @$pb.TagNumber(3)
  void clearFavorite() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get up => $_getIZ(3);
  @$pb.TagNumber(4)
  set up($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUp() => $_has(3);
  @$pb.TagNumber(4)
  void clearUp() => clearField(4);
}

class ReviewMarker extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ReviewMarker', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..aOS(1, 'dish')
    ..aOS(2, 'restaurantName')
    ..aOM<$1.DocumentReferenceProto>(3, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(4, 'photo')
    ..aOS(5, 'userPhoto')
    ..aOS(6, 'text')
    ..e<$2.Reaction>(7, 'reaction', $pb.PbFieldType.OE, defaultOrMaker: $2.Reaction.UNDEFINED, valueOf: $2.Reaction.valueOf, enumValues: $2.Reaction.values)
    ..pPS(8, 'emojis')
    ..aOM<GeoLoc>(9, 'Geoloc', subBuilder: GeoLoc.create)
    ..aOS(10, 'objectID', protoName: 'objectID')
    ..pPS(11, 'Tags')
    ..a<$core.int>(12, 'score', $pb.PbFieldType.O3)
    ..aOS(13, 'username')
    ..aOS(14, 'userDisplayName')
    ..aOM<$1.DocumentReferenceProto>(15, 'restaurantRef', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<ReviewMarker_RestaurantCounts>(16, 'restaurantCounts', subBuilder: ReviewMarker_RestaurantCounts.create)
    ..aOS(17, 'fbPlaceId')
    ..pPS(18, 'morePhotos')
    ..hasRequiredFields = false
  ;

  ReviewMarker._() : super();
  factory ReviewMarker() => create();
  factory ReviewMarker.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReviewMarker.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ReviewMarker clone() => ReviewMarker()..mergeFromMessage(this);
  ReviewMarker copyWith(void Function(ReviewMarker) updates) => super.copyWith((message) => updates(message as ReviewMarker));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReviewMarker create() => ReviewMarker._();
  ReviewMarker createEmptyInstance() => create();
  static $pb.PbList<ReviewMarker> createRepeated() => $pb.PbList<ReviewMarker>();
  @$core.pragma('dart2js:noInline')
  static ReviewMarker getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReviewMarker>(create);
  static ReviewMarker _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dish => $_getSZ(0);
  @$pb.TagNumber(1)
  set dish($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDish() => $_has(0);
  @$pb.TagNumber(1)
  void clearDish() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get restaurantName => $_getSZ(1);
  @$pb.TagNumber(2)
  set restaurantName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRestaurantName() => $_has(1);
  @$pb.TagNumber(2)
  void clearRestaurantName() => clearField(2);

  @$pb.TagNumber(3)
  $1.DocumentReferenceProto get user => $_getN(2);
  @$pb.TagNumber(3)
  set user($1.DocumentReferenceProto v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => clearField(3);
  @$pb.TagNumber(3)
  $1.DocumentReferenceProto ensureUser() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get photo => $_getSZ(3);
  @$pb.TagNumber(4)
  set photo($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhoto() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhoto() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get userPhoto => $_getSZ(4);
  @$pb.TagNumber(5)
  set userPhoto($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUserPhoto() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserPhoto() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get text => $_getSZ(5);
  @$pb.TagNumber(6)
  set text($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasText() => $_has(5);
  @$pb.TagNumber(6)
  void clearText() => clearField(6);

  @$pb.TagNumber(7)
  $2.Reaction get reaction => $_getN(6);
  @$pb.TagNumber(7)
  set reaction($2.Reaction v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasReaction() => $_has(6);
  @$pb.TagNumber(7)
  void clearReaction() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.String> get emojis => $_getList(7);

  @$pb.TagNumber(9)
  GeoLoc get geoloc => $_getN(8);
  @$pb.TagNumber(9)
  set geoloc(GeoLoc v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasGeoloc() => $_has(8);
  @$pb.TagNumber(9)
  void clearGeoloc() => clearField(9);
  @$pb.TagNumber(9)
  GeoLoc ensureGeoloc() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get objectID => $_getSZ(9);
  @$pb.TagNumber(10)
  set objectID($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasObjectID() => $_has(9);
  @$pb.TagNumber(10)
  void clearObjectID() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<$core.String> get tags => $_getList(10);

  @$pb.TagNumber(12)
  $core.int get score => $_getIZ(11);
  @$pb.TagNumber(12)
  set score($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasScore() => $_has(11);
  @$pb.TagNumber(12)
  void clearScore() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get username => $_getSZ(12);
  @$pb.TagNumber(13)
  set username($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasUsername() => $_has(12);
  @$pb.TagNumber(13)
  void clearUsername() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get userDisplayName => $_getSZ(13);
  @$pb.TagNumber(14)
  set userDisplayName($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasUserDisplayName() => $_has(13);
  @$pb.TagNumber(14)
  void clearUserDisplayName() => clearField(14);

  @$pb.TagNumber(15)
  $1.DocumentReferenceProto get restaurantRef => $_getN(14);
  @$pb.TagNumber(15)
  set restaurantRef($1.DocumentReferenceProto v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasRestaurantRef() => $_has(14);
  @$pb.TagNumber(15)
  void clearRestaurantRef() => clearField(15);
  @$pb.TagNumber(15)
  $1.DocumentReferenceProto ensureRestaurantRef() => $_ensure(14);

  @$pb.TagNumber(16)
  ReviewMarker_RestaurantCounts get restaurantCounts => $_getN(15);
  @$pb.TagNumber(16)
  set restaurantCounts(ReviewMarker_RestaurantCounts v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasRestaurantCounts() => $_has(15);
  @$pb.TagNumber(16)
  void clearRestaurantCounts() => clearField(16);
  @$pb.TagNumber(16)
  ReviewMarker_RestaurantCounts ensureRestaurantCounts() => $_ensure(15);

  @$pb.TagNumber(17)
  $core.String get fbPlaceId => $_getSZ(16);
  @$pb.TagNumber(17)
  set fbPlaceId($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasFbPlaceId() => $_has(16);
  @$pb.TagNumber(17)
  void clearFbPlaceId() => clearField(17);

  @$pb.TagNumber(18)
  $core.List<$core.String> get morePhotos => $_getList(17);
}

class DiscoverReviewRecord extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DiscoverReviewRecord', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..aOS(1, 'displayText')
    ..aOM<$1.DocumentReferenceProto>(2, 'review', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(3, 'user')
    ..aOS(4, 'userPhoto')
    ..aOS(5, 'dish')
    ..aOS(6, 'restaurantName')
    ..aOS(7, 'photo')
    ..aOS(8, 'searchText')
    ..pPS(9, 'morePhotos')
    ..a<$core.int>(10, 'score', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  DiscoverReviewRecord._() : super();
  factory DiscoverReviewRecord() => create();
  factory DiscoverReviewRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscoverReviewRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DiscoverReviewRecord clone() => DiscoverReviewRecord()..mergeFromMessage(this);
  DiscoverReviewRecord copyWith(void Function(DiscoverReviewRecord) updates) => super.copyWith((message) => updates(message as DiscoverReviewRecord));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DiscoverReviewRecord create() => DiscoverReviewRecord._();
  DiscoverReviewRecord createEmptyInstance() => create();
  static $pb.PbList<DiscoverReviewRecord> createRepeated() => $pb.PbList<DiscoverReviewRecord>();
  @$core.pragma('dart2js:noInline')
  static DiscoverReviewRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiscoverReviewRecord>(create);
  static DiscoverReviewRecord _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get displayText => $_getSZ(0);
  @$pb.TagNumber(1)
  set displayText($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDisplayText() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisplayText() => clearField(1);

  @$pb.TagNumber(2)
  $1.DocumentReferenceProto get review => $_getN(1);
  @$pb.TagNumber(2)
  set review($1.DocumentReferenceProto v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasReview() => $_has(1);
  @$pb.TagNumber(2)
  void clearReview() => clearField(2);
  @$pb.TagNumber(2)
  $1.DocumentReferenceProto ensureReview() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get user => $_getSZ(2);
  @$pb.TagNumber(3)
  set user($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userPhoto => $_getSZ(3);
  @$pb.TagNumber(4)
  set userPhoto($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserPhoto() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserPhoto() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get dish => $_getSZ(4);
  @$pb.TagNumber(5)
  set dish($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDish() => $_has(4);
  @$pb.TagNumber(5)
  void clearDish() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get restaurantName => $_getSZ(5);
  @$pb.TagNumber(6)
  set restaurantName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRestaurantName() => $_has(5);
  @$pb.TagNumber(6)
  void clearRestaurantName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get photo => $_getSZ(6);
  @$pb.TagNumber(7)
  set photo($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPhoto() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoto() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get searchText => $_getSZ(7);
  @$pb.TagNumber(8)
  set searchText($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSearchText() => $_has(7);
  @$pb.TagNumber(8)
  void clearSearchText() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.String> get morePhotos => $_getList(8);

  @$pb.TagNumber(10)
  $core.int get score => $_getIZ(9);
  @$pb.TagNumber(10)
  set score($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasScore() => $_has(9);
  @$pb.TagNumber(10)
  void clearScore() => clearField(10);
}

class AlgoliaUserRecord extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AlgoliaUserRecord', package: const $pb.PackageName('algolia'), createEmptyInstance: create)
    ..aOM<GeoLoc>(1, 'Geoloc', subBuilder: GeoLoc.create)
    ..pPS(2, 'Tags')
    ..aOS(3, 'objectID', protoName: 'objectID')
    ..aOS(4, 'reference')
    ..aOS(5, 'recordType')
    ..aOS(6, 'name')
    ..aOS(7, 'username')
    ..aOS(8, 'profilePicUrl')
    ..hasRequiredFields = false
  ;

  AlgoliaUserRecord._() : super();
  factory AlgoliaUserRecord() => create();
  factory AlgoliaUserRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AlgoliaUserRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AlgoliaUserRecord clone() => AlgoliaUserRecord()..mergeFromMessage(this);
  AlgoliaUserRecord copyWith(void Function(AlgoliaUserRecord) updates) => super.copyWith((message) => updates(message as AlgoliaUserRecord));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AlgoliaUserRecord create() => AlgoliaUserRecord._();
  AlgoliaUserRecord createEmptyInstance() => create();
  static $pb.PbList<AlgoliaUserRecord> createRepeated() => $pb.PbList<AlgoliaUserRecord>();
  @$core.pragma('dart2js:noInline')
  static AlgoliaUserRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AlgoliaUserRecord>(create);
  static AlgoliaUserRecord _defaultInstance;

  @$pb.TagNumber(1)
  GeoLoc get geoloc => $_getN(0);
  @$pb.TagNumber(1)
  set geoloc(GeoLoc v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGeoloc() => $_has(0);
  @$pb.TagNumber(1)
  void clearGeoloc() => clearField(1);
  @$pb.TagNumber(1)
  GeoLoc ensureGeoloc() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.String> get tags => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get objectID => $_getSZ(2);
  @$pb.TagNumber(3)
  set objectID($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasObjectID() => $_has(2);
  @$pb.TagNumber(3)
  void clearObjectID() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get recordType => $_getSZ(4);
  @$pb.TagNumber(5)
  set recordType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRecordType() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecordType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get name => $_getSZ(5);
  @$pb.TagNumber(6)
  set name($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasName() => $_has(5);
  @$pb.TagNumber(6)
  void clearName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get username => $_getSZ(6);
  @$pb.TagNumber(7)
  set username($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUsername() => $_has(6);
  @$pb.TagNumber(7)
  void clearUsername() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get profilePicUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set profilePicUrl($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasProfilePicUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearProfilePicUrl() => clearField(8);
}

