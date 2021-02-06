import '../utilities.dart';

Future missingPhotosFix() => autoBatch((t) async {
      final batch = await BatchDump.fetch(t, {
        CollectionType.reviews,
        CollectionType.home_meals,
        CollectionType.photos
      });
      final photoSet = batch.typed<Photo>().map((p) => p.ref).toSet();
      final bucket = admin.storage().bucket();
      await batch.reviews.futureMap((r) async {
        if (r.proto.firePhotos
            .map((x) => x.photoReference.ref)
            .toSet()
            .difference(photoSet)
            .isEmpty) {
          return null;
        }
        print(['not ok', refLink(r.ref)]);
        final photos = (await r.proto.firePhotos.futureMap((p) async {
          final ref = p.photoReference.ref;
          final match = batch.get(ref);
          if (match != null) {
            return ref;
          }
          final path = p.firebaseStorage;
          if (!(await bucket.file(path).exists())) {
            print(['no path', refLink(r.ref), 'https://go/ph/$path']);
            return null;
          }
          final photo = await Photos.createNew(t,
              data: {'firebase_storage_path': path}.documentData.withExtras);
          print(['created photo', refLink(r.ref), 'https://go/ph/$path']);
          return photo.ref;
        }))
            .withoutNulls;
        if (photos.isEmpty) {
          print(['deleting', refLink(r.ref)]);
          return r.deleteSelf();
        }
        return r.updateSelf({
          'fire_photos': [],
          'photo': photos.first,
          'more_photos': photos.skip(1).toList()
        }.ensureAs(r.prototype, explicitEmpties: true));
      });
    }, dryRun: false);
