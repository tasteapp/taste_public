import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'responses.dart';

class Follower extends SnapshotHolder<$pb.Follower> with UserOwned {
  Follower(DocumentSnapshot snapshot) : super(snapshot);
  @override
  String get userField => 'follower';
}
