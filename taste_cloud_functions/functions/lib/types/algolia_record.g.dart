// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'algolia_record.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class AlgoliaRecords extends FirestoreProto<$pb.AlgoliaRecord>
    with AlgoliaRecord {
  static $pb.AlgoliaRecord get emptyInstance => $pb.AlgoliaRecord();
  static final collectionType = CollectionType.algolia_records;
  static final collection = collectionType.coll;
  AlgoliaRecords(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.algolia_records,
            checkExists: checkExists);

  static Future<AlgoliaRecord> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static AlgoliaRecord make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      AlgoliaRecords(snapshot, transaction, checkExists);
  static AlgoliaRecord makeSimple(DocumentData data,
          DocumentReference reference, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<AlgoliaRecord> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<AlgoliaRecord> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.AlgoliaRecord get prototype => emptyInstance;

  static Future<List<AlgoliaRecord>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    AlgoliaRecord.triggers(collectionType, make);
  }

  @override
  Future<AlgoliaRecord> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension AlgoliaRecordExtension on AlgoliaRecord {
  Future<AlgoliaRecord> get refetch async =>
      (await refetchInternal) as AlgoliaRecord;
}
