import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

class TasteBudGroup extends SnapshotHolder<$pb.TasteBudGroup> with UserOwned {
  TasteBudGroup(DocumentSnapshot snapshot) : super(snapshot);
}
