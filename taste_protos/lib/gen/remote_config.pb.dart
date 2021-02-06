///
//  Generated code. Do not modify.
//  source: remote_config.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'remote_config.pbenum.dart';

class SupportedVersionsV2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SupportedVersionsV2', package: const $pb.PackageName('remote_config'), createEmptyInstance: create)
    ..m<$core.String, $core.bool>(1, 'versionIsSupported', entryClassName: 'SupportedVersionsV2.VersionIsSupportedEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OB, packageName: const $pb.PackageName('remote_config'))
    ..aOB(2, 'forbidByDefault')
    ..hasRequiredFields = false
  ;

  SupportedVersionsV2._() : super();
  factory SupportedVersionsV2() => create();
  factory SupportedVersionsV2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SupportedVersionsV2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SupportedVersionsV2 clone() => SupportedVersionsV2()..mergeFromMessage(this);
  SupportedVersionsV2 copyWith(void Function(SupportedVersionsV2) updates) => super.copyWith((message) => updates(message as SupportedVersionsV2));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SupportedVersionsV2 create() => SupportedVersionsV2._();
  SupportedVersionsV2 createEmptyInstance() => create();
  static $pb.PbList<SupportedVersionsV2> createRepeated() => $pb.PbList<SupportedVersionsV2>();
  @$core.pragma('dart2js:noInline')
  static SupportedVersionsV2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SupportedVersionsV2>(create);
  static SupportedVersionsV2 _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.bool> get versionIsSupported => $_getMap(0);

  @$pb.TagNumber(2)
  $core.bool get forbidByDefault => $_getBF(1);
  @$pb.TagNumber(2)
  set forbidByDefault($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasForbidByDefault() => $_has(1);
  @$pb.TagNumber(2)
  void clearForbidByDefault() => clearField(2);
}

class SupportedVersionsVersioning extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SupportedVersionsVersioning', package: const $pb.PackageName('remote_config'), createEmptyInstance: create)
    ..aOS(1, 'supportedVersions')
    ..aOS(2, 'allowUndefinedVersions')
    ..aOS(3, 'supportedVersionsV2')
    ..hasRequiredFields = false
  ;

  SupportedVersionsVersioning._() : super();
  factory SupportedVersionsVersioning() => create();
  factory SupportedVersionsVersioning.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SupportedVersionsVersioning.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SupportedVersionsVersioning clone() => SupportedVersionsVersioning()..mergeFromMessage(this);
  SupportedVersionsVersioning copyWith(void Function(SupportedVersionsVersioning) updates) => super.copyWith((message) => updates(message as SupportedVersionsVersioning));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SupportedVersionsVersioning create() => SupportedVersionsVersioning._();
  SupportedVersionsVersioning createEmptyInstance() => create();
  static $pb.PbList<SupportedVersionsVersioning> createRepeated() => $pb.PbList<SupportedVersionsVersioning>();
  @$core.pragma('dart2js:noInline')
  static SupportedVersionsVersioning getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SupportedVersionsVersioning>(create);
  static SupportedVersionsVersioning _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get supportedVersions => $_getSZ(0);
  @$pb.TagNumber(1)
  set supportedVersions($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSupportedVersions() => $_has(0);
  @$pb.TagNumber(1)
  void clearSupportedVersions() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get allowUndefinedVersions => $_getSZ(1);
  @$pb.TagNumber(2)
  set allowUndefinedVersions($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAllowUndefinedVersions() => $_has(1);
  @$pb.TagNumber(2)
  void clearAllowUndefinedVersions() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get supportedVersionsV2 => $_getSZ(2);
  @$pb.TagNumber(3)
  set supportedVersionsV2($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSupportedVersionsV2() => $_has(2);
  @$pb.TagNumber(3)
  void clearSupportedVersionsV2() => clearField(3);
}

