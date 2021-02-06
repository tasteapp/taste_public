// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Comments extends FirestoreProto<$pb.Comment>
    with ParentUpdater, Likeable, UserOwned, ParentHolder, Comment {
  static $pb.Comment get emptyInstance => $pb.Comment();
  static final collectionType = CollectionType.comments;
  static final collection = collectionType.coll;
  Comments(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.comments,
            checkExists: checkExists);

  static Future<Comment> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Comment make(DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Comments(snapshot, transaction, checkExists);
  static Comment makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Comment> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Comment> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Comment get prototype => emptyInstance;

  static Future<List<Comment>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    Comment.triggers(collectionType, make);
  }

  @override
  Future<Comment> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension CommentExtension on Comment {
  Future<Comment> get refetch async => (await refetchInternal) as Comment;
}
