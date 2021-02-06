import 'package:taste_cloud_functions/taste_functions.dart';

typedef _Callback = void Function();

/// A transaction implementation which queues all modifications into a batch
/// and commits the batch at the end of the function's context.
///
/// This allows us to interleave gets and modifies without the transaction
/// complaining about mixing them.
///
/// This in turn allows better encapsulation of type functionality, without
/// having to worry if one type-wrapper makes modifications inside. The batch
/// will simply queue it and commit at the very end.
class BatchedTransaction implements Transaction {
  final Transaction _transaction;
  final _queue = <_Callback>[];
  final String eventId;

  BatchedTransaction(this._transaction, this.eventId);

  FutureOr commit() {
    _queue.forEach((cb) => cb());
  }

  @override
  FutureOr<DocumentReference> create(
      DocumentReference reference, DocumentData data) {
    _queue.add(() => _transaction.create(reference, data));
    return reference;
  }

  @override
  Future<DocumentSnapshot> get(DocumentReference reference) {
    return _transaction.get(reference);
  }

  @override
  Future<QuerySnapshot> getQuery(DocumentQuery query) {
    return _transaction.getQuery(query);
  }

  @override
  FutureOr<DocumentReference> set(
      DocumentReference reference, DocumentData data,
      {bool merge = false}) {
    _queue.add(() => _transaction.set(reference, data, merge: merge));
    return reference;
  }

  @override
  FutureOr<DocumentReference> update(
      DocumentReference reference, UpdateData data,
      {Timestamp lastUpdateTime}) async {
    if (data.isEmpty) {
      return reference;
    }
    _queue.add(() => _transaction.update(reference, data));
    return reference;
  }

  @override
  FutureOr<DocumentReference> delete(DocumentReference reference,
      {Timestamp lastUpdateTime}) {
    _queue.add(() => _transaction.delete(reference));
    return reference;
  }

  static Future<T> batchedTransaction<T>(
      String eventId, BatchedFn<T> fn) async {
    return await firestore.runTransaction((t) async {
      final batchedTransaction = BatchedTransaction(t, eventId);
      final returnValue = await fn(batchedTransaction);
      batchedTransaction.commit();
      return returnValue;
    });
  }

  @override
  JsTransaction get nativeInstance => throw UnimplementedError();

  Future<T> inner<T>(Future<T> Function(BatchedTransaction t) fn) =>
      batchedTransaction(eventId, fn);
}

typedef BatchedFn<T> = FutureOr<T> Function(BatchedTransaction t);
