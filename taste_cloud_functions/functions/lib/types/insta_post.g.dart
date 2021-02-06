// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insta_post.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class InstaPosts extends FirestoreProto<$pb.InstaPost>
    with UserOwned, InstaPost {
  static $pb.InstaPost get emptyInstance => $pb.InstaPost();
  static final collectionType = CollectionType.insta_posts;
  static final collection = collectionType.coll;
  InstaPosts(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.insta_posts,
            checkExists: checkExists);

  static Future<InstaPost> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static InstaPost make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      InstaPosts(snapshot, transaction, checkExists);
  static InstaPost makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<InstaPost> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<InstaPost> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.InstaPost get prototype => emptyInstance;

  static Future<List<InstaPost>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    InstaPost.triggers(collectionType, make);
  }

  @override
  Future<InstaPost> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension InstaPostExtension on InstaPost {
  Future<InstaPost> get refetch async => (await refetchInternal) as InstaPost;
}
