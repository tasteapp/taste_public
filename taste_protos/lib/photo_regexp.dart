import 'extensions.dart';

// Here's the pattern:
// <_base>/<timestamp-micros-or-millis>[.optional-int-suffix]/.(jpg,jpeg,png)
final _photoStorageRegexp = RegExp(r'^(.*)/(\d{13,21}(\.\d+)?)\.(jpe?g|png)$');

enum Resolution { thumbnail, medium, full }

const photoUploadSize = 1000;

final _size = {
  Resolution.full: 900,
  Resolution.medium: 600,
  Resolution.thumbnail: 200,
};

extension ResolutionExtension on Resolution {
  int get size => _size[this];
}

List<String> allPhotoPaths(String path) {
  final parsed = PhotoStoragePath.tryParse(path);
  if (parsed == null) {
    return [];
  }
  return Resolution.values.listMap(parsed.forResolution);
}

mixin PhotoStoragePath {
  String forResolution(Resolution resolution);
  static PhotoStoragePath tryParse(String path) {
    if (path.startsWith('http')) {
      return _SingleResPath(path);
    }
    final match = _photoStorageRegexp.firstMatch(path);
    if (match == null) {
      return _SingleResPath(path);
    }
    return _PhotoStoragePath._(
        match.group(1), match.group(2), match.group(4), path);
  }

  bool get isFixed => this is _SingleResPath;
}

class _SingleResPath with PhotoStoragePath {
  _SingleResPath(this.path);
  final String path;
  @override
  String forResolution(Resolution resolution) => path;
}

class _PhotoStoragePath with PhotoStoragePath {
  _PhotoStoragePath._(this._base, this._filename, this._filetype, this._full);
  final String _base;
  final String _filename;
  final String _filetype;
  final String _full;
  @override
  String forResolution(Resolution resolution) {
    if (resolution == Resolution.full || resolution == null) {
      return _full;
    }
    final size = _size[resolution];
    return '$_base/thumbnails/${_filename}_${size}x$size.$_filetype';
  }
}
