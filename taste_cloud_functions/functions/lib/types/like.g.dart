// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Likes extends FirestoreProto<$pb.Like>
    with ParentUpdater, UserOwned, ParentHolder, UniqueUserIndexed, Like {
  static $pb.Like get emptyInstance => $pb.Like();
  static final collectionType = CollectionType.likes;
  static final collection = collectionType.coll;
  Likes(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.likes,
            checkExists: checkExists);

  static Future<Like> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Like make(DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Likes(snapshot, transaction, checkExists);
  static Like makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Like> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Like> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Like get prototype => emptyInstance;

  static Future<List<Like>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    Like.triggers(collectionType, make);
  }

  @override
  Future<Like> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension LikeExtension on Like {
  Future<Like> get refetch async => (await refetchInternal) as Like;
}
