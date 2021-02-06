// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// FirestoreProtoGenerator
// **************************************************************************

class Movies extends FirestoreProto<$pb.Movie> with UserOwned, Movie {
  static $pb.Movie get emptyInstance => $pb.Movie();
  static final collectionType = CollectionType.movies;
  static final collection = collectionType.coll;
  Movies(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.movies,
            checkExists: checkExists);

  static Future<Movie> fromPath(String path,
      [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  }

  static Movie make(DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      Movies(snapshot, transaction, checkExists);
  static Movie makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<Movie> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);

  static Future<Movie> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $pb.Movie get prototype => emptyInstance;

  static Future<List<Movie>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    Movie.registerInternal();
    Movie.triggers(collectionType, make);
  }

  @override
  Future<Movie> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension MovieExtension on Movie {
  Future<Movie> get refetch async => (await refetchInternal) as Movie;
}
