// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Conversations extends FirestoreProto<$pb.Conversation> with Conversation {
  static $pb.Conversation get emptyInstance => $pb.Conversation();
  static final collectionType = CollectionType.conversations;
  static final collection = collectionType.coll;
  Conversations(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.conversations,
            checkExists: checkExists);

  static Future<Conversation> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Conversation make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Conversations(snapshot, transaction, checkExists);
  static Conversation makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Conversation> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Conversation> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Conversation get prototype => emptyInstance;

  static Future<List<Conversation>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    Conversation.triggers(collectionType, make);
  }

  @override
  Future<Conversation> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension ConversationExtension on Conversation {
  Future<Conversation> get refetch async =>
      (await refetchInternal) as Conversation;
}
