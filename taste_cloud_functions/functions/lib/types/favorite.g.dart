// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Favorites extends FirestoreProto<$pb.Favorite>
    with ParentUpdater, UserOwned, ParentHolder, UniqueUserIndexed, Favorite {
  static $pb.Favorite get emptyInstance => $pb.Favorite();
  static final collectionType = CollectionType.favorites;
  static final collection = collectionType.coll;
  Favorites(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.favorites,
            checkExists: checkExists);

  static Future<Favorite> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Favorite make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Favorites(snapshot, transaction, checkExists);
  static Favorite makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Favorite> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Favorite> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Favorite get prototype => emptyInstance;

  static Future<List<Favorite>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    Favorite.triggers(collectionType, make);
  }

  @override
  Future<Favorite> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension FavoriteExtension on Favorite {
  Future<Favorite> get refetch async => (await refetchInternal) as Favorite;
}
