import 'package:node_interop/node.dart';
import 'package:node_interop/util.dart';

class Tile {
  const Tile(this.x, this.y, this.z);
  final int x;
  final int y;
  final int z;
  String get token => [x, y, z].join(',');

  @override
  String toString() => token;
}

final _tiles = require('web-mercator-tiles');
final _mercator = callConstructor(require('@mapbox/sphericalmercator'), []);

List<Tile> tile(double lat, double lng) {
  final xy = List.from(dartify(callMethod(_mercator, 'forward', [
    jsify([lng, lat])
  ])));
  final x = xy[0];
  final y = xy[1];
  final extents = jsify({
    'left': x,
    'bottom': y,
    'right': x,
    'top': y,
  });
  return Iterable.generate(21, (zoom) => List.from(_tiles(extents, zoom)).first)
      .map(dartify)
      .map((e) => Tile(e['X'], e['Y'], e['Z']))
      .toList();
}
