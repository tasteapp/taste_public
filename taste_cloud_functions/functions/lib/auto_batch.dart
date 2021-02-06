import 'package:quiver/iterables.dart' as quiver;
import 'package:taste_cloud_functions/taste_functions.dart';

const _batchSize = 500;

class _BatchBackedTransaction implements BatchedTransaction {
  final ops = [];
  @override
  final String eventId;
  _BatchBackedTransaction._(this.eventId);

  @override
  Future<T> inner<T>(Future<T> Function(BatchedTransaction t) fn) =>
      autoBatch(fn, eventId: eventId, dryRun: false);

  @override
  FutureOr<DocumentReference> update(
      DocumentReference reference, UpdateData data,
      {Timestamp lastUpdateTime}) {
    _add((batch) => batch.updateData(reference, data));
    return reference;
  }

  @override
  FutureOr<DocumentReference> delete(DocumentReference reference,
      {Timestamp lastUpdateTime}) {
    _add((batch) => batch.delete(reference));
    return reference;
  }

  @override
  FutureOr<DocumentReference> set(
      DocumentReference reference, DocumentData data,
      {bool merge = false}) {
    _add((batch) => batch.setData(
        reference, data, merge == null ? null : SetOptions(merge: merge)));
    return reference;
  }

  void _add(void Function(WriteBatch batch) fn) async {
    ops.add(fn);
  }

  @override
  Future commit() async {
    if (ops.isEmpty) {
      return;
    }
    await quiver.partition(ops, _batchSize).futureMap((ops) async {
      final batch = firestore.batch();
      ops.forEach((op) => op(batch));
      await batch.commit();
    });
    ops.clear();
  }

  @override
  FutureOr<DocumentReference> create(
          DocumentReference reference, DocumentData data) =>
      set(reference, data);

  @override
  Future<DocumentSnapshot> get(DocumentReference reference) => reference.get();

  @override
  Future<QuerySnapshot> getQuery(DocumentQuery query) => query.get();

  @override
  JsTransaction get nativeInstance => throw UnimplementedError();
}

/// Performs read-transactions immediately without transactional safety, and
/// batches all writes to the very end, where the write operations are batched
/// themselves into chunks of 500 in order to not go over the batch limit.
///
/// Note: This does not provide any read-consistency guarantees, and is simply
/// an optimization mechanism to batch all writes to the end.
Future<T> autoBatch<T>(FutureOr<T> Function(BatchedTransaction batch) fn,
    {String eventId, bool dryRun = false}) async {
  if (dryRun) {
    return fn(_DryRunTransaction(eventId));
  }
  final transaction = _BatchBackedTransaction._(eventId);
  final value = await fn(transaction);
  await transaction.commit();
  return value;
}

class _DryRunTransaction implements BatchedTransaction {
  const _DryRunTransaction([this.eventId = 'dry-run']);

  @override
  Future<T> inner<T>(Future<T> Function(BatchedTransaction t) fn) =>
      autoBatch(fn, eventId: eventId, dryRun: true);

  DocumentReference _log(
    String operation,
    DocumentReference ref, [
    Map<String, dynamic> data,
  ]) {
    print(const JsonEncoder.withIndent('  ').convert(
      {
        'operation': operation,
        'path': ref.path,
        'data': data?.asJson,
      }.withoutNulls,
    ));
    structuredLog(
      'dry_run',
      eventId,
      operation,
      {
        'operation': operation,
        'path': ref.path,
        'data': data?.asJson,
      }.withoutNulls,
    );

    return ref;
  }

  @override
  FutureOr<DocumentReference> update(
    DocumentReference reference,
    UpdateData data, {
    Timestamp lastUpdateTime,
  }) =>
      _log('update', reference, data.toMap());

  @override
  FutureOr<DocumentReference> delete(
    DocumentReference reference, {
    Timestamp lastUpdateTime,
  }) =>
      _log('delete', reference);

  @override
  FutureOr<DocumentReference> set(
    DocumentReference reference,
    DocumentData data, {
    bool merge = false,
  }) =>
      _log('set', reference, data.toMap());

  @override
  Future commit() async {}

  @override
  FutureOr<DocumentReference> create(
    DocumentReference reference,
    DocumentData data,
  ) =>
      _log('create', reference, data.toMap());

  @override
  Future<DocumentSnapshot> get(DocumentReference reference) => reference.get();

  @override
  Future<QuerySnapshot> getQuery(DocumentQuery query) => query.get();

  @override
  JsTransaction get nativeInstance => throw UnimplementedError();

  @override
  final String eventId;
}
