import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'responses.dart';

class Contest extends SnapshotHolder<$pb.Contest> {
  Contest(DocumentSnapshot snapshot) : super(snapshot);

  $pb.Contest_ContestType get contestType => proto.contestType;

  String get short => proto.description;
  bool get isHomeCooking =>
      contestType == $pb.Contest_ContestType.contest_type_home_cooking;
  bool get isRestaurant =>
      contestType == $pb.Contest_ContestType.contest_type_local_restaurants;
}
