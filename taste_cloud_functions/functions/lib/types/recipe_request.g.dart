// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_request.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class RecipeRequests extends FirestoreProto<$pb.RecipeRequest>
    with UserOwned, ParentHolder, UniqueUserIndexed, RecipeRequest {
  static $pb.RecipeRequest get emptyInstance => $pb.RecipeRequest();
  static final collectionType = CollectionType.recipe_requests;
  static final collection = collectionType.coll;
  RecipeRequests(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.recipe_requests,
            checkExists: checkExists);

  static Future<RecipeRequest> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static RecipeRequest make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      RecipeRequests(snapshot, transaction, checkExists);
  static RecipeRequest makeSimple(DocumentData data,
          DocumentReference reference, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<RecipeRequest> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<RecipeRequest> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.RecipeRequest get prototype => emptyInstance;

  static Future<List<RecipeRequest>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    RecipeRequest.triggers(collectionType, make);
  }

  @override
  Future<RecipeRequest> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension RecipeRequestExtension on RecipeRequest {
  Future<RecipeRequest> get refetch async =>
      (await refetchInternal) as RecipeRequest;
}
