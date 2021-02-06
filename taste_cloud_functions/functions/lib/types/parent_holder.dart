import 'package:taste_cloud_functions/taste_functions.dart';

mixin ParentHolder on SnapshotHolder {
  String get parentField => 'parent';
  DocumentReference get parent => data.getReference(parentField);

  Future updateParent(DocumentReference ref) => updateSelf({parentField: ref});
}
