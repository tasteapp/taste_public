///
//  Generated code. Do not modify.
//  source: cloud_functions.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GenerateAuthTokenRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GenerateAuthTokenRequest', package: const $pb.PackageName('cloud_functions'), createEmptyInstance: create)
    ..aOS(1, 'uid')
    ..aOS(2, 'fullName')
    ..aOS(3, 'email')
    ..hasRequiredFields = false
  ;

  GenerateAuthTokenRequest._() : super();
  factory GenerateAuthTokenRequest() => create();
  factory GenerateAuthTokenRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateAuthTokenRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GenerateAuthTokenRequest clone() => GenerateAuthTokenRequest()..mergeFromMessage(this);
  GenerateAuthTokenRequest copyWith(void Function(GenerateAuthTokenRequest) updates) => super.copyWith((message) => updates(message as GenerateAuthTokenRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateAuthTokenRequest create() => GenerateAuthTokenRequest._();
  GenerateAuthTokenRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateAuthTokenRequest> createRepeated() => $pb.PbList<GenerateAuthTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateAuthTokenRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateAuthTokenRequest>(create);
  static GenerateAuthTokenRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fullName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fullName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFullName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFullName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);
}

class GenerateAuthTokenResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GenerateAuthTokenResponse', package: const $pb.PackageName('cloud_functions'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GenerateAuthTokenResponse._() : super();
  factory GenerateAuthTokenResponse() => create();
  factory GenerateAuthTokenResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateAuthTokenResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GenerateAuthTokenResponse clone() => GenerateAuthTokenResponse()..mergeFromMessage(this);
  GenerateAuthTokenResponse copyWith(void Function(GenerateAuthTokenResponse) updates) => super.copyWith((message) => updates(message as GenerateAuthTokenResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenerateAuthTokenResponse create() => GenerateAuthTokenResponse._();
  GenerateAuthTokenResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateAuthTokenResponse> createRepeated() => $pb.PbList<GenerateAuthTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateAuthTokenResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateAuthTokenResponse>(create);
  static GenerateAuthTokenResponse _defaultInstance;
}

class ResolveReportRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ResolveReportRequest', package: const $pb.PackageName('cloud_functions'), createEmptyInstance: create)
    ..aOS(1, 'report')
    ..aOS(2, 'text')
    ..aOB(3, 'sendUserNotification')
    ..hasRequiredFields = false
  ;

  ResolveReportRequest._() : super();
  factory ResolveReportRequest() => create();
  factory ResolveReportRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveReportRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ResolveReportRequest clone() => ResolveReportRequest()..mergeFromMessage(this);
  ResolveReportRequest copyWith(void Function(ResolveReportRequest) updates) => super.copyWith((message) => updates(message as ResolveReportRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResolveReportRequest create() => ResolveReportRequest._();
  ResolveReportRequest createEmptyInstance() => create();
  static $pb.PbList<ResolveReportRequest> createRepeated() => $pb.PbList<ResolveReportRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolveReportRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveReportRequest>(create);
  static ResolveReportRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get report => $_getSZ(0);
  @$pb.TagNumber(1)
  set report($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReport() => $_has(0);
  @$pb.TagNumber(1)
  void clearReport() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get sendUserNotification => $_getBF(2);
  @$pb.TagNumber(3)
  set sendUserNotification($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSendUserNotification() => $_has(2);
  @$pb.TagNumber(3)
  void clearSendUserNotification() => clearField(3);
}

class ResolveReportResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ResolveReportResponse', package: const $pb.PackageName('cloud_functions'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ResolveReportResponse._() : super();
  factory ResolveReportResponse() => create();
  factory ResolveReportResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveReportResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ResolveReportResponse clone() => ResolveReportResponse()..mergeFromMessage(this);
  ResolveReportResponse copyWith(void Function(ResolveReportResponse) updates) => super.copyWith((message) => updates(message as ResolveReportResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResolveReportResponse create() => ResolveReportResponse._();
  ResolveReportResponse createEmptyInstance() => create();
  static $pb.PbList<ResolveReportResponse> createRepeated() => $pb.PbList<ResolveReportResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolveReportResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveReportResponse>(create);
  static ResolveReportResponse _defaultInstance;
}

class GetIsFoodStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetIsFoodStatusRequest', package: const $pb.PackageName('cloud_functions'), createEmptyInstance: create)
    ..pPS(1, 'urls')
    ..hasRequiredFields = false
  ;

  GetIsFoodStatusRequest._() : super();
  factory GetIsFoodStatusRequest() => create();
  factory GetIsFoodStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIsFoodStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetIsFoodStatusRequest clone() => GetIsFoodStatusRequest()..mergeFromMessage(this);
  GetIsFoodStatusRequest copyWith(void Function(GetIsFoodStatusRequest) updates) => super.copyWith((message) => updates(message as GetIsFoodStatusRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetIsFoodStatusRequest create() => GetIsFoodStatusRequest._();
  GetIsFoodStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetIsFoodStatusRequest> createRepeated() => $pb.PbList<GetIsFoodStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIsFoodStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIsFoodStatusRequest>(create);
  static GetIsFoodStatusRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get urls => $_getList(0);
}

class GetIsFoodStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetIsFoodStatusResponse', package: const $pb.PackageName('cloud_functions'), createEmptyInstance: create)
    ..a<$core.double>(1, 'fractionFood', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetIsFoodStatusResponse._() : super();
  factory GetIsFoodStatusResponse() => create();
  factory GetIsFoodStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIsFoodStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetIsFoodStatusResponse clone() => GetIsFoodStatusResponse()..mergeFromMessage(this);
  GetIsFoodStatusResponse copyWith(void Function(GetIsFoodStatusResponse) updates) => super.copyWith((message) => updates(message as GetIsFoodStatusResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetIsFoodStatusResponse create() => GetIsFoodStatusResponse._();
  GetIsFoodStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetIsFoodStatusResponse> createRepeated() => $pb.PbList<GetIsFoodStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIsFoodStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIsFoodStatusResponse>(create);
  static GetIsFoodStatusResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get fractionFood => $_getN(0);
  @$pb.TagNumber(1)
  set fractionFood($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFractionFood() => $_has(0);
  @$pb.TagNumber(1)
  void clearFractionFood() => clearField(1);
}

class QueueInstagramUsernameRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('QueueInstagramUsernameRequest', package: const $pb.PackageName('cloud_functions'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..hasRequiredFields = false
  ;

  QueueInstagramUsernameRequest._() : super();
  factory QueueInstagramUsernameRequest() => create();
  factory QueueInstagramUsernameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueueInstagramUsernameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  QueueInstagramUsernameRequest clone() => QueueInstagramUsernameRequest()..mergeFromMessage(this);
  QueueInstagramUsernameRequest copyWith(void Function(QueueInstagramUsernameRequest) updates) => super.copyWith((message) => updates(message as QueueInstagramUsernameRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QueueInstagramUsernameRequest create() => QueueInstagramUsernameRequest._();
  QueueInstagramUsernameRequest createEmptyInstance() => create();
  static $pb.PbList<QueueInstagramUsernameRequest> createRepeated() => $pb.PbList<QueueInstagramUsernameRequest>();
  @$core.pragma('dart2js:noInline')
  static QueueInstagramUsernameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueueInstagramUsernameRequest>(create);
  static QueueInstagramUsernameRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);
}

class QueueInstagramUsernameResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('QueueInstagramUsernameResponse', package: const $pb.PackageName('cloud_functions'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  QueueInstagramUsernameResponse._() : super();
  factory QueueInstagramUsernameResponse() => create();
  factory QueueInstagramUsernameResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueueInstagramUsernameResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  QueueInstagramUsernameResponse clone() => QueueInstagramUsernameResponse()..mergeFromMessage(this);
  QueueInstagramUsernameResponse copyWith(void Function(QueueInstagramUsernameResponse) updates) => super.copyWith((message) => updates(message as QueueInstagramUsernameResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QueueInstagramUsernameResponse create() => QueueInstagramUsernameResponse._();
  QueueInstagramUsernameResponse createEmptyInstance() => create();
  static $pb.PbList<QueueInstagramUsernameResponse> createRepeated() => $pb.PbList<QueueInstagramUsernameResponse>();
  @$core.pragma('dart2js:noInline')
  static QueueInstagramUsernameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueueInstagramUsernameResponse>(create);
  static QueueInstagramUsernameResponse _defaultInstance;
}

