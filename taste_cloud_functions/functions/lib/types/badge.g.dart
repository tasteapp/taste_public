// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Badges extends FirestoreProto<$pb.Badge> with UserOwned, Badge {
  static $pb.Badge get emptyInstance => $pb.Badge();
  static final collectionType = CollectionType.badges;
  static final collection = collectionType.coll;
  Badges(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.badges,
            checkExists: checkExists);

  static Future<Badge> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Badge make(DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Badges(snapshot, transaction, checkExists);
  static Badge makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Badge> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Badge> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Badge get prototype => emptyInstance;

  static Future<List<Badge>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    Badge.registerInternal();
  }

  @override
  Future<Badge> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension BadgeExtension on Badge {
  Future<Badge> get refetch async => (await refetchInternal) as Badge;
}
