// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Operations extends FirestoreProto<$pb.Operation>
    with ParentHolder, Operation {
  static $pb.Operation get emptyInstance => $pb.Operation();
  static final collectionType = CollectionType.operations;
  static final collection = collectionType.coll;
  Operations(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.operations,
            checkExists: checkExists);

  static Future<Operation> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Operation make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Operations(snapshot, transaction, checkExists);
  static Operation makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Operation> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Operation> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Operation get prototype => emptyInstance;

  static Future<List<Operation>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {}

  @override
  Future<Operation> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension OperationExtension on Operation {
  Future<Operation> get refetch async => (await refetchInternal) as Operation;
}
