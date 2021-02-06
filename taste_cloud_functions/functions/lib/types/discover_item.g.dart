// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_item.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class DiscoverItems extends FirestoreProto<$pb.DiscoverItem>
    with UserOwned, DiscoverItem {
  static $pb.DiscoverItem get emptyInstance => $pb.DiscoverItem();
  static final collectionType = CollectionType.discover_items;
  static final collection = collectionType.coll;
  DiscoverItems(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.discover_items,
            checkExists: checkExists);

  static Future<DiscoverItem> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static DiscoverItem make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      DiscoverItems(snapshot, transaction, checkExists);
  static DiscoverItem makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<DiscoverItem> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<DiscoverItem> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.DiscoverItem get prototype => emptyInstance;

  static Future<List<DiscoverItem>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {}

  @override
  Future<DiscoverItem> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension DiscoverItemExtension on DiscoverItem {
  Future<DiscoverItem> get refetch async =>
      (await refetchInternal) as DiscoverItem;
}
