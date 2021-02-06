import 'package:taste_cloud_functions/taste_functions.dart';

mixin SpatialIndexed {
  GeoPoint get indexLocation;
  SpatialIndex get spatialIndex {
    return getSpatialIndex(indexLocation);
  }
}

SpatialIndex getSpatialIndex(GeoPoint point) {
  if (point == null) {
    return null;
  }
  final tiles = tile(point.latitude, point.longitude);
  return {
    'cell_id': tiles.last.token,
    'levels': tiles.map((e) => e.token).toList(),
  }.asProto(SpatialIndex());
}
