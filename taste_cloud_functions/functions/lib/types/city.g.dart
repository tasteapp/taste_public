// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Citys extends FirestoreProto<$pb.City> with AlgoliaBacked, City {
  static $pb.City get emptyInstance => $pb.City();
  static final collectionType = CollectionType.cities;
  static final collection = collectionType.coll;
  Citys(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.cities,
            checkExists: checkExists);

  static Future<City> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static City make(DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Citys(snapshot, transaction, checkExists);
  static City makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<City> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<City> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.City get prototype => emptyInstance;

  static Future<List<City>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    City.triggers(collectionType, make);
  }

  @override
  Future<City> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension CityExtension on City {
  Future<City> get refetch async => (await refetchInternal) as City;
}
