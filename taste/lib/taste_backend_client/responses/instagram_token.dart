import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'responses.dart';

class InstagramToken extends SnapshotHolder<$pb.InstagramToken> {
  InstagramToken(DocumentSnapshot snapshot) : super(snapshot);

  $pb.DocumentReferenceProto get user => proto.user;
  String get token => proto.token;
  $pb.InstagramToken_ImportStatus get status => proto.importStatus;
  bool get hasLastUpdate => proto.hasLastUpdate();
  $pb.Timestamp get lastUpdate => proto.lastUpdate;
}
