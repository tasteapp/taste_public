///
//  Generated code. Do not modify.
//  source: notifications.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'firestore.pbenum.dart' as $5;
import 'notifications.pbenum.dart';

export 'notifications.pbenum.dart';

class FcmExtras extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FcmExtras', package: const $pb.PackageName('notifications'), createEmptyInstance: create)
    ..e<$5.NotificationType>(1, 'notificationType', $pb.PbFieldType.OE, defaultOrMaker: $5.NotificationType.UNDEFINED, valueOf: $5.NotificationType.valueOf, enumValues: $5.NotificationType.values)
    ..aOS(2, 'notificationPath')
    ..aOS(3, 'documentLink')
    ..aOS(4, 'user')
    ..hasRequiredFields = false
  ;

  FcmExtras._() : super();
  factory FcmExtras() => create();
  factory FcmExtras.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FcmExtras.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FcmExtras clone() => FcmExtras()..mergeFromMessage(this);
  FcmExtras copyWith(void Function(FcmExtras) updates) => super.copyWith((message) => updates(message as FcmExtras));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FcmExtras create() => FcmExtras._();
  FcmExtras createEmptyInstance() => create();
  static $pb.PbList<FcmExtras> createRepeated() => $pb.PbList<FcmExtras>();
  @$core.pragma('dart2js:noInline')
  static FcmExtras getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FcmExtras>(create);
  static FcmExtras _defaultInstance;

  @$pb.TagNumber(1)
  $5.NotificationType get notificationType => $_getN(0);
  @$pb.TagNumber(1)
  set notificationType($5.NotificationType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasNotificationType() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotificationType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get notificationPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set notificationPath($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNotificationPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearNotificationPath() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentLink => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentLink($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocumentLink() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentLink() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get user => $_getSZ(3);
  @$pb.TagNumber(4)
  set user($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => clearField(4);
}

class FcmMessage_Notification extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FcmMessage.Notification', package: const $pb.PackageName('notifications'), createEmptyInstance: create)
    ..aOS(1, 'body')
    ..aOS(2, 'title')
    ..hasRequiredFields = false
  ;

  FcmMessage_Notification._() : super();
  factory FcmMessage_Notification() => create();
  factory FcmMessage_Notification.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FcmMessage_Notification.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FcmMessage_Notification clone() => FcmMessage_Notification()..mergeFromMessage(this);
  FcmMessage_Notification copyWith(void Function(FcmMessage_Notification) updates) => super.copyWith((message) => updates(message as FcmMessage_Notification));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FcmMessage_Notification create() => FcmMessage_Notification._();
  FcmMessage_Notification createEmptyInstance() => create();
  static $pb.PbList<FcmMessage_Notification> createRepeated() => $pb.PbList<FcmMessage_Notification>();
  @$core.pragma('dart2js:noInline')
  static FcmMessage_Notification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FcmMessage_Notification>(create);
  static FcmMessage_Notification _defaultInstance;

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
}

class FcmMessage_Data extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FcmMessage.Data', package: const $pb.PackageName('notifications'), createEmptyInstance: create)
    ..aOS(1, 'extras')
    ..e<ClickAction>(2, 'clickAction', $pb.PbFieldType.OE, defaultOrMaker: ClickAction.FLUTTER_NOTIFICATION_CLICK, valueOf: ClickAction.valueOf, enumValues: ClickAction.values)
    ..hasRequiredFields = false
  ;

  FcmMessage_Data._() : super();
  factory FcmMessage_Data() => create();
  factory FcmMessage_Data.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FcmMessage_Data.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FcmMessage_Data clone() => FcmMessage_Data()..mergeFromMessage(this);
  FcmMessage_Data copyWith(void Function(FcmMessage_Data) updates) => super.copyWith((message) => updates(message as FcmMessage_Data));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FcmMessage_Data create() => FcmMessage_Data._();
  FcmMessage_Data createEmptyInstance() => create();
  static $pb.PbList<FcmMessage_Data> createRepeated() => $pb.PbList<FcmMessage_Data>();
  @$core.pragma('dart2js:noInline')
  static FcmMessage_Data getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FcmMessage_Data>(create);
  static FcmMessage_Data _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get extras => $_getSZ(0);
  @$pb.TagNumber(1)
  set extras($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasExtras() => $_has(0);
  @$pb.TagNumber(1)
  void clearExtras() => clearField(1);

  @$pb.TagNumber(2)
  ClickAction get clickAction => $_getN(1);
  @$pb.TagNumber(2)
  set clickAction(ClickAction v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasClickAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearClickAction() => clearField(2);
}

class FcmMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FcmMessage', package: const $pb.PackageName('notifications'), createEmptyInstance: create)
    ..aOM<FcmMessage_Notification>(1, 'notification', subBuilder: FcmMessage_Notification.create)
    ..aOM<FcmMessage_Data>(2, 'data', subBuilder: FcmMessage_Data.create)
    ..hasRequiredFields = false
  ;

  FcmMessage._() : super();
  factory FcmMessage() => create();
  factory FcmMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FcmMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FcmMessage clone() => FcmMessage()..mergeFromMessage(this);
  FcmMessage copyWith(void Function(FcmMessage) updates) => super.copyWith((message) => updates(message as FcmMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FcmMessage create() => FcmMessage._();
  FcmMessage createEmptyInstance() => create();
  static $pb.PbList<FcmMessage> createRepeated() => $pb.PbList<FcmMessage>();
  @$core.pragma('dart2js:noInline')
  static FcmMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FcmMessage>(create);
  static FcmMessage _defaultInstance;

  @$pb.TagNumber(1)
  FcmMessage_Notification get notification => $_getN(0);
  @$pb.TagNumber(1)
  set notification(FcmMessage_Notification v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasNotification() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotification() => clearField(1);
  @$pb.TagNumber(1)
  FcmMessage_Notification ensureNotification() => $_ensure(0);

  @$pb.TagNumber(2)
  FcmMessage_Data get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(FcmMessage_Data v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);
  @$pb.TagNumber(2)
  FcmMessage_Data ensureData() => $_ensure(1);
}

