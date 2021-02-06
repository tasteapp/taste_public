import 'package:taste_cloud_functions/taste_functions.dart' hide PhotoExtension;
import 'package:taste_protos/taste_protos.dart' as $pb
    show Photo, Point, InferenceResult;

import '../image_size.dart' as image_size;

part 'photo.g.dart';

@RegisterType()
mixin Photo on FirestoreProto<$pb.Photo>, UserOwned {
  static final triggers = trigger<Photo>(
    create: (r) => r.postProcess(),
    update: (r, _) => r.postProcess(),
    delete: (r) => ifNotTest(() async {
      if (await r.queryExists(r.type.coll
          .where('firebase_storage_path', isEqualTo: r.firebaseStoragePath))) {
        return true;
      }
      return allPhotoPaths(r.firebaseStoragePath)
          .futureMap(tasteStorage.delete);
    }),
  );
  String get firebaseStoragePath => proto.firebaseStoragePath;

  Future postProcess() => [setImageSize()].wait;

  Future setImageSize() async {
    if (proto.hasPhotoSize()) {
      return;
    }
    final size = await image_size.imageSize(await bytes(Resolution.full));
    await updateSelf({
      'photo_size': {'width': size.width, 'height': size.height}
    });
    await (await review)?.recacheFirePhotos();
  }

  FirePhoto get firePhoto => proto.firePhoto(ref.proto);

  static Future<Photo> createFromStoragePath(
      BatchedTransaction transaction, String path) async {
    await tasteStorage.makePublic(path);
    if (path.contains('thumbnails')) {
      print({'status': 'skipped', 'reason': 'thumbnail'});
      return null;
    }
    return Photos.createNew(transaction,
        data: {
          'user': CollectionType.users.coll.document(path.split('/')[1]),
          'firebase_storage_path': path,
        }.ensureAs(Photos.emptyInstance).documentData.withExtras);
  }

  Future setOwner(Review review) => updateSelf({
        'references': [review.ref],
      }.ensureAs(prototype));

  Future<List<int>> bytes(Resolution resolution) =>
      tasteStorage.bytes(url(resolution));
  PhotoStoragePath get storagePath =>
      PhotoStoragePath.tryParse(firebaseStoragePath);
  String url(Resolution r) => storagePath.forResolution(r);

  Future<void> runObjectDetection() async {
    final exists = await CollectionType.inference_results.coll
        .where('photo_ref', isEqualTo: ref)
        .exists;
    if (exists) {
      print('InferenceResult already exists for ${ref.path}, skipping...');
      return;
    }
    final bytes = await this.bytes(Resolution.medium);
    final imagePath = url(Resolution.medium);
    if (bytes == null) {
      print('detection failed for $imagePath, could not find image');
      if (!(await refetch).exists) {
        print('Photo was deleted before detection $path $imagePath');
        return;
      }
      throw Exception('detection: no bytes for $path $imagePath');
    }
    final inferenceResults = await tasteVision.annotations(bytes);
    // Write all results.
    final inferenceRef = await CollectionType.inference_results.coll.add({
      'photo_ref': ref,
      'objects': inferenceResults,
    }.ensureAs($pb.InferenceResult()).documentData.withExtras);
    if (inferenceResults.isEmpty) {
      return;
    }
    final detection = pickDetectionCenter(inferenceResults);
    final center = getPolygonCenter(detection?.boundingPoly?.vertices);
    await updateSelf({
      'inference_data': {
        'source_ref': inferenceRef,
        'detection_center': center,
      }
    }.ensureAs(Photos.emptyInstance));
    await (await review)?.recacheFirePhotos();
  }

  Future<Review> get review async => reviewOrHomeMeal(
      await proto.references.firstOrNull?.ref?.tGet(transaction), transaction);
}

// Based on most common detected objects. See `visualize_object_detection`
// notebook.
const _foodDetections = {
  'Food',
  'Baked goods',
  'Dessert',
  'Snack',
  'Taco',
  'Plate',
  'Ice cream',
  'Sandwich',
  'Cake',
  'Hamburger',
  'Pizza',
  'Doughnut',
  'Pasta',
  'Fruit',
  'Cocktail',
  'Sushi',
};

/// Pick's what should be the "center" of the image from a list of candidate
/// object detections. Currently algorithm returns the max-area detection of
/// food candidates (see `_foodDetections`). If there are no food detections it
/// returns the max-area detection regardless of detected object.
InferenceResult_LocalizedObjectAnnotation pickDetectionCenter(
    List<InferenceResult_LocalizedObjectAnnotation> allCandidates) {
  final foodCandidates =
      allCandidates.where((c) => _foodDetections.contains(c.name));
  if (foodCandidates.isNotEmpty) {
    return getMaxAreaCandidate(foodCandidates);
  }
  return getMaxAreaCandidate(allCandidates);
}

InferenceResult_LocalizedObjectAnnotation getMaxAreaCandidate(
    Iterable<InferenceResult_LocalizedObjectAnnotation> candidates) {
  return candidates
      .max((result) => getPolygonArea(result.boundingPoly.vertices));
}

double getPolygonArea(List<$pb.Point> vertices) =>
// From https://www.mathopenref.com/coordpolygonarea2.html
// `pairCycle` simply pairs up all vertices w/ their neighbor, including (i-1) paired w/ 0.
    vertices.pairCycle.sum((t) => (t.b.x + t.a.x) * (t.b.y - t.a.y)).abs() / 2;

$pb.Point getPolygonCenter(List<$pb.Point> vertices) => {
      'x': vertices.average((v) => v.x),
      'y': vertices.average((v) => v.y),
    }.asProto($pb.Point());
