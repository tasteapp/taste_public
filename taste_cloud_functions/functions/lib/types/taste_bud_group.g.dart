// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_bud_group.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class TasteBudGroups extends FirestoreProto<$pb.TasteBudGroup>
    with UserOwned, TasteBudGroup {
  static $pb.TasteBudGroup get emptyInstance => $pb.TasteBudGroup();
  static final collectionType = CollectionType.taste_bud_groups;
  static final collection = collectionType.coll;
  TasteBudGroups(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.taste_bud_groups,
            checkExists: checkExists);

  static Future<TasteBudGroup> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static TasteBudGroup make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      TasteBudGroups(snapshot, transaction, checkExists);
  static TasteBudGroup makeSimple(DocumentData data,
          DocumentReference reference, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<TasteBudGroup> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<TasteBudGroup> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.TasteBudGroup get prototype => emptyInstance;

  static Future<List<TasteBudGroup>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {}

  @override
  Future<TasteBudGroup> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension TasteBudGroupExtension on TasteBudGroup {
  Future<TasteBudGroup> get refetch async =>
      (await refetchInternal) as TasteBudGroup;
}
