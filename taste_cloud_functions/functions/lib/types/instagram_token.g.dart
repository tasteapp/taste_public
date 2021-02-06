// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instagram_token.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class InstagramTokens extends FirestoreProto<$pb.InstagramToken>
    with UserOwned, InstagramToken {
  static $pb.InstagramToken get emptyInstance => $pb.InstagramToken();
  static final collectionType = CollectionType.instagram_tokens;
  static final collection = collectionType.coll;
  InstagramTokens(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.instagram_tokens,
            checkExists: checkExists);

  static Future<InstagramToken> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static InstagramToken make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      InstagramTokens(snapshot, transaction, checkExists);
  static InstagramToken makeSimple(DocumentData data,
          DocumentReference reference, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<InstagramToken> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<InstagramToken> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.InstagramToken get prototype => emptyInstance;

  static Future<List<InstagramToken>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    InstagramToken.triggers(collectionType, make);
  }

  @override
  Future<InstagramToken> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension InstagramTokenExtension on InstagramToken {
  Future<InstagramToken> get refetch async =>
      (await refetchInternal) as InstagramToken;
}
