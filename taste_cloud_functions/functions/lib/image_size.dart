import 'package:node_interop/node.dart';
import 'package:node_interop/util.dart';

import 'taste_functions.dart';

final _r = require('image-size');

class ImageSize {
  const ImageSize._(this.width, this.height);
  final int width;
  final int height;
}

Future<ImageSize> imageSize(List<int> bytes) async {
  if (buildType.isTest) {
    return _testSize;
  }
  final x = Map.from(dartify(_r(Buffer.from(bytes))));
  return ImageSize._(x['width'] as int, x['height'] as int);
}

const _testSize = ImageSize._(800, 600);
