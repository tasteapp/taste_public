///
//  Generated code. Do not modify.
//  source: firebase_rules_options.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RulesMessageOptions extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RulesMessageOptions', package: const $pb.PackageName('rules_gen'), createEmptyInstance: create)
    ..aOS(1, 'validate')
    ..aOB(2, 'extraProperties')
    ..aOB(3, 'nullable')
    ..aOB(4, 'required')
    ..hasRequiredFields = false
  ;

  RulesMessageOptions._() : super();
  factory RulesMessageOptions() => create();
  factory RulesMessageOptions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RulesMessageOptions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RulesMessageOptions clone() => RulesMessageOptions()..mergeFromMessage(this);
  RulesMessageOptions copyWith(void Function(RulesMessageOptions) updates) => super.copyWith((message) => updates(message as RulesMessageOptions));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RulesMessageOptions create() => RulesMessageOptions._();
  RulesMessageOptions createEmptyInstance() => create();
  static $pb.PbList<RulesMessageOptions> createRepeated() => $pb.PbList<RulesMessageOptions>();
  @$core.pragma('dart2js:noInline')
  static RulesMessageOptions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RulesMessageOptions>(create);
  static RulesMessageOptions _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get validate => $_getSZ(0);
  @$pb.TagNumber(1)
  set validate($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValidate() => $_has(0);
  @$pb.TagNumber(1)
  void clearValidate() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get extraProperties => $_getBF(1);
  @$pb.TagNumber(2)
  set extraProperties($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasExtraProperties() => $_has(1);
  @$pb.TagNumber(2)
  void clearExtraProperties() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get nullable => $_getBF(2);
  @$pb.TagNumber(3)
  set nullable($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNullable() => $_has(2);
  @$pb.TagNumber(3)
  void clearNullable() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get required => $_getBF(3);
  @$pb.TagNumber(4)
  set required($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRequired() => $_has(3);
  @$pb.TagNumber(4)
  void clearRequired() => clearField(4);
}

class RulesFieldOptions extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RulesFieldOptions', package: const $pb.PackageName('rules_gen'), createEmptyInstance: create)
    ..aOS(1, 'validate')
    ..aOB(2, 'referenceType')
    ..aOB(3, 'nullable')
    ..aOB(4, 'authUser')
    ..aOB(5, 'required')
    ..aOB(6, 'notEmpty')
    ..aOB(7, 'isHttp')
    ..hasRequiredFields = false
  ;

  RulesFieldOptions._() : super();
  factory RulesFieldOptions() => create();
  factory RulesFieldOptions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RulesFieldOptions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RulesFieldOptions clone() => RulesFieldOptions()..mergeFromMessage(this);
  RulesFieldOptions copyWith(void Function(RulesFieldOptions) updates) => super.copyWith((message) => updates(message as RulesFieldOptions));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RulesFieldOptions create() => RulesFieldOptions._();
  RulesFieldOptions createEmptyInstance() => create();
  static $pb.PbList<RulesFieldOptions> createRepeated() => $pb.PbList<RulesFieldOptions>();
  @$core.pragma('dart2js:noInline')
  static RulesFieldOptions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RulesFieldOptions>(create);
  static RulesFieldOptions _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get validate => $_getSZ(0);
  @$pb.TagNumber(1)
  set validate($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValidate() => $_has(0);
  @$pb.TagNumber(1)
  void clearValidate() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get referenceType => $_getBF(1);
  @$pb.TagNumber(2)
  set referenceType($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReferenceType() => $_has(1);
  @$pb.TagNumber(2)
  void clearReferenceType() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get nullable => $_getBF(2);
  @$pb.TagNumber(3)
  set nullable($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNullable() => $_has(2);
  @$pb.TagNumber(3)
  void clearNullable() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get authUser => $_getBF(3);
  @$pb.TagNumber(4)
  set authUser($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAuthUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthUser() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get required => $_getBF(4);
  @$pb.TagNumber(5)
  set required($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRequired() => $_has(4);
  @$pb.TagNumber(5)
  void clearRequired() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get notEmpty => $_getBF(5);
  @$pb.TagNumber(6)
  set notEmpty($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasNotEmpty() => $_has(5);
  @$pb.TagNumber(6)
  void clearNotEmpty() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isHttp => $_getBF(6);
  @$pb.TagNumber(7)
  set isHttp($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsHttp() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsHttp() => clearField(7);
}

class RulesFileOptions extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RulesFileOptions', package: const $pb.PackageName('rules_gen'), createEmptyInstance: create)
    ..aOB(1, 'fullPackageNames')
    ..hasRequiredFields = false
  ;

  RulesFileOptions._() : super();
  factory RulesFileOptions() => create();
  factory RulesFileOptions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RulesFileOptions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RulesFileOptions clone() => RulesFileOptions()..mergeFromMessage(this);
  RulesFileOptions copyWith(void Function(RulesFileOptions) updates) => super.copyWith((message) => updates(message as RulesFileOptions));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RulesFileOptions create() => RulesFileOptions._();
  RulesFileOptions createEmptyInstance() => create();
  static $pb.PbList<RulesFileOptions> createRepeated() => $pb.PbList<RulesFileOptions>();
  @$core.pragma('dart2js:noInline')
  static RulesFileOptions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RulesFileOptions>(create);
  static RulesFileOptions _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get fullPackageNames => $_getBF(0);
  @$pb.TagNumber(1)
  set fullPackageNames($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFullPackageNames() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullPackageNames() => clearField(1);
}

class RulesEnumOptions extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RulesEnumOptions', package: const $pb.PackageName('rules_gen'), createEmptyInstance: create)
    ..a<$core.bool>(1, 'stringValues', $pb.PbFieldType.OB, defaultOrMaker: true)
    ..hasRequiredFields = false
  ;

  RulesEnumOptions._() : super();
  factory RulesEnumOptions() => create();
  factory RulesEnumOptions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RulesEnumOptions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RulesEnumOptions clone() => RulesEnumOptions()..mergeFromMessage(this);
  RulesEnumOptions copyWith(void Function(RulesEnumOptions) updates) => super.copyWith((message) => updates(message as RulesEnumOptions));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RulesEnumOptions create() => RulesEnumOptions._();
  RulesEnumOptions createEmptyInstance() => create();
  static $pb.PbList<RulesEnumOptions> createRepeated() => $pb.PbList<RulesEnumOptions>();
  @$core.pragma('dart2js:noInline')
  static RulesEnumOptions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RulesEnumOptions>(create);
  static RulesEnumOptions _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get stringValues => $_getB(0, true);
  @$pb.TagNumber(1)
  set stringValues($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStringValues() => $_has(0);
  @$pb.TagNumber(1)
  void clearStringValues() => clearField(1);
}

class Firebase_rules_options {
  static final $pb.Extension message = $pb.Extension<RulesMessageOptions>('google.protobuf.MessageOptions', 'message', 92493, $pb.PbFieldType.OM, defaultOrMaker: RulesMessageOptions.getDefault, subBuilder: RulesMessageOptions.create);
  static final $pb.Extension field_92493 = $pb.Extension<RulesFieldOptions>('google.protobuf.FieldOptions', 'field', 92493, $pb.PbFieldType.OM, defaultOrMaker: RulesFieldOptions.getDefault, subBuilder: RulesFieldOptions.create);
  static final $pb.Extension firebaseRules = $pb.Extension<RulesFileOptions>('google.protobuf.FileOptions', 'firebaseRules', 92493, $pb.PbFieldType.OM, defaultOrMaker: RulesFileOptions.getDefault, subBuilder: RulesFileOptions.create);
  static final $pb.Extension firebaseRulesEnum = $pb.Extension<RulesEnumOptions>('google.protobuf.EnumOptions', 'firebaseRulesEnum', 92493, $pb.PbFieldType.OM, defaultOrMaker: RulesEnumOptions.getDefault, subBuilder: RulesEnumOptions.create);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(message);
    registry.add(field_92493);
    registry.add(firebaseRules);
    registry.add(firebaseRulesEnum);
  }
}

