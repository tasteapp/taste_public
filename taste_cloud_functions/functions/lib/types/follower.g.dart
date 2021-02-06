// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Followers extends FirestoreProto<$pb.Follower>
    with ParentHolder, UserOwned, UniqueUserIndexed, Follower {
  static $pb.Follower get emptyInstance => $pb.Follower();
  static final collectionType = CollectionType.followers;
  static final collection = collectionType.coll;
  Followers(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.followers,
            checkExists: checkExists);

  static Future<Follower> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Follower make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Followers(snapshot, transaction, checkExists);
  static Follower makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Follower> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Follower> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Follower get prototype => emptyInstance;

  static Future<List<Follower>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    Follower.triggers(collectionType, make);
  }

  @override
  Future<Follower> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension FollowerExtension on Follower {
  Future<Follower> get refetch async => (await refetchInternal) as Follower;
}
