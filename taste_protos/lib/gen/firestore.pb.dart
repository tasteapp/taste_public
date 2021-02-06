///
//  Generated code. Do not modify.
//  source: firestore.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'google/protobuf/timestamp.pb.dart' as $0;
import 'google/protobuf/struct.pb.dart' as $3;

import 'firestore.pbenum.dart';
import 'review.pbenum.dart' as $2;
import 'common.pbenum.dart' as $1;
import 'algolia.pbenum.dart' as $4;

export 'firestore.pbenum.dart';

class RecipeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RecipeRequest', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(2, 'parent', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.Extras>(3, 'Extras', subBuilder: $1.Extras.create)
    ..hasRequiredFields = false
  ;

  RecipeRequest._() : super();
  factory RecipeRequest() => create();
  factory RecipeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecipeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RecipeRequest clone() => RecipeRequest()..mergeFromMessage(this);
  RecipeRequest copyWith(void Function(RecipeRequest) updates) => super.copyWith((message) => updates(message as RecipeRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RecipeRequest create() => RecipeRequest._();
  RecipeRequest createEmptyInstance() => create();
  static $pb.PbList<RecipeRequest> createRepeated() => $pb.PbList<RecipeRequest>();
  @$core.pragma('dart2js:noInline')
  static RecipeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecipeRequest>(create);
  static RecipeRequest _defaultInstance;

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
  $1.DocumentReferenceProto get parent => $_getN(1);
  @$pb.TagNumber(2)
  set parent($1.DocumentReferenceProto v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasParent() => $_has(1);
  @$pb.TagNumber(2)
  void clearParent() => clearField(2);
  @$pb.TagNumber(2)
  $1.DocumentReferenceProto ensureParent() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Extras get extras => $_getN(2);
  @$pb.TagNumber(3)
  set extras($1.Extras v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasExtras() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtras() => clearField(3);
  @$pb.TagNumber(3)
  $1.Extras ensureExtras() => $_ensure(2);
}

class Comment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Comment', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(2, 'text')
    ..aOM<$1.Extras>(5, 'Extras', subBuilder: $1.Extras.create)
    ..aOM<$1.DocumentReferenceProto>(7, 'parent', subBuilder: $1.DocumentReferenceProto.create)
    ..pc<$1.DocumentReferenceProto>(8, 'taggedUsers', $pb.PbFieldType.PM, subBuilder: $1.DocumentReferenceProto.create)
    ..hasRequiredFields = false
  ;

  Comment._() : super();
  factory Comment() => create();
  factory Comment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Comment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Comment clone() => Comment()..mergeFromMessage(this);
  Comment copyWith(void Function(Comment) updates) => super.copyWith((message) => updates(message as Comment));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Comment create() => Comment._();
  Comment createEmptyInstance() => create();
  static $pb.PbList<Comment> createRepeated() => $pb.PbList<Comment>();
  @$core.pragma('dart2js:noInline')
  static Comment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Comment>(create);
  static Comment _defaultInstance;

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
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => clearField(2);

  @$pb.TagNumber(5)
  $1.Extras get extras => $_getN(2);
  @$pb.TagNumber(5)
  set extras($1.Extras v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasExtras() => $_has(2);
  @$pb.TagNumber(5)
  void clearExtras() => clearField(5);
  @$pb.TagNumber(5)
  $1.Extras ensureExtras() => $_ensure(2);

  @$pb.TagNumber(7)
  $1.DocumentReferenceProto get parent => $_getN(3);
  @$pb.TagNumber(7)
  set parent($1.DocumentReferenceProto v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasParent() => $_has(3);
  @$pb.TagNumber(7)
  void clearParent() => clearField(7);
  @$pb.TagNumber(7)
  $1.DocumentReferenceProto ensureParent() => $_ensure(3);

  @$pb.TagNumber(8)
  $core.List<$1.DocumentReferenceProto> get taggedUsers => $_getList(4);
}

class Notification extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Notification', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'body')
    ..aOS(2, 'title')
    ..aOM<$1.DocumentReferenceProto>(3, 'documentLink', subBuilder: $1.DocumentReferenceProto.create)
    ..e<NotificationType>(4, 'notificationType', $pb.PbFieldType.OE, defaultOrMaker: NotificationType.UNDEFINED, valueOf: NotificationType.valueOf, enumValues: NotificationType.values)
    ..aOM<$1.DocumentReferenceProto>(5, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOB(6, 'seen')
    ..e<Notification_FCMSettings>(7, 'fcmSettings', $pb.PbFieldType.OE, defaultOrMaker: Notification_FCMSettings.fcm_settings_undefined, valueOf: Notification_FCMSettings.valueOf, enumValues: Notification_FCMSettings.values)
    ..hasRequiredFields = false
  ;

  Notification._() : super();
  factory Notification() => create();
  factory Notification.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Notification.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Notification clone() => Notification()..mergeFromMessage(this);
  Notification copyWith(void Function(Notification) updates) => super.copyWith((message) => updates(message as Notification));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Notification create() => Notification._();
  Notification createEmptyInstance() => create();
  static $pb.PbList<Notification> createRepeated() => $pb.PbList<Notification>();
  @$core.pragma('dart2js:noInline')
  static Notification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Notification>(create);
  static Notification _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get body => $_getSZ(0);
  @$pb.TagNumber(1)
  set body($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBody() => $_has(0);
  @$pb.TagNumber(1)
  void clearBody() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $1.DocumentReferenceProto get documentLink => $_getN(2);
  @$pb.TagNumber(3)
  set documentLink($1.DocumentReferenceProto v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocumentLink() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentLink() => clearField(3);
  @$pb.TagNumber(3)
  $1.DocumentReferenceProto ensureDocumentLink() => $_ensure(2);

  @$pb.TagNumber(4)
  NotificationType get notificationType => $_getN(3);
  @$pb.TagNumber(4)
  set notificationType(NotificationType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasNotificationType() => $_has(3);
  @$pb.TagNumber(4)
  void clearNotificationType() => clearField(4);

  @$pb.TagNumber(5)
  $1.DocumentReferenceProto get user => $_getN(4);
  @$pb.TagNumber(5)
  set user($1.DocumentReferenceProto v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasUser() => $_has(4);
  @$pb.TagNumber(5)
  void clearUser() => clearField(5);
  @$pb.TagNumber(5)
  $1.DocumentReferenceProto ensureUser() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.bool get seen => $_getBF(5);
  @$pb.TagNumber(6)
  set seen($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSeen() => $_has(5);
  @$pb.TagNumber(6)
  void clearSeen() => clearField(6);

  @$pb.TagNumber(7)
  Notification_FCMSettings get fcmSettings => $_getN(6);
  @$pb.TagNumber(7)
  set fcmSettings(Notification_FCMSettings v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasFcmSettings() => $_has(6);
  @$pb.TagNumber(7)
  void clearFcmSettings() => clearField(7);
}

class Operation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Operation', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'text')
    ..a<$core.int>(2, 'status', $pb.PbFieldType.O3)
    ..aOM<$1.Extras>(3, 'Extras', subBuilder: $1.Extras.create)
    ..aOM<$1.DocumentReferenceProto>(4, 'parent', subBuilder: $1.DocumentReferenceProto.create)
    ..hasRequiredFields = false
  ;

  Operation._() : super();
  factory Operation() => create();
  factory Operation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Operation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Operation clone() => Operation()..mergeFromMessage(this);
  Operation copyWith(void Function(Operation) updates) => super.copyWith((message) => updates(message as Operation));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Operation create() => Operation._();
  Operation createEmptyInstance() => create();
  static $pb.PbList<Operation> createRepeated() => $pb.PbList<Operation>();
  @$core.pragma('dart2js:noInline')
  static Operation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Operation>(create);
  static Operation _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get status => $_getIZ(1);
  @$pb.TagNumber(2)
  set status($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $1.Extras get extras => $_getN(2);
  @$pb.TagNumber(3)
  set extras($1.Extras v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasExtras() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtras() => clearField(3);
  @$pb.TagNumber(3)
  $1.Extras ensureExtras() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.DocumentReferenceProto get parent => $_getN(3);
  @$pb.TagNumber(4)
  set parent($1.DocumentReferenceProto v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasParent() => $_has(3);
  @$pb.TagNumber(4)
  void clearParent() => clearField(4);
  @$pb.TagNumber(4)
  $1.DocumentReferenceProto ensureParent() => $_ensure(3);
}

class InstagramSettings extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InstagramSettings', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..e<InstagramSettings_AutoImportSetting>(1, 'autoImportSetting', $pb.PbFieldType.OE, defaultOrMaker: InstagramSettings_AutoImportSetting.AUTO_IMPORT_SETTING_UNDEFINED, valueOf: InstagramSettings_AutoImportSetting.valueOf, enumValues: InstagramSettings_AutoImportSetting.values)
    ..hasRequiredFields = false
  ;

  InstagramSettings._() : super();
  factory InstagramSettings() => create();
  factory InstagramSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstagramSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InstagramSettings clone() => InstagramSettings()..mergeFromMessage(this);
  InstagramSettings copyWith(void Function(InstagramSettings) updates) => super.copyWith((message) => updates(message as InstagramSettings));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InstagramSettings create() => InstagramSettings._();
  InstagramSettings createEmptyInstance() => create();
  static $pb.PbList<InstagramSettings> createRepeated() => $pb.PbList<InstagramSettings>();
  @$core.pragma('dart2js:noInline')
  static InstagramSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstagramSettings>(create);
  static InstagramSettings _defaultInstance;

  @$pb.TagNumber(1)
  InstagramSettings_AutoImportSetting get autoImportSetting => $_getN(0);
  @$pb.TagNumber(1)
  set autoImportSetting(InstagramSettings_AutoImportSetting v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAutoImportSetting() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutoImportSetting() => clearField(1);
}

class InstagramInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InstagramInfo', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..aOS(2, 'userId')
    ..a<$core.int>(3, 'numPosts', $pb.PbFieldType.O3)
    ..aOM<InstagramSettings>(4, 'settings', subBuilder: InstagramSettings.create)
    ..aOM<$1.FirePhoto>(5, 'profilePic', subBuilder: $1.FirePhoto.create)
    ..aOS(6, 'displayName')
    ..a<$core.int>(7, 'numFollowers', $pb.PbFieldType.O3)
    ..a<$core.int>(8, 'numFollowing', $pb.PbFieldType.O3)
    ..aOB(9, 'isPrivate')
    ..aOB(10, 'tokenInvalid')
    ..aOB(11, 'grantedPermission')
    ..aOS(12, 'profilePicUrl')
    ..aOS(13, 'email')
    ..aOS(14, 'biography')
    ..aOS(15, 'phoneNumber')
    ..aOM<$0.Timestamp>(16, 'scrapeFinishTime', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(17, 'startNetworkTime', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(18, 'endNetworkTime', subBuilder: $0.Timestamp.create)
    ..pPS(19, 'following')
    ..hasRequiredFields = false
  ;

  InstagramInfo._() : super();
  factory InstagramInfo() => create();
  factory InstagramInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstagramInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InstagramInfo clone() => InstagramInfo()..mergeFromMessage(this);
  InstagramInfo copyWith(void Function(InstagramInfo) updates) => super.copyWith((message) => updates(message as InstagramInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InstagramInfo create() => InstagramInfo._();
  InstagramInfo createEmptyInstance() => create();
  static $pb.PbList<InstagramInfo> createRepeated() => $pb.PbList<InstagramInfo>();
  @$core.pragma('dart2js:noInline')
  static InstagramInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstagramInfo>(create);
  static InstagramInfo _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get numPosts => $_getIZ(2);
  @$pb.TagNumber(3)
  set numPosts($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNumPosts() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumPosts() => clearField(3);

  @$pb.TagNumber(4)
  InstagramSettings get settings => $_getN(3);
  @$pb.TagNumber(4)
  set settings(InstagramSettings v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSettings() => $_has(3);
  @$pb.TagNumber(4)
  void clearSettings() => clearField(4);
  @$pb.TagNumber(4)
  InstagramSettings ensureSettings() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.FirePhoto get profilePic => $_getN(4);
  @$pb.TagNumber(5)
  set profilePic($1.FirePhoto v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasProfilePic() => $_has(4);
  @$pb.TagNumber(5)
  void clearProfilePic() => clearField(5);
  @$pb.TagNumber(5)
  $1.FirePhoto ensureProfilePic() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get displayName => $_getSZ(5);
  @$pb.TagNumber(6)
  set displayName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDisplayName() => $_has(5);
  @$pb.TagNumber(6)
  void clearDisplayName() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get numFollowers => $_getIZ(6);
  @$pb.TagNumber(7)
  set numFollowers($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNumFollowers() => $_has(6);
  @$pb.TagNumber(7)
  void clearNumFollowers() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get numFollowing => $_getIZ(7);
  @$pb.TagNumber(8)
  set numFollowing($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasNumFollowing() => $_has(7);
  @$pb.TagNumber(8)
  void clearNumFollowing() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isPrivate => $_getBF(8);
  @$pb.TagNumber(9)
  set isPrivate($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIsPrivate() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsPrivate() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get tokenInvalid => $_getBF(9);
  @$pb.TagNumber(10)
  set tokenInvalid($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTokenInvalid() => $_has(9);
  @$pb.TagNumber(10)
  void clearTokenInvalid() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get grantedPermission => $_getBF(10);
  @$pb.TagNumber(11)
  set grantedPermission($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasGrantedPermission() => $_has(10);
  @$pb.TagNumber(11)
  void clearGrantedPermission() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get profilePicUrl => $_getSZ(11);
  @$pb.TagNumber(12)
  set profilePicUrl($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasProfilePicUrl() => $_has(11);
  @$pb.TagNumber(12)
  void clearProfilePicUrl() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get email => $_getSZ(12);
  @$pb.TagNumber(13)
  set email($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasEmail() => $_has(12);
  @$pb.TagNumber(13)
  void clearEmail() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get biography => $_getSZ(13);
  @$pb.TagNumber(14)
  set biography($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasBiography() => $_has(13);
  @$pb.TagNumber(14)
  void clearBiography() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get phoneNumber => $_getSZ(14);
  @$pb.TagNumber(15)
  set phoneNumber($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasPhoneNumber() => $_has(14);
  @$pb.TagNumber(15)
  void clearPhoneNumber() => clearField(15);

  @$pb.TagNumber(16)
  $0.Timestamp get scrapeFinishTime => $_getN(15);
  @$pb.TagNumber(16)
  set scrapeFinishTime($0.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasScrapeFinishTime() => $_has(15);
  @$pb.TagNumber(16)
  void clearScrapeFinishTime() => clearField(16);
  @$pb.TagNumber(16)
  $0.Timestamp ensureScrapeFinishTime() => $_ensure(15);

  @$pb.TagNumber(17)
  $0.Timestamp get startNetworkTime => $_getN(16);
  @$pb.TagNumber(17)
  set startNetworkTime($0.Timestamp v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasStartNetworkTime() => $_has(16);
  @$pb.TagNumber(17)
  void clearStartNetworkTime() => clearField(17);
  @$pb.TagNumber(17)
  $0.Timestamp ensureStartNetworkTime() => $_ensure(16);

  @$pb.TagNumber(18)
  $0.Timestamp get endNetworkTime => $_getN(17);
  @$pb.TagNumber(18)
  set endNetworkTime($0.Timestamp v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasEndNetworkTime() => $_has(17);
  @$pb.TagNumber(18)
  void clearEndNetworkTime() => clearField(18);
  @$pb.TagNumber(18)
  $0.Timestamp ensureEndNetworkTime() => $_ensure(17);

  @$pb.TagNumber(19)
  $core.List<$core.String> get following => $_getList(18);
}

class TasteUser_Vanity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('TasteUser.Vanity', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'displayName')
    ..aOS(2, 'username')
    ..aOM<$1.DocumentReferenceProto>(3, 'photo', subBuilder: $1.DocumentReferenceProto.create)
    ..aOB(4, 'hasSetUpAccount')
    ..aOS(5, 'phoneNumber')
    ..aOM<$1.FirePhoto>(6, 'firePhoto', subBuilder: $1.FirePhoto.create)
    ..hasRequiredFields = false
  ;

  TasteUser_Vanity._() : super();
  factory TasteUser_Vanity() => create();
  factory TasteUser_Vanity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TasteUser_Vanity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  TasteUser_Vanity clone() => TasteUser_Vanity()..mergeFromMessage(this);
  TasteUser_Vanity copyWith(void Function(TasteUser_Vanity) updates) => super.copyWith((message) => updates(message as TasteUser_Vanity));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TasteUser_Vanity create() => TasteUser_Vanity._();
  TasteUser_Vanity createEmptyInstance() => create();
  static $pb.PbList<TasteUser_Vanity> createRepeated() => $pb.PbList<TasteUser_Vanity>();
  @$core.pragma('dart2js:noInline')
  static TasteUser_Vanity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TasteUser_Vanity>(create);
  static TasteUser_Vanity _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get displayName => $_getSZ(0);
  @$pb.TagNumber(1)
  set displayName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDisplayName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisplayName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $1.DocumentReferenceProto get photo => $_getN(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  set photo($1.DocumentReferenceProto v) { setField(3, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.bool hasPhoto() => $_has(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  void clearPhoto() => clearField(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $1.DocumentReferenceProto ensurePhoto() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get hasSetUpAccount => $_getBF(3);
  @$pb.TagNumber(4)
  set hasSetUpAccount($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHasSetUpAccount() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasSetUpAccount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phoneNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set phoneNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhoneNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhoneNumber() => clearField(5);

  @$pb.TagNumber(6)
  $1.FirePhoto get firePhoto => $_getN(5);
  @$pb.TagNumber(6)
  set firePhoto($1.FirePhoto v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasFirePhoto() => $_has(5);
  @$pb.TagNumber(6)
  void clearFirePhoto() => clearField(6);
  @$pb.TagNumber(6)
  $1.FirePhoto ensureFirePhoto() => $_ensure(5);
}

class TasteUser_DailyDigest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('TasteUser.DailyDigest', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOB(1, 'enabled')
    ..hasRequiredFields = false
  ;

  TasteUser_DailyDigest._() : super();
  factory TasteUser_DailyDigest() => create();
  factory TasteUser_DailyDigest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TasteUser_DailyDigest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  TasteUser_DailyDigest clone() => TasteUser_DailyDigest()..mergeFromMessage(this);
  TasteUser_DailyDigest copyWith(void Function(TasteUser_DailyDigest) updates) => super.copyWith((message) => updates(message as TasteUser_DailyDigest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TasteUser_DailyDigest create() => TasteUser_DailyDigest._();
  TasteUser_DailyDigest createEmptyInstance() => create();
  static $pb.PbList<TasteUser_DailyDigest> createRepeated() => $pb.PbList<TasteUser_DailyDigest>();
  @$core.pragma('dart2js:noInline')
  static TasteUser_DailyDigest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TasteUser_DailyDigest>(create);
  static TasteUser_DailyDigest _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get enabled => $_getBF(0);
  @$pb.TagNumber(1)
  set enabled($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnabled() => clearField(1);
}

class TasteUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('TasteUser', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'displayName')
    ..aOM<TasteUser_Vanity>(2, 'vanity', subBuilder: TasteUser_Vanity.create)
    ..aOS(3, 'photoUrl')
    ..aOM<$1.Extras>(5, 'Extras', subBuilder: $1.Extras.create)
    ..a<$core.int>(8, 'score', $pb.PbFieldType.O3)
    ..aOS(9, 'email')
    ..aOM<TasteUser_DailyDigest>(10, 'dailyDigest', subBuilder: TasteUser_DailyDigest.create)
    ..aOS(11, 'fbId')
    ..aOM<InstagramInfo>(12, 'instagramInfo', subBuilder: InstagramInfo.create)
    ..aOB(13, 'guestMode')
    ..aOS(14, 'uid')
    ..pc<$1.DocumentReferenceProto>(15, 'setupLikedRestos', $pb.PbFieldType.PM, subBuilder: $1.DocumentReferenceProto.create)
    ..hasRequiredFields = false
  ;

  TasteUser._() : super();
  factory TasteUser() => create();
  factory TasteUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TasteUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  TasteUser clone() => TasteUser()..mergeFromMessage(this);
  TasteUser copyWith(void Function(TasteUser) updates) => super.copyWith((message) => updates(message as TasteUser));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TasteUser create() => TasteUser._();
  TasteUser createEmptyInstance() => create();
  static $pb.PbList<TasteUser> createRepeated() => $pb.PbList<TasteUser>();
  @$core.pragma('dart2js:noInline')
  static TasteUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TasteUser>(create);
  static TasteUser _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get displayName => $_getSZ(0);
  @$pb.TagNumber(1)
  set displayName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDisplayName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisplayName() => clearField(1);

  @$pb.TagNumber(2)
  TasteUser_Vanity get vanity => $_getN(1);
  @$pb.TagNumber(2)
  set vanity(TasteUser_Vanity v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasVanity() => $_has(1);
  @$pb.TagNumber(2)
  void clearVanity() => clearField(2);
  @$pb.TagNumber(2)
  TasteUser_Vanity ensureVanity() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get photoUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set photoUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhotoUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhotoUrl() => clearField(3);

  @$pb.TagNumber(5)
  $1.Extras get extras => $_getN(3);
  @$pb.TagNumber(5)
  set extras($1.Extras v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasExtras() => $_has(3);
  @$pb.TagNumber(5)
  void clearExtras() => clearField(5);
  @$pb.TagNumber(5)
  $1.Extras ensureExtras() => $_ensure(3);

  @$pb.TagNumber(8)
  $core.int get score => $_getIZ(4);
  @$pb.TagNumber(8)
  set score($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(8)
  $core.bool hasScore() => $_has(4);
  @$pb.TagNumber(8)
  void clearScore() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get email => $_getSZ(5);
  @$pb.TagNumber(9)
  set email($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(9)
  $core.bool hasEmail() => $_has(5);
  @$pb.TagNumber(9)
  void clearEmail() => clearField(9);

  @$pb.TagNumber(10)
  TasteUser_DailyDigest get dailyDigest => $_getN(6);
  @$pb.TagNumber(10)
  set dailyDigest(TasteUser_DailyDigest v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasDailyDigest() => $_has(6);
  @$pb.TagNumber(10)
  void clearDailyDigest() => clearField(10);
  @$pb.TagNumber(10)
  TasteUser_DailyDigest ensureDailyDigest() => $_ensure(6);

  @$pb.TagNumber(11)
  $core.String get fbId => $_getSZ(7);
  @$pb.TagNumber(11)
  set fbId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(11)
  $core.bool hasFbId() => $_has(7);
  @$pb.TagNumber(11)
  void clearFbId() => clearField(11);

  @$pb.TagNumber(12)
  InstagramInfo get instagramInfo => $_getN(8);
  @$pb.TagNumber(12)
  set instagramInfo(InstagramInfo v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasInstagramInfo() => $_has(8);
  @$pb.TagNumber(12)
  void clearInstagramInfo() => clearField(12);
  @$pb.TagNumber(12)
  InstagramInfo ensureInstagramInfo() => $_ensure(8);

  @$pb.TagNumber(13)
  $core.bool get guestMode => $_getBF(9);
  @$pb.TagNumber(13)
  set guestMode($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(13)
  $core.bool hasGuestMode() => $_has(9);
  @$pb.TagNumber(13)
  void clearGuestMode() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get uid => $_getSZ(10);
  @$pb.TagNumber(14)
  set uid($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(14)
  $core.bool hasUid() => $_has(10);
  @$pb.TagNumber(14)
  void clearUid() => clearField(14);

  @$pb.TagNumber(15)
  $core.List<$1.DocumentReferenceProto> get setupLikedRestos => $_getList(11);
}

class FoodFinderAction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FoodFinderAction', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(2, 'restaurant', subBuilder: $1.DocumentReferenceProto.create)
    ..pc<$1.DocumentReferenceProto>(3, 'discoverItems', $pb.PbFieldType.PM, subBuilder: $1.DocumentReferenceProto.create)
    ..a<$core.int>(4, 'activeDiscoverItemIndex', $pb.PbFieldType.O3)
    ..e<FoodFinderAction_ActionType>(5, 'action', $pb.PbFieldType.OE, defaultOrMaker: FoodFinderAction_ActionType.ACTION_TYPE_UNDEFINED, valueOf: FoodFinderAction_ActionType.valueOf, enumValues: FoodFinderAction_ActionType.values)
    ..aOS(6, 'sessionId')
    ..aOM<$0.Timestamp>(7, 'time', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  FoodFinderAction._() : super();
  factory FoodFinderAction() => create();
  factory FoodFinderAction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FoodFinderAction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FoodFinderAction clone() => FoodFinderAction()..mergeFromMessage(this);
  FoodFinderAction copyWith(void Function(FoodFinderAction) updates) => super.copyWith((message) => updates(message as FoodFinderAction));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FoodFinderAction create() => FoodFinderAction._();
  FoodFinderAction createEmptyInstance() => create();
  static $pb.PbList<FoodFinderAction> createRepeated() => $pb.PbList<FoodFinderAction>();
  @$core.pragma('dart2js:noInline')
  static FoodFinderAction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FoodFinderAction>(create);
  static FoodFinderAction _defaultInstance;

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
  $1.DocumentReferenceProto get restaurant => $_getN(1);
  @$pb.TagNumber(2)
  set restaurant($1.DocumentReferenceProto v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRestaurant() => $_has(1);
  @$pb.TagNumber(2)
  void clearRestaurant() => clearField(2);
  @$pb.TagNumber(2)
  $1.DocumentReferenceProto ensureRestaurant() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<$1.DocumentReferenceProto> get discoverItems => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get activeDiscoverItemIndex => $_getIZ(3);
  @$pb.TagNumber(4)
  set activeDiscoverItemIndex($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasActiveDiscoverItemIndex() => $_has(3);
  @$pb.TagNumber(4)
  void clearActiveDiscoverItemIndex() => clearField(4);

  @$pb.TagNumber(5)
  FoodFinderAction_ActionType get action => $_getN(4);
  @$pb.TagNumber(5)
  set action(FoodFinderAction_ActionType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasAction() => $_has(4);
  @$pb.TagNumber(5)
  void clearAction() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get sessionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set sessionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSessionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearSessionId() => clearField(6);

  @$pb.TagNumber(7)
  $0.Timestamp get time => $_getN(6);
  @$pb.TagNumber(7)
  set time($0.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearTime() => clearField(7);
  @$pb.TagNumber(7)
  $0.Timestamp ensureTime() => $_ensure(6);
}

class Review extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Review', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'text')
    ..aOM<$1.DocumentReferenceProto>(2, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(3, 'photo', subBuilder: $1.DocumentReferenceProto.create)
    ..e<$2.Reaction>(5, 'reaction', $pb.PbFieldType.OE, defaultOrMaker: $2.Reaction.UNDEFINED, valueOf: $2.Reaction.valueOf, enumValues: $2.Reaction.values)
    ..e<Review_MealType>(6, 'mealType', $pb.PbFieldType.OE, defaultOrMaker: Review_MealType.MEAL_TYPE_UNDEFINED, valueOf: Review_MealType.valueOf, enumValues: Review_MealType.values)
    ..aOB(8, 'published')
    ..a<$core.int>(9, 'score', $pb.PbFieldType.O3)
    ..aOM<$1.DocumentReferenceProto>(10, 'restaurant', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.LatLng>(11, 'restaurantLocation', subBuilder: $1.LatLng.create)
    ..aOM<Restaurant_Attributes_Address>(12, 'address', subBuilder: Restaurant_Attributes_Address.create)
    ..aOM<$1.Extras>(13, 'Extras', subBuilder: $1.Extras.create)
    ..pPS(15, 'emojis')
    ..aOM<$1.LatLng>(16, 'location', subBuilder: $1.LatLng.create)
    ..aOS(17, 'dish')
    ..aOS(18, 'restaurantName')
    ..pPS(19, 'attributes')
    ..pc<$1.DocumentReferenceProto>(20, 'mealMates', $pb.PbFieldType.PM, subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(21, 'contest', subBuilder: $1.DocumentReferenceProto.create)
    ..e<Review_DeliveryApp>(22, 'deliveryApp', $pb.PbFieldType.OE, defaultOrMaker: Review_DeliveryApp.UNDEFINED, valueOf: Review_DeliveryApp.valueOf, enumValues: Review_DeliveryApp.values)
    ..pc<$1.DocumentReferenceProto>(23, 'morePhotos', $pb.PbFieldType.PM, subBuilder: $1.DocumentReferenceProto.create)
    ..pc<$1.DocumentReferenceProto>(24, 'userTagsInText', $pb.PbFieldType.PM, subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(25, 'instaPost', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$0.Timestamp>(26, 'importedAt', subBuilder: $0.Timestamp.create)
    ..aOM<Awards>(27, 'awards', subBuilder: Awards.create)
    ..aOB(28, 'freezePlace')
    ..pPS(29, 'categories')
    ..pc<$1.FirePhoto>(30, 'firePhotos', $pb.PbFieldType.PM, subBuilder: $1.FirePhoto.create)
    ..aOS(31, 'recipe')
    ..e<Review_BlackOwnedStatus>(32, 'blackOwned', $pb.PbFieldType.OE, defaultOrMaker: Review_BlackOwnedStatus.BLACK_OWNED_UNDEFINED, valueOf: Review_BlackOwnedStatus.valueOf, enumValues: Review_BlackOwnedStatus.values)
    ..e<BlackCharity>(33, 'blackCharity', $pb.PbFieldType.OE, defaultOrMaker: BlackCharity.CHARITY_UNDEFINED, valueOf: BlackCharity.valueOf, enumValues: BlackCharity.values)
    ..a<$core.int>(34, 'numInstaLikes', $pb.PbFieldType.O3)
    ..a<$core.int>(35, 'numInstaFollowers', $pb.PbFieldType.O3)
    ..aOB(36, 'hidden')
    ..pc<$1.FoodType>(37, 'foodTypes', $pb.PbFieldType.PE, valueOf: $1.FoodType.valueOf, enumValues: $1.FoodType.values)
    ..p<$core.int>(38, 'foodTypesPhotoIndices', $pb.PbFieldType.P3)
    ..hasRequiredFields = false
  ;

  Review._() : super();
  factory Review() => create();
  factory Review.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Review.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Review clone() => Review()..mergeFromMessage(this);
  Review copyWith(void Function(Review) updates) => super.copyWith((message) => updates(message as Review));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Review create() => Review._();
  Review createEmptyInstance() => create();
  static $pb.PbList<Review> createRepeated() => $pb.PbList<Review>();
  @$core.pragma('dart2js:noInline')
  static Review getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Review>(create);
  static Review _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);

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

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $1.DocumentReferenceProto get photo => $_getN(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  set photo($1.DocumentReferenceProto v) { setField(3, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.bool hasPhoto() => $_has(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  void clearPhoto() => clearField(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $1.DocumentReferenceProto ensurePhoto() => $_ensure(2);

  @$pb.TagNumber(5)
  $2.Reaction get reaction => $_getN(3);
  @$pb.TagNumber(5)
  set reaction($2.Reaction v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasReaction() => $_has(3);
  @$pb.TagNumber(5)
  void clearReaction() => clearField(5);

  @$pb.TagNumber(6)
  Review_MealType get mealType => $_getN(4);
  @$pb.TagNumber(6)
  set mealType(Review_MealType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasMealType() => $_has(4);
  @$pb.TagNumber(6)
  void clearMealType() => clearField(6);

  @$pb.TagNumber(8)
  $core.bool get published => $_getBF(5);
  @$pb.TagNumber(8)
  set published($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(8)
  $core.bool hasPublished() => $_has(5);
  @$pb.TagNumber(8)
  void clearPublished() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get score => $_getIZ(6);
  @$pb.TagNumber(9)
  set score($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(9)
  $core.bool hasScore() => $_has(6);
  @$pb.TagNumber(9)
  void clearScore() => clearField(9);

  @$pb.TagNumber(10)
  $1.DocumentReferenceProto get restaurant => $_getN(7);
  @$pb.TagNumber(10)
  set restaurant($1.DocumentReferenceProto v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasRestaurant() => $_has(7);
  @$pb.TagNumber(10)
  void clearRestaurant() => clearField(10);
  @$pb.TagNumber(10)
  $1.DocumentReferenceProto ensureRestaurant() => $_ensure(7);

  @$pb.TagNumber(11)
  $1.LatLng get restaurantLocation => $_getN(8);
  @$pb.TagNumber(11)
  set restaurantLocation($1.LatLng v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasRestaurantLocation() => $_has(8);
  @$pb.TagNumber(11)
  void clearRestaurantLocation() => clearField(11);
  @$pb.TagNumber(11)
  $1.LatLng ensureRestaurantLocation() => $_ensure(8);

  @$pb.TagNumber(12)
  Restaurant_Attributes_Address get address => $_getN(9);
  @$pb.TagNumber(12)
  set address(Restaurant_Attributes_Address v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasAddress() => $_has(9);
  @$pb.TagNumber(12)
  void clearAddress() => clearField(12);
  @$pb.TagNumber(12)
  Restaurant_Attributes_Address ensureAddress() => $_ensure(9);

  @$pb.TagNumber(13)
  $1.Extras get extras => $_getN(10);
  @$pb.TagNumber(13)
  set extras($1.Extras v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasExtras() => $_has(10);
  @$pb.TagNumber(13)
  void clearExtras() => clearField(13);
  @$pb.TagNumber(13)
  $1.Extras ensureExtras() => $_ensure(10);

  @$pb.TagNumber(15)
  $core.List<$core.String> get emojis => $_getList(11);

  @$pb.TagNumber(16)
  $1.LatLng get location => $_getN(12);
  @$pb.TagNumber(16)
  set location($1.LatLng v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasLocation() => $_has(12);
  @$pb.TagNumber(16)
  void clearLocation() => clearField(16);
  @$pb.TagNumber(16)
  $1.LatLng ensureLocation() => $_ensure(12);

  @$pb.TagNumber(17)
  $core.String get dish => $_getSZ(13);
  @$pb.TagNumber(17)
  set dish($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(17)
  $core.bool hasDish() => $_has(13);
  @$pb.TagNumber(17)
  void clearDish() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get restaurantName => $_getSZ(14);
  @$pb.TagNumber(18)
  set restaurantName($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(18)
  $core.bool hasRestaurantName() => $_has(14);
  @$pb.TagNumber(18)
  void clearRestaurantName() => clearField(18);

  @$pb.TagNumber(19)
  $core.List<$core.String> get attributes => $_getList(15);

  @$pb.TagNumber(20)
  $core.List<$1.DocumentReferenceProto> get mealMates => $_getList(16);

  @$pb.TagNumber(21)
  $1.DocumentReferenceProto get contest => $_getN(17);
  @$pb.TagNumber(21)
  set contest($1.DocumentReferenceProto v) { setField(21, v); }
  @$pb.TagNumber(21)
  $core.bool hasContest() => $_has(17);
  @$pb.TagNumber(21)
  void clearContest() => clearField(21);
  @$pb.TagNumber(21)
  $1.DocumentReferenceProto ensureContest() => $_ensure(17);

  @$pb.TagNumber(22)
  Review_DeliveryApp get deliveryApp => $_getN(18);
  @$pb.TagNumber(22)
  set deliveryApp(Review_DeliveryApp v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasDeliveryApp() => $_has(18);
  @$pb.TagNumber(22)
  void clearDeliveryApp() => clearField(22);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(23)
  $core.List<$1.DocumentReferenceProto> get morePhotos => $_getList(19);

  @$pb.TagNumber(24)
  $core.List<$1.DocumentReferenceProto> get userTagsInText => $_getList(20);

  @$pb.TagNumber(25)
  $1.DocumentReferenceProto get instaPost => $_getN(21);
  @$pb.TagNumber(25)
  set instaPost($1.DocumentReferenceProto v) { setField(25, v); }
  @$pb.TagNumber(25)
  $core.bool hasInstaPost() => $_has(21);
  @$pb.TagNumber(25)
  void clearInstaPost() => clearField(25);
  @$pb.TagNumber(25)
  $1.DocumentReferenceProto ensureInstaPost() => $_ensure(21);

  @$pb.TagNumber(26)
  $0.Timestamp get importedAt => $_getN(22);
  @$pb.TagNumber(26)
  set importedAt($0.Timestamp v) { setField(26, v); }
  @$pb.TagNumber(26)
  $core.bool hasImportedAt() => $_has(22);
  @$pb.TagNumber(26)
  void clearImportedAt() => clearField(26);
  @$pb.TagNumber(26)
  $0.Timestamp ensureImportedAt() => $_ensure(22);

  @$pb.TagNumber(27)
  Awards get awards => $_getN(23);
  @$pb.TagNumber(27)
  set awards(Awards v) { setField(27, v); }
  @$pb.TagNumber(27)
  $core.bool hasAwards() => $_has(23);
  @$pb.TagNumber(27)
  void clearAwards() => clearField(27);
  @$pb.TagNumber(27)
  Awards ensureAwards() => $_ensure(23);

  @$pb.TagNumber(28)
  $core.bool get freezePlace => $_getBF(24);
  @$pb.TagNumber(28)
  set freezePlace($core.bool v) { $_setBool(24, v); }
  @$pb.TagNumber(28)
  $core.bool hasFreezePlace() => $_has(24);
  @$pb.TagNumber(28)
  void clearFreezePlace() => clearField(28);

  @$pb.TagNumber(29)
  $core.List<$core.String> get categories => $_getList(25);

  @$pb.TagNumber(30)
  $core.List<$1.FirePhoto> get firePhotos => $_getList(26);

  @$pb.TagNumber(31)
  $core.String get recipe => $_getSZ(27);
  @$pb.TagNumber(31)
  set recipe($core.String v) { $_setString(27, v); }
  @$pb.TagNumber(31)
  $core.bool hasRecipe() => $_has(27);
  @$pb.TagNumber(31)
  void clearRecipe() => clearField(31);

  @$pb.TagNumber(32)
  Review_BlackOwnedStatus get blackOwned => $_getN(28);
  @$pb.TagNumber(32)
  set blackOwned(Review_BlackOwnedStatus v) { setField(32, v); }
  @$pb.TagNumber(32)
  $core.bool hasBlackOwned() => $_has(28);
  @$pb.TagNumber(32)
  void clearBlackOwned() => clearField(32);

  @$pb.TagNumber(33)
  BlackCharity get blackCharity => $_getN(29);
  @$pb.TagNumber(33)
  set blackCharity(BlackCharity v) { setField(33, v); }
  @$pb.TagNumber(33)
  $core.bool hasBlackCharity() => $_has(29);
  @$pb.TagNumber(33)
  void clearBlackCharity() => clearField(33);

  @$pb.TagNumber(34)
  $core.int get numInstaLikes => $_getIZ(30);
  @$pb.TagNumber(34)
  set numInstaLikes($core.int v) { $_setSignedInt32(30, v); }
  @$pb.TagNumber(34)
  $core.bool hasNumInstaLikes() => $_has(30);
  @$pb.TagNumber(34)
  void clearNumInstaLikes() => clearField(34);

  @$pb.TagNumber(35)
  $core.int get numInstaFollowers => $_getIZ(31);
  @$pb.TagNumber(35)
  set numInstaFollowers($core.int v) { $_setSignedInt32(31, v); }
  @$pb.TagNumber(35)
  $core.bool hasNumInstaFollowers() => $_has(31);
  @$pb.TagNumber(35)
  void clearNumInstaFollowers() => clearField(35);

  @$pb.TagNumber(36)
  $core.bool get hidden => $_getBF(32);
  @$pb.TagNumber(36)
  set hidden($core.bool v) { $_setBool(32, v); }
  @$pb.TagNumber(36)
  $core.bool hasHidden() => $_has(32);
  @$pb.TagNumber(36)
  void clearHidden() => clearField(36);

  @$pb.TagNumber(37)
  $core.List<$1.FoodType> get foodTypes => $_getList(33);

  @$pb.TagNumber(38)
  $core.List<$core.int> get foodTypesPhotoIndices => $_getList(34);
}

class Restaurant_Attributes_Address extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Restaurant.Attributes.Address', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'street')
    ..aOS(2, 'city')
    ..aOS(3, 'state')
    ..aOS(4, 'country')
    ..e<Restaurant_Attributes_Address_Source>(5, 'source', $pb.PbFieldType.OE, defaultOrMaker: Restaurant_Attributes_Address_Source.SOURCE_UNDEFINED, valueOf: Restaurant_Attributes_Address_Source.valueOf, enumValues: Restaurant_Attributes_Address_Source.values)
    ..aOM<$1.LatLng>(6, 'sourceLocation', subBuilder: $1.LatLng.create)
    ..hasRequiredFields = false
  ;

  Restaurant_Attributes_Address._() : super();
  factory Restaurant_Attributes_Address() => create();
  factory Restaurant_Attributes_Address.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Restaurant_Attributes_Address.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Restaurant_Attributes_Address clone() => Restaurant_Attributes_Address()..mergeFromMessage(this);
  Restaurant_Attributes_Address copyWith(void Function(Restaurant_Attributes_Address) updates) => super.copyWith((message) => updates(message as Restaurant_Attributes_Address));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Restaurant_Attributes_Address create() => Restaurant_Attributes_Address._();
  Restaurant_Attributes_Address createEmptyInstance() => create();
  static $pb.PbList<Restaurant_Attributes_Address> createRepeated() => $pb.PbList<Restaurant_Attributes_Address>();
  @$core.pragma('dart2js:noInline')
  static Restaurant_Attributes_Address getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Restaurant_Attributes_Address>(create);
  static Restaurant_Attributes_Address _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get street => $_getSZ(0);
  @$pb.TagNumber(1)
  set street($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStreet() => $_has(0);
  @$pb.TagNumber(1)
  void clearStreet() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get city => $_getSZ(1);
  @$pb.TagNumber(2)
  set city($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCity() => $_has(1);
  @$pb.TagNumber(2)
  void clearCity() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get state => $_getSZ(2);
  @$pb.TagNumber(3)
  set state($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasState() => $_has(2);
  @$pb.TagNumber(3)
  void clearState() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get country => $_getSZ(3);
  @$pb.TagNumber(4)
  set country($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCountry() => $_has(3);
  @$pb.TagNumber(4)
  void clearCountry() => clearField(4);

  @$pb.TagNumber(5)
  Restaurant_Attributes_Address_Source get source => $_getN(4);
  @$pb.TagNumber(5)
  set source(Restaurant_Attributes_Address_Source v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasSource() => $_has(4);
  @$pb.TagNumber(5)
  void clearSource() => clearField(5);

  @$pb.TagNumber(6)
  $1.LatLng get sourceLocation => $_getN(5);
  @$pb.TagNumber(6)
  set sourceLocation($1.LatLng v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasSourceLocation() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceLocation() => clearField(6);
  @$pb.TagNumber(6)
  $1.LatLng ensureSourceLocation() => $_ensure(5);
}

class Restaurant_Attributes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Restaurant.Attributes', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.LatLng>(1, 'location', subBuilder: $1.LatLng.create)
    ..aOS(2, 'name')
    ..aOS(3, 'googlePlaceId')
    ..pPS(4, 'allFbPlaceIds')
    ..aOS(5, 'fbPlaceId')
    ..aOM<Restaurant_Attributes_Address>(6, 'address', subBuilder: Restaurant_Attributes_Address.create)
    ..pPS(7, 'categories')
    ..aOB(8, 'blackOwned')
    ..aOS(9, 'phone')
    ..aOS(10, 'website')
    ..pc<$1.FoodType>(11, 'foodTypes', $pb.PbFieldType.PE, valueOf: $1.FoodType.valueOf, enumValues: $1.FoodType.values)
    ..pc<$1.PlaceType>(12, 'placeTypes', $pb.PbFieldType.PE, valueOf: $1.PlaceType.valueOf, enumValues: $1.PlaceType.values)
    ..p<$core.double>(13, 'placeTypeScores', $pb.PbFieldType.PD)
    ..aOB(14, 'placeTypesSet')
    ..aOM<Restaurant_Hours>(15, 'hours', subBuilder: Restaurant_Hours.create)
    ..aOB(16, 'queriedHours')
    ..hasRequiredFields = false
  ;

  Restaurant_Attributes._() : super();
  factory Restaurant_Attributes() => create();
  factory Restaurant_Attributes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Restaurant_Attributes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Restaurant_Attributes clone() => Restaurant_Attributes()..mergeFromMessage(this);
  Restaurant_Attributes copyWith(void Function(Restaurant_Attributes) updates) => super.copyWith((message) => updates(message as Restaurant_Attributes));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Restaurant_Attributes create() => Restaurant_Attributes._();
  Restaurant_Attributes createEmptyInstance() => create();
  static $pb.PbList<Restaurant_Attributes> createRepeated() => $pb.PbList<Restaurant_Attributes>();
  @$core.pragma('dart2js:noInline')
  static Restaurant_Attributes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Restaurant_Attributes>(create);
  static Restaurant_Attributes _defaultInstance;

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
  $core.String get googlePlaceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set googlePlaceId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGooglePlaceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearGooglePlaceId() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get allFbPlaceIds => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get fbPlaceId => $_getSZ(4);
  @$pb.TagNumber(5)
  set fbPlaceId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFbPlaceId() => $_has(4);
  @$pb.TagNumber(5)
  void clearFbPlaceId() => clearField(5);

  @$pb.TagNumber(6)
  Restaurant_Attributes_Address get address => $_getN(5);
  @$pb.TagNumber(6)
  set address(Restaurant_Attributes_Address v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasAddress() => $_has(5);
  @$pb.TagNumber(6)
  void clearAddress() => clearField(6);
  @$pb.TagNumber(6)
  Restaurant_Attributes_Address ensureAddress() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.List<$core.String> get categories => $_getList(6);

  @$pb.TagNumber(8)
  $core.bool get blackOwned => $_getBF(7);
  @$pb.TagNumber(8)
  set blackOwned($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBlackOwned() => $_has(7);
  @$pb.TagNumber(8)
  void clearBlackOwned() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get phone => $_getSZ(8);
  @$pb.TagNumber(9)
  set phone($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPhone() => $_has(8);
  @$pb.TagNumber(9)
  void clearPhone() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get website => $_getSZ(9);
  @$pb.TagNumber(10)
  set website($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasWebsite() => $_has(9);
  @$pb.TagNumber(10)
  void clearWebsite() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<$1.FoodType> get foodTypes => $_getList(10);

  @$pb.TagNumber(12)
  $core.List<$1.PlaceType> get placeTypes => $_getList(11);

  @$pb.TagNumber(13)
  $core.List<$core.double> get placeTypeScores => $_getList(12);

  @$pb.TagNumber(14)
  $core.bool get placeTypesSet => $_getBF(13);
  @$pb.TagNumber(14)
  set placeTypesSet($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasPlaceTypesSet() => $_has(13);
  @$pb.TagNumber(14)
  void clearPlaceTypesSet() => clearField(14);

  @$pb.TagNumber(15)
  Restaurant_Hours get hours => $_getN(14);
  @$pb.TagNumber(15)
  set hours(Restaurant_Hours v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasHours() => $_has(14);
  @$pb.TagNumber(15)
  void clearHours() => clearField(15);
  @$pb.TagNumber(15)
  Restaurant_Hours ensureHours() => $_ensure(14);

  @$pb.TagNumber(16)
  $core.bool get queriedHours => $_getBF(15);
  @$pb.TagNumber(16)
  set queriedHours($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasQueriedHours() => $_has(15);
  @$pb.TagNumber(16)
  void clearQueriedHours() => clearField(16);
}

class Restaurant_DeliveryAppInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Restaurant.DeliveryAppInfo', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'phone')
    ..aOB(2, 'subscriptionDiscount')
    ..aOB(3, 'takingOrders')
    ..aOS(4, 'deliveryFee')
    ..aOM<Restaurant_Hours>(5, 'hours', subBuilder: Restaurant_Hours.create)
    ..aOS(6, 'extra')
    ..aOB(7, 'hasDelivery')
    ..aOB(8, 'hasPickup')
    ..hasRequiredFields = false
  ;

  Restaurant_DeliveryAppInfo._() : super();
  factory Restaurant_DeliveryAppInfo() => create();
  factory Restaurant_DeliveryAppInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Restaurant_DeliveryAppInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Restaurant_DeliveryAppInfo clone() => Restaurant_DeliveryAppInfo()..mergeFromMessage(this);
  Restaurant_DeliveryAppInfo copyWith(void Function(Restaurant_DeliveryAppInfo) updates) => super.copyWith((message) => updates(message as Restaurant_DeliveryAppInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Restaurant_DeliveryAppInfo create() => Restaurant_DeliveryAppInfo._();
  Restaurant_DeliveryAppInfo createEmptyInstance() => create();
  static $pb.PbList<Restaurant_DeliveryAppInfo> createRepeated() => $pb.PbList<Restaurant_DeliveryAppInfo>();
  @$core.pragma('dart2js:noInline')
  static Restaurant_DeliveryAppInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Restaurant_DeliveryAppInfo>(create);
  static Restaurant_DeliveryAppInfo _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get subscriptionDiscount => $_getBF(1);
  @$pb.TagNumber(2)
  set subscriptionDiscount($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSubscriptionDiscount() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubscriptionDiscount() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get takingOrders => $_getBF(2);
  @$pb.TagNumber(3)
  set takingOrders($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTakingOrders() => $_has(2);
  @$pb.TagNumber(3)
  void clearTakingOrders() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get deliveryFee => $_getSZ(3);
  @$pb.TagNumber(4)
  set deliveryFee($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDeliveryFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeliveryFee() => clearField(4);

  @$pb.TagNumber(5)
  Restaurant_Hours get hours => $_getN(4);
  @$pb.TagNumber(5)
  set hours(Restaurant_Hours v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasHours() => $_has(4);
  @$pb.TagNumber(5)
  void clearHours() => clearField(5);
  @$pb.TagNumber(5)
  Restaurant_Hours ensureHours() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get extra => $_getSZ(5);
  @$pb.TagNumber(6)
  set extra($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasExtra() => $_has(5);
  @$pb.TagNumber(6)
  void clearExtra() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get hasDelivery => $_getBF(6);
  @$pb.TagNumber(7)
  set hasDelivery($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasHasDelivery() => $_has(6);
  @$pb.TagNumber(7)
  void clearHasDelivery() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get hasPickup => $_getBF(7);
  @$pb.TagNumber(8)
  set hasPickup($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasHasPickup() => $_has(7);
  @$pb.TagNumber(8)
  void clearHasPickup() => clearField(8);
}

class Restaurant_HoursInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Restaurant.HoursInfo', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOB(1, 'isOpen')
    ..aOM<Restaurant_HoursWindows>(2, 'delivery', subBuilder: Restaurant_HoursWindows.create)
    ..aOM<Restaurant_HoursWindows>(3, 'pickup', subBuilder: Restaurant_HoursWindows.create)
    ..aOM<Restaurant_FacebookHours>(4, 'fbHours', subBuilder: Restaurant_FacebookHours.create)
    ..hasRequiredFields = false
  ;

  Restaurant_HoursInfo._() : super();
  factory Restaurant_HoursInfo() => create();
  factory Restaurant_HoursInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Restaurant_HoursInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Restaurant_HoursInfo clone() => Restaurant_HoursInfo()..mergeFromMessage(this);
  Restaurant_HoursInfo copyWith(void Function(Restaurant_HoursInfo) updates) => super.copyWith((message) => updates(message as Restaurant_HoursInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Restaurant_HoursInfo create() => Restaurant_HoursInfo._();
  Restaurant_HoursInfo createEmptyInstance() => create();
  static $pb.PbList<Restaurant_HoursInfo> createRepeated() => $pb.PbList<Restaurant_HoursInfo>();
  @$core.pragma('dart2js:noInline')
  static Restaurant_HoursInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Restaurant_HoursInfo>(create);
  static Restaurant_HoursInfo _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isOpen => $_getBF(0);
  @$pb.TagNumber(1)
  set isOpen($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsOpen() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsOpen() => clearField(1);

  @$pb.TagNumber(2)
  Restaurant_HoursWindows get delivery => $_getN(1);
  @$pb.TagNumber(2)
  set delivery(Restaurant_HoursWindows v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDelivery() => $_has(1);
  @$pb.TagNumber(2)
  void clearDelivery() => clearField(2);
  @$pb.TagNumber(2)
  Restaurant_HoursWindows ensureDelivery() => $_ensure(1);

  @$pb.TagNumber(3)
  Restaurant_HoursWindows get pickup => $_getN(2);
  @$pb.TagNumber(3)
  set pickup(Restaurant_HoursWindows v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPickup() => $_has(2);
  @$pb.TagNumber(3)
  void clearPickup() => clearField(3);
  @$pb.TagNumber(3)
  Restaurant_HoursWindows ensurePickup() => $_ensure(2);

  @$pb.TagNumber(4)
  Restaurant_FacebookHours get fbHours => $_getN(3);
  @$pb.TagNumber(4)
  set fbHours(Restaurant_FacebookHours v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasFbHours() => $_has(3);
  @$pb.TagNumber(4)
  void clearFbHours() => clearField(4);
  @$pb.TagNumber(4)
  Restaurant_FacebookHours ensureFbHours() => $_ensure(3);
}

class Restaurant_HoursWindows extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Restaurant.HoursWindows', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..pPS(1, 'begin')
    ..pPS(2, 'end')
    ..hasRequiredFields = false
  ;

  Restaurant_HoursWindows._() : super();
  factory Restaurant_HoursWindows() => create();
  factory Restaurant_HoursWindows.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Restaurant_HoursWindows.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Restaurant_HoursWindows clone() => Restaurant_HoursWindows()..mergeFromMessage(this);
  Restaurant_HoursWindows copyWith(void Function(Restaurant_HoursWindows) updates) => super.copyWith((message) => updates(message as Restaurant_HoursWindows));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Restaurant_HoursWindows create() => Restaurant_HoursWindows._();
  Restaurant_HoursWindows createEmptyInstance() => create();
  static $pb.PbList<Restaurant_HoursWindows> createRepeated() => $pb.PbList<Restaurant_HoursWindows>();
  @$core.pragma('dart2js:noInline')
  static Restaurant_HoursWindows getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Restaurant_HoursWindows>(create);
  static Restaurant_HoursWindows _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get begin => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.String> get end => $_getList(1);
}

class Restaurant_OpenWindow extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Restaurant.OpenWindow', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'open')
    ..aOS(2, 'close')
    ..hasRequiredFields = false
  ;

  Restaurant_OpenWindow._() : super();
  factory Restaurant_OpenWindow() => create();
  factory Restaurant_OpenWindow.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Restaurant_OpenWindow.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Restaurant_OpenWindow clone() => Restaurant_OpenWindow()..mergeFromMessage(this);
  Restaurant_OpenWindow copyWith(void Function(Restaurant_OpenWindow) updates) => super.copyWith((message) => updates(message as Restaurant_OpenWindow));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Restaurant_OpenWindow create() => Restaurant_OpenWindow._();
  Restaurant_OpenWindow createEmptyInstance() => create();
  static $pb.PbList<Restaurant_OpenWindow> createRepeated() => $pb.PbList<Restaurant_OpenWindow>();
  @$core.pragma('dart2js:noInline')
  static Restaurant_OpenWindow getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Restaurant_OpenWindow>(create);
  static Restaurant_OpenWindow _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get open => $_getSZ(0);
  @$pb.TagNumber(1)
  set open($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOpen() => $_has(0);
  @$pb.TagNumber(1)
  void clearOpen() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get close => $_getSZ(1);
  @$pb.TagNumber(2)
  set close($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClose() => $_has(1);
  @$pb.TagNumber(2)
  void clearClose() => clearField(2);
}

class Restaurant_FacebookHours extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Restaurant.FacebookHours', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..pc<Restaurant_OpenWindow>(1, 'hours', $pb.PbFieldType.PM, subBuilder: Restaurant_OpenWindow.create)
    ..hasRequiredFields = false
  ;

  Restaurant_FacebookHours._() : super();
  factory Restaurant_FacebookHours() => create();
  factory Restaurant_FacebookHours.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Restaurant_FacebookHours.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Restaurant_FacebookHours clone() => Restaurant_FacebookHours()..mergeFromMessage(this);
  Restaurant_FacebookHours copyWith(void Function(Restaurant_FacebookHours) updates) => super.copyWith((message) => updates(message as Restaurant_FacebookHours));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Restaurant_FacebookHours create() => Restaurant_FacebookHours._();
  Restaurant_FacebookHours createEmptyInstance() => create();
  static $pb.PbList<Restaurant_FacebookHours> createRepeated() => $pb.PbList<Restaurant_FacebookHours>();
  @$core.pragma('dart2js:noInline')
  static Restaurant_FacebookHours getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Restaurant_FacebookHours>(create);
  static Restaurant_FacebookHours _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Restaurant_OpenWindow> get hours => $_getList(0);
}

class Restaurant_Hours extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Restaurant.Hours', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<Restaurant_HoursInfo>(1, 'Mon', protoName: 'Mon', subBuilder: Restaurant_HoursInfo.create)
    ..aOM<Restaurant_HoursInfo>(2, 'Tue', protoName: 'Tue', subBuilder: Restaurant_HoursInfo.create)
    ..aOM<Restaurant_HoursInfo>(3, 'Wed', protoName: 'Wed', subBuilder: Restaurant_HoursInfo.create)
    ..aOM<Restaurant_HoursInfo>(4, 'Thu', protoName: 'Thu', subBuilder: Restaurant_HoursInfo.create)
    ..aOM<Restaurant_HoursInfo>(5, 'Fri', protoName: 'Fri', subBuilder: Restaurant_HoursInfo.create)
    ..aOM<Restaurant_HoursInfo>(6, 'Sat', protoName: 'Sat', subBuilder: Restaurant_HoursInfo.create)
    ..aOM<Restaurant_HoursInfo>(7, 'Sun', protoName: 'Sun', subBuilder: Restaurant_HoursInfo.create)
    ..aOB(8, 'hasHours')
    ..hasRequiredFields = false
  ;

  Restaurant_Hours._() : super();
  factory Restaurant_Hours() => create();
  factory Restaurant_Hours.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Restaurant_Hours.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Restaurant_Hours clone() => Restaurant_Hours()..mergeFromMessage(this);
  Restaurant_Hours copyWith(void Function(Restaurant_Hours) updates) => super.copyWith((message) => updates(message as Restaurant_Hours));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Restaurant_Hours create() => Restaurant_Hours._();
  Restaurant_Hours createEmptyInstance() => create();
  static $pb.PbList<Restaurant_Hours> createRepeated() => $pb.PbList<Restaurant_Hours>();
  @$core.pragma('dart2js:noInline')
  static Restaurant_Hours getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Restaurant_Hours>(create);
  static Restaurant_Hours _defaultInstance;

  @$pb.TagNumber(1)
  Restaurant_HoursInfo get mon => $_getN(0);
  @$pb.TagNumber(1)
  set mon(Restaurant_HoursInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMon() => $_has(0);
  @$pb.TagNumber(1)
  void clearMon() => clearField(1);
  @$pb.TagNumber(1)
  Restaurant_HoursInfo ensureMon() => $_ensure(0);

  @$pb.TagNumber(2)
  Restaurant_HoursInfo get tue => $_getN(1);
  @$pb.TagNumber(2)
  set tue(Restaurant_HoursInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTue() => $_has(1);
  @$pb.TagNumber(2)
  void clearTue() => clearField(2);
  @$pb.TagNumber(2)
  Restaurant_HoursInfo ensureTue() => $_ensure(1);

  @$pb.TagNumber(3)
  Restaurant_HoursInfo get wed => $_getN(2);
  @$pb.TagNumber(3)
  set wed(Restaurant_HoursInfo v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasWed() => $_has(2);
  @$pb.TagNumber(3)
  void clearWed() => clearField(3);
  @$pb.TagNumber(3)
  Restaurant_HoursInfo ensureWed() => $_ensure(2);

  @$pb.TagNumber(4)
  Restaurant_HoursInfo get thu => $_getN(3);
  @$pb.TagNumber(4)
  set thu(Restaurant_HoursInfo v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasThu() => $_has(3);
  @$pb.TagNumber(4)
  void clearThu() => clearField(4);
  @$pb.TagNumber(4)
  Restaurant_HoursInfo ensureThu() => $_ensure(3);

  @$pb.TagNumber(5)
  Restaurant_HoursInfo get fri => $_getN(4);
  @$pb.TagNumber(5)
  set fri(Restaurant_HoursInfo v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasFri() => $_has(4);
  @$pb.TagNumber(5)
  void clearFri() => clearField(5);
  @$pb.TagNumber(5)
  Restaurant_HoursInfo ensureFri() => $_ensure(4);

  @$pb.TagNumber(6)
  Restaurant_HoursInfo get sat => $_getN(5);
  @$pb.TagNumber(6)
  set sat(Restaurant_HoursInfo v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasSat() => $_has(5);
  @$pb.TagNumber(6)
  void clearSat() => clearField(6);
  @$pb.TagNumber(6)
  Restaurant_HoursInfo ensureSat() => $_ensure(5);

  @$pb.TagNumber(7)
  Restaurant_HoursInfo get sun => $_getN(6);
  @$pb.TagNumber(7)
  set sun(Restaurant_HoursInfo v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasSun() => $_has(6);
  @$pb.TagNumber(7)
  void clearSun() => clearField(7);
  @$pb.TagNumber(7)
  Restaurant_HoursInfo ensureSun() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get hasHours => $_getBF(7);
  @$pb.TagNumber(8)
  set hasHours($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasHasHours() => $_has(7);
  @$pb.TagNumber(8)
  void clearHasHours() => clearField(8);
}

class Restaurant_DeliveryInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Restaurant.DeliveryInfo', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<Restaurant_DeliveryAppInfo>(1, 'ubereats', subBuilder: Restaurant_DeliveryAppInfo.create)
    ..aOM<Restaurant_DeliveryAppInfo>(2, 'postmates', subBuilder: Restaurant_DeliveryAppInfo.create)
    ..aOM<Restaurant_DeliveryAppInfo>(3, 'grubhub', subBuilder: Restaurant_DeliveryAppInfo.create)
    ..aOM<Restaurant_DeliveryAppInfo>(4, 'doordash', subBuilder: Restaurant_DeliveryAppInfo.create)
    ..aOM<Restaurant_DeliveryAppInfo>(5, 'favor', subBuilder: Restaurant_DeliveryAppInfo.create)
    ..hasRequiredFields = false
  ;

  Restaurant_DeliveryInfo._() : super();
  factory Restaurant_DeliveryInfo() => create();
  factory Restaurant_DeliveryInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Restaurant_DeliveryInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Restaurant_DeliveryInfo clone() => Restaurant_DeliveryInfo()..mergeFromMessage(this);
  Restaurant_DeliveryInfo copyWith(void Function(Restaurant_DeliveryInfo) updates) => super.copyWith((message) => updates(message as Restaurant_DeliveryInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Restaurant_DeliveryInfo create() => Restaurant_DeliveryInfo._();
  Restaurant_DeliveryInfo createEmptyInstance() => create();
  static $pb.PbList<Restaurant_DeliveryInfo> createRepeated() => $pb.PbList<Restaurant_DeliveryInfo>();
  @$core.pragma('dart2js:noInline')
  static Restaurant_DeliveryInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Restaurant_DeliveryInfo>(create);
  static Restaurant_DeliveryInfo _defaultInstance;

  @$pb.TagNumber(1)
  Restaurant_DeliveryAppInfo get ubereats => $_getN(0);
  @$pb.TagNumber(1)
  set ubereats(Restaurant_DeliveryAppInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUbereats() => $_has(0);
  @$pb.TagNumber(1)
  void clearUbereats() => clearField(1);
  @$pb.TagNumber(1)
  Restaurant_DeliveryAppInfo ensureUbereats() => $_ensure(0);

  @$pb.TagNumber(2)
  Restaurant_DeliveryAppInfo get postmates => $_getN(1);
  @$pb.TagNumber(2)
  set postmates(Restaurant_DeliveryAppInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPostmates() => $_has(1);
  @$pb.TagNumber(2)
  void clearPostmates() => clearField(2);
  @$pb.TagNumber(2)
  Restaurant_DeliveryAppInfo ensurePostmates() => $_ensure(1);

  @$pb.TagNumber(3)
  Restaurant_DeliveryAppInfo get grubhub => $_getN(2);
  @$pb.TagNumber(3)
  set grubhub(Restaurant_DeliveryAppInfo v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGrubhub() => $_has(2);
  @$pb.TagNumber(3)
  void clearGrubhub() => clearField(3);
  @$pb.TagNumber(3)
  Restaurant_DeliveryAppInfo ensureGrubhub() => $_ensure(2);

  @$pb.TagNumber(4)
  Restaurant_DeliveryAppInfo get doordash => $_getN(3);
  @$pb.TagNumber(4)
  set doordash(Restaurant_DeliveryAppInfo v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDoordash() => $_has(3);
  @$pb.TagNumber(4)
  void clearDoordash() => clearField(4);
  @$pb.TagNumber(4)
  Restaurant_DeliveryAppInfo ensureDoordash() => $_ensure(3);

  @$pb.TagNumber(5)
  Restaurant_DeliveryAppInfo get favor => $_getN(4);
  @$pb.TagNumber(5)
  set favor(Restaurant_DeliveryAppInfo v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasFavor() => $_has(4);
  @$pb.TagNumber(5)
  void clearFavor() => clearField(5);
  @$pb.TagNumber(5)
  Restaurant_DeliveryAppInfo ensureFavor() => $_ensure(4);
}

class Restaurant_DeliveryUrl extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Restaurant.DeliveryUrl', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'ubereats')
    ..aOS(2, 'postmates')
    ..aOS(3, 'grubhub')
    ..aOS(4, 'seamless')
    ..aOS(5, 'doordash')
    ..aOS(6, 'caviar')
    ..aOS(7, 'favor')
    ..hasRequiredFields = false
  ;

  Restaurant_DeliveryUrl._() : super();
  factory Restaurant_DeliveryUrl() => create();
  factory Restaurant_DeliveryUrl.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Restaurant_DeliveryUrl.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Restaurant_DeliveryUrl clone() => Restaurant_DeliveryUrl()..mergeFromMessage(this);
  Restaurant_DeliveryUrl copyWith(void Function(Restaurant_DeliveryUrl) updates) => super.copyWith((message) => updates(message as Restaurant_DeliveryUrl));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Restaurant_DeliveryUrl create() => Restaurant_DeliveryUrl._();
  Restaurant_DeliveryUrl createEmptyInstance() => create();
  static $pb.PbList<Restaurant_DeliveryUrl> createRepeated() => $pb.PbList<Restaurant_DeliveryUrl>();
  @$core.pragma('dart2js:noInline')
  static Restaurant_DeliveryUrl getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Restaurant_DeliveryUrl>(create);
  static Restaurant_DeliveryUrl _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ubereats => $_getSZ(0);
  @$pb.TagNumber(1)
  set ubereats($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUbereats() => $_has(0);
  @$pb.TagNumber(1)
  void clearUbereats() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get postmates => $_getSZ(1);
  @$pb.TagNumber(2)
  set postmates($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPostmates() => $_has(1);
  @$pb.TagNumber(2)
  void clearPostmates() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get grubhub => $_getSZ(2);
  @$pb.TagNumber(3)
  set grubhub($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGrubhub() => $_has(2);
  @$pb.TagNumber(3)
  void clearGrubhub() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get seamless => $_getSZ(3);
  @$pb.TagNumber(4)
  set seamless($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSeamless() => $_has(3);
  @$pb.TagNumber(4)
  void clearSeamless() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get doordash => $_getSZ(4);
  @$pb.TagNumber(5)
  set doordash($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDoordash() => $_has(4);
  @$pb.TagNumber(5)
  void clearDoordash() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get caviar => $_getSZ(5);
  @$pb.TagNumber(6)
  set caviar($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCaviar() => $_has(5);
  @$pb.TagNumber(6)
  void clearCaviar() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get favor => $_getSZ(6);
  @$pb.TagNumber(7)
  set favor($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFavor() => $_has(6);
  @$pb.TagNumber(7)
  void clearFavor() => clearField(7);
}

class Restaurant extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Restaurant', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.Extras>(1, 'Extras', subBuilder: $1.Extras.create)
    ..aOM<Restaurant_Attributes>(2, 'attributes', subBuilder: Restaurant_Attributes.create)
    ..aOM<$1.DocumentReferenceProto>(3, 'merchant', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.ScraperResults>(4, 'yelp', subBuilder: $1.ScraperResults.create)
    ..aOM<$1.ScraperResults>(5, 'google', subBuilder: $1.ScraperResults.create)
    ..a<$core.double>(6, 'popularityScore', $pb.PbFieldType.OD)
    ..aOM<$1.DocumentReferenceProto>(7, 'profilePic', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(8, 'profilePicExternalUrl')
    ..aOM<$1.FirePhoto>(9, 'fireProfilePic', subBuilder: $1.FirePhoto.create)
    ..aOB(10, 'yelpScraped')
    ..aOB(11, 'yelpMatch')
    ..aOB(12, 'googleScraped')
    ..aOB(13, 'googleMatch')
    ..aOB(14, 'fromHiddenReview')
    ..a<$core.double>(15, 'gmYelpScore', $pb.PbFieldType.OD)
    ..a<$core.double>(16, 'instagramScore', $pb.PbFieldType.OD)
    ..aOM<SpatialIndex>(17, 'spatialIndex', subBuilder: SpatialIndex.create)
    ..aOS(18, 'geohash')
    ..a<$core.int>(19, 'numReviews', $pb.PbFieldType.O3)
    ..a<$core.int>(20, 'numVisibleReviews', $pb.PbFieldType.O3)
    ..aOB(21, 'deliveryScraped')
    ..aOM<Restaurant_DeliveryUrl>(22, 'deliveryUrl', subBuilder: Restaurant_DeliveryUrl.create)
    ..aOM<Restaurant_DeliveryInfo>(23, 'deliveryInfo', subBuilder: Restaurant_DeliveryInfo.create)
    ..aOB(24, 'deliveryScraperError')
    ..a<$core.int>(25, 'totalIgLikes', $pb.PbFieldType.O3)
    ..a<$core.int>(26, 'totalIgFollowers', $pb.PbFieldType.O3)
    ..a<$core.int>(27, 'numIgPosts', $pb.PbFieldType.O3)
    ..aOB(28, 'scoresUpToDate')
    ..aOM<$1.FirePhoto>(29, 'topReviewPic', subBuilder: $1.FirePhoto.create)
    ..hasRequiredFields = false
  ;

  Restaurant._() : super();
  factory Restaurant() => create();
  factory Restaurant.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Restaurant.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Restaurant clone() => Restaurant()..mergeFromMessage(this);
  Restaurant copyWith(void Function(Restaurant) updates) => super.copyWith((message) => updates(message as Restaurant));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Restaurant create() => Restaurant._();
  Restaurant createEmptyInstance() => create();
  static $pb.PbList<Restaurant> createRepeated() => $pb.PbList<Restaurant>();
  @$core.pragma('dart2js:noInline')
  static Restaurant getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Restaurant>(create);
  static Restaurant _defaultInstance;

  @$pb.TagNumber(1)
  $1.Extras get extras => $_getN(0);
  @$pb.TagNumber(1)
  set extras($1.Extras v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasExtras() => $_has(0);
  @$pb.TagNumber(1)
  void clearExtras() => clearField(1);
  @$pb.TagNumber(1)
  $1.Extras ensureExtras() => $_ensure(0);

  @$pb.TagNumber(2)
  Restaurant_Attributes get attributes => $_getN(1);
  @$pb.TagNumber(2)
  set attributes(Restaurant_Attributes v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAttributes() => $_has(1);
  @$pb.TagNumber(2)
  void clearAttributes() => clearField(2);
  @$pb.TagNumber(2)
  Restaurant_Attributes ensureAttributes() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.DocumentReferenceProto get merchant => $_getN(2);
  @$pb.TagNumber(3)
  set merchant($1.DocumentReferenceProto v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMerchant() => $_has(2);
  @$pb.TagNumber(3)
  void clearMerchant() => clearField(3);
  @$pb.TagNumber(3)
  $1.DocumentReferenceProto ensureMerchant() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.ScraperResults get yelp => $_getN(3);
  @$pb.TagNumber(4)
  set yelp($1.ScraperResults v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasYelp() => $_has(3);
  @$pb.TagNumber(4)
  void clearYelp() => clearField(4);
  @$pb.TagNumber(4)
  $1.ScraperResults ensureYelp() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.ScraperResults get google => $_getN(4);
  @$pb.TagNumber(5)
  set google($1.ScraperResults v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasGoogle() => $_has(4);
  @$pb.TagNumber(5)
  void clearGoogle() => clearField(5);
  @$pb.TagNumber(5)
  $1.ScraperResults ensureGoogle() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.double get popularityScore => $_getN(5);
  @$pb.TagNumber(6)
  set popularityScore($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPopularityScore() => $_has(5);
  @$pb.TagNumber(6)
  void clearPopularityScore() => clearField(6);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  $1.DocumentReferenceProto get profilePic => $_getN(6);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  set profilePic($1.DocumentReferenceProto v) { setField(7, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  $core.bool hasProfilePic() => $_has(6);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  void clearProfilePic() => clearField(7);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  $1.DocumentReferenceProto ensureProfilePic() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get profilePicExternalUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set profilePicExternalUrl($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasProfilePicExternalUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearProfilePicExternalUrl() => clearField(8);

  @$pb.TagNumber(9)
  $1.FirePhoto get fireProfilePic => $_getN(8);
  @$pb.TagNumber(9)
  set fireProfilePic($1.FirePhoto v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasFireProfilePic() => $_has(8);
  @$pb.TagNumber(9)
  void clearFireProfilePic() => clearField(9);
  @$pb.TagNumber(9)
  $1.FirePhoto ensureFireProfilePic() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.bool get yelpScraped => $_getBF(9);
  @$pb.TagNumber(10)
  set yelpScraped($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasYelpScraped() => $_has(9);
  @$pb.TagNumber(10)
  void clearYelpScraped() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get yelpMatch => $_getBF(10);
  @$pb.TagNumber(11)
  set yelpMatch($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasYelpMatch() => $_has(10);
  @$pb.TagNumber(11)
  void clearYelpMatch() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get googleScraped => $_getBF(11);
  @$pb.TagNumber(12)
  set googleScraped($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasGoogleScraped() => $_has(11);
  @$pb.TagNumber(12)
  void clearGoogleScraped() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get googleMatch => $_getBF(12);
  @$pb.TagNumber(13)
  set googleMatch($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasGoogleMatch() => $_has(12);
  @$pb.TagNumber(13)
  void clearGoogleMatch() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get fromHiddenReview => $_getBF(13);
  @$pb.TagNumber(14)
  set fromHiddenReview($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasFromHiddenReview() => $_has(13);
  @$pb.TagNumber(14)
  void clearFromHiddenReview() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get gmYelpScore => $_getN(14);
  @$pb.TagNumber(15)
  set gmYelpScore($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasGmYelpScore() => $_has(14);
  @$pb.TagNumber(15)
  void clearGmYelpScore() => clearField(15);

  @$pb.TagNumber(16)
  $core.double get instagramScore => $_getN(15);
  @$pb.TagNumber(16)
  set instagramScore($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasInstagramScore() => $_has(15);
  @$pb.TagNumber(16)
  void clearInstagramScore() => clearField(16);

  @$pb.TagNumber(17)
  SpatialIndex get spatialIndex => $_getN(16);
  @$pb.TagNumber(17)
  set spatialIndex(SpatialIndex v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasSpatialIndex() => $_has(16);
  @$pb.TagNumber(17)
  void clearSpatialIndex() => clearField(17);
  @$pb.TagNumber(17)
  SpatialIndex ensureSpatialIndex() => $_ensure(16);

  @$pb.TagNumber(18)
  $core.String get geohash => $_getSZ(17);
  @$pb.TagNumber(18)
  set geohash($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasGeohash() => $_has(17);
  @$pb.TagNumber(18)
  void clearGeohash() => clearField(18);

  @$pb.TagNumber(19)
  $core.int get numReviews => $_getIZ(18);
  @$pb.TagNumber(19)
  set numReviews($core.int v) { $_setSignedInt32(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasNumReviews() => $_has(18);
  @$pb.TagNumber(19)
  void clearNumReviews() => clearField(19);

  @$pb.TagNumber(20)
  $core.int get numVisibleReviews => $_getIZ(19);
  @$pb.TagNumber(20)
  set numVisibleReviews($core.int v) { $_setSignedInt32(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasNumVisibleReviews() => $_has(19);
  @$pb.TagNumber(20)
  void clearNumVisibleReviews() => clearField(20);

  @$pb.TagNumber(21)
  $core.bool get deliveryScraped => $_getBF(20);
  @$pb.TagNumber(21)
  set deliveryScraped($core.bool v) { $_setBool(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasDeliveryScraped() => $_has(20);
  @$pb.TagNumber(21)
  void clearDeliveryScraped() => clearField(21);

  @$pb.TagNumber(22)
  Restaurant_DeliveryUrl get deliveryUrl => $_getN(21);
  @$pb.TagNumber(22)
  set deliveryUrl(Restaurant_DeliveryUrl v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasDeliveryUrl() => $_has(21);
  @$pb.TagNumber(22)
  void clearDeliveryUrl() => clearField(22);
  @$pb.TagNumber(22)
  Restaurant_DeliveryUrl ensureDeliveryUrl() => $_ensure(21);

  @$pb.TagNumber(23)
  Restaurant_DeliveryInfo get deliveryInfo => $_getN(22);
  @$pb.TagNumber(23)
  set deliveryInfo(Restaurant_DeliveryInfo v) { setField(23, v); }
  @$pb.TagNumber(23)
  $core.bool hasDeliveryInfo() => $_has(22);
  @$pb.TagNumber(23)
  void clearDeliveryInfo() => clearField(23);
  @$pb.TagNumber(23)
  Restaurant_DeliveryInfo ensureDeliveryInfo() => $_ensure(22);

  @$pb.TagNumber(24)
  $core.bool get deliveryScraperError => $_getBF(23);
  @$pb.TagNumber(24)
  set deliveryScraperError($core.bool v) { $_setBool(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasDeliveryScraperError() => $_has(23);
  @$pb.TagNumber(24)
  void clearDeliveryScraperError() => clearField(24);

  @$pb.TagNumber(25)
  $core.int get totalIgLikes => $_getIZ(24);
  @$pb.TagNumber(25)
  set totalIgLikes($core.int v) { $_setSignedInt32(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasTotalIgLikes() => $_has(24);
  @$pb.TagNumber(25)
  void clearTotalIgLikes() => clearField(25);

  @$pb.TagNumber(26)
  $core.int get totalIgFollowers => $_getIZ(25);
  @$pb.TagNumber(26)
  set totalIgFollowers($core.int v) { $_setSignedInt32(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasTotalIgFollowers() => $_has(25);
  @$pb.TagNumber(26)
  void clearTotalIgFollowers() => clearField(26);

  @$pb.TagNumber(27)
  $core.int get numIgPosts => $_getIZ(26);
  @$pb.TagNumber(27)
  set numIgPosts($core.int v) { $_setSignedInt32(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasNumIgPosts() => $_has(26);
  @$pb.TagNumber(27)
  void clearNumIgPosts() => clearField(27);

  @$pb.TagNumber(28)
  $core.bool get scoresUpToDate => $_getBF(27);
  @$pb.TagNumber(28)
  set scoresUpToDate($core.bool v) { $_setBool(27, v); }
  @$pb.TagNumber(28)
  $core.bool hasScoresUpToDate() => $_has(27);
  @$pb.TagNumber(28)
  void clearScoresUpToDate() => clearField(28);

  @$pb.TagNumber(29)
  $1.FirePhoto get topReviewPic => $_getN(28);
  @$pb.TagNumber(29)
  set topReviewPic($1.FirePhoto v) { setField(29, v); }
  @$pb.TagNumber(29)
  $core.bool hasTopReviewPic() => $_has(28);
  @$pb.TagNumber(29)
  void clearTopReviewPic() => clearField(29);
  @$pb.TagNumber(29)
  $1.FirePhoto ensureTopReviewPic() => $_ensure(28);
}

class View extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('View', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(2, 'parent', subBuilder: $1.DocumentReferenceProto.create)
    ..hasRequiredFields = false
  ;

  View._() : super();
  factory View() => create();
  factory View.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory View.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  View clone() => View()..mergeFromMessage(this);
  View copyWith(void Function(View) updates) => super.copyWith((message) => updates(message as View));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static View create() => View._();
  View createEmptyInstance() => create();
  static $pb.PbList<View> createRepeated() => $pb.PbList<View>();
  @$core.pragma('dart2js:noInline')
  static View getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<View>(create);
  static View _defaultInstance;

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
  $1.DocumentReferenceProto get parent => $_getN(1);
  @$pb.TagNumber(2)
  set parent($1.DocumentReferenceProto v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasParent() => $_has(1);
  @$pb.TagNumber(2)
  void clearParent() => clearField(2);
  @$pb.TagNumber(2)
  $1.DocumentReferenceProto ensureParent() => $_ensure(1);
}

class Photo_InferenceData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Photo.InferenceData', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'sourceRef', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.Point>(2, 'detectionCenter', subBuilder: $1.Point.create)
    ..hasRequiredFields = false
  ;

  Photo_InferenceData._() : super();
  factory Photo_InferenceData() => create();
  factory Photo_InferenceData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Photo_InferenceData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Photo_InferenceData clone() => Photo_InferenceData()..mergeFromMessage(this);
  Photo_InferenceData copyWith(void Function(Photo_InferenceData) updates) => super.copyWith((message) => updates(message as Photo_InferenceData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Photo_InferenceData create() => Photo_InferenceData._();
  Photo_InferenceData createEmptyInstance() => create();
  static $pb.PbList<Photo_InferenceData> createRepeated() => $pb.PbList<Photo_InferenceData>();
  @$core.pragma('dart2js:noInline')
  static Photo_InferenceData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Photo_InferenceData>(create);
  static Photo_InferenceData _defaultInstance;

  @$pb.TagNumber(1)
  $1.DocumentReferenceProto get sourceRef => $_getN(0);
  @$pb.TagNumber(1)
  set sourceRef($1.DocumentReferenceProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSourceRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearSourceRef() => clearField(1);
  @$pb.TagNumber(1)
  $1.DocumentReferenceProto ensureSourceRef() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Point get detectionCenter => $_getN(1);
  @$pb.TagNumber(2)
  set detectionCenter($1.Point v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDetectionCenter() => $_has(1);
  @$pb.TagNumber(2)
  void clearDetectionCenter() => clearField(2);
  @$pb.TagNumber(2)
  $1.Point ensureDetectionCenter() => $_ensure(1);
}

class Photo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Photo', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(2, 'firebaseStoragePath')
    ..aOM<Photo_InferenceData>(4, 'inferenceData', subBuilder: Photo_InferenceData.create)
    ..pc<$1.DocumentReferenceProto>(5, 'references', $pb.PbFieldType.PM, subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.Size>(6, 'photoSize', subBuilder: $1.Size.create)
    ..hasRequiredFields = false
  ;

  Photo._() : super();
  factory Photo() => create();
  factory Photo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Photo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Photo clone() => Photo()..mergeFromMessage(this);
  Photo copyWith(void Function(Photo) updates) => super.copyWith((message) => updates(message as Photo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Photo create() => Photo._();
  Photo createEmptyInstance() => create();
  static $pb.PbList<Photo> createRepeated() => $pb.PbList<Photo>();
  @$core.pragma('dart2js:noInline')
  static Photo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Photo>(create);
  static Photo _defaultInstance;

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
  $core.String get firebaseStoragePath => $_getSZ(1);
  @$pb.TagNumber(2)
  set firebaseStoragePath($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirebaseStoragePath() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirebaseStoragePath() => clearField(2);

  @$pb.TagNumber(4)
  Photo_InferenceData get inferenceData => $_getN(2);
  @$pb.TagNumber(4)
  set inferenceData(Photo_InferenceData v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasInferenceData() => $_has(2);
  @$pb.TagNumber(4)
  void clearInferenceData() => clearField(4);
  @$pb.TagNumber(4)
  Photo_InferenceData ensureInferenceData() => $_ensure(2);

  @$pb.TagNumber(5)
  $core.List<$1.DocumentReferenceProto> get references => $_getList(3);

  @$pb.TagNumber(6)
  $1.Size get photoSize => $_getN(4);
  @$pb.TagNumber(6)
  set photoSize($1.Size v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhotoSize() => $_has(4);
  @$pb.TagNumber(6)
  void clearPhotoSize() => clearField(6);
  @$pb.TagNumber(6)
  $1.Size ensurePhotoSize() => $_ensure(4);
}

class Follower extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Follower', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'following', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(2, 'follower', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.Extras>(3, 'Extras', subBuilder: $1.Extras.create)
    ..hasRequiredFields = false
  ;

  Follower._() : super();
  factory Follower() => create();
  factory Follower.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Follower.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Follower clone() => Follower()..mergeFromMessage(this);
  Follower copyWith(void Function(Follower) updates) => super.copyWith((message) => updates(message as Follower));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Follower create() => Follower._();
  Follower createEmptyInstance() => create();
  static $pb.PbList<Follower> createRepeated() => $pb.PbList<Follower>();
  @$core.pragma('dart2js:noInline')
  static Follower getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Follower>(create);
  static Follower _defaultInstance;

  @$pb.TagNumber(1)
  $1.DocumentReferenceProto get following => $_getN(0);
  @$pb.TagNumber(1)
  set following($1.DocumentReferenceProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFollowing() => $_has(0);
  @$pb.TagNumber(1)
  void clearFollowing() => clearField(1);
  @$pb.TagNumber(1)
  $1.DocumentReferenceProto ensureFollowing() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.DocumentReferenceProto get follower => $_getN(1);
  @$pb.TagNumber(2)
  set follower($1.DocumentReferenceProto v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasFollower() => $_has(1);
  @$pb.TagNumber(2)
  void clearFollower() => clearField(2);
  @$pb.TagNumber(2)
  $1.DocumentReferenceProto ensureFollower() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Extras get extras => $_getN(2);
  @$pb.TagNumber(3)
  set extras($1.Extras v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasExtras() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtras() => clearField(3);
  @$pb.TagNumber(3)
  $1.Extras ensureExtras() => $_ensure(2);
}

class Favorite extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Favorite', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'restaurant', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(2, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.Extras>(3, 'Extras', subBuilder: $1.Extras.create)
    ..hasRequiredFields = false
  ;

  Favorite._() : super();
  factory Favorite() => create();
  factory Favorite.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Favorite.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Favorite clone() => Favorite()..mergeFromMessage(this);
  Favorite copyWith(void Function(Favorite) updates) => super.copyWith((message) => updates(message as Favorite));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Favorite create() => Favorite._();
  Favorite createEmptyInstance() => create();
  static $pb.PbList<Favorite> createRepeated() => $pb.PbList<Favorite>();
  @$core.pragma('dart2js:noInline')
  static Favorite getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Favorite>(create);
  static Favorite _defaultInstance;

  @$pb.TagNumber(1)
  $1.DocumentReferenceProto get restaurant => $_getN(0);
  @$pb.TagNumber(1)
  set restaurant($1.DocumentReferenceProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRestaurant() => $_has(0);
  @$pb.TagNumber(1)
  void clearRestaurant() => clearField(1);
  @$pb.TagNumber(1)
  $1.DocumentReferenceProto ensureRestaurant() => $_ensure(0);

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
  $1.Extras get extras => $_getN(2);
  @$pb.TagNumber(3)
  set extras($1.Extras v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasExtras() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtras() => clearField(3);
  @$pb.TagNumber(3)
  $1.Extras ensureExtras() => $_ensure(2);
}

class Like extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Like', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'parent', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(2, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.Extras>(3, 'Extras', subBuilder: $1.Extras.create)
    ..hasRequiredFields = false
  ;

  Like._() : super();
  factory Like() => create();
  factory Like.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Like.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Like clone() => Like()..mergeFromMessage(this);
  Like copyWith(void Function(Like) updates) => super.copyWith((message) => updates(message as Like));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Like create() => Like._();
  Like createEmptyInstance() => create();
  static $pb.PbList<Like> createRepeated() => $pb.PbList<Like>();
  @$core.pragma('dart2js:noInline')
  static Like getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Like>(create);
  static Like _defaultInstance;

  @$pb.TagNumber(1)
  $1.DocumentReferenceProto get parent => $_getN(0);
  @$pb.TagNumber(1)
  set parent($1.DocumentReferenceProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasParent() => $_has(0);
  @$pb.TagNumber(1)
  void clearParent() => clearField(1);
  @$pb.TagNumber(1)
  $1.DocumentReferenceProto ensureParent() => $_ensure(0);

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
  $1.Extras get extras => $_getN(2);
  @$pb.TagNumber(3)
  set extras($1.Extras v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasExtras() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtras() => clearField(3);
  @$pb.TagNumber(3)
  $1.Extras ensureExtras() => $_ensure(2);
}

class Bookmark extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Bookmark', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'parent', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(2, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.Extras>(3, 'Extras', subBuilder: $1.Extras.create)
    ..hasRequiredFields = false
  ;

  Bookmark._() : super();
  factory Bookmark() => create();
  factory Bookmark.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bookmark.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Bookmark clone() => Bookmark()..mergeFromMessage(this);
  Bookmark copyWith(void Function(Bookmark) updates) => super.copyWith((message) => updates(message as Bookmark));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Bookmark create() => Bookmark._();
  Bookmark createEmptyInstance() => create();
  static $pb.PbList<Bookmark> createRepeated() => $pb.PbList<Bookmark>();
  @$core.pragma('dart2js:noInline')
  static Bookmark getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bookmark>(create);
  static Bookmark _defaultInstance;

  @$pb.TagNumber(1)
  $1.DocumentReferenceProto get parent => $_getN(0);
  @$pb.TagNumber(1)
  set parent($1.DocumentReferenceProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasParent() => $_has(0);
  @$pb.TagNumber(1)
  void clearParent() => clearField(1);
  @$pb.TagNumber(1)
  $1.DocumentReferenceProto ensureParent() => $_ensure(0);

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
  $1.Extras get extras => $_getN(2);
  @$pb.TagNumber(3)
  set extras($1.Extras v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasExtras() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtras() => clearField(3);
  @$pb.TagNumber(3)
  $1.Extras ensureExtras() => $_ensure(2);
}

class BugReport extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('BugReport', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'text')
    ..aOM<$1.DocumentReferenceProto>(2, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..pc<$1.DocumentReferenceProto>(3, 'bugPhotos', $pb.PbFieldType.PM, subBuilder: $1.DocumentReferenceProto.create)
    ..e<BugReportType>(4, 'reportType', $pb.PbFieldType.OE, defaultOrMaker: BugReportType.bug_report, valueOf: BugReportType.valueOf, enumValues: BugReportType.values)
    ..aOM<$1.AppMetadata>(5, 'metadata', subBuilder: $1.AppMetadata.create)
    ..aOM<$1.Extras>(6, 'Extras', subBuilder: $1.Extras.create)
    ..hasRequiredFields = false
  ;

  BugReport._() : super();
  factory BugReport() => create();
  factory BugReport.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BugReport.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  BugReport clone() => BugReport()..mergeFromMessage(this);
  BugReport copyWith(void Function(BugReport) updates) => super.copyWith((message) => updates(message as BugReport));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BugReport create() => BugReport._();
  BugReport createEmptyInstance() => create();
  static $pb.PbList<BugReport> createRepeated() => $pb.PbList<BugReport>();
  @$core.pragma('dart2js:noInline')
  static BugReport getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BugReport>(create);
  static BugReport _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);

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
  $core.List<$1.DocumentReferenceProto> get bugPhotos => $_getList(2);

  @$pb.TagNumber(4)
  BugReportType get reportType => $_getN(3);
  @$pb.TagNumber(4)
  set reportType(BugReportType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasReportType() => $_has(3);
  @$pb.TagNumber(4)
  void clearReportType() => clearField(4);

  @$pb.TagNumber(5)
  $1.AppMetadata get metadata => $_getN(4);
  @$pb.TagNumber(5)
  set metadata($1.AppMetadata v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasMetadata() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetadata() => clearField(5);
  @$pb.TagNumber(5)
  $1.AppMetadata ensureMetadata() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Extras get extras => $_getN(5);
  @$pb.TagNumber(6)
  set extras($1.Extras v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasExtras() => $_has(5);
  @$pb.TagNumber(6)
  void clearExtras() => clearField(6);
  @$pb.TagNumber(6)
  $1.Extras ensureExtras() => $_ensure(5);
}

class Report extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Report', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(2, 'parent', subBuilder: $1.DocumentReferenceProto.create)
    ..aOB(3, 'resolved')
    ..aOS(4, 'text')
    ..aOS(5, 'resolutionText')
    ..aOB(6, 'sendNotification')
    ..hasRequiredFields = false
  ;

  Report._() : super();
  factory Report() => create();
  factory Report.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Report.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Report clone() => Report()..mergeFromMessage(this);
  Report copyWith(void Function(Report) updates) => super.copyWith((message) => updates(message as Report));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Report create() => Report._();
  Report createEmptyInstance() => create();
  static $pb.PbList<Report> createRepeated() => $pb.PbList<Report>();
  @$core.pragma('dart2js:noInline')
  static Report getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Report>(create);
  static Report _defaultInstance;

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
  $1.DocumentReferenceProto get parent => $_getN(1);
  @$pb.TagNumber(2)
  set parent($1.DocumentReferenceProto v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasParent() => $_has(1);
  @$pb.TagNumber(2)
  void clearParent() => clearField(2);
  @$pb.TagNumber(2)
  $1.DocumentReferenceProto ensureParent() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get resolved => $_getBF(2);
  @$pb.TagNumber(3)
  set resolved($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasResolved() => $_has(2);
  @$pb.TagNumber(3)
  void clearResolved() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get text => $_getSZ(3);
  @$pb.TagNumber(4)
  set text($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasText() => $_has(3);
  @$pb.TagNumber(4)
  void clearText() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get resolutionText => $_getSZ(4);
  @$pb.TagNumber(5)
  set resolutionText($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasResolutionText() => $_has(4);
  @$pb.TagNumber(5)
  void clearResolutionText() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get sendNotification => $_getBF(5);
  @$pb.TagNumber(6)
  set sendNotification($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSendNotification() => $_has(5);
  @$pb.TagNumber(6)
  void clearSendNotification() => clearField(6);
}

class AlgoliaRecord extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AlgoliaRecord', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..e<$4.AlgoliaIndex>(1, 'index', $pb.PbFieldType.OE, defaultOrMaker: $4.AlgoliaIndex.ALGOLIA_INDEX_UNDEFINED, valueOf: $4.AlgoliaIndex.valueOf, enumValues: $4.AlgoliaIndex.values)
    ..e<$4.AlgoliaRecordType>(2, 'recordType', $pb.PbFieldType.OE, defaultOrMaker: $4.AlgoliaRecordType.ALGOLIA_RECORD_TYPE_UNDEFINED, valueOf: $4.AlgoliaRecordType.valueOf, enumValues: $4.AlgoliaRecordType.values)
    ..pPS(3, 'tags')
    ..aOM<$1.DocumentReferenceProto>(4, 'reference', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(5, 'objectId')
    ..aOM<$3.Struct>(6, 'payload', subBuilder: $3.Struct.create)
    ..aOM<$1.LatLng>(7, 'location', subBuilder: $1.LatLng.create)
    ..hasRequiredFields = false
  ;

  AlgoliaRecord._() : super();
  factory AlgoliaRecord() => create();
  factory AlgoliaRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AlgoliaRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AlgoliaRecord clone() => AlgoliaRecord()..mergeFromMessage(this);
  AlgoliaRecord copyWith(void Function(AlgoliaRecord) updates) => super.copyWith((message) => updates(message as AlgoliaRecord));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AlgoliaRecord create() => AlgoliaRecord._();
  AlgoliaRecord createEmptyInstance() => create();
  static $pb.PbList<AlgoliaRecord> createRepeated() => $pb.PbList<AlgoliaRecord>();
  @$core.pragma('dart2js:noInline')
  static AlgoliaRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AlgoliaRecord>(create);
  static AlgoliaRecord _defaultInstance;

  @$pb.TagNumber(1)
  $4.AlgoliaIndex get index => $_getN(0);
  @$pb.TagNumber(1)
  set index($4.AlgoliaIndex v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndex() => clearField(1);

  @$pb.TagNumber(2)
  $4.AlgoliaRecordType get recordType => $_getN(1);
  @$pb.TagNumber(2)
  set recordType($4.AlgoliaRecordType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecordType() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecordType() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get tags => $_getList(2);

  @$pb.TagNumber(4)
  $1.DocumentReferenceProto get reference => $_getN(3);
  @$pb.TagNumber(4)
  set reference($1.DocumentReferenceProto v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => clearField(4);
  @$pb.TagNumber(4)
  $1.DocumentReferenceProto ensureReference() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get objectId => $_getSZ(4);
  @$pb.TagNumber(5)
  set objectId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasObjectId() => $_has(4);
  @$pb.TagNumber(5)
  void clearObjectId() => clearField(5);

  @$pb.TagNumber(6)
  $3.Struct get payload => $_getN(5);
  @$pb.TagNumber(6)
  set payload($3.Struct v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasPayload() => $_has(5);
  @$pb.TagNumber(6)
  void clearPayload() => clearField(6);
  @$pb.TagNumber(6)
  $3.Struct ensurePayload() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.LatLng get location => $_getN(6);
  @$pb.TagNumber(7)
  set location($1.LatLng v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasLocation() => $_has(6);
  @$pb.TagNumber(7)
  void clearLocation() => clearField(7);
  @$pb.TagNumber(7)
  $1.LatLng ensureLocation() => $_ensure(6);
}

class InstagramUsernameRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InstagramUsernameRequest', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..aOM<$0.Timestamp>(2, 'mostRecentPostDate', subBuilder: $0.Timestamp.create)
    ..aOB(3, 'setLocationRequest')
    ..hasRequiredFields = false
  ;

  InstagramUsernameRequest._() : super();
  factory InstagramUsernameRequest() => create();
  factory InstagramUsernameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstagramUsernameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InstagramUsernameRequest clone() => InstagramUsernameRequest()..mergeFromMessage(this);
  InstagramUsernameRequest copyWith(void Function(InstagramUsernameRequest) updates) => super.copyWith((message) => updates(message as InstagramUsernameRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InstagramUsernameRequest create() => InstagramUsernameRequest._();
  InstagramUsernameRequest createEmptyInstance() => create();
  static $pb.PbList<InstagramUsernameRequest> createRepeated() => $pb.PbList<InstagramUsernameRequest>();
  @$core.pragma('dart2js:noInline')
  static InstagramUsernameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstagramUsernameRequest>(create);
  static InstagramUsernameRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  $0.Timestamp get mostRecentPostDate => $_getN(1);
  @$pb.TagNumber(2)
  set mostRecentPostDate($0.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMostRecentPostDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearMostRecentPostDate() => clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureMostRecentPostDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get setLocationRequest => $_getBF(2);
  @$pb.TagNumber(3)
  set setLocationRequest($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSetLocationRequest() => $_has(2);
  @$pb.TagNumber(3)
  void clearSetLocationRequest() => clearField(3);
}

class InstagramPost extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InstagramPost', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..a<$core.int>(3, 'likes', $pb.PbFieldType.O3)
    ..aOS(4, 'fullName')
    ..aOS(5, 'profilePicUrl')
    ..aOS(6, 'text')
    ..aOS(7, 'code')
    ..aOS(8, 'locationName')
    ..aOM<$1.LatLng>(9, 'location', subBuilder: $1.LatLng.create)
    ..aOM<$0.Timestamp>(10, 'dateProcessed', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(11, 'datePosted', subBuilder: $0.Timestamp.create)
    ..aOM<SpatialIndex>(12, 'spatialIndex', subBuilder: SpatialIndex.create)
    ..e<InstagramPost_PostType>(13, 'postType', $pb.PbFieldType.OE, defaultOrMaker: InstagramPost_PostType.POST_TYPE_UNDEFINED, valueOf: InstagramPost_PostType.valueOf, enumValues: InstagramPost_PostType.values)
    ..aOS(14, 'pk')
    ..pc<InstagramPost_PhotoClassification>(15, 'classifications', $pb.PbFieldType.PE, valueOf: InstagramPost_PhotoClassification.valueOf, enumValues: InstagramPost_PhotoClassification.values)
    ..aOS(16, 's3PhotoUrl')
    ..e<InstagramPost_InstagramPostSource>(17, 'source', $pb.PbFieldType.OE, defaultOrMaker: InstagramPost_InstagramPostSource.InstagramPostSource_UNDEFINED, valueOf: InstagramPost_InstagramPostSource.valueOf, enumValues: InstagramPost_InstagramPostSource.values)
    ..aOM<$1.DocumentReferenceProto>(19, 'reference', subBuilder: $1.DocumentReferenceProto.create)
    ..pPS(20, 'photoUrls')
    ..hasRequiredFields = false
  ;

  InstagramPost._() : super();
  factory InstagramPost() => create();
  factory InstagramPost.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstagramPost.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InstagramPost clone() => InstagramPost()..mergeFromMessage(this);
  InstagramPost copyWith(void Function(InstagramPost) updates) => super.copyWith((message) => updates(message as InstagramPost));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InstagramPost create() => InstagramPost._();
  InstagramPost createEmptyInstance() => create();
  static $pb.PbList<InstagramPost> createRepeated() => $pb.PbList<InstagramPost>();
  @$core.pragma('dart2js:noInline')
  static InstagramPost getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstagramPost>(create);
  static InstagramPost _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(3)
  $core.int get likes => $_getIZ(1);
  @$pb.TagNumber(3)
  set likes($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasLikes() => $_has(1);
  @$pb.TagNumber(3)
  void clearLikes() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fullName => $_getSZ(2);
  @$pb.TagNumber(4)
  set fullName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasFullName() => $_has(2);
  @$pb.TagNumber(4)
  void clearFullName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get profilePicUrl => $_getSZ(3);
  @$pb.TagNumber(5)
  set profilePicUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasProfilePicUrl() => $_has(3);
  @$pb.TagNumber(5)
  void clearProfilePicUrl() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get text => $_getSZ(4);
  @$pb.TagNumber(6)
  set text($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasText() => $_has(4);
  @$pb.TagNumber(6)
  void clearText() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get code => $_getSZ(5);
  @$pb.TagNumber(7)
  set code($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasCode() => $_has(5);
  @$pb.TagNumber(7)
  void clearCode() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get locationName => $_getSZ(6);
  @$pb.TagNumber(8)
  set locationName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasLocationName() => $_has(6);
  @$pb.TagNumber(8)
  void clearLocationName() => clearField(8);

  @$pb.TagNumber(9)
  $1.LatLng get location => $_getN(7);
  @$pb.TagNumber(9)
  set location($1.LatLng v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasLocation() => $_has(7);
  @$pb.TagNumber(9)
  void clearLocation() => clearField(9);
  @$pb.TagNumber(9)
  $1.LatLng ensureLocation() => $_ensure(7);

  @$pb.TagNumber(10)
  $0.Timestamp get dateProcessed => $_getN(8);
  @$pb.TagNumber(10)
  set dateProcessed($0.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasDateProcessed() => $_has(8);
  @$pb.TagNumber(10)
  void clearDateProcessed() => clearField(10);
  @$pb.TagNumber(10)
  $0.Timestamp ensureDateProcessed() => $_ensure(8);

  @$pb.TagNumber(11)
  $0.Timestamp get datePosted => $_getN(9);
  @$pb.TagNumber(11)
  set datePosted($0.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasDatePosted() => $_has(9);
  @$pb.TagNumber(11)
  void clearDatePosted() => clearField(11);
  @$pb.TagNumber(11)
  $0.Timestamp ensureDatePosted() => $_ensure(9);

  @$pb.TagNumber(12)
  SpatialIndex get spatialIndex => $_getN(10);
  @$pb.TagNumber(12)
  set spatialIndex(SpatialIndex v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasSpatialIndex() => $_has(10);
  @$pb.TagNumber(12)
  void clearSpatialIndex() => clearField(12);
  @$pb.TagNumber(12)
  SpatialIndex ensureSpatialIndex() => $_ensure(10);

  @$pb.TagNumber(13)
  InstagramPost_PostType get postType => $_getN(11);
  @$pb.TagNumber(13)
  set postType(InstagramPost_PostType v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasPostType() => $_has(11);
  @$pb.TagNumber(13)
  void clearPostType() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get pk => $_getSZ(12);
  @$pb.TagNumber(14)
  set pk($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(14)
  $core.bool hasPk() => $_has(12);
  @$pb.TagNumber(14)
  void clearPk() => clearField(14);

  @$pb.TagNumber(15)
  $core.List<InstagramPost_PhotoClassification> get classifications => $_getList(13);

  @$pb.TagNumber(16)
  $core.String get s3PhotoUrl => $_getSZ(14);
  @$pb.TagNumber(16)
  set s3PhotoUrl($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(16)
  $core.bool hasS3PhotoUrl() => $_has(14);
  @$pb.TagNumber(16)
  void clearS3PhotoUrl() => clearField(16);

  @$pb.TagNumber(17)
  InstagramPost_InstagramPostSource get source => $_getN(15);
  @$pb.TagNumber(17)
  set source(InstagramPost_InstagramPostSource v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasSource() => $_has(15);
  @$pb.TagNumber(17)
  void clearSource() => clearField(17);

  @$pb.TagNumber(19)
  $1.DocumentReferenceProto get reference => $_getN(16);
  @$pb.TagNumber(19)
  set reference($1.DocumentReferenceProto v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasReference() => $_has(16);
  @$pb.TagNumber(19)
  void clearReference() => clearField(19);
  @$pb.TagNumber(19)
  $1.DocumentReferenceProto ensureReference() => $_ensure(16);

  @$pb.TagNumber(20)
  $core.List<$core.String> get photoUrls => $_getList(17);
}

class Badge_CountData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Badge.CountData', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..a<$core.int>(1, 'count', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Badge_CountData._() : super();
  factory Badge_CountData() => create();
  factory Badge_CountData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Badge_CountData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Badge_CountData clone() => Badge_CountData()..mergeFromMessage(this);
  Badge_CountData copyWith(void Function(Badge_CountData) updates) => super.copyWith((message) => updates(message as Badge_CountData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Badge_CountData create() => Badge_CountData._();
  Badge_CountData createEmptyInstance() => create();
  static $pb.PbList<Badge_CountData> createRepeated() => $pb.PbList<Badge_CountData>();
  @$core.pragma('dart2js:noInline')
  static Badge_CountData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Badge_CountData>(create);
  static Badge_CountData _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get count => $_getIZ(0);
  @$pb.TagNumber(1)
  set count($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearCount() => clearField(1);
}

class Badge_CityChampion_City extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Badge.CityChampion.City', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'city')
    ..aOS(2, 'country')
    ..aOS(3, 'state')
    ..hasRequiredFields = false
  ;

  Badge_CityChampion_City._() : super();
  factory Badge_CityChampion_City() => create();
  factory Badge_CityChampion_City.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Badge_CityChampion_City.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Badge_CityChampion_City clone() => Badge_CityChampion_City()..mergeFromMessage(this);
  Badge_CityChampion_City copyWith(void Function(Badge_CityChampion_City) updates) => super.copyWith((message) => updates(message as Badge_CityChampion_City));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Badge_CityChampion_City create() => Badge_CityChampion_City._();
  Badge_CityChampion_City createEmptyInstance() => create();
  static $pb.PbList<Badge_CityChampion_City> createRepeated() => $pb.PbList<Badge_CityChampion_City>();
  @$core.pragma('dart2js:noInline')
  static Badge_CityChampion_City getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Badge_CityChampion_City>(create);
  static Badge_CityChampion_City _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get city => $_getSZ(0);
  @$pb.TagNumber(1)
  set city($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCity() => $_has(0);
  @$pb.TagNumber(1)
  void clearCity() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get country => $_getSZ(1);
  @$pb.TagNumber(2)
  set country($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountry() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountry() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get state => $_getSZ(2);
  @$pb.TagNumber(3)
  set state($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasState() => $_has(2);
  @$pb.TagNumber(3)
  void clearState() => clearField(3);
}

class Badge_CityChampion extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Badge.CityChampion', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..pc<Badge_CityChampion_City>(1, 'cities', $pb.PbFieldType.PM, subBuilder: Badge_CityChampion_City.create)
    ..hasRequiredFields = false
  ;

  Badge_CityChampion._() : super();
  factory Badge_CityChampion() => create();
  factory Badge_CityChampion.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Badge_CityChampion.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Badge_CityChampion clone() => Badge_CityChampion()..mergeFromMessage(this);
  Badge_CityChampion copyWith(void Function(Badge_CityChampion) updates) => super.copyWith((message) => updates(message as Badge_CityChampion));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Badge_CityChampion create() => Badge_CityChampion._();
  Badge_CityChampion createEmptyInstance() => create();
  static $pb.PbList<Badge_CityChampion> createRepeated() => $pb.PbList<Badge_CityChampion>();
  @$core.pragma('dart2js:noInline')
  static Badge_CityChampion getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Badge_CityChampion>(create);
  static Badge_CityChampion _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Badge_CityChampion_City> get cities => $_getList(0);
}

class Badge_EmojiFlags extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Badge.EmojiFlags', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..pPS(1, 'flags')
    ..hasRequiredFields = false
  ;

  Badge_EmojiFlags._() : super();
  factory Badge_EmojiFlags() => create();
  factory Badge_EmojiFlags.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Badge_EmojiFlags.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Badge_EmojiFlags clone() => Badge_EmojiFlags()..mergeFromMessage(this);
  Badge_EmojiFlags copyWith(void Function(Badge_EmojiFlags) updates) => super.copyWith((message) => updates(message as Badge_EmojiFlags));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Badge_EmojiFlags create() => Badge_EmojiFlags._();
  Badge_EmojiFlags createEmptyInstance() => create();
  static $pb.PbList<Badge_EmojiFlags> createRepeated() => $pb.PbList<Badge_EmojiFlags>();
  @$core.pragma('dart2js:noInline')
  static Badge_EmojiFlags getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Badge_EmojiFlags>(create);
  static Badge_EmojiFlags _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get flags => $_getList(0);
}

class Badge_Brainiac extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Badge.Brainiac', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..pPS(1, 'attributes')
    ..hasRequiredFields = false
  ;

  Badge_Brainiac._() : super();
  factory Badge_Brainiac() => create();
  factory Badge_Brainiac.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Badge_Brainiac.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Badge_Brainiac clone() => Badge_Brainiac()..mergeFromMessage(this);
  Badge_Brainiac copyWith(void Function(Badge_Brainiac) updates) => super.copyWith((message) => updates(message as Badge_Brainiac));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Badge_Brainiac create() => Badge_Brainiac._();
  Badge_Brainiac createEmptyInstance() => create();
  static $pb.PbList<Badge_Brainiac> createRepeated() => $pb.PbList<Badge_Brainiac>();
  @$core.pragma('dart2js:noInline')
  static Badge_Brainiac getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Badge_Brainiac>(create);
  static Badge_Brainiac _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get attributes => $_getList(0);
}

class Badge extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Badge', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..e<Badge_BadgeType>(2, 'type', $pb.PbFieldType.OE, defaultOrMaker: Badge_BadgeType.BADGE_TYPE_UNDEFINED, valueOf: Badge_BadgeType.valueOf, enumValues: Badge_BadgeType.values)
    ..aOM<Badge_CountData>(3, 'countData', subBuilder: Badge_CountData.create)
    ..aOM<Badge_CityChampion>(4, 'cityChampionData', subBuilder: Badge_CityChampion.create)
    ..aOM<Badge_EmojiFlags>(5, 'emojiFlags', subBuilder: Badge_EmojiFlags.create)
    ..pc<$1.DocumentReferenceProto>(6, 'matchingReferences', $pb.PbFieldType.PM, subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<Badge_Brainiac>(7, 'brainiacInfo', subBuilder: Badge_Brainiac.create)
    ..hasRequiredFields = false
  ;

  Badge._() : super();
  factory Badge() => create();
  factory Badge.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Badge.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Badge clone() => Badge()..mergeFromMessage(this);
  Badge copyWith(void Function(Badge) updates) => super.copyWith((message) => updates(message as Badge));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Badge create() => Badge._();
  Badge createEmptyInstance() => create();
  static $pb.PbList<Badge> createRepeated() => $pb.PbList<Badge>();
  @$core.pragma('dart2js:noInline')
  static Badge getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Badge>(create);
  static Badge _defaultInstance;

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
  Badge_BadgeType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(Badge_BadgeType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  Badge_CountData get countData => $_getN(2);
  @$pb.TagNumber(3)
  set countData(Badge_CountData v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCountData() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountData() => clearField(3);
  @$pb.TagNumber(3)
  Badge_CountData ensureCountData() => $_ensure(2);

  @$pb.TagNumber(4)
  Badge_CityChampion get cityChampionData => $_getN(3);
  @$pb.TagNumber(4)
  set cityChampionData(Badge_CityChampion v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCityChampionData() => $_has(3);
  @$pb.TagNumber(4)
  void clearCityChampionData() => clearField(4);
  @$pb.TagNumber(4)
  Badge_CityChampion ensureCityChampionData() => $_ensure(3);

  @$pb.TagNumber(5)
  Badge_EmojiFlags get emojiFlags => $_getN(4);
  @$pb.TagNumber(5)
  set emojiFlags(Badge_EmojiFlags v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmojiFlags() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmojiFlags() => clearField(5);
  @$pb.TagNumber(5)
  Badge_EmojiFlags ensureEmojiFlags() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.List<$1.DocumentReferenceProto> get matchingReferences => $_getList(5);

  @$pb.TagNumber(7)
  Badge_Brainiac get brainiacInfo => $_getN(6);
  @$pb.TagNumber(7)
  set brainiacInfo(Badge_Brainiac v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasBrainiacInfo() => $_has(6);
  @$pb.TagNumber(7)
  void clearBrainiacInfo() => clearField(7);
  @$pb.TagNumber(7)
  Badge_Brainiac ensureBrainiacInfo() => $_ensure(6);
}

class SpatialIndex extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SpatialIndex', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'cellId')
    ..pPS(2, 'levels')
    ..hasRequiredFields = false
  ;

  SpatialIndex._() : super();
  factory SpatialIndex() => create();
  factory SpatialIndex.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SpatialIndex.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SpatialIndex clone() => SpatialIndex()..mergeFromMessage(this);
  SpatialIndex copyWith(void Function(SpatialIndex) updates) => super.copyWith((message) => updates(message as SpatialIndex));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SpatialIndex create() => SpatialIndex._();
  SpatialIndex createEmptyInstance() => create();
  static $pb.PbList<SpatialIndex> createRepeated() => $pb.PbList<SpatialIndex>();
  @$core.pragma('dart2js:noInline')
  static SpatialIndex getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SpatialIndex>(create);
  static SpatialIndex _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cellId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cellId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCellId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCellId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get levels => $_getList(1);
}

class UniqueUserIndex extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UniqueUserIndex', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'reference', subBuilder: $1.DocumentReferenceProto.create)
    ..hasRequiredFields = false
  ;

  UniqueUserIndex._() : super();
  factory UniqueUserIndex() => create();
  factory UniqueUserIndex.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UniqueUserIndex.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UniqueUserIndex clone() => UniqueUserIndex()..mergeFromMessage(this);
  UniqueUserIndex copyWith(void Function(UniqueUserIndex) updates) => super.copyWith((message) => updates(message as UniqueUserIndex));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UniqueUserIndex create() => UniqueUserIndex._();
  UniqueUserIndex createEmptyInstance() => create();
  static $pb.PbList<UniqueUserIndex> createRepeated() => $pb.PbList<UniqueUserIndex>();
  @$core.pragma('dart2js:noInline')
  static UniqueUserIndex getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UniqueUserIndex>(create);
  static UniqueUserIndex _defaultInstance;

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
}

class DiscoverItem_DiscoverRestaurant extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DiscoverItem.DiscoverRestaurant', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'reference', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(2, 'name')
    ..aOM<Restaurant_Attributes_Address>(3, 'address', subBuilder: Restaurant_Attributes_Address.create)
    ..hasRequiredFields = false
  ;

  DiscoverItem_DiscoverRestaurant._() : super();
  factory DiscoverItem_DiscoverRestaurant() => create();
  factory DiscoverItem_DiscoverRestaurant.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscoverItem_DiscoverRestaurant.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DiscoverItem_DiscoverRestaurant clone() => DiscoverItem_DiscoverRestaurant()..mergeFromMessage(this);
  DiscoverItem_DiscoverRestaurant copyWith(void Function(DiscoverItem_DiscoverRestaurant) updates) => super.copyWith((message) => updates(message as DiscoverItem_DiscoverRestaurant));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DiscoverItem_DiscoverRestaurant create() => DiscoverItem_DiscoverRestaurant._();
  DiscoverItem_DiscoverRestaurant createEmptyInstance() => create();
  static $pb.PbList<DiscoverItem_DiscoverRestaurant> createRepeated() => $pb.PbList<DiscoverItem_DiscoverRestaurant>();
  @$core.pragma('dart2js:noInline')
  static DiscoverItem_DiscoverRestaurant getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiscoverItem_DiscoverRestaurant>(create);
  static DiscoverItem_DiscoverRestaurant _defaultInstance;

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
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  Restaurant_Attributes_Address get address => $_getN(2);
  @$pb.TagNumber(3)
  set address(Restaurant_Attributes_Address v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddress() => clearField(3);
  @$pb.TagNumber(3)
  Restaurant_Attributes_Address ensureAddress() => $_ensure(2);
}

class DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DiscoverItem.DiscoverReview.DiscoverMealMates.DiscoverMealMate', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'reference', subBuilder: $1.DocumentReferenceProto.create)
    ..hasRequiredFields = false
  ;

  DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate._() : super();
  factory DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate() => create();
  factory DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate clone() => DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate()..mergeFromMessage(this);
  DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate copyWith(void Function(DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate) updates) => super.copyWith((message) => updates(message as DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate create() => DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate._();
  DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate createEmptyInstance() => create();
  static $pb.PbList<DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate> createRepeated() => $pb.PbList<DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate>();
  @$core.pragma('dart2js:noInline')
  static DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate>(create);
  static DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate _defaultInstance;

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
}

class DiscoverItem_DiscoverReview_DiscoverMealMates extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DiscoverItem.DiscoverReview.DiscoverMealMates', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..pc<DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate>(1, 'mealMates', $pb.PbFieldType.PM, subBuilder: DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate.create)
    ..hasRequiredFields = false
  ;

  DiscoverItem_DiscoverReview_DiscoverMealMates._() : super();
  factory DiscoverItem_DiscoverReview_DiscoverMealMates() => create();
  factory DiscoverItem_DiscoverReview_DiscoverMealMates.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscoverItem_DiscoverReview_DiscoverMealMates.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DiscoverItem_DiscoverReview_DiscoverMealMates clone() => DiscoverItem_DiscoverReview_DiscoverMealMates()..mergeFromMessage(this);
  DiscoverItem_DiscoverReview_DiscoverMealMates copyWith(void Function(DiscoverItem_DiscoverReview_DiscoverMealMates) updates) => super.copyWith((message) => updates(message as DiscoverItem_DiscoverReview_DiscoverMealMates));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DiscoverItem_DiscoverReview_DiscoverMealMates create() => DiscoverItem_DiscoverReview_DiscoverMealMates._();
  DiscoverItem_DiscoverReview_DiscoverMealMates createEmptyInstance() => create();
  static $pb.PbList<DiscoverItem_DiscoverReview_DiscoverMealMates> createRepeated() => $pb.PbList<DiscoverItem_DiscoverReview_DiscoverMealMates>();
  @$core.pragma('dart2js:noInline')
  static DiscoverItem_DiscoverReview_DiscoverMealMates getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiscoverItem_DiscoverReview_DiscoverMealMates>(create);
  static DiscoverItem_DiscoverReview_DiscoverMealMates _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate> get mealMates => $_getList(0);
}

class DiscoverItem_DiscoverReview extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DiscoverItem.DiscoverReview', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'text')
    ..e<$2.Reaction>(2, 'reaction', $pb.PbFieldType.OE, defaultOrMaker: $2.Reaction.UNDEFINED, valueOf: $2.Reaction.valueOf, enumValues: $2.Reaction.values)
    ..aOM<DiscoverItem_DiscoverReview_DiscoverMealMates>(3, 'mealMates', subBuilder: DiscoverItem_DiscoverReview_DiscoverMealMates.create)
    ..aOS(4, 'rawText')
    ..pPS(5, 'emojis')
    ..pPS(6, 'attributes')
    ..e<Review_DeliveryApp>(7, 'deliveryApp', $pb.PbFieldType.OE, defaultOrMaker: Review_DeliveryApp.UNDEFINED, valueOf: Review_DeliveryApp.valueOf, enumValues: Review_DeliveryApp.values)
    ..aOS(8, 'recipe')
    ..pc<$1.FoodType>(9, 'foodTypes', $pb.PbFieldType.PE, valueOf: $1.FoodType.valueOf, enumValues: $1.FoodType.values)
    ..p<$core.int>(10, 'foodTypesPhotoIndices', $pb.PbFieldType.P3)
    ..hasRequiredFields = false
  ;

  DiscoverItem_DiscoverReview._() : super();
  factory DiscoverItem_DiscoverReview() => create();
  factory DiscoverItem_DiscoverReview.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscoverItem_DiscoverReview.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DiscoverItem_DiscoverReview clone() => DiscoverItem_DiscoverReview()..mergeFromMessage(this);
  DiscoverItem_DiscoverReview copyWith(void Function(DiscoverItem_DiscoverReview) updates) => super.copyWith((message) => updates(message as DiscoverItem_DiscoverReview));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DiscoverItem_DiscoverReview create() => DiscoverItem_DiscoverReview._();
  DiscoverItem_DiscoverReview createEmptyInstance() => create();
  static $pb.PbList<DiscoverItem_DiscoverReview> createRepeated() => $pb.PbList<DiscoverItem_DiscoverReview>();
  @$core.pragma('dart2js:noInline')
  static DiscoverItem_DiscoverReview getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiscoverItem_DiscoverReview>(create);
  static DiscoverItem_DiscoverReview _defaultInstance;

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  void clearText() => clearField(1);

  @$pb.TagNumber(2)
  $2.Reaction get reaction => $_getN(1);
  @$pb.TagNumber(2)
  set reaction($2.Reaction v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasReaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearReaction() => clearField(2);

  @$pb.TagNumber(3)
  DiscoverItem_DiscoverReview_DiscoverMealMates get mealMates => $_getN(2);
  @$pb.TagNumber(3)
  set mealMates(DiscoverItem_DiscoverReview_DiscoverMealMates v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMealMates() => $_has(2);
  @$pb.TagNumber(3)
  void clearMealMates() => clearField(3);
  @$pb.TagNumber(3)
  DiscoverItem_DiscoverReview_DiscoverMealMates ensureMealMates() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get rawText => $_getSZ(3);
  @$pb.TagNumber(4)
  set rawText($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRawText() => $_has(3);
  @$pb.TagNumber(4)
  void clearRawText() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get emojis => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<$core.String> get attributes => $_getList(5);

  @$pb.TagNumber(7)
  Review_DeliveryApp get deliveryApp => $_getN(6);
  @$pb.TagNumber(7)
  set deliveryApp(Review_DeliveryApp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDeliveryApp() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeliveryApp() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get recipe => $_getSZ(7);
  @$pb.TagNumber(8)
  set recipe($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRecipe() => $_has(7);
  @$pb.TagNumber(8)
  void clearRecipe() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$1.FoodType> get foodTypes => $_getList(8);

  @$pb.TagNumber(10)
  $core.List<$core.int> get foodTypesPhotoIndices => $_getList(9);
}

class DiscoverItem_User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DiscoverItem.User', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'reference', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(2, 'name')
    ..aOS(3, 'photo')
    ..hasRequiredFields = false
  ;

  DiscoverItem_User._() : super();
  factory DiscoverItem_User() => create();
  factory DiscoverItem_User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscoverItem_User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DiscoverItem_User clone() => DiscoverItem_User()..mergeFromMessage(this);
  DiscoverItem_User copyWith(void Function(DiscoverItem_User) updates) => super.copyWith((message) => updates(message as DiscoverItem_User));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DiscoverItem_User create() => DiscoverItem_User._();
  DiscoverItem_User createEmptyInstance() => create();
  static $pb.PbList<DiscoverItem_User> createRepeated() => $pb.PbList<DiscoverItem_User>();
  @$core.pragma('dart2js:noInline')
  static DiscoverItem_User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiscoverItem_User>(create);
  static DiscoverItem_User _defaultInstance;

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
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get photo => $_getSZ(2);
  @$pb.TagNumber(3)
  set photo($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhoto() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhoto() => clearField(3);
}

class DiscoverItem_Comment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DiscoverItem.Comment', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'reference', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(2, 'text')
    ..aOM<$0.Timestamp>(3, 'date', subBuilder: $0.Timestamp.create)
    ..aOM<DiscoverItem_User>(4, 'user', subBuilder: DiscoverItem_User.create)
    ..hasRequiredFields = false
  ;

  DiscoverItem_Comment._() : super();
  factory DiscoverItem_Comment() => create();
  factory DiscoverItem_Comment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscoverItem_Comment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DiscoverItem_Comment clone() => DiscoverItem_Comment()..mergeFromMessage(this);
  DiscoverItem_Comment copyWith(void Function(DiscoverItem_Comment) updates) => super.copyWith((message) => updates(message as DiscoverItem_Comment));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DiscoverItem_Comment create() => DiscoverItem_Comment._();
  DiscoverItem_Comment createEmptyInstance() => create();
  static $pb.PbList<DiscoverItem_Comment> createRepeated() => $pb.PbList<DiscoverItem_Comment>();
  @$core.pragma('dart2js:noInline')
  static DiscoverItem_Comment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiscoverItem_Comment>(create);
  static DiscoverItem_Comment _defaultInstance;

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
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get date => $_getN(2);
  @$pb.TagNumber(3)
  set date($0.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDate() => clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureDate() => $_ensure(2);

  @$pb.TagNumber(4)
  DiscoverItem_User get user => $_getN(3);
  @$pb.TagNumber(4)
  set user(DiscoverItem_User v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => clearField(4);
  @$pb.TagNumber(4)
  DiscoverItem_User ensureUser() => $_ensure(3);
}

class DiscoverItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DiscoverItem', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'reference', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<DiscoverItem_DiscoverRestaurant>(2, 'restaurant', subBuilder: DiscoverItem_DiscoverRestaurant.create)
    ..aOM<DiscoverItem_DiscoverReview>(3, 'review', subBuilder: DiscoverItem_DiscoverReview.create)
    ..aOM<DiscoverItem_User>(4, 'user', subBuilder: DiscoverItem_User.create)
    ..aOM<$0.Timestamp>(5, 'date', subBuilder: $0.Timestamp.create)
    ..pc<DiscoverItem_Comment>(6, 'comments', $pb.PbFieldType.PM, subBuilder: DiscoverItem_Comment.create)
    ..e<Review_MealType>(7, 'mealType', $pb.PbFieldType.OE, defaultOrMaker: Review_MealType.MEAL_TYPE_UNDEFINED, valueOf: Review_MealType.valueOf, enumValues: Review_MealType.values)
    ..aOM<$1.LatLng>(8, 'location', subBuilder: $1.LatLng.create)
    ..aOS(9, 'dish')
    ..aOS(10, 'photo')
    ..pPS(11, 'tags')
    ..pPS(12, 'morePhotos')
    ..aOM<$1.DocumentReferenceProto>(13, 'instaPost', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<Awards>(14, 'awards', subBuilder: Awards.create)
    ..aOB(15, 'freezePlace')
    ..aOM<$0.Timestamp>(16, 'importedAt', subBuilder: $0.Timestamp.create)
    ..aOB(17, 'isInstagramPost')
    ..pc<$1.FirePhoto>(18, 'firePhotos', $pb.PbFieldType.PM, subBuilder: $1.FirePhoto.create)
    ..aOM<$1.Extras>(20, 'Extras', subBuilder: $1.Extras.create)
    ..aOB(21, 'blackOwned')
    ..pc<DiscoverItem_User>(22, 'likes', $pb.PbFieldType.PM, subBuilder: DiscoverItem_User.create)
    ..pc<DiscoverItem_User>(23, 'bookmarks', $pb.PbFieldType.PM, subBuilder: DiscoverItem_User.create)
    ..e<BlackCharity>(24, 'blackCharity', $pb.PbFieldType.OE, defaultOrMaker: BlackCharity.CHARITY_UNDEFINED, valueOf: BlackCharity.valueOf, enumValues: BlackCharity.values)
    ..a<$core.int>(25, 'score', $pb.PbFieldType.O3)
    ..pPS(26, 'categories')
    ..aOM<SpatialIndex>(27, 'spatialIndex', subBuilder: SpatialIndex.create)
    ..aOB(28, 'hidden')
    ..a<$core.int>(29, 'numInstaLikes', $pb.PbFieldType.O3)
    ..a<$core.int>(30, 'numInstaFollowers', $pb.PbFieldType.O3)
    ..aOB(31, 'showOnDiscoverFeed')
    ..hasRequiredFields = false
  ;

  DiscoverItem._() : super();
  factory DiscoverItem() => create();
  factory DiscoverItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiscoverItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DiscoverItem clone() => DiscoverItem()..mergeFromMessage(this);
  DiscoverItem copyWith(void Function(DiscoverItem) updates) => super.copyWith((message) => updates(message as DiscoverItem));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DiscoverItem create() => DiscoverItem._();
  DiscoverItem createEmptyInstance() => create();
  static $pb.PbList<DiscoverItem> createRepeated() => $pb.PbList<DiscoverItem>();
  @$core.pragma('dart2js:noInline')
  static DiscoverItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiscoverItem>(create);
  static DiscoverItem _defaultInstance;

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
  DiscoverItem_DiscoverRestaurant get restaurant => $_getN(1);
  @$pb.TagNumber(2)
  set restaurant(DiscoverItem_DiscoverRestaurant v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRestaurant() => $_has(1);
  @$pb.TagNumber(2)
  void clearRestaurant() => clearField(2);
  @$pb.TagNumber(2)
  DiscoverItem_DiscoverRestaurant ensureRestaurant() => $_ensure(1);

  @$pb.TagNumber(3)
  DiscoverItem_DiscoverReview get review => $_getN(2);
  @$pb.TagNumber(3)
  set review(DiscoverItem_DiscoverReview v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasReview() => $_has(2);
  @$pb.TagNumber(3)
  void clearReview() => clearField(3);
  @$pb.TagNumber(3)
  DiscoverItem_DiscoverReview ensureReview() => $_ensure(2);

  @$pb.TagNumber(4)
  DiscoverItem_User get user => $_getN(3);
  @$pb.TagNumber(4)
  set user(DiscoverItem_User v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => clearField(4);
  @$pb.TagNumber(4)
  DiscoverItem_User ensureUser() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.Timestamp get date => $_getN(4);
  @$pb.TagNumber(5)
  set date($0.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearDate() => clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureDate() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.List<DiscoverItem_Comment> get comments => $_getList(5);

  @$pb.TagNumber(7)
  Review_MealType get mealType => $_getN(6);
  @$pb.TagNumber(7)
  set mealType(Review_MealType v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasMealType() => $_has(6);
  @$pb.TagNumber(7)
  void clearMealType() => clearField(7);

  @$pb.TagNumber(8)
  $1.LatLng get location => $_getN(7);
  @$pb.TagNumber(8)
  set location($1.LatLng v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLocation() => $_has(7);
  @$pb.TagNumber(8)
  void clearLocation() => clearField(8);
  @$pb.TagNumber(8)
  $1.LatLng ensureLocation() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get dish => $_getSZ(8);
  @$pb.TagNumber(9)
  set dish($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDish() => $_has(8);
  @$pb.TagNumber(9)
  void clearDish() => clearField(9);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(10)
  $core.String get photo => $_getSZ(9);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(10)
  set photo($core.String v) { $_setString(9, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(10)
  $core.bool hasPhoto() => $_has(9);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(10)
  void clearPhoto() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<$core.String> get tags => $_getList(10);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(12)
  $core.List<$core.String> get morePhotos => $_getList(11);

  @$pb.TagNumber(13)
  $1.DocumentReferenceProto get instaPost => $_getN(12);
  @$pb.TagNumber(13)
  set instaPost($1.DocumentReferenceProto v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasInstaPost() => $_has(12);
  @$pb.TagNumber(13)
  void clearInstaPost() => clearField(13);
  @$pb.TagNumber(13)
  $1.DocumentReferenceProto ensureInstaPost() => $_ensure(12);

  @$pb.TagNumber(14)
  Awards get awards => $_getN(13);
  @$pb.TagNumber(14)
  set awards(Awards v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasAwards() => $_has(13);
  @$pb.TagNumber(14)
  void clearAwards() => clearField(14);
  @$pb.TagNumber(14)
  Awards ensureAwards() => $_ensure(13);

  @$pb.TagNumber(15)
  $core.bool get freezePlace => $_getBF(14);
  @$pb.TagNumber(15)
  set freezePlace($core.bool v) { $_setBool(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasFreezePlace() => $_has(14);
  @$pb.TagNumber(15)
  void clearFreezePlace() => clearField(15);

  @$pb.TagNumber(16)
  $0.Timestamp get importedAt => $_getN(15);
  @$pb.TagNumber(16)
  set importedAt($0.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasImportedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearImportedAt() => clearField(16);
  @$pb.TagNumber(16)
  $0.Timestamp ensureImportedAt() => $_ensure(15);

  @$pb.TagNumber(17)
  $core.bool get isInstagramPost => $_getBF(16);
  @$pb.TagNumber(17)
  set isInstagramPost($core.bool v) { $_setBool(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasIsInstagramPost() => $_has(16);
  @$pb.TagNumber(17)
  void clearIsInstagramPost() => clearField(17);

  @$pb.TagNumber(18)
  $core.List<$1.FirePhoto> get firePhotos => $_getList(17);

  @$pb.TagNumber(20)
  $1.Extras get extras => $_getN(18);
  @$pb.TagNumber(20)
  set extras($1.Extras v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasExtras() => $_has(18);
  @$pb.TagNumber(20)
  void clearExtras() => clearField(20);
  @$pb.TagNumber(20)
  $1.Extras ensureExtras() => $_ensure(18);

  @$pb.TagNumber(21)
  $core.bool get blackOwned => $_getBF(19);
  @$pb.TagNumber(21)
  set blackOwned($core.bool v) { $_setBool(19, v); }
  @$pb.TagNumber(21)
  $core.bool hasBlackOwned() => $_has(19);
  @$pb.TagNumber(21)
  void clearBlackOwned() => clearField(21);

  @$pb.TagNumber(22)
  $core.List<DiscoverItem_User> get likes => $_getList(20);

  @$pb.TagNumber(23)
  $core.List<DiscoverItem_User> get bookmarks => $_getList(21);

  @$pb.TagNumber(24)
  BlackCharity get blackCharity => $_getN(22);
  @$pb.TagNumber(24)
  set blackCharity(BlackCharity v) { setField(24, v); }
  @$pb.TagNumber(24)
  $core.bool hasBlackCharity() => $_has(22);
  @$pb.TagNumber(24)
  void clearBlackCharity() => clearField(24);

  @$pb.TagNumber(25)
  $core.int get score => $_getIZ(23);
  @$pb.TagNumber(25)
  set score($core.int v) { $_setSignedInt32(23, v); }
  @$pb.TagNumber(25)
  $core.bool hasScore() => $_has(23);
  @$pb.TagNumber(25)
  void clearScore() => clearField(25);

  @$pb.TagNumber(26)
  $core.List<$core.String> get categories => $_getList(24);

  @$pb.TagNumber(27)
  SpatialIndex get spatialIndex => $_getN(25);
  @$pb.TagNumber(27)
  set spatialIndex(SpatialIndex v) { setField(27, v); }
  @$pb.TagNumber(27)
  $core.bool hasSpatialIndex() => $_has(25);
  @$pb.TagNumber(27)
  void clearSpatialIndex() => clearField(27);
  @$pb.TagNumber(27)
  SpatialIndex ensureSpatialIndex() => $_ensure(25);

  @$pb.TagNumber(28)
  $core.bool get hidden => $_getBF(26);
  @$pb.TagNumber(28)
  set hidden($core.bool v) { $_setBool(26, v); }
  @$pb.TagNumber(28)
  $core.bool hasHidden() => $_has(26);
  @$pb.TagNumber(28)
  void clearHidden() => clearField(28);

  @$pb.TagNumber(29)
  $core.int get numInstaLikes => $_getIZ(27);
  @$pb.TagNumber(29)
  set numInstaLikes($core.int v) { $_setSignedInt32(27, v); }
  @$pb.TagNumber(29)
  $core.bool hasNumInstaLikes() => $_has(27);
  @$pb.TagNumber(29)
  void clearNumInstaLikes() => clearField(29);

  @$pb.TagNumber(30)
  $core.int get numInstaFollowers => $_getIZ(28);
  @$pb.TagNumber(30)
  set numInstaFollowers($core.int v) { $_setSignedInt32(28, v); }
  @$pb.TagNumber(30)
  $core.bool hasNumInstaFollowers() => $_has(28);
  @$pb.TagNumber(30)
  void clearNumInstaFollowers() => clearField(30);

  @$pb.TagNumber(31)
  $core.bool get showOnDiscoverFeed => $_getBF(29);
  @$pb.TagNumber(31)
  set showOnDiscoverFeed($core.bool v) { $_setBool(29, v); }
  @$pb.TagNumber(31)
  $core.bool hasShowOnDiscoverFeed() => $_has(29);
  @$pb.TagNumber(31)
  void clearShowOnDiscoverFeed() => clearField(31);
}

class City extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('City', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'city')
    ..aOS(2, 'state')
    ..aOS(3, 'country')
    ..a<$core.double>(4, 'popularityScore', $pb.PbFieldType.OD)
    ..aOM<$1.LatLng>(5, 'location', subBuilder: $1.LatLng.create)
    ..hasRequiredFields = false
  ;

  City._() : super();
  factory City() => create();
  factory City.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory City.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  City clone() => City()..mergeFromMessage(this);
  City copyWith(void Function(City) updates) => super.copyWith((message) => updates(message as City));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static City create() => City._();
  City createEmptyInstance() => create();
  static $pb.PbList<City> createRepeated() => $pb.PbList<City>();
  @$core.pragma('dart2js:noInline')
  static City getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<City>(create);
  static City _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get city => $_getSZ(0);
  @$pb.TagNumber(1)
  set city($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCity() => $_has(0);
  @$pb.TagNumber(1)
  void clearCity() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get state => $_getSZ(1);
  @$pb.TagNumber(2)
  set state($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get country => $_getSZ(2);
  @$pb.TagNumber(3)
  set country($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCountry() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountry() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get popularityScore => $_getN(3);
  @$pb.TagNumber(4)
  set popularityScore($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPopularityScore() => $_has(3);
  @$pb.TagNumber(4)
  void clearPopularityScore() => clearField(4);

  @$pb.TagNumber(5)
  $1.LatLng get location => $_getN(4);
  @$pb.TagNumber(5)
  set location($1.LatLng v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasLocation() => $_has(4);
  @$pb.TagNumber(5)
  void clearLocation() => clearField(5);
  @$pb.TagNumber(5)
  $1.LatLng ensureLocation() => $_ensure(4);
}

class Tag extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Tag', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'tag')
    ..a<$core.double>(2, 'trendingScore', $pb.PbFieldType.OD)
    ..aOM<$0.Timestamp>(3, 'lastUpdated', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Tag._() : super();
  factory Tag() => create();
  factory Tag.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Tag clone() => Tag()..mergeFromMessage(this);
  Tag copyWith(void Function(Tag) updates) => super.copyWith((message) => updates(message as Tag));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag create() => Tag._();
  Tag createEmptyInstance() => create();
  static $pb.PbList<Tag> createRepeated() => $pb.PbList<Tag>();
  @$core.pragma('dart2js:noInline')
  static Tag getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag>(create);
  static Tag _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tag => $_getSZ(0);
  @$pb.TagNumber(1)
  set tag($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTag() => $_has(0);
  @$pb.TagNumber(1)
  void clearTag() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get trendingScore => $_getN(1);
  @$pb.TagNumber(2)
  set trendingScore($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTrendingScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearTrendingScore() => clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get lastUpdated => $_getN(2);
  @$pb.TagNumber(3)
  set lastUpdated($0.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastUpdated() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastUpdated() => clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureLastUpdated() => $_ensure(2);
}

class Contest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Contest', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$0.Timestamp>(1, 'start', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(2, 'end', subBuilder: $0.Timestamp.create)
    ..aOS(3, 'description')
    ..e<Contest_ContestType>(4, 'contestType', $pb.PbFieldType.OE, defaultOrMaker: Contest_ContestType.contest_type_undefined, valueOf: Contest_ContestType.valueOf, enumValues: Contest_ContestType.values)
    ..hasRequiredFields = false
  ;

  Contest._() : super();
  factory Contest() => create();
  factory Contest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Contest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Contest clone() => Contest()..mergeFromMessage(this);
  Contest copyWith(void Function(Contest) updates) => super.copyWith((message) => updates(message as Contest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Contest create() => Contest._();
  Contest createEmptyInstance() => create();
  static $pb.PbList<Contest> createRepeated() => $pb.PbList<Contest>();
  @$core.pragma('dart2js:noInline')
  static Contest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Contest>(create);
  static Contest _defaultInstance;

  @$pb.TagNumber(1)
  $0.Timestamp get start => $_getN(0);
  @$pb.TagNumber(1)
  set start($0.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);
  @$pb.TagNumber(1)
  $0.Timestamp ensureStart() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.Timestamp get end => $_getN(1);
  @$pb.TagNumber(2)
  set end($0.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureEnd() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  Contest_ContestType get contestType => $_getN(3);
  @$pb.TagNumber(4)
  set contestType(Contest_ContestType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasContestType() => $_has(3);
  @$pb.TagNumber(4)
  void clearContestType() => clearField(4);
}

class DailyTastyVote extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DailyTastyVote', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..a<$core.double>(1, 'score', $pb.PbFieldType.OD)
    ..aOM<$1.DocumentReferenceProto>(2, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.DocumentReferenceProto>(3, 'post', subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$0.Timestamp>(4, 'date', subBuilder: $0.Timestamp.create)
    ..aOM<$1.Extras>(5, 'Extras', subBuilder: $1.Extras.create)
    ..hasRequiredFields = false
  ;

  DailyTastyVote._() : super();
  factory DailyTastyVote() => create();
  factory DailyTastyVote.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DailyTastyVote.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DailyTastyVote clone() => DailyTastyVote()..mergeFromMessage(this);
  DailyTastyVote copyWith(void Function(DailyTastyVote) updates) => super.copyWith((message) => updates(message as DailyTastyVote));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DailyTastyVote create() => DailyTastyVote._();
  DailyTastyVote createEmptyInstance() => create();
  static $pb.PbList<DailyTastyVote> createRepeated() => $pb.PbList<DailyTastyVote>();
  @$core.pragma('dart2js:noInline')
  static DailyTastyVote getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DailyTastyVote>(create);
  static DailyTastyVote _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get score => $_getN(0);
  @$pb.TagNumber(1)
  set score($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasScore() => $_has(0);
  @$pb.TagNumber(1)
  void clearScore() => clearField(1);

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
  $1.DocumentReferenceProto get post => $_getN(2);
  @$pb.TagNumber(3)
  set post($1.DocumentReferenceProto v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPost() => $_has(2);
  @$pb.TagNumber(3)
  void clearPost() => clearField(3);
  @$pb.TagNumber(3)
  $1.DocumentReferenceProto ensurePost() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.Timestamp get date => $_getN(3);
  @$pb.TagNumber(4)
  set date($0.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearDate() => clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureDate() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Extras get extras => $_getN(4);
  @$pb.TagNumber(5)
  set extras($1.Extras v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasExtras() => $_has(4);
  @$pb.TagNumber(5)
  void clearExtras() => clearField(5);
  @$pb.TagNumber(5)
  $1.Extras ensureExtras() => $_ensure(4);
}

class Awards extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Awards', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$0.Timestamp>(1, 'dailyTasty', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Awards._() : super();
  factory Awards() => create();
  factory Awards.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Awards.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Awards clone() => Awards()..mergeFromMessage(this);
  Awards copyWith(void Function(Awards) updates) => super.copyWith((message) => updates(message as Awards));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Awards create() => Awards._();
  Awards createEmptyInstance() => create();
  static $pb.PbList<Awards> createRepeated() => $pb.PbList<Awards>();
  @$core.pragma('dart2js:noInline')
  static Awards getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Awards>(create);
  static Awards _defaultInstance;

  @$pb.TagNumber(1)
  $0.Timestamp get dailyTasty => $_getN(0);
  @$pb.TagNumber(1)
  set dailyTasty($0.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDailyTasty() => $_has(0);
  @$pb.TagNumber(1)
  void clearDailyTasty() => clearField(1);
  @$pb.TagNumber(1)
  $0.Timestamp ensureDailyTasty() => $_ensure(0);
}

class Conversation_Message extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Conversation.Message', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(2, 'text')
    ..aOM<$0.Timestamp>(3, 'sentAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Conversation_Message._() : super();
  factory Conversation_Message() => create();
  factory Conversation_Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Conversation_Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Conversation_Message clone() => Conversation_Message()..mergeFromMessage(this);
  Conversation_Message copyWith(void Function(Conversation_Message) updates) => super.copyWith((message) => updates(message as Conversation_Message));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Conversation_Message create() => Conversation_Message._();
  Conversation_Message createEmptyInstance() => create();
  static $pb.PbList<Conversation_Message> createRepeated() => $pb.PbList<Conversation_Message>();
  @$core.pragma('dart2js:noInline')
  static Conversation_Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Conversation_Message>(create);
  static Conversation_Message _defaultInstance;

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
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get sentAt => $_getN(2);
  @$pb.TagNumber(3)
  set sentAt($0.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSentAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearSentAt() => clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureSentAt() => $_ensure(2);
}

class Conversation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Conversation', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..pc<$1.DocumentReferenceProto>(1, 'members', $pb.PbFieldType.PM, subBuilder: $1.DocumentReferenceProto.create)
    ..pc<Conversation_Message>(2, 'messages', $pb.PbFieldType.PM, subBuilder: Conversation_Message.create)
    ..pc<$1.DocumentReferenceProto>(4, 'seenBy', $pb.PbFieldType.PM, subBuilder: $1.DocumentReferenceProto.create)
    ..aOM<$1.Extras>(5, 'Extras', subBuilder: $1.Extras.create)
    ..m<$core.String, $0.Timestamp>(6, 'lastSeen', entryClassName: 'Conversation.LastSeenEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: $0.Timestamp.create, packageName: const $pb.PackageName('firestore'))
    ..hasRequiredFields = false
  ;

  Conversation._() : super();
  factory Conversation() => create();
  factory Conversation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Conversation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Conversation clone() => Conversation()..mergeFromMessage(this);
  Conversation copyWith(void Function(Conversation) updates) => super.copyWith((message) => updates(message as Conversation));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Conversation create() => Conversation._();
  Conversation createEmptyInstance() => create();
  static $pb.PbList<Conversation> createRepeated() => $pb.PbList<Conversation>();
  @$core.pragma('dart2js:noInline')
  static Conversation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Conversation>(create);
  static Conversation _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$1.DocumentReferenceProto> get members => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<Conversation_Message> get messages => $_getList(1);

  @$pb.TagNumber(4)
  $core.List<$1.DocumentReferenceProto> get seenBy => $_getList(2);

  @$pb.TagNumber(5)
  $1.Extras get extras => $_getN(3);
  @$pb.TagNumber(5)
  set extras($1.Extras v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasExtras() => $_has(3);
  @$pb.TagNumber(5)
  void clearExtras() => clearField(5);
  @$pb.TagNumber(5)
  $1.Extras ensureExtras() => $_ensure(3);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $0.Timestamp> get lastSeen => $_getMap(4);
}

class Movie extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Movie', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(2, 'movie')
    ..aOM<$0.Timestamp>(3, 'date', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Movie._() : super();
  factory Movie() => create();
  factory Movie.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Movie.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Movie clone() => Movie()..mergeFromMessage(this);
  Movie copyWith(void Function(Movie) updates) => super.copyWith((message) => updates(message as Movie));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Movie create() => Movie._();
  Movie createEmptyInstance() => create();
  static $pb.PbList<Movie> createRepeated() => $pb.PbList<Movie>();
  @$core.pragma('dart2js:noInline')
  static Movie getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Movie>(create);
  static Movie _defaultInstance;

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
  $core.String get movie => $_getSZ(1);
  @$pb.TagNumber(2)
  set movie($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMovie() => $_has(1);
  @$pb.TagNumber(2)
  void clearMovie() => clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get date => $_getN(2);
  @$pb.TagNumber(3)
  set date($0.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDate() => clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureDate() => $_ensure(2);
}

class InferenceResult_LocalizedObjectAnnotation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InferenceResult.LocalizedObjectAnnotation', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..aOS(2, 'locale')
    ..a<$core.double>(3, 'score', $pb.PbFieldType.OD)
    ..aOM<$1.Polygon>(5, 'boundingPoly', subBuilder: $1.Polygon.create)
    ..hasRequiredFields = false
  ;

  InferenceResult_LocalizedObjectAnnotation._() : super();
  factory InferenceResult_LocalizedObjectAnnotation() => create();
  factory InferenceResult_LocalizedObjectAnnotation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InferenceResult_LocalizedObjectAnnotation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InferenceResult_LocalizedObjectAnnotation clone() => InferenceResult_LocalizedObjectAnnotation()..mergeFromMessage(this);
  InferenceResult_LocalizedObjectAnnotation copyWith(void Function(InferenceResult_LocalizedObjectAnnotation) updates) => super.copyWith((message) => updates(message as InferenceResult_LocalizedObjectAnnotation));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InferenceResult_LocalizedObjectAnnotation create() => InferenceResult_LocalizedObjectAnnotation._();
  InferenceResult_LocalizedObjectAnnotation createEmptyInstance() => create();
  static $pb.PbList<InferenceResult_LocalizedObjectAnnotation> createRepeated() => $pb.PbList<InferenceResult_LocalizedObjectAnnotation>();
  @$core.pragma('dart2js:noInline')
  static InferenceResult_LocalizedObjectAnnotation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InferenceResult_LocalizedObjectAnnotation>(create);
  static InferenceResult_LocalizedObjectAnnotation _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get locale => $_getSZ(1);
  @$pb.TagNumber(2)
  set locale($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLocale() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocale() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get score => $_getN(2);
  @$pb.TagNumber(3)
  set score($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearScore() => clearField(3);

  @$pb.TagNumber(5)
  $1.Polygon get boundingPoly => $_getN(3);
  @$pb.TagNumber(5)
  set boundingPoly($1.Polygon v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasBoundingPoly() => $_has(3);
  @$pb.TagNumber(5)
  void clearBoundingPoly() => clearField(5);
  @$pb.TagNumber(5)
  $1.Polygon ensureBoundingPoly() => $_ensure(3);
}

class InferenceResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InferenceResult', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.Extras>(1, 'Extras', subBuilder: $1.Extras.create)
    ..aOM<$1.DocumentReferenceProto>(2, 'photoRef', subBuilder: $1.DocumentReferenceProto.create)
    ..pc<InferenceResult_LocalizedObjectAnnotation>(3, 'objects', $pb.PbFieldType.PM, subBuilder: InferenceResult_LocalizedObjectAnnotation.create)
    ..hasRequiredFields = false
  ;

  InferenceResult._() : super();
  factory InferenceResult() => create();
  factory InferenceResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InferenceResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InferenceResult clone() => InferenceResult()..mergeFromMessage(this);
  InferenceResult copyWith(void Function(InferenceResult) updates) => super.copyWith((message) => updates(message as InferenceResult));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InferenceResult create() => InferenceResult._();
  InferenceResult createEmptyInstance() => create();
  static $pb.PbList<InferenceResult> createRepeated() => $pb.PbList<InferenceResult>();
  @$core.pragma('dart2js:noInline')
  static InferenceResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InferenceResult>(create);
  static InferenceResult _defaultInstance;

  @$pb.TagNumber(1)
  $1.Extras get extras => $_getN(0);
  @$pb.TagNumber(1)
  set extras($1.Extras v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasExtras() => $_has(0);
  @$pb.TagNumber(1)
  void clearExtras() => clearField(1);
  @$pb.TagNumber(1)
  $1.Extras ensureExtras() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.DocumentReferenceProto get photoRef => $_getN(1);
  @$pb.TagNumber(2)
  set photoRef($1.DocumentReferenceProto v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPhotoRef() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhotoRef() => clearField(2);
  @$pb.TagNumber(2)
  $1.DocumentReferenceProto ensurePhotoRef() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<InferenceResult_LocalizedObjectAnnotation> get objects => $_getList(2);
}

class InstagramToken extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InstagramToken', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(2, 'code')
    ..aOS(3, 'token')
    ..aOM<$0.Timestamp>(4, 'timeAcquired', subBuilder: $0.Timestamp.create)
    ..a<$core.int>(5, 'expiresIn', $pb.PbFieldType.O3)
    ..aOS(6, 'username')
    ..aOS(7, 'userId')
    ..e<InstagramToken_ImportStatus>(8, 'importStatus', $pb.PbFieldType.OE, defaultOrMaker: InstagramToken_ImportStatus.import_status_undefined, valueOf: InstagramToken_ImportStatus.valueOf, enumValues: InstagramToken_ImportStatus.values)
    ..aOM<$0.Timestamp>(9, 'lastUpdate', subBuilder: $0.Timestamp.create)
    ..e<InstagramToken_TokenStatus>(10, 'tokenStatus', $pb.PbFieldType.OE, defaultOrMaker: InstagramToken_TokenStatus.token_status_undefined, valueOf: InstagramToken_TokenStatus.valueOf, enumValues: InstagramToken_TokenStatus.values)
    ..hasRequiredFields = false
  ;

  InstagramToken._() : super();
  factory InstagramToken() => create();
  factory InstagramToken.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstagramToken.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InstagramToken clone() => InstagramToken()..mergeFromMessage(this);
  InstagramToken copyWith(void Function(InstagramToken) updates) => super.copyWith((message) => updates(message as InstagramToken));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InstagramToken create() => InstagramToken._();
  InstagramToken createEmptyInstance() => create();
  static $pb.PbList<InstagramToken> createRepeated() => $pb.PbList<InstagramToken>();
  @$core.pragma('dart2js:noInline')
  static InstagramToken getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstagramToken>(create);
  static InstagramToken _defaultInstance;

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
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get token => $_getSZ(2);
  @$pb.TagNumber(3)
  set token($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearToken() => clearField(3);

  @$pb.TagNumber(4)
  $0.Timestamp get timeAcquired => $_getN(3);
  @$pb.TagNumber(4)
  set timeAcquired($0.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimeAcquired() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimeAcquired() => clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureTimeAcquired() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.int get expiresIn => $_getIZ(4);
  @$pb.TagNumber(5)
  set expiresIn($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpiresIn() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiresIn() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get username => $_getSZ(5);
  @$pb.TagNumber(6)
  set username($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUsername() => $_has(5);
  @$pb.TagNumber(6)
  void clearUsername() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get userId => $_getSZ(6);
  @$pb.TagNumber(7)
  set userId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUserId() => $_has(6);
  @$pb.TagNumber(7)
  void clearUserId() => clearField(7);

  @$pb.TagNumber(8)
  InstagramToken_ImportStatus get importStatus => $_getN(7);
  @$pb.TagNumber(8)
  set importStatus(InstagramToken_ImportStatus v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasImportStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearImportStatus() => clearField(8);

  @$pb.TagNumber(9)
  $0.Timestamp get lastUpdate => $_getN(8);
  @$pb.TagNumber(9)
  set lastUpdate($0.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasLastUpdate() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastUpdate() => clearField(9);
  @$pb.TagNumber(9)
  $0.Timestamp ensureLastUpdate() => $_ensure(8);

  @$pb.TagNumber(10)
  InstagramToken_TokenStatus get tokenStatus => $_getN(9);
  @$pb.TagNumber(10)
  set tokenStatus(InstagramToken_TokenStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasTokenStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearTokenStatus() => clearField(10);
}

class TasteBudGroup_TasteBud extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('TasteBudGroup.TasteBud', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'bud', subBuilder: $1.DocumentReferenceProto.create)
    ..a<$core.double>(2, 'score', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  TasteBudGroup_TasteBud._() : super();
  factory TasteBudGroup_TasteBud() => create();
  factory TasteBudGroup_TasteBud.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TasteBudGroup_TasteBud.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  TasteBudGroup_TasteBud clone() => TasteBudGroup_TasteBud()..mergeFromMessage(this);
  TasteBudGroup_TasteBud copyWith(void Function(TasteBudGroup_TasteBud) updates) => super.copyWith((message) => updates(message as TasteBudGroup_TasteBud));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TasteBudGroup_TasteBud create() => TasteBudGroup_TasteBud._();
  TasteBudGroup_TasteBud createEmptyInstance() => create();
  static $pb.PbList<TasteBudGroup_TasteBud> createRepeated() => $pb.PbList<TasteBudGroup_TasteBud>();
  @$core.pragma('dart2js:noInline')
  static TasteBudGroup_TasteBud getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TasteBudGroup_TasteBud>(create);
  static TasteBudGroup_TasteBud _defaultInstance;

  @$pb.TagNumber(1)
  $1.DocumentReferenceProto get bud => $_getN(0);
  @$pb.TagNumber(1)
  set bud($1.DocumentReferenceProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBud() => $_has(0);
  @$pb.TagNumber(1)
  void clearBud() => clearField(1);
  @$pb.TagNumber(1)
  $1.DocumentReferenceProto ensureBud() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get score => $_getN(1);
  @$pb.TagNumber(2)
  set score($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearScore() => clearField(2);
}

class TasteBudGroup extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('TasteBudGroup', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..pc<TasteBudGroup_TasteBud>(2, 'tasteBuds', $pb.PbFieldType.PM, subBuilder: TasteBudGroup_TasteBud.create)
    ..hasRequiredFields = false
  ;

  TasteBudGroup._() : super();
  factory TasteBudGroup() => create();
  factory TasteBudGroup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TasteBudGroup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  TasteBudGroup clone() => TasteBudGroup()..mergeFromMessage(this);
  TasteBudGroup copyWith(void Function(TasteBudGroup) updates) => super.copyWith((message) => updates(message as TasteBudGroup));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TasteBudGroup create() => TasteBudGroup._();
  TasteBudGroup createEmptyInstance() => create();
  static $pb.PbList<TasteBudGroup> createRepeated() => $pb.PbList<TasteBudGroup>();
  @$core.pragma('dart2js:noInline')
  static TasteBudGroup getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TasteBudGroup>(create);
  static TasteBudGroup _defaultInstance;

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
  $core.List<TasteBudGroup_TasteBud> get tasteBuds => $_getList(1);
}

class PrivateUserDocument extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PrivateUserDocument', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..pPS(1, 'fcmTokens')
    ..aOS(2, 'timezone')
    ..aOS(3, 'email')
    ..hasRequiredFields = false
  ;

  PrivateUserDocument._() : super();
  factory PrivateUserDocument() => create();
  factory PrivateUserDocument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PrivateUserDocument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PrivateUserDocument clone() => PrivateUserDocument()..mergeFromMessage(this);
  PrivateUserDocument copyWith(void Function(PrivateUserDocument) updates) => super.copyWith((message) => updates(message as PrivateUserDocument));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PrivateUserDocument create() => PrivateUserDocument._();
  PrivateUserDocument createEmptyInstance() => create();
  static $pb.PbList<PrivateUserDocument> createRepeated() => $pb.PbList<PrivateUserDocument>();
  @$core.pragma('dart2js:noInline')
  static PrivateUserDocument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PrivateUserDocument>(create);
  static PrivateUserDocument _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get fcmTokens => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get timezone => $_getSZ(1);
  @$pb.TagNumber(2)
  set timezone($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimezone() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimezone() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);
}

class MailchimpUserSetting extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MailchimpUserSetting', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'user', subBuilder: $1.DocumentReferenceProto.create)
    ..pPS(2, 'tags')
    ..hasRequiredFields = false
  ;

  MailchimpUserSetting._() : super();
  factory MailchimpUserSetting() => create();
  factory MailchimpUserSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MailchimpUserSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MailchimpUserSetting clone() => MailchimpUserSetting()..mergeFromMessage(this);
  MailchimpUserSetting copyWith(void Function(MailchimpUserSetting) updates) => super.copyWith((message) => updates(message as MailchimpUserSetting));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MailchimpUserSetting create() => MailchimpUserSetting._();
  MailchimpUserSetting createEmptyInstance() => create();
  static $pb.PbList<MailchimpUserSetting> createRepeated() => $pb.PbList<MailchimpUserSetting>();
  @$core.pragma('dart2js:noInline')
  static MailchimpUserSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MailchimpUserSetting>(create);
  static MailchimpUserSetting _defaultInstance;

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
  $core.List<$core.String> get tags => $_getList(1);
}

class UserPostsStartingLocation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserPostsStartingLocation', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..aOM<$1.LatLng>(2, 'location', subBuilder: $1.LatLng.create)
    ..hasRequiredFields = false
  ;

  UserPostsStartingLocation._() : super();
  factory UserPostsStartingLocation() => create();
  factory UserPostsStartingLocation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserPostsStartingLocation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserPostsStartingLocation clone() => UserPostsStartingLocation()..mergeFromMessage(this);
  UserPostsStartingLocation copyWith(void Function(UserPostsStartingLocation) updates) => super.copyWith((message) => updates(message as UserPostsStartingLocation));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserPostsStartingLocation create() => UserPostsStartingLocation._();
  UserPostsStartingLocation createEmptyInstance() => create();
  static $pb.PbList<UserPostsStartingLocation> createRepeated() => $pb.PbList<UserPostsStartingLocation>();
  @$core.pragma('dart2js:noInline')
  static UserPostsStartingLocation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserPostsStartingLocation>(create);
  static UserPostsStartingLocation _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  $1.LatLng get location => $_getN(1);
  @$pb.TagNumber(2)
  set location($1.LatLng v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLocation() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocation() => clearField(2);
  @$pb.TagNumber(2)
  $1.LatLng ensureLocation() => $_ensure(1);
}

class GooglePlaces extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GooglePlaces', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'address')
    ..aOM<$0.Timestamp>(2, 'lastExecute', subBuilder: $0.Timestamp.create)
    ..aOS(3, 'name')
    ..aOS(4, 'phoneNumber')
    ..a<$core.int>(5, 'numReviews', $pb.PbFieldType.O3)
    ..a<$core.int>(6, 'scrapedReviews', $pb.PbFieldType.O3)
    ..aOB(7, 'matchFound')
    ..aOS(8, 'url')
    ..aOS(9, 'website')
    ..hasRequiredFields = false
  ;

  GooglePlaces._() : super();
  factory GooglePlaces() => create();
  factory GooglePlaces.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GooglePlaces.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GooglePlaces clone() => GooglePlaces()..mergeFromMessage(this);
  GooglePlaces copyWith(void Function(GooglePlaces) updates) => super.copyWith((message) => updates(message as GooglePlaces));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GooglePlaces create() => GooglePlaces._();
  GooglePlaces createEmptyInstance() => create();
  static $pb.PbList<GooglePlaces> createRepeated() => $pb.PbList<GooglePlaces>();
  @$core.pragma('dart2js:noInline')
  static GooglePlaces getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GooglePlaces>(create);
  static GooglePlaces _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);

  @$pb.TagNumber(2)
  $0.Timestamp get lastExecute => $_getN(1);
  @$pb.TagNumber(2)
  set lastExecute($0.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastExecute() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastExecute() => clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureLastExecute() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get phoneNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set phoneNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhoneNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhoneNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get numReviews => $_getIZ(4);
  @$pb.TagNumber(5)
  set numReviews($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNumReviews() => $_has(4);
  @$pb.TagNumber(5)
  void clearNumReviews() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get scrapedReviews => $_getIZ(5);
  @$pb.TagNumber(6)
  set scrapedReviews($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasScrapedReviews() => $_has(5);
  @$pb.TagNumber(6)
  void clearScrapedReviews() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get matchFound => $_getBF(6);
  @$pb.TagNumber(7)
  set matchFound($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMatchFound() => $_has(6);
  @$pb.TagNumber(7)
  void clearMatchFound() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get url => $_getSZ(7);
  @$pb.TagNumber(8)
  set url($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearUrl() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get website => $_getSZ(8);
  @$pb.TagNumber(9)
  set website($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasWebsite() => $_has(8);
  @$pb.TagNumber(9)
  void clearWebsite() => clearField(9);
}

class YelpPlaces extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('YelpPlaces', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOS(1, 'placeId')
    ..aOS(2, 'address')
    ..aOM<$1.LatLng>(3, 'center', subBuilder: $1.LatLng.create)
    ..aOB(4, 'hasCenter')
    ..aOM<$0.Timestamp>(5, 'lastExecute', subBuilder: $0.Timestamp.create)
    ..aOS(6, 'name')
    ..aOS(7, 'phoneNumber')
    ..a<$core.int>(8, 'numReviews', $pb.PbFieldType.O3)
    ..a<$core.int>(9, 'scrapedReviews', $pb.PbFieldType.O3)
    ..aOB(10, 'success')
    ..aOS(11, 'url')
    ..aOS(12, 'website')
    ..hasRequiredFields = false
  ;

  YelpPlaces._() : super();
  factory YelpPlaces() => create();
  factory YelpPlaces.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory YelpPlaces.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  YelpPlaces clone() => YelpPlaces()..mergeFromMessage(this);
  YelpPlaces copyWith(void Function(YelpPlaces) updates) => super.copyWith((message) => updates(message as YelpPlaces));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static YelpPlaces create() => YelpPlaces._();
  YelpPlaces createEmptyInstance() => create();
  static $pb.PbList<YelpPlaces> createRepeated() => $pb.PbList<YelpPlaces>();
  @$core.pragma('dart2js:noInline')
  static YelpPlaces getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<YelpPlaces>(create);
  static YelpPlaces _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get placeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set placeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlaceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlaceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get address => $_getSZ(1);
  @$pb.TagNumber(2)
  set address($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => clearField(2);

  @$pb.TagNumber(3)
  $1.LatLng get center => $_getN(2);
  @$pb.TagNumber(3)
  set center($1.LatLng v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCenter() => $_has(2);
  @$pb.TagNumber(3)
  void clearCenter() => clearField(3);
  @$pb.TagNumber(3)
  $1.LatLng ensureCenter() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get hasCenter_4 => $_getBF(3);
  @$pb.TagNumber(4)
  set hasCenter_4($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHasCenter_4() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasCenter_4() => clearField(4);

  @$pb.TagNumber(5)
  $0.Timestamp get lastExecute => $_getN(4);
  @$pb.TagNumber(5)
  set lastExecute($0.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastExecute() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastExecute() => clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureLastExecute() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get name => $_getSZ(5);
  @$pb.TagNumber(6)
  set name($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasName() => $_has(5);
  @$pb.TagNumber(6)
  void clearName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get phoneNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set phoneNumber($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPhoneNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoneNumber() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get numReviews => $_getIZ(7);
  @$pb.TagNumber(8)
  set numReviews($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasNumReviews() => $_has(7);
  @$pb.TagNumber(8)
  void clearNumReviews() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get scrapedReviews => $_getIZ(8);
  @$pb.TagNumber(9)
  set scrapedReviews($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasScrapedReviews() => $_has(8);
  @$pb.TagNumber(9)
  void clearScrapedReviews() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get success => $_getBF(9);
  @$pb.TagNumber(10)
  set success($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSuccess() => $_has(9);
  @$pb.TagNumber(10)
  void clearSuccess() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get url => $_getSZ(10);
  @$pb.TagNumber(11)
  set url($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasUrl() => $_has(10);
  @$pb.TagNumber(11)
  void clearUrl() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get website => $_getSZ(11);
  @$pb.TagNumber(12)
  set website($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasWebsite() => $_has(11);
  @$pb.TagNumber(12)
  void clearWebsite() => clearField(12);
}

class GoogleReviews extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GoogleReviews', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'place', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(2, 'text')
    ..pPS(3, 'photoUrls')
    ..aOB(4, 'photosSaved')
    ..aOM<$0.Timestamp>(5, 'approximateTimestamp', subBuilder: $0.Timestamp.create)
    ..a<$core.int>(6, 'rating', $pb.PbFieldType.O3)
    ..a<$core.double>(7, 'random', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GoogleReviews._() : super();
  factory GoogleReviews() => create();
  factory GoogleReviews.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GoogleReviews.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GoogleReviews clone() => GoogleReviews()..mergeFromMessage(this);
  GoogleReviews copyWith(void Function(GoogleReviews) updates) => super.copyWith((message) => updates(message as GoogleReviews));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GoogleReviews create() => GoogleReviews._();
  GoogleReviews createEmptyInstance() => create();
  static $pb.PbList<GoogleReviews> createRepeated() => $pb.PbList<GoogleReviews>();
  @$core.pragma('dart2js:noInline')
  static GoogleReviews getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GoogleReviews>(create);
  static GoogleReviews _defaultInstance;

  @$pb.TagNumber(1)
  $1.DocumentReferenceProto get place => $_getN(0);
  @$pb.TagNumber(1)
  set place($1.DocumentReferenceProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlace() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlace() => clearField(1);
  @$pb.TagNumber(1)
  $1.DocumentReferenceProto ensurePlace() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get photoUrls => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get photosSaved => $_getBF(3);
  @$pb.TagNumber(4)
  set photosSaved($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhotosSaved() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhotosSaved() => clearField(4);

  @$pb.TagNumber(5)
  $0.Timestamp get approximateTimestamp => $_getN(4);
  @$pb.TagNumber(5)
  set approximateTimestamp($0.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasApproximateTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearApproximateTimestamp() => clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureApproximateTimestamp() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.int get rating => $_getIZ(5);
  @$pb.TagNumber(6)
  set rating($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRating() => $_has(5);
  @$pb.TagNumber(6)
  void clearRating() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get random => $_getN(6);
  @$pb.TagNumber(7)
  set random($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRandom() => $_has(6);
  @$pb.TagNumber(7)
  void clearRandom() => clearField(7);
}

class YelpReviews extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('YelpReviews', package: const $pb.PackageName('firestore'), createEmptyInstance: create)
    ..aOM<$1.DocumentReferenceProto>(1, 'place', subBuilder: $1.DocumentReferenceProto.create)
    ..aOS(2, 'text')
    ..pPS(3, 'photoUrls')
    ..aOB(4, 'photosSaved')
    ..aOS(5, 'date')
    ..a<$core.int>(6, 'rating', $pb.PbFieldType.O3)
    ..a<$core.double>(7, 'random', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  YelpReviews._() : super();
  factory YelpReviews() => create();
  factory YelpReviews.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory YelpReviews.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  YelpReviews clone() => YelpReviews()..mergeFromMessage(this);
  YelpReviews copyWith(void Function(YelpReviews) updates) => super.copyWith((message) => updates(message as YelpReviews));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static YelpReviews create() => YelpReviews._();
  YelpReviews createEmptyInstance() => create();
  static $pb.PbList<YelpReviews> createRepeated() => $pb.PbList<YelpReviews>();
  @$core.pragma('dart2js:noInline')
  static YelpReviews getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<YelpReviews>(create);
  static YelpReviews _defaultInstance;

  @$pb.TagNumber(1)
  $1.DocumentReferenceProto get place => $_getN(0);
  @$pb.TagNumber(1)
  set place($1.DocumentReferenceProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlace() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlace() => clearField(1);
  @$pb.TagNumber(1)
  $1.DocumentReferenceProto ensurePlace() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get photoUrls => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get photosSaved => $_getBF(3);
  @$pb.TagNumber(4)
  set photosSaved($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhotosSaved() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhotosSaved() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get date => $_getSZ(4);
  @$pb.TagNumber(5)
  set date($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearDate() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get rating => $_getIZ(5);
  @$pb.TagNumber(6)
  set rating($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRating() => $_has(5);
  @$pb.TagNumber(6)
  void clearRating() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get random => $_getN(6);
  @$pb.TagNumber(7)
  set random($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRandom() => $_has(6);
  @$pb.TagNumber(7)
  void clearRandom() => clearField(7);
}

