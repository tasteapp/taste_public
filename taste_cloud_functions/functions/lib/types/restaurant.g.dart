// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Restaurants extends FirestoreProto<$pb.Restaurant>
    with AlgoliaBacked, SpatialIndexed, Restaurant {
  static $pb.Restaurant get emptyInstance => $pb.Restaurant();
  static final collectionType = CollectionType.restaurants;
  static final collection = collectionType.coll;
  Restaurants(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.restaurants,
            checkExists: checkExists);

  static Future<Restaurant> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Restaurant make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Restaurants(snapshot, transaction, checkExists);
  static Restaurant makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Restaurant> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Restaurant> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Restaurant get prototype => emptyInstance;

  static Future<List<Restaurant>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    Restaurant.triggers(collectionType, make);
  }

  @override
  Future<Restaurant> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension RestaurantExtension on Restaurant {
  Future<Restaurant> get refetch async => (await refetchInternal) as Restaurant;
}
