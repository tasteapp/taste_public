import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pedantic/pedantic.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taste/components/icons.dart';
import 'package:taste/screens/create_review/create_review_background.dart';
import 'package:taste/screens/create_review/get_photo_location.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/buttons.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/photo_regexp.dart';

import 'review/create_review.dart';

final _buttonOptions = kDefaultButtonOptions.copyWith(
  height: 55.0,
  width: 180.0,
  color: const Color(0xFF608154),
  textColor: Colors.white,
  fontSize: 18.0,
  iconPadding: const EdgeInsets.only(right: 4.0),
  fontWeight: FontWeight.w600,
  padding: EdgeInsets.zero,
);

class TakePhotoPage extends StatelessWidget {
  const TakePhotoPage();
  @override
  Widget build(BuildContext context) => Scaffold(
          body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            CreateReviewBackground(),
            Align(
              alignment: const Alignment(0.0, -0.6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Share Your Taste",
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        color: kDarkGrey,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 11.0),
                  const Text(
                    "Add your food photos to get started",
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        color: kDarkGrey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 35.0),
                  TasteButton(
                    text: "Select Photos",
                    iconData: PostingPhotoLibraryIcon.postingPhotoLibrary,
                    onPressed: () => _selectPhotos(context),
                    options: _buttonOptions,
                  ),
                  const SizedBox(height: 27.0),
                  TasteButton(
                    text: "Camera",
                    iconData: CameraIcon.camera,
                    onPressed: () => _takePicture(context),
                    options: _buttonOptions,
                  ),
                ],
              ),
            ),
          ],
        ),
      ));

  double getTextTop(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double workerTop = topDistance(screenSize, 439.0);
    return max(30.0, workerTop - 279);
  }
}

class AssetFile {
  const AssetFile(this.asset, this.file);
  final Asset asset;
  final File file;
}

const maxPhotosPerPost = 4;

Future<List<AssetFile>> pickAssetFiles(BuildContext context,
        {int numExisting = 0}) =>
    spinner(() async {
      final numToSelect = maxPhotosPerPost - numExisting;
      final dir = await (await getTemporaryDirectory()).createTemp();
      final assets = await MultiImagePicker.pickImages(
            materialOptions: MaterialOptions(
              startInAllView: true,
              allViewTitle: "Select ${'Photo'.pluralize(numToSelect)}",
              actionBarColor: "#e8ae61",
              actionBarTitleColor: "white",
              lightStatusBar: false,
              statusBarColor: "#e8ae61",
            ),
            maxImages: numToSelect,
            enableCamera: true,
          ) ??
          const <Asset>[];
      TAEvent.selected_assets({'count': assets.length});
      return assets.enumerate.futureMap((i, asset) async {
        final file = File('${dir.path}/$i.jpg');
        final scale = min(1,
            photoUploadSize / max(asset.originalHeight, asset.originalWidth));
        final width = (asset.originalWidth * scale).toInt();
        final height = (asset.originalHeight * scale).toInt();
        final data = await asset.getThumbByteData(width, height, quality: 70);
        await file.writeAsBytes(
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
        return AssetFile(asset, file);
      });
    });

Future _selectPhotos(BuildContext context) async {
  final assetFiles = await pickAssetFiles(context);
  if (assetFiles.isEmpty) {
    return;
  }
  final assets = assetFiles.listMap((t) => t.asset);
  final files = assetFiles.listMap((t) => t.file);
  LatLng location;
  try {
    final _metadata = await metadata;
    final platformVersion = _metadata['platformVersion'];
    final isNewAndroid = platformVersion.contains('Android') &&
        Iterable.generate(100, (i) => (10 + i).toString())
            .any(platformVersion.contains);
    final cannotGetGps = isNewAndroid &&
        (await PermissionHandler().requestPermissions([
              PermissionGroup.accessMediaLocation
            ]))[PermissionGroup.accessMediaLocation] !=
            PermissionStatus.granted;
    location = cannotGetGps
        ? null
        : (await assets.futureMap((a) => a.metadata))
            .withoutNulls
            .map((m) => m.latLng)
            .withoutNulls
            .firstOrNull;
  } catch (e, s) {
    unawaited(
        Crashlytics.instance.recordError(e, s, context: {'reason': 'gps'}));
  }
  await createReview(context, files, location);
}

Future _takePicture(BuildContext context) async {
  Future<T> spin<T>(Future<T> Function() fn) => spinner(fn);
  final raw = await spin(() => ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 60,
      maxWidth: 1700,
      maxHeight: 1700));
  TAEvent.selected_take_photo();
  if (raw == null) {
    return;
  }
  final location = await spin(() => getLocationData(File(raw.path)));
  final processed = await FlutterExifRotation.rotateImage(path: raw.path);
  await createReview(context, [processed], location);
}

Future createReview(BuildContext context, List<File> images, LatLng location) {
  TAEvent.draft_post();
  return quickPush(
      TAPage.create_post_page,
      (_) => CreateOrUpdateReviewWidget.create(
          photoLocation: location, images: images));
}

extension MIPMetadataExtension on Metadata {
  LatLng get latLng {
    if (gps == null) {
      return null;
    }
    final lat = gps.gpsLatitude;
    final lng = gps.gpsLongitude;
    if ((lat ?? 0).abs() + (lng ?? 0).abs() <= 0) {
      return null;
    }
    final latRef = gps.gpsLatitudeRef?.toLowerCase();
    final lngRef = gps.gpsLongitudeRef?.toLowerCase();
    final latSign = (latRef?.startsWith('s') ?? false)
        ? false
        : (latRef?.startsWith('n') ?? false) ? true : null;
    final lngSign = (lngRef?.startsWith('w') ?? false)
        ? false
        : (lngRef?.startsWith('e') ?? false) ? true : null;
    return LatLng(
      latSign == null ? lat : latSign ? lat.abs() : (-1 * lat.abs()),
      lngSign == null ? lng : lngSign ? lng.abs() : (-1 * lng.abs()),
    );
  }
}
