// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Reports extends FirestoreProto<$pb.Report>
    with UserOwned, ParentHolder, Report {
  static $pb.Report get emptyInstance => $pb.Report();
  static final collectionType = CollectionType.reports;
  static final collection = collectionType.coll;
  Reports(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.reports,
            checkExists: checkExists);

  static Future<Report> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Report make(DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Reports(snapshot, transaction, checkExists);
  static Report makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Report> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Report> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Report get prototype => emptyInstance;

  static Future<List<Report>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    Report.triggers(collectionType, make);
  }

  @override
  Future<Report> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension ReportExtension on Report {
  Future<Report> get refetch async => (await refetchInternal) as Report;
}
