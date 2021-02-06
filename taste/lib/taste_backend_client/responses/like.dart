import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'responses.dart';

class Like extends SnapshotHolder<$pb.Like> with UserOwned, ParentHolder {
  Like(DocumentSnapshot snapshot) : super(snapshot);
}
