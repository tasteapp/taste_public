// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailchimp_user_setting.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class MailchimpUserSettings extends FirestoreProto<$pb.MailchimpUserSetting>
    with UserOwned, MailchimpUserSetting {
  static $pb.MailchimpUserSetting get emptyInstance =>
      $pb.MailchimpUserSetting();
  static final collectionType = CollectionType.mailchimp_user_settings;
  static final collection = collectionType.coll;
  MailchimpUserSettings(
      DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.mailchimp_user_settings,
            checkExists: checkExists);

  static Future<MailchimpUserSetting> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static MailchimpUserSetting make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      MailchimpUserSettings(snapshot, transaction, checkExists);
  static MailchimpUserSetting makeSimple(DocumentData data,
          DocumentReference reference, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<MailchimpUserSetting> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<MailchimpUserSetting> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.MailchimpUserSetting get prototype => emptyInstance;

  static Future<List<MailchimpUserSetting>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    MailchimpUserSetting.registerInternal();
    MailchimpUserSetting.triggers(collectionType, make);
  }

  @override
  Future<MailchimpUserSetting> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension MailchimpUserSettingExtension on MailchimpUserSetting {
  Future<MailchimpUserSetting> get refetch async =>
      (await refetchInternal) as MailchimpUserSetting;
}
