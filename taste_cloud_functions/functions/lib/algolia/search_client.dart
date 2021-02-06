import 'package:algolia/algolia.dart';

class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);
}

class LatLngBounds {
  final LatLng southwest;
  final LatLng northeast;

  LatLngBounds(this.southwest, this.northeast);
}

Future<List<AlgoliaObjectSnapshot>> searchAlgolia(
    {String term,
    LatLngBounds bounds,
    LatLng location,
    Set<String> tags,
    AlgoliaIndexReference index}) async {
  AlgoliaQuery query = index;
  if (location != null) {
    query = query.setAroundLatLng('${location.latitude},${location.longitude}');
    if (bounds == null) {
      query = query.setAroundRadius('all');
    }
  }
  if (bounds != null) {
    query = query.setInsideBoundingBox(toBoxes(bounds));
  }
  query = query.setHitsPerPage(300);
  if (term != null) {
    query = query.search(term);
  }
  for (final tag in (tags ?? <String>{})) {
    query = query.setTagFilter(tag);
  }
  final result = await query.getObjects();
  return result.hits;
}

List<BoundingBox> toBoxes(LatLngBounds bounds) {
  if (bounds.southwest.longitude <= bounds.northeast.longitude) {
    return [
      BoundingBox(
          p1Lat: bounds.northeast.latitude,
          p2Lat: bounds.southwest.latitude,
          p1Lng: bounds.southwest.longitude,
          p2Lng: bounds.northeast.longitude)
    ];
  }
  return [
    BoundingBox(
        p1Lat: bounds.northeast.latitude,
        p2Lat: bounds.southwest.latitude,
        p1Lng: bounds.southwest.longitude,
        p2Lng: 180),
    BoundingBox(
        p1Lat: bounds.northeast.latitude,
        p2Lat: bounds.southwest.latitude,
        p1Lng: -180,
        p2Lng: bounds.northeast.longitude)
  ];
}
