import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

@immutable
class BoundingBox {
  const BoundingBox(this.lo, this.hi);
  final LatLng lo;
  final LatLng hi;
}
