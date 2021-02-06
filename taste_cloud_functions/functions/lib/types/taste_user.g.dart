// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_user.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class TasteUsers extends FirestoreProto<$pb.TasteUser>
    with AlgoliaBacked, ParentUpdater, TasteUser {
  static $pb.TasteUser get emptyInstance => $pb.TasteUser();
  static final collectionType = CollectionType.users;
  static final collection = collectionType.coll;
  TasteUsers(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.users,
            checkExists: checkExists);

  static Future<TasteUser> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static TasteUser make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      TasteUsers(snapshot, transaction, checkExists);
  static TasteUser makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<TasteUser> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<TasteUser> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.TasteUser get prototype => emptyInstance;

  static Future<List<TasteUser>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    TasteUser.registerInternal();
    TasteUser.triggers(collectionType, make);
  }

  @override
  Future<TasteUser> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension TasteUserExtension on TasteUser {
  Future<TasteUser> get refetch async => (await refetchInternal) as TasteUser;
}
