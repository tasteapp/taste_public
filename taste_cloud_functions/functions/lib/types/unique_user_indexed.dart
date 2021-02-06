import 'package:taste_cloud_functions/taste_functions.dart';

mixin UniqueUserIndexed on ParentHolder, UserOwned implements SnapshotHolder {
  DocumentReference get userIndexReference => indexReferencePath(
          root: type,
          parentId: parent.documentID,
          parentCollection: parent.parent.id,
          userId: userReference.documentID)
      .ref;
  Future get ensureIndexCreated =>
      BatchedTransaction.batchedTransaction('ensure-index-created', (t) async {
        final retrieve = await t.get(userIndexReference);
        if (retrieve.exists) {
          return;
        }
        await t.set(
            retrieve.reference, uniqueUserRecord(path).asMap.documentData);
      });
  Future get ensureIndexDeleted =>
      BatchedTransaction.batchedTransaction('ensure-index-deleted', (t) async {
        final retrieve = await t.get(userIndexReference);
        if (retrieve.exists) {
          await t.delete(retrieve.reference);
        }
      });
}
