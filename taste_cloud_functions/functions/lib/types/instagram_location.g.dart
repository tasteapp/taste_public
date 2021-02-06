// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instagram_location.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class InstagramLocations extends FirestoreProto<$pb.InstagramLocation>
    with InstagramLocation {
  static $pb.InstagramLocation get emptyInstance => $pb.InstagramLocation();
  static final collectionType = CollectionType.instagram_locations;
  static final collection = collectionType.coll;
  InstagramLocations(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.instagram_locations,
            checkExists: checkExists);

  static Future<InstagramLocation> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static InstagramLocation make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      InstagramLocations(snapshot, transaction, checkExists);
  static InstagramLocation makeSimple(DocumentData data,
          DocumentReference reference, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<InstagramLocation> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<InstagramLocation> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.InstagramLocation get prototype => emptyInstance;

  static Future<List<InstagramLocation>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    InstagramLocation.triggers(collectionType, make);
  }

  @override
  Future<InstagramLocation> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension InstagramLocationExtension on InstagramLocation {
  Future<InstagramLocation> get refetch async =>
      (await refetchInternal) as InstagramLocation;
}
