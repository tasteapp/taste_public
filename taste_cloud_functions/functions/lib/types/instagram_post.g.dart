// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instagram_post.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class InstagramPosts extends FirestoreProto<$pb.InstagramPost>
    with SpatialIndexed, InstagramPost {
  static $pb.InstagramPost get emptyInstance => $pb.InstagramPost();
  static final collectionType = CollectionType.instagram_posts;
  static final collection = collectionType.coll;
  InstagramPosts(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.instagram_posts,
            checkExists: checkExists);

  static Future<InstagramPost> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static InstagramPost make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      InstagramPosts(snapshot, transaction, checkExists);
  static InstagramPost makeSimple(DocumentData data,
          DocumentReference reference, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<InstagramPost> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<InstagramPost> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.InstagramPost get prototype => emptyInstance;

  static Future<List<InstagramPost>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    InstagramPost.triggers(collectionType, make);
  }

  @override
  Future<InstagramPost> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension InstagramPostExtension on InstagramPost {
  Future<InstagramPost> get refetch async =>
      (await refetchInternal) as InstagramPost;
}
