import 'package:taste_cloud_functions/taste_functions.dart';

abstract class FirestoreProto<T extends GeneratedMessage>
    extends SnapshotHolder {
  T get prototype;
  T get newProto => prototype.createEmptyInstance() as T;
  T get proto => memoize<T>(() => snapshot.data.asProto(newProto), 'proto');
  Future<FirestoreProto<T>> get refetchInternal;

  FirestoreProto(DocumentSnapshot snapshot, BatchedTransaction transaction,
      CollectionType type,
      {bool checkExists = true})
      : super(snapshot, transaction, type, checkExists: checkExists);
}
