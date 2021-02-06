import 'gen/firestore.pbenum.dart' show CollectionType;
import 'extensions.dart';
import 'gen/firestore.pb.dart' show UniqueUserIndex;

String indexReferencePath(
    {CollectionType root,
    String parentCollection,
    String parentId,
    String userId}) {
  assert([root, parentCollection, parentId, userId]
      .every((element) => element != null));
  return [
    CollectionType.index.name,
    root.name,
    'parent',
    parentCollection,
    'id',
    parentId,
    'user',
    userId
  ].join('/');
}

UniqueUserIndex uniqueUserRecord(String path) => {
      'reference': {'path': path}
    }.asProto(UniqueUserIndex());
