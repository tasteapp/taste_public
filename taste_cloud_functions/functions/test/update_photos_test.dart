import 'utilities.dart';

void main() {
  group('update-photos', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('simple', () async {
      final fixture = Fixture();
      final review =
          await fixture.createReview(morePhotos: [await fixture.createPhoto()]);
      await review.updateSelf({'more_photos': []}
          .ensureAs(review.prototype, explicitEmpties: true));
      expect((await review.refetch).proto.morePhotos, isEmpty);
      await (await review.refetch).recacheFirePhotos();
      expect(await (await review.refetch).photos, hasLength(1));
      final photos = [await fixture.createPhoto(), await fixture.createPhoto()];
      await review.updateSelf({
        'photo': photos[0],
        'more_photos': [photos[1]]
      }.ensureAs(review.prototype));
      await (await review.refetch).recacheFirePhotos();
      expect(await (await review.refetch).photos, photos);
      await review.updateSelf({
        'photo': photos[1],
        'more_photos': [photos[0]]
      }.ensureAs(review.prototype));
      await (await review.refetch).recacheFirePhotos();
      expect(await (await review.refetch).photos, photos.reversed.toList());
    });
    test('update-photos', () async {
      final fixture = Fixture();
      final review = await fixture.createReview(noPhoto: true);

      Future check(Photo photo, List<Photo> morePhotos,
          Map<Photo, bool> expectation) async {
        await review.updateSelf({
          'photo': photo.ref,
          'more_photos': morePhotos.listMap((p) => p.ref),
        }.ensureAs(review.prototype, explicitEmpties: true));
        expect((await review.refetch).proto.morePhotos.listMap((r) => r.ref),
            morePhotos.listMap((t) => t.ref));
        await eventually(
            () async =>
                (await (await review.refetch).photos).listMap((t) => t.path),
            [photo, ...morePhotos].listMap((t) => t.path));
        for (final entry in expectation.entries) {
          final photo = entry.key;
          final exists = entry.value;
          if (exists) {
            expect((await photo.refetch).exists, isTrue,
                reason: [photo, morePhotos, 'is true'].toString());
          } else {
            await eventually(
                () async => (await photo.ref.get()).exists, isFalse,
                message: (i) => [i, photo, morePhotos, 'is false']);
          }
        }
      }

      final photoA1 = await fixture.createPhoto();
      final photoA2 = await fixture.createPhoto();
      await check(photoA1, [photoA2], {photoA1: true, photoA2: true});
      await check(photoA1, [], {photoA1: true, photoA2: false});
      final photoB1 = await fixture.createPhoto();
      await check(photoB1, [photoA1], {photoA1: true, photoB1: true});
      await check(photoA1, [photoB1], {photoA1: true, photoB1: true});
      final photoC1 = await fixture.createPhoto();
      await check(photoA1, [photoC1, photoB1],
          {photoA1: true, photoB1: true, photoC1: true});
      await check(
          photoA1, [photoB1], {photoA1: true, photoB1: true, photoC1: false});

      await review.deleteSelf();
      for (final photo in {photoA1, photoB1}) {
        await eventually(() async => (await photo.ref.get()).exists, isFalse,
            message: (i) => [i, photo, 'is false']);
      }
    });
  });
}
