import 'package:taste_protos/taste_protos.dart';

class AlgoliaRecordTypeData {
  final AlgoliaRecordType type;
  final Set<String> tags;
  final AlgoliaIndex index;

  AlgoliaRecordTypeData(this.type, this.tags, this.index);
}

final recordTypes = [
  AlgoliaRecordTypeData(
      AlgoliaRecordType.restaurant, {'restaurant'}, AlgoliaIndex.restaurants),
  AlgoliaRecordTypeData(
      AlgoliaRecordType.user, {'user', 'discover'}, AlgoliaIndex.discover),
  AlgoliaRecordTypeData(AlgoliaRecordType.referral_link, {'referral_link'},
      AlgoliaIndex.referrals),
  AlgoliaRecordTypeData(AlgoliaRecordType.restaurant_marker,
      {'restaurant_marker'}, AlgoliaIndex.discover),
  AlgoliaRecordTypeData(
      AlgoliaRecordType.review_marker, {'review_marker'}, AlgoliaIndex.reviews),
  AlgoliaRecordTypeData(AlgoliaRecordType.review_discover,
      {'review', 'discover'}, AlgoliaIndex.discover),
  AlgoliaRecordTypeData(
      AlgoliaRecordType.city, {'city', 'discover'}, AlgoliaIndex.discover),
].asMap().map((k, v) => MapEntry(v.type, v));
