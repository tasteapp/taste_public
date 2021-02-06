// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instagram_scrape_request.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class InstagramScrapeRequests extends FirestoreProto<$pb.InstagramScrapeRequest>
    with UserOwned, InstagramScrapeRequest {
  static $pb.InstagramScrapeRequest get emptyInstance =>
      $pb.InstagramScrapeRequest();
  static final collectionType = CollectionType.instagram_scrape_requests;
  static final collection = collectionType.coll;
  InstagramScrapeRequests(
      DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.instagram_scrape_requests,
            checkExists: checkExists);

  static Future<InstagramScrapeRequest> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static InstagramScrapeRequest make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      InstagramScrapeRequests(snapshot, transaction, checkExists);
  static InstagramScrapeRequest makeSimple(DocumentData data,
          DocumentReference reference, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<InstagramScrapeRequest> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<InstagramScrapeRequest> createNew(
      BatchedTransaction transaction,
      {DocumentData data,
      String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.InstagramScrapeRequest get prototype => emptyInstance;

  static Future<List<InstagramScrapeRequest>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    InstagramScrapeRequest.triggers(collectionType, make);
  }

  @override
  Future<InstagramScrapeRequest> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension InstagramScrapeRequestExtension on InstagramScrapeRequest {
  Future<InstagramScrapeRequest> get refetch async =>
      (await refetchInternal) as InstagramScrapeRequest;
}
