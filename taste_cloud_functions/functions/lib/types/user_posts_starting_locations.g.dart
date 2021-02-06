// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_posts_starting_locations.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class UserPostsStartingLocations
    extends FirestoreProto<$pb.UserPostsStartingLocation>
    with UserPostsStartingLocation {
  static $pb.UserPostsStartingLocation get emptyInstance =>
      $pb.UserPostsStartingLocation();
  static final collectionType = CollectionType.user_posts_starting_locations;
  static final collection = collectionType.coll;
  UserPostsStartingLocations(
      DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(
            snapshot, transaction, CollectionType.user_posts_starting_locations,
            checkExists: checkExists);

  static Future<UserPostsStartingLocation> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static UserPostsStartingLocation make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      UserPostsStartingLocations(snapshot, transaction, checkExists);
  static UserPostsStartingLocation makeSimple(DocumentData data,
          DocumentReference reference, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<UserPostsStartingLocation> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<UserPostsStartingLocation> createNew(
      BatchedTransaction transaction,
      {DocumentData data,
      String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.UserPostsStartingLocation get prototype => emptyInstance;

  static Future<List<UserPostsStartingLocation>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    UserPostsStartingLocation.registerInternal();
  }

  @override
  Future<UserPostsStartingLocation> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension UserPostsStartingLocationExtension on UserPostsStartingLocation {
  Future<UserPostsStartingLocation> get refetch async =>
      (await refetchInternal) as UserPostsStartingLocation;
}
