// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Bookmarks extends FirestoreProto<$pb.Bookmark>
    with ParentUpdater, UserOwned, ParentHolder, UniqueUserIndexed, Bookmark {
  static $pb.Bookmark get emptyInstance => $pb.Bookmark();
  static final collectionType = CollectionType.bookmarks;
  static final collection = collectionType.coll;
  Bookmarks(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.bookmarks,
            checkExists: checkExists);

  static Future<Bookmark> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Bookmark make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Bookmarks(snapshot, transaction, checkExists);
  static Bookmark makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Bookmark> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Bookmark> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Bookmark get prototype => emptyInstance;

  static Future<List<Bookmark>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    Bookmark.triggers(collectionType, make);
  }

  @override
  Future<Bookmark> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension BookmarkExtension on Bookmark {
  Future<Bookmark> get refetch async => (await refetchInternal) as Bookmark;
}
