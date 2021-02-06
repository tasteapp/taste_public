import 'package:taste_cloud_functions/taste_functions.dart';

mixin Likeable implements SnapshotHolder {
  DocumentQuery get likesQuery =>
      CollectionType.likes.coll.where('parent', isEqualTo: ref);
  Future<List<Like>> get likes => wrapQuery(likesQuery, Likes.make);
  Future<Like> userLike(TasteUser user) async {
    final results = await transaction.getQuery(
        likesQuery.where('user', isEqualTo: user.ref).select([]).limit(1));
    if (results.isEmpty) {
      return null;
    }
    return Likes.make(results.documents.first, transaction);
  }

  Future<Like> like(TasteUser user, bool enable) async => Likes.make(
      await transaction.get(await toggleUnique(
          type: CollectionType.likes,
          parent: ref,
          user: user.ref,
          enable: enable)),
      transaction,
      enable);
}
