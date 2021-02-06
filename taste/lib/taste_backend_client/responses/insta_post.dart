import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'responses.dart';

class InstaPost extends SnapshotHolder<$pb.InstaPost> {
  InstaPost(DocumentSnapshot snapshot) : super(snapshot);
}
