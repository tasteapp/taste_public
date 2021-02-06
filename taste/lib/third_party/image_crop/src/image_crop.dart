part of image_crop;

@immutable
class ImageOptions {
  const ImageOptions({@required this.width, @required this.height})
      : assert(width != null),
        assert(height != null);
  final int width;
  final int height;

  @override
  int get hashCode => hashValues(width, height);

  @override
  bool operator ==(other) {
    return other is ImageOptions &&
        other.width == width &&
        other.height == height;
  }

  @override
  String toString() {
    return '$runtimeType(width: $width, height: $height)';
  }
}

class ImageCrop {
  static const _channel = MethodChannel('plugins.lykhonis.com/image_crop');

  static Future<bool> requestPermissions() {
    return _channel
        .invokeMethod('requestPermissions')
        .then<bool>((result) => result as bool);
  }

  static Future<ImageOptions> getImageOptions({@required File file}) async {
    assert(file != null);
    final result =
        await _channel.invokeMethod('getImageOptions', {'path': file.path});
    return ImageOptions(
      width: result['width'] as int,
      height: result['height'] as int,
    );
  }

  static Future<File> cropImage({
    @required File file,
    @required Rect area,
    double scale,
  }) {
    assert(file != null);
    assert(area != null);
    return _channel.invokeMethod('cropImage', {
      'path': file.path,
      'left': area.left,
      'top': area.top,
      'right': area.right,
      'bottom': area.bottom,
      'scale': scale ?? 1.0,
    }).then<File>((result) => File(result as String));
  }

  static Future<File> sampleImage({
    @required File file,
    int preferredSize,
    int preferredWidth,
    int preferredHeight,
  }) async {
    assert(file != null);
    assert(() {
      if (preferredSize == null &&
          (preferredWidth == null || preferredHeight == null)) {
        throw ArgumentError(
            'Preferred size or both width and height of a resampled image must be specified.');
      }
      return true;
    }());
    final String path = await _channel.invokeMethod('sampleImage', {
      'path': file.path,
      'maximumWidth': preferredSize ?? preferredWidth,
      'maximumHeight': preferredSize ?? preferredHeight,
    });
    return File(path);
  }
}
