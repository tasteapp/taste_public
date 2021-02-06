import 'dart:math';

double _degreesToRadians(double x) => x * pi / 180;

class MercatorPoint {
  const MercatorPoint(this.x, this.y);

  final double x;
  final double y;

  @override
  String toString() => '$x,$y';
}

const _kEarthRadiusMeters = 6378137.0;
const _kMetersPerMile = 1609.34;
const _kResolutions = [
  156543.03392804097,
  78271.51696402048,
  39135.75848201024,
  19567.87924100512,
  9783.93962050256,
  4891.96981025128,
  2445.98490512564,
  1222.99245256282,
  611.49622628141,
  305.748113140705,
  152.8740565703525,
  76.43702828517625,
  38.21851414258813,
  19.109257071294063,
  9.554628535647032,
  4.777314267823516,
  2.388657133911758,
  1.194328566955879,
  0.5971642834779395,
  0.29858214173896974,
  0.14929107086948487,
  0.07464553543474244,
  0.03732276771737122,
  0.01866138385868561
];
const _kTileSize = 256;

class Tile {
  const Tile(this.x, this.y, this.z);
  final int x;
  final int y;
  final int z;
  String get token => [x, y, z].join(',');

  @override
  String toString() => token;
}

class ProjectionExtents {
  static final min = -20037508.342789244;
  static final max = 20037508.342789244;
}

class WebMercatorTiles {
  static MercatorPoint latLngToMercator(double lat, double lng) {
    return latLngRadsToMercator(_degreesToRadians(lat), _degreesToRadians(lng));
  }

  static MercatorPoint latLngRadsToMercator(double latRad, double lngRad) {
    final x = _kEarthRadiusMeters * lngRad;
    final y = _kEarthRadiusMeters * log(tan((pi * 0.25) + (0.5 * latRad)));
    return MercatorPoint(x.clamp(ProjectionExtents.min, ProjectionExtents.max),
        y.clamp(ProjectionExtents.min, ProjectionExtents.max));
  }

  static List<Tile> getTiles(
      double lat, double lng, double radiusMiles, int zoom) {
    final latRad = _degreesToRadians(lat);
    final lngRad = _degreesToRadians(lng);
    // Distance
    final angle = radiusMiles * _kMetersPerMile / _kEarthRadiusMeters;

    // Get the bounds.
    final minLatRad = latRad - angle;
    final maxLatRad = latRad + angle;
    final latTRad = asin(sin(latRad) / cos(angle));
    final deltaLng = asin(sin(angle) / cos(latTRad));
    final minLngRad = lngRad - deltaLng;
    final maxLngRad = lngRad + deltaLng;

    // Get tile boundaries.
    final bottomLeftMercator = latLngRadsToMercator(minLatRad, minLngRad);
    final topRightMercator = latLngRadsToMercator(maxLatRad, maxLngRad);
    final lx =
        ((bottomLeftMercator.x - ProjectionExtents.min) / _kResolutions[zoom])
            .floor();
    final rx =
        ((topRightMercator.x - ProjectionExtents.min) / _kResolutions[zoom])
            .floor();
    final by =
        ((ProjectionExtents.max - bottomLeftMercator.y) / _kResolutions[zoom])
            .floor();
    final ty =
        ((ProjectionExtents.max - topRightMercator.y) / _kResolutions[zoom])
            .floor();
    final lX = (lx / _kTileSize).floor();
    final rX = (rx / _kTileSize).floor();
    final bY = (by / _kTileSize).floor();
    final tY = (ty / _kTileSize).floor();
    final tiles = <Tile>[];
    for (var i = lX; i <= rX; i++) {
      for (var j = tY; j <= bY; j++) {
        tiles.add(Tile(i, j, zoom));
      }
    }
    return tiles;
  }
}

void main(List<String> arguments) {
  print(WebMercatorTiles.getTiles(37.718590, -122.431642, 1, 14));
}
