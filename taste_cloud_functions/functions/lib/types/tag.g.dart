// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Tags extends FirestoreProto<$pb.Tag> with Tag {
  static $pb.Tag get emptyInstance => $pb.Tag();
  static final collectionType = CollectionType.tags;
  static final collection = collectionType.coll;
  Tags(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.tags,
            checkExists: checkExists);

  static Future<Tag> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Tag make(DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Tags(snapshot, transaction, checkExists);
  static Tag makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Tag> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Tag> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Tag get prototype => emptyInstance;

  static Future<List<Tag>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {}

  @override
  Future<Tag> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension TagExtension on Tag {
  Future<Tag> get refetch async => (await refetchInternal) as Tag;
}
