// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_notification.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class TasteNotifications extends FirestoreProto<$pb.Notification>
    with UserOwned, TasteNotification {
  static $pb.Notification get emptyInstance => $pb.Notification();
  static final collectionType = CollectionType.notifications;
  static final collection = collectionType.coll;
  TasteNotifications(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.notifications,
            checkExists: checkExists);

  static Future<TasteNotification> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static TasteNotification make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      TasteNotifications(snapshot, transaction, checkExists);
  static TasteNotification makeSimple(DocumentData data,
          DocumentReference reference, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<TasteNotification> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<TasteNotification> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Notification get prototype => emptyInstance;

  static Future<List<TasteNotification>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    TasteNotification.triggers(collectionType, make);
  }

  @override
  Future<TasteNotification> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension TasteNotificationExtension on TasteNotification {
  Future<TasteNotification> get refetch async =>
      (await refetchInternal) as TasteNotification;
}
