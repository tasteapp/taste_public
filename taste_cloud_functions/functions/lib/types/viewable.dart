import 'package:taste_cloud_functions/taste_functions.dart';

mixin Viewable implements SnapshotHolder {
  DocumentQuery get viewsQuery =>
      Views.collection.where('parent', isEqualTo: ref);
  Future<List<View>> get views async => (await transaction.getQuery(viewsQuery))
      .documents
      .map((d) => Views.make(d, transaction))
      .toList(growable: false);

  Future<DocumentReference> createView(TasteUser user) async {
    return addToCollection(Views.collection,
        DocumentData.fromMap({'user': user.ref, 'parent': ref}));
  }
}
