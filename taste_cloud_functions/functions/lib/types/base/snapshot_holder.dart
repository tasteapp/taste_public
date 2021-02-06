import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

class MissingReference implements Exception {
  final DocumentReference reference;

  MissingReference(this.reference);

  @override
  String toString() => 'Missing Reference: ${reference.path}';
}

class SnapshotHolder with TransactionHolder, Memoizer, EquatableMixin {
  final DocumentSnapshot snapshot;
  @override
  final BatchedTransaction transaction;
  final CollectionType type;
  final bool checkExists;
  DocumentData get data => snapshot.data;
  DocumentReference get ref => snapshot.reference;

  SnapshotHolder(this.snapshot, this.transaction, this.type,
      {this.checkExists = true}) {
    if (!type.isA(ref)) {
      throw CloudFnException(
          'Expected type ${type.path}, got ${ref.parent.id}');
    }
    if (checkExists && !snapshot.exists) {
      throw MissingReference(ref);
    }
  }

  Map<String, dynamic> diffUpdate(Map<String, dynamic> update) {
    Iterable<MapEntry<List<String>, dynamic>> flatten(
            List<String> path, dynamic value) =>
        value is! Map
            ? [MapEntry(path, value)]
            : Map<String, dynamic>.from(value as Map)
                .entries
                .expand((e) => flatten(List.from(path)..add(e.key), e.value));
    final otherMap = data.toMap();
    final entries =
        update.entries.expand((e) => flatten([e.key], e.value)).where((e) {
      final path = e.key;
      final value = e.value;
      dynamic other = otherMap;
      for (final component in path) {
        if (other == null || other is! Map) {
          return true;
        }
        other = other[component];
      }
      return !firestoreEquals(value, other);
    });
    final result = <String, dynamic>{};
    entries.forEach((e) {
      final path = e.key;
      final value = e.value;
      dynamic spot = result;
      (List.from(path)..removeLast())
          .forEach((c) => spot = spot.putIfAbsent(c, () => {}));
      spot[List.from(path).removeLast()] = value;
    });
    return result;
  }

  Future<Map<String, dynamic>> updateSelf(Map<String, dynamic> data,
      {bool changeUpdatedAt = true, bool validate = false}) async {
    if (validate) {
      if (this is! FirestoreProto) {
        throw Exception('Only FirestoreProto is supported for validate');
      }
      final transformed = data.ensureAs((this as FirestoreProto).prototype);
      if (!deepEquals(data, transformed)) {
        throw CloudFnException(
            'Update does not validate: $data vs. transformed $transformed');
      }
    }
    final diffUpdate = this.diffUpdate(data);
    if (diffUpdate.isEmpty) {
      return data;
    }
    final updateData = fromNestedMap(diffUpdate);
    if (changeUpdatedAt) {
      updateData.setTimestamp('_extras.updated_at', tasteServerTimestamp());
    }
    await transaction.update(firestore.document(ref.path), updateData);
    return data;
  }

  bool get exists => snapshot.exists;
  String get path => ref?.path;
  Timestamp get createdAt =>
      data.getNestedData('_extras')?.getTimestamp('created_at');
  Timestamp get updatedAt =>
      data.getNestedData('_extras')?.getTimestamp('updated_at');

  FutureOr<DocumentReference> create(
          DocumentReference reference, DocumentData data) =>
      transaction.create(reference, data.withExtras);
  FutureOr<DocumentReference> addToCollection(
          CollectionReference collection, DocumentData data) =>
      transaction.create(collection.document(), data.withExtras);

  Future<DocumentReference> deleteSelf() async {
    await transaction.delete(ref);
    return ref;
  }

  Future deleteDynamic(dynamic x) async {
    if (x == null) {
      await structuredLog('delete_dynamic', transaction.eventId ?? 'event-id',
          'delete_dynamic', {'failure': null, 'reference': path});
      return;
    }
    if (x is Future) {
      return await deleteDynamic(await x);
    }
    if (x is DocumentQuery) {
      return await deleteDynamic(await transaction.getQuery(x));
    }
    if (x is QuerySnapshot) {
      return await deleteDynamic(x.documents);
    }
    if (x is DocumentReference) {
      return await transaction.delete(x);
    }
    if (x is DocumentSnapshot) {
      return await transaction.delete(x.reference);
    }
    if (x is SnapshotHolder) {
      return await x.deleteSelf();
    }
    if (x is Iterable) {
      return x.futureMap(deleteDynamic);
    }
    throw Exception(
        'Could not figure out delete operation for type ${x.runtimeType}');
  }

  Future forceUpdate() =>
      updateSelf({'_force_update': Firestore.fieldValues.increment(1)},
          changeUpdatedAt: false);

  @override
  List<Object> get props => [ref];

  @override
  String toString() {
    return [ref, data.toMap()].toString();
  }

  /// Returns a list of [SnapshotHolder], one constructed for each document
  /// returned from the provided query.
  ///
  /// This pattern is pervasive across most [SnapshotHolder] types, so we
  /// consolidate the logic and reduce duplication w/ this helper method.
  Future<List<T>> wrapQuery<T extends SnapshotHolder>(
          DocumentQuery query,
          T Function(DocumentSnapshot snapshot, BatchedTransaction transaction)
              create) async =>
      wrapQueryStatic(query, transaction, create);

  static Future<List<T>> wrapQueryStatic<T extends SnapshotHolder>(
          DocumentQuery query,
          BatchedTransaction transaction,
          T Function(DocumentSnapshot snapshot, BatchedTransaction transaction)
              create) async =>
      (await transaction.getQuery(query))
          .documents
          .map((d) => create(d, transaction))
          .toList(growable: false);

  Future<bool> queryExists(DocumentQuery query) async =>
      (await existingDocument(query)) != null;
  Future<DocumentSnapshot> existingDocument(DocumentQuery query) async =>
      (await transaction.getQuery(query.limit(1))).documents.firstOrNull;
  Future<DocumentReference> toggleUnique(
      {@required CollectionType type,
      @required DocumentReference parent,
      @required DocumentReference user,
      String parentField = 'parent',
      String userField = 'user',
      @required bool enable}) async {
    final existing = await existingDocument(type.coll
        .where(parentField, isEqualTo: parent)
        .where(userField, isEqualTo: user));
    if (enable ^ (existing == null)) {
      throw ArgumentError('already enabled or already disabled');
    }
    final reference = enable ? type.coll.document() : existing.reference;
    await (enable
        ? create(reference, {parentField: parent, userField: user}.documentData)
        : transaction.delete(reference));
    return reference;
  }

  Future<T> withTransaction<T>(
          FutureOr<T> Function(BatchedTransaction transaction) fn) =>
      BatchedTransaction.batchedTransaction('withTransaction', (t) async {
        // guard against modifications to itself within the context of this transaction
        await t.get(ref);
        return fn(t);
      });

  Future deleteLinkedNotifications() => deleteDynamic(TasteNotifications.get(
      trans: transaction,
      queryFn: (q) => q.where('document_link', isEqualTo: ref)));

  Future<List<T>> wrap<T>(
          List<DocumentReference> refs,
          T Function(DocumentSnapshot snapshot, BatchedTransaction transaction)
              fn) async =>
      (await refs.futureMap(getRef)).listMap((s) => fn(s, transaction));
  Future<List<T>> protoWrap<T>(
          List<$pb.DocumentReferenceProto> refs,
          T Function(DocumentSnapshot snapshot, BatchedTransaction transaction)
              fn) =>
      wrap(refs.listMap((r) => r.ref), fn);
}
