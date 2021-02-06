import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'responses.dart';

class InstagramLocation extends SnapshotHolder<$pb.InstagramLocation> {
  InstagramLocation(DocumentSnapshot snapshot) : super(snapshot);

  String get id => proto.id;
  String get name => proto.name;
  $pb.LatLng get latLng => proto.location;
}
