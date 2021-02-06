import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'responses.dart';

class DailyTastyVote extends SnapshotHolder<$pb.DailyTastyVote> with UserOwned {
  DailyTastyVote(DocumentSnapshot s) : super(s);
  DocumentReference get post => proto.post.ref;
  double get score => proto.score;
}
