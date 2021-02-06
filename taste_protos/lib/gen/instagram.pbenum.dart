///
//  Generated code. Do not modify.
//  source: instagram.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class RejectedInstagramUsers_RejectionReason extends $pb.ProtobufEnum {
  static const RejectedInstagramUsers_RejectionReason rejection_reason_undefined = RejectedInstagramUsers_RejectionReason._(0, 'rejection_reason_undefined');
  static const RejectedInstagramUsers_RejectionReason no_email = RejectedInstagramUsers_RejectionReason._(1, 'no_email');
  static const RejectedInstagramUsers_RejectionReason posts_not_food = RejectedInstagramUsers_RejectionReason._(2, 'posts_not_food');
  static const RejectedInstagramUsers_RejectionReason posts_not_tagged = RejectedInstagramUsers_RejectionReason._(3, 'posts_not_tagged');
  static const RejectedInstagramUsers_RejectionReason posts_not_usa = RejectedInstagramUsers_RejectionReason._(4, 'posts_not_usa');
  static const RejectedInstagramUsers_RejectionReason too_many_followers = RejectedInstagramUsers_RejectionReason._(5, 'too_many_followers');
  static const RejectedInstagramUsers_RejectionReason too_few_posts = RejectedInstagramUsers_RejectionReason._(6, 'too_few_posts');
  static const RejectedInstagramUsers_RejectionReason is_food_call_failed = RejectedInstagramUsers_RejectionReason._(7, 'is_food_call_failed');
  static const RejectedInstagramUsers_RejectionReason likely_restaurant = RejectedInstagramUsers_RejectionReason._(8, 'likely_restaurant');

  static const $core.List<RejectedInstagramUsers_RejectionReason> values = <RejectedInstagramUsers_RejectionReason> [
    rejection_reason_undefined,
    no_email,
    posts_not_food,
    posts_not_tagged,
    posts_not_usa,
    too_many_followers,
    too_few_posts,
    is_food_call_failed,
    likely_restaurant,
  ];

  static final $core.Map<$core.int, RejectedInstagramUsers_RejectionReason> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RejectedInstagramUsers_RejectionReason valueOf($core.int value) => _byValue[value];

  const RejectedInstagramUsers_RejectionReason._($core.int v, $core.String n) : super(v, n);
}

