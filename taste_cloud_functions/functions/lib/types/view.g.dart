// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Views extends FirestoreProto<$pb.View>
    with UserOwned, ParentHolder, View {
  static $pb.View get emptyInstance => $pb.View();
  static final collectionType = CollectionType.views;
  static final collection = collectionType.coll;
  Views(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.views,
            checkExists: checkExists);

  static Future<View> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static View make(DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Views(snapshot, transaction, checkExists);
  static View makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<View> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<View> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.View get prototype => emptyInstance;

  static Future<List<View>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {}

  @override
  Future<View> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension ViewExtension on View {
  Future<View> get refetch async => (await refetchInternal) as View;
}
