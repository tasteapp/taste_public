import 'package:taste_cloud_functions/taste_functions.dart';

class SimpleSnapshot implements DocumentSnapshot {
  @override
  final DocumentData data;
  @override
  final DocumentReference reference;
  @override
  final bool exists = true;

  SimpleSnapshot(this.data, this.reference);

  @override
  Timestamp get createTime => throw UnimplementedError();

  @override
  String get documentID => throw UnimplementedError();

  @override
  Firestore get firestore => throw UnimplementedError();

  @override
  JsDocumentSnapshot get nativeInstance => throw UnimplementedError();

  @override
  Timestamp get updateTime => throw UnimplementedError();
}
