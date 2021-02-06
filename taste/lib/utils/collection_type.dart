import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste_protos/taste_protos.dart' show CollectionType;

export 'package:taste_protos/taste_protos.dart' show CollectionType;

extension ColType on CollectionType {
  String get path => name;
  bool isA(DocumentReference reference) =>
      reference.parent().path.endsWith(path);
  CollectionReference get coll => Firestore.instance.collection(path);
}
