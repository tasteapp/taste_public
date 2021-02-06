// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Photos extends FirestoreProto<$pb.Photo> with UserOwned, Photo {
  static $pb.Photo get emptyInstance => $pb.Photo();
  static final collectionType = CollectionType.photos;
  static final collection = collectionType.coll;
  Photos(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.photos,
            checkExists: checkExists);

  static Future<Photo> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Photo make(DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Photos(snapshot, transaction, checkExists);
  static Photo makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Photo> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Photo> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Photo get prototype => emptyInstance;

  static Future<List<Photo>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    Photo.triggers(collectionType, make);
  }

  @override
  Future<Photo> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension PhotoExtension on Photo {
  Future<Photo> get refetch async => (await refetchInternal) as Photo;
}
