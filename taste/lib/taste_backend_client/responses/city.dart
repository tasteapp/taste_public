import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import '../../utils/extensions.dart';
import 'responses.dart';

class City extends SnapshotHolder<$pb.City> {
  City(DocumentSnapshot snapshot) : super(snapshot);

  String get city => proto.city;
  String get state => proto.state;
  String get country => proto.country;
  LatLng get location => proto.location.latLng;
  double get popularityScore => proto.popularityScore;
  String get displayName => cityDisplayName(proto);

  static String cityDisplayName($pb.City city) =>
      (city.country == 'United States'
              ? [
                  city.city,
                  city.state,
                ]
              : [
                  city.city ?? city.state,
                  city.country,
                ])
          .withoutEmpties
          .join(', ');
}
