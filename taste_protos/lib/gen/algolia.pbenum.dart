///
//  Generated code. Do not modify.
//  source: algolia.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class AlgoliaIndex extends $pb.ProtobufEnum {
  static const AlgoliaIndex ALGOLIA_INDEX_UNDEFINED = AlgoliaIndex._(0, 'ALGOLIA_INDEX_UNDEFINED');
  static const AlgoliaIndex discover = AlgoliaIndex._(1, 'discover');
  static const AlgoliaIndex referrals = AlgoliaIndex._(2, 'referrals');
  static const AlgoliaIndex reviews = AlgoliaIndex._(3, 'reviews');
  static const AlgoliaIndex restaurants = AlgoliaIndex._(4, 'restaurants');

  static const $core.List<AlgoliaIndex> values = <AlgoliaIndex> [
    ALGOLIA_INDEX_UNDEFINED,
    discover,
    referrals,
    reviews,
    restaurants,
  ];

  static final $core.Map<$core.int, AlgoliaIndex> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AlgoliaIndex valueOf($core.int value) => _byValue[value];

  const AlgoliaIndex._($core.int v, $core.String n) : super(v, n);
}

class AlgoliaRecordType extends $pb.ProtobufEnum {
  static const AlgoliaRecordType ALGOLIA_RECORD_TYPE_UNDEFINED = AlgoliaRecordType._(0, 'ALGOLIA_RECORD_TYPE_UNDEFINED');
  static const AlgoliaRecordType restaurant = AlgoliaRecordType._(1, 'restaurant');
  static const AlgoliaRecordType restaurant_marker = AlgoliaRecordType._(2, 'restaurant_marker');
  static const AlgoliaRecordType dish = AlgoliaRecordType._(3, 'dish');
  static const AlgoliaRecordType user = AlgoliaRecordType._(4, 'user');
  static const AlgoliaRecordType referral_link = AlgoliaRecordType._(5, 'referral_link');
  static const AlgoliaRecordType review_marker = AlgoliaRecordType._(6, 'review_marker');
  static const AlgoliaRecordType review_discover = AlgoliaRecordType._(7, 'review_discover');
  static const AlgoliaRecordType city = AlgoliaRecordType._(8, 'city');

  static const $core.List<AlgoliaRecordType> values = <AlgoliaRecordType> [
    ALGOLIA_RECORD_TYPE_UNDEFINED,
    restaurant,
    restaurant_marker,
    dish,
    user,
    referral_link,
    review_marker,
    review_discover,
    city,
  ];

  static final $core.Map<$core.int, AlgoliaRecordType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AlgoliaRecordType valueOf($core.int value) => _byValue[value];

  const AlgoliaRecordType._($core.int v, $core.String n) : super(v, n);
}

