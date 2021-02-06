// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_meal.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class HomeMeals extends FirestoreProto<$pb.Review>
    with
        ParentUpdater,
        Likeable,
        Viewable,
        UserOwned,
        AlgoliaBacked,
        SpatialIndexed,
        Review,
        HomeMeal {
  static $pb.Review get emptyInstance => $pb.Review();
  static final collectionType = CollectionType.home_meals;
  static final collection = collectionType.coll;
  HomeMeals(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.home_meals,
            checkExists: checkExists);

  static Future<HomeMeal> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static HomeMeal make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      HomeMeals(snapshot, transaction, checkExists);
  static HomeMeal makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<HomeMeal> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<HomeMeal> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Review get prototype => emptyInstance;

  static Future<List<HomeMeal>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    HomeMeal.triggers(collectionType, make);
  }

  @override
  Future<HomeMeal> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension HomeMealExtension on HomeMeal {
  Future<HomeMeal> get refetch async => (await refetchInternal) as HomeMeal;
}
