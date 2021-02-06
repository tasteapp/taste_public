import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'responses.dart';

class Report extends SnapshotHolder<$pb.Report> {
  Report._(DocumentSnapshot snapshot) : super(snapshot);
}
