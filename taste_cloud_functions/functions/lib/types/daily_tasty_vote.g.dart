// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_tasty_vote.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class DailyTastyVotes extends FirestoreProto<$pb.DailyTastyVote>
    with
        ParentUpdater,
        UserOwned,
        ParentHolder,
        UniqueUserIndexed,
        DailyTastyVote {
  static $pb.DailyTastyVote get emptyInstance => $pb.DailyTastyVote();
  static final collectionType = CollectionType.daily_tasty_votes;
  static final collection = collectionType.coll;
  DailyTastyVotes(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.daily_tasty_votes,
            checkExists: checkExists);

  static Future<DailyTastyVote> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static DailyTastyVote make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      DailyTastyVotes(snapshot, transaction, checkExists);
  static DailyTastyVote makeSimple(DocumentData data,
          DocumentReference reference, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<DailyTastyVote> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<DailyTastyVote> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.DailyTastyVote get prototype => emptyInstance;

  static Future<List<DailyTastyVote>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    DailyTastyVote.registerInternal();
    DailyTastyVote.triggers(collectionType, make);
  }

  @override
  Future<DailyTastyVote> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension DailyTastyVoteExtension on DailyTastyVote {
  Future<DailyTastyVote> get refetch async =>
      (await refetchInternal) as DailyTastyVote;
}
