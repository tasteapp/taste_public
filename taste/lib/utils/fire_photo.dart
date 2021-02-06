import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart'
    hide FirePhotoExt;
import 'package:taste_protos/taste_protos.dart'
    show
        FirePhoto,
        PhotoStoragePath,
        ResolutionExtension,
        DocumentReferenceProto;

import '../app_config.dart';
import 'extensions.dart';

export 'package:taste_protos/taste_protos.dart' show FirePhoto, Resolution;

extension FirePhotoExt on FirePhoto {
  double get aspect => (1.0 * height) / (max(width, 1));
  int get height => photoSize.height;
  int get width => photoSize.width;
  Stream<File> file(Resolution res) => DefaultCacheManager()
      .getFileStream(url(res))
      .whereType<FileInfo>()
      .map((f) => f.file);
  Widget thumbnail(BoxFit fit) => progressive(
        Resolution.thumbnail,
        null,
        fit,
      );
  bool get isFixed => !_isEmpty && _regexp.isFixed;
  // This can be removed once all client caches are cleared.
  bool get _onlyReference =>
      _isEmpty && !isFixed && (photoReference.exists ?? false);
  String url(Resolution resolution) => isFixed
      ? firebaseStorage
      : _isEmpty
          ? null
          : 'https://storage.googleapis.com/${isDev ? 'FIREBASE_DEV_PROJECT' : 'FIREBASE_PROD_PROJECT'}.appspot.com/${_regexp.forResolution(resolution)}';
  Widget progressive(Resolution highRes, Resolution lowRes, BoxFit fit,
      {double height, double width}) {
    final bottom = Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Image.asset(
        'assets/ui/taste_watermark_2.png',
        width: width == null ? null : width * 0.4,
        height: height == null ? null : height * 0.4,
        fit: BoxFit.contain,
      ),
    );
    if (_onlyReference) {
      // Missing the photo details, so pull the full-photo,
      // then recursively call this same method with the full details.
      return Builder(
        builder: (context) => FutureBuilder<Photo>(
          future: photoReference.ref.fetch(),
          builder: (context, snapshot) =>
              snapshot.data?.firePhoto?.progressive(highRes, lowRes, fit,
                  width: width, height: height) ??
              bottom,
        ),
      );
    }

    final alignment = fit == BoxFit.contain || !specifiesCenter
        ? const Alignment(0, 0)
        // Convert from [0,1] range to [-1,1] range.
        : Alignment(2 * center.x - 1, 2 * center.y - 1);

    /// We have a three-tiered loader: high-res, low-res, and placeholder (i.e. bottom).
    /// Thus we construct the widget recursively: (high -> (low -> bottom)).
    /// If [first] is null, then [bottom] is returned immediately.
    /// Otherwise, [first] is the main image, and the placeholder is recursively created
    /// by calling this method again with arguments [second, null].
    /// It's easy to see that eventually the recursive call will terminate with the [null]
    /// value taking the [first] position.
    ///
    /// Additionally, we see that [lowRes] can be null, as it just terminates the recursive
    /// call quicker.
    Widget helper(Resolution first, Resolution second) =>
        first == null || _isEmpty
            ? bottom
            : CachedNetworkImage(
                alignment: alignment,
                imageUrl: url(first),
                placeholder: (_, __) => helper(second, null),
                height: height,
                width: width,
                // Derive the memory footprint from the image resolution
                memCacheWidth: first.size,
                fadeInDuration: first == highRes && lowRes != null
                    // If this transition is not 0 for the top of the stack, then there's an ugly fade effect.
                    ? const Duration()
                    : const Duration(milliseconds: 800),
                fit: fit,
              );
    return helper(highRes, lowRes);
  }

  // In case x,y accidentally both got set to 0 explicitly.
  bool get specifiesCenter =>
      hasCenter() && [center.x.abs(), center.y.abs()].sum > 0;

  bool get _isEmpty => firebaseStorage?.isEmpty ?? true;
  PhotoStoragePath get _regexp => PhotoStoragePath.tryParse(firebaseStorage);
}

FirePhoto fixedFirePhoto(String s) => FirePhoto()..firebaseStorage = s ?? '';
FirePhoto referenceOnlyFirePhoto(DocumentReferenceProto ref) =>
    FirePhoto()..photoReference = ref;
final emptyFirePhoto = FirePhoto();
