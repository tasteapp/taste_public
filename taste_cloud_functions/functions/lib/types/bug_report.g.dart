// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bug_report.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class BugReports extends FirestoreProto<$pb.BugReport> with BugReport {
  static $pb.BugReport get emptyInstance => $pb.BugReport();
  static final collectionType = CollectionType.bug_reports;
  static final collection = collectionType.coll;
  BugReports(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.bug_reports,
            checkExists: checkExists);

  static Future<BugReport> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static BugReport make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      BugReports(snapshot, transaction, checkExists);
  static BugReport makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<BugReport> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<BugReport> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.BugReport get prototype => emptyInstance;

  static Future<List<BugReport>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    BugReport.triggers(collectionType, make);
  }

  @override
  Future<BugReport> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension BugReportExtension on BugReport {
  Future<BugReport> get refetch async => (await refetchInternal) as BugReport;
}
