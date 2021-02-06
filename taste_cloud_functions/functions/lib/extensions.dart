import 'package:taste_cloud_functions/taste_functions.dart'
    hide
        DocumentSnapshotExtension,
        DocumentDataExtension,
        IsADoc,
        ChangeExtensionSnapshot,
        ProtoDocumentReference;
import 'package:taste_protos/taste_protos.dart' as $pb;

DocumentReference _check(String path) {
  if (path?.isEmpty ?? true) {
    throw CloudFnException('Empty reference path');
  }
  return firestore.document(path);
}

extension ProtoDocumentReference on $pb.DocumentReferenceProto {
  DocumentReference get ref => _check(path);
  Future<T> fetch<T extends FirestoreProto>(
          T Function(DocumentSnapshot s, BatchedTransaction) builder,
          BatchedTransaction transaction) async =>
      builder(await transaction.get(ref), transaction);
}

extension IterRefProto on Iterable<$pb.DocumentReferenceProto> {
  Future<List<T>> fetch<T extends FirestoreProto>(
          T Function(DocumentSnapshot s, BatchedTransaction) builder,
          BatchedTransaction transaction) async =>
      futureMap((x) => x.fetch(builder, transaction));
}

extension StringDocRef on String {
  DocumentReference get ref => _check(this);
  CollectionReference get coll => firestore.collection(this);
}

extension IsADoc on DocumentReference {
  bool isA(CollectionType type) => type.isA(this);
  CollectionType get collectionType =>
      $pb.enumFromString(parent.id, CollectionType.values);
  CollectionReference append(CollectionType type) => collection(type.path);
  Future<DocumentSnapshot> tGet(Transaction t) => t.get(this);
  $pb.DocumentReferenceProto get proto =>
      $pb.DocumentReferenceProto()..path = path;
}

extension ChangeExtension<T extends SnapshotHolder> on Change<T> {
  bool fieldsChanged(Set<String> fields) => _proxy.fieldsChanged(fields);
  Change<DocumentSnapshot> get _proxy =>
      Change(after.snapshot, before.snapshot);

  bool fieldChanged(String field) => fieldsChanged({field});
}

extension ChangeExtensionSnapshot<T extends DocumentSnapshot> on Change<T> {
  bool fieldsChanged(Set<String> fields) {
    return fields.any(fieldChanged);
  }

  bool fieldChanged(String field) =>
      !firestoreEquals(before.select(field), after.select(field));
}

extension DocumentSnapshotExtension on DocumentSnapshot {
  dynamic select(String field) => data.select(field);
}

extension StringKeyMap on Map<String, dynamic> {
  DocumentData get documentData => DocumentData.fromMap(this);
  UpdateData get updateData => fromNestedMap(this);
}

extension AlgIndex on $pb.AlgoliaIndex {
  AlgoliaIndexReference get ref => algolia.index(name);
}

extension LLGeoPoint on GeoPoint {
  Map<String, double> get algoliaLoc => {'lat': latitude, 'lng': longitude};
}

Timestamp tasteServerTimestamp() => Timestamp.fromDateTime(DateTime.now());

extension DocumentDataExtension on DocumentData {
  DocumentData get withExtras => DocumentData.fromMap(toMap()
    ..addAll({
      '_extras': {
        'created_at': tasteServerTimestamp(),
        'updated_at': tasteServerTimestamp(),
      }
    }));

  /// Select field in document by dot-delimited path, or null if absent.
  dynamic select(String path) {
    dynamic fn(Iterable<String> path, DocumentData value) => value == null
        ? null
        : path.length == 1
            ? value.toMap()[path.first]
            : fn(path.skip(1), value.getNestedData(path.first));
    return fn(path.split('.'), this);
  }
}

typedef SnapshotWrapper<T extends SnapshotHolder> = T Function(
    DocumentSnapshot s, BatchedTransaction t);

extension Wrap on QuerySnapshot {
  List<T> wrap<T extends SnapshotHolder>(
          SnapshotWrapper<T> fn, BatchedTransaction t) =>
      documents.map((d) => fn(d, t)).toList();
}

extension TimestampDateTime on DateTime {
  Timestamp get timestamp => Timestamp.fromDateTime(this);
}

extension QueryExt on DocumentQuery {
  Future<bool> get exists async => (await limit(1).get()).isNotEmpty;
}

extension FirePhotoExt on FirePhoto {
  Future<Photo> photo(BatchedTransaction t) async =>
      Photos.make(await photoReference.ref.tGet(t), t);
}

extension UserRecordExt on UserRecord {
  Future<DocumentReference> get reference async =>
      (await CollectionType.users.coll.where('uid', isEqualTo: uid).get())
          .documents
          .firstOrNull
          ?.reference;
}
