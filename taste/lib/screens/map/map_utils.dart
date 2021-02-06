import 'dart:math';
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:s2geometry/s2geometry.dart';
import 'package:taste/screens/map/google_map_widget.dart';
import 'package:taste/utils/extensions.dart';
import 'package:vector_math/vector_math.dart';

double calculateZoomToFit(LatLngBounds bounds, Size mapSize) {
  const worldSize = Size(256, 256);

  double latRad(double lat) {
    double latSing = sin(radians(lat));
    var radX2 = log((1 + latSing) / (1 - latSing)) / 2;
    return max(min(radX2, pi), -pi) / 2;
  }

  double zoom(double mapPx, double worldPx, double fraction) =>
      log(mapPx / worldPx / fraction) / ln2;

  LatLng sw = bounds.southwest;
  LatLng ne = bounds.northeast;

  double latFraction = (latRad(ne.latitude) - latRad(sw.latitude)) / pi;

  double lngDiff = ne.longitude - sw.longitude;
  double lngFraction = (lngDiff < 0 ? lngDiff + 360 : lngDiff) / 360;

  double latZoom = zoom(mapSize.height, worldSize.height, latFraction);
  double lngZoom = zoom(mapSize.width, worldSize.width, lngFraction);

  double fitZoom = min(latZoom, lngZoom);
  // Add some padding, and ensure zoom is in reasonable range.
  return max(min(fitZoom - 0.6, GoogleMapWidget.INITIAL_ZOOM), 0.0);
}

LatLngBounds pointsBounds(Iterable<LatLng> latLngs, {LatLng center}) {
  final s2s = latLngs.map(toS2LatLng);
  if (center == null) {
    return toBounds(S2LatLngRect.fromPoints(s2s));
  }
  final s2Center = toS2LatLng(center);
  S2LatLng reflect(S2LatLng latLng) => s2Center * 2 - latLng;
  return toBounds(
      S2LatLngRect.fromPoints(s2s.toList()..addAll(s2s.map(reflect))));
}

double get earthRadiusMeters => 6371000.0;

// Returns the area of the bounding box in square meters.
double area(LatLngBounds bounds) =>
    toS2Rect(bounds).area * pow(earthRadiusMeters, 2);

LatLng center(LatLngBounds bounds) => toLatLng(toS2Rect(bounds).center);

S2LatLngRect toS2Rect(LatLngBounds bounds) {
  return S2LatLngRect.fromLoHi(
      lo: toS2LatLng(bounds.southwest), hi: toS2LatLng(bounds.northeast));
}

S2LatLng toS2LatLng(LatLng ll) =>
    S2LatLng.fromDegrees(ll.latitude, ll.longitude);

LatLngBounds toBounds(S2LatLngRect bounds) {
  if (bounds.isEmpty) {
    return LatLngBounds(
        southwest: const LatLng(0, 0), northeast: const LatLng(0, 0));
  }
  return LatLngBounds(
      southwest: toLatLng(bounds.lo), northeast: toLatLng(bounds.hi));
}

LatLng toLatLng(S2LatLng ll) => LatLng(ll.lat.degrees, ll.lng.degrees);

LatLngBounds expand(LatLngBounds latLngBounds, double expansionFactor) {
  final rect = toS2Rect(latLngBounds);
  final expanded = rect.expanded(rect.size * (expansionFactor - 1));
  return toBounds(expanded);
}

LatLngBounds latLngBounds(LatLng center, double radiusMeters) => LatLngBounds(
    southwest: computeOffset(center, radiusMeters * sqrt(2), 225),
    northeast: computeOffset(center, radiusMeters * sqrt(2), 45));

LatLng computeOffset(LatLng center, double radiusMeters, double heading) {
  var radius = radiusMeters / earthRadiusMeters;
  heading = radians(heading);
  // http://williams.best.vwh.net/avform.htm#LL
  double centerLat = radians(center.latitude);
  double centerLng = radians(center.longitude);
  double cosDistance = cos(radius);
  double sinDistance = sin(radius);
  double sinFromLat = sin(centerLat);
  double cosFromLat = cos(centerLat);
  double sinLat =
      cosDistance * sinFromLat + sinDistance * cosFromLat * cos(heading);
  double dLng = atan2(sinDistance * cosFromLat * sin(heading),
      cosDistance - sinFromLat * sinLat);
  return LatLng(degrees(asin(sinLat)), degrees(centerLng + dLng));
}

double heading(LatLng a, LatLng b) {
  final aLat = radians(a.latitude);
  final aLng = radians(a.longitude);
  final bLat = radians(b.latitude);
  final bLng = radians(b.longitude);
  double dLon = bLng - aLng;
  double y = sin(dLon) * cos(bLat);
  double x = cos(aLat) * sin(bLat) - sin(aLat) * cos(bLat) * cos(dLon);
  double brng = atan2(y, x);
  brng = degrees(brng);
  brng = (brng + 360) % 360;
  return brng;
}

LatLng fractionAlong(LatLng from, LatLng to, double fraction) =>
    computeOffset(from, from.distanceMeters(to) * fraction, heading(from, to));

// Returns the overlap of two LatLngBounds, or null if there is none.
LatLngBounds overlap(LatLngBounds a, LatLngBounds b) {
  final sw = a.southwest;
  final ne = a.northeast;
  final sw2 = b.southwest;
  final ne2 = b.northeast;
  final latOverlaps =
      (ne2.latitude > sw.latitude) && (sw2.latitude < ne.latitude);
  final lngOverlaps =
      (ne2.longitude > sw.longitude) && (sw2.longitude < ne.longitude);
  final overlaps = latOverlaps && lngOverlaps;
  if (!overlaps) {
    return null;
  }

  final latPoints = [sw.latitude, ne.latitude, sw2.latitude, ne2.latitude]
    ..sort();
  final lngPoints = [sw.longitude, ne.longitude, sw2.longitude, ne2.longitude]
    ..sort();
  return LatLngBounds(
      southwest: LatLng(latPoints[1], lngPoints[1]),
      northeast: LatLng(latPoints[2], lngPoints[2]));
}
