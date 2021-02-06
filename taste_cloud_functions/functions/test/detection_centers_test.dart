import 'utilities.dart';

void main() {
  group('detection-centers', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('detection-centers', () async {
      final fixture = Fixture();
      await fixture.createReview(
          photo: await fixture.createPhoto(),
          morePhotos: [await fixture.createPhoto()]);
      await eventually(
          () async => (await DiscoverItems.get())
              .firstOrNull
              ?.detectionCenters
              ?.listMap((t) => t.asMap),
          [
            {'x': .3, 'y': near(.4)},
            {'x': .3, 'y': near(.4)},
          ]);
    });
  });
}
