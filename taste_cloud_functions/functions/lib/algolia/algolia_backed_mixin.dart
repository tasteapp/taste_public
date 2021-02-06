import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

mixin AlgoliaBacked implements SnapshotHolder {
  static final coll = AlgoliaRecords.collection;
  List<AlgoliaRecordID> get algoliaRecordIDs;
  FutureOr<GeoPoint> get algoliaGeoPoint async => null;
  Future<AlgoliaRecord> updateAlgoliaRecord({
    GeoPoint geoPoint,
    AlgoliaRecordID recordID,
    @required Map<String, dynamic> payload,
    Set<String> extraTags = const {},
  }) async {
    recordID ??= algoliaRecordIDs.first;
    geoPoint ??= await algoliaGeoPoint;
    final data = {
      'record_type': recordID.recordType,
      'reference': ref,
      'location': geoPoint,
      'payload': payload,
      'index': recordID.recordTypeData.index,
      'tags': recordID.recordTypeData.tags.toList() + extraTags.toList(),
      'object_id': recordID.objectID,
    }.ensureAs($pb.AlgoliaRecord()).documentData.withExtras;
    final reference = (await _algoliaRecord(recordID))?.ref ?? coll.document();
    await transaction.set(reference, data);
    return AlgoliaRecords.makeSimple(data, reference, transaction);
  }

  Future<AlgoliaRecord> _algoliaRecord(AlgoliaRecordID recordID) async {
    final objectID = recordID.objectID;
    final query = coll.where('object_id', isEqualTo: objectID);
    final results = await wrapQuery(query, AlgoliaRecords.make);
    return results.firstOrNull;
  }

  Future deleteAlgoliaCache() => deleteDynamic(AlgoliaRecords.get(
      trans: transaction,
      queryFn: (q) => q.where('reference', isEqualTo: ref)));
}
