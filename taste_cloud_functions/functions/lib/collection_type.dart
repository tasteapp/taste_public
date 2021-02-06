import 'package:taste_cloud_functions/taste_functions.dart';

extension ColType on CollectionType {
  String get path => name;
  bool isA(DocumentReference reference) => reference.parent.path.endsWith(path);
  CollectionReference get coll => firestore.collection(path);
  DocumentQuery get collGroup => firestore.collectionGroup(path);
}
