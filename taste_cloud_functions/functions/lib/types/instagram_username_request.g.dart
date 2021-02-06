// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instagram_username_request.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class InstagramUsernameRequests
    extends FirestoreProto<$pb.InstagramUsernameRequest>
    with InstagramUsernameRequest {
  static $pb.InstagramUsernameRequest get emptyInstance =>
      $pb.InstagramUsernameRequest();
  static final collectionType = CollectionType.instagram_username_requests;
  static final collection = collectionType.coll;
  InstagramUsernameRequests(
      DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.instagram_username_requests,
            checkExists: checkExists);

  static Future<InstagramUsernameRequest> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static InstagramUsernameRequest make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      InstagramUsernameRequests(snapshot, transaction, checkExists);
  static InstagramUsernameRequest makeSimple(DocumentData data,
          DocumentReference reference, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<InstagramUsernameRequest> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<InstagramUsernameRequest> createNew(
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
  $pb.InstagramUsernameRequest get prototype => emptyInstance;

  static Future<List<InstagramUsernameRequest>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {}

  @override
  Future<InstagramUsernameRequest> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension InstagramUsernameRequestExtension on InstagramUsernameRequest {
  Future<InstagramUsernameRequest> get refetch async =>
      (await refetchInternal) as InstagramUsernameRequest;
}
