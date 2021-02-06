///
//  Generated code. Do not modify.
//  source: notifications.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ClickAction extends $pb.ProtobufEnum {
  static const ClickAction FLUTTER_NOTIFICATION_CLICK = ClickAction._(0, 'FLUTTER_NOTIFICATION_CLICK');

  static const $core.List<ClickAction> values = <ClickAction> [
    FLUTTER_NOTIFICATION_CLICK,
  ];

  static final $core.Map<$core.int, ClickAction> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ClickAction valueOf($core.int value) => _byValue[value];

  const ClickAction._($core.int v, $core.String n) : super(v, n);
}

