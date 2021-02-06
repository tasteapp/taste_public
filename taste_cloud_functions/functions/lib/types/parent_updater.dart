import 'package:taste_cloud_functions/taste_functions.dart';

mixin ParentUpdater implements SnapshotHolder {
  Future updateParents() async =>
      (await allSnapshotsToUpdate).futureMap((s) => s.forceUpdate());

  Future<Iterable<DocumentReference>> get referencesToUpdate;

  Future<List<SnapshotHolder>> get allSnapshotsToUpdate async {
    return (await (await referencesToUpdate).futureMap((parent) async =>
            SnapshotHolder(
                await getRef(parent), transaction, parent.collectionType,
                checkExists: false)))
        .where((s) => s.exists)
        .toList();
  }
}
