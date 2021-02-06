// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Reviews extends FirestoreProto<$pb.Review>
    with
        ParentUpdater,
        Likeable,
        Viewable,
        UserOwned,
        AlgoliaBacked,
        SpatialIndexed,
        Review {
  static $pb.Review get emptyInstance => $pb.Review();
  static final collectionType = CollectionType.reviews;
  static final collection = collectionType.coll;
  Reviews(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.reviews,
            checkExists: checkExists);

  static Future<Review> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Review make(DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Reviews(snapshot, transaction, checkExists);
  static Review makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Review> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Review> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Review get prototype => emptyInstance;

  static Future<List<Review>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    Review.triggers(collectionType, make);
  }

  @override
  Future<Review> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension ReviewExtension on Review {
  Future<Review> get refetch async => (await refetchInternal) as Review;
}
