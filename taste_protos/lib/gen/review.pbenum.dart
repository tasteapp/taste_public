///
//  Generated code. Do not modify.
//  source: review.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Reaction extends $pb.ProtobufEnum {
  static const Reaction UNDEFINED = Reaction._(0, 'UNDEFINED');
  static const Reaction up = Reaction._(1, 'up');
  static const Reaction down = Reaction._(2, 'down');
  static const Reaction love = Reaction._(3, 'love');

  static const $core.List<Reaction> values = <Reaction> [
    UNDEFINED,
    up,
    down,
    love,
  ];

  static final $core.Map<$core.int, Reaction> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Reaction valueOf($core.int value) => _byValue[value];

  const Reaction._($core.int v, $core.String n) : super(v, n);
}

