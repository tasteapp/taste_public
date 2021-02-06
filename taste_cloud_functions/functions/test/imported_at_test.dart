import 'utilities.dart';

void main() {
  group('imported-at', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('imported-at', () async {
      final date = DateTime(2020, 3, 3, 3, 3, 3).toUtc();
      await Fixture().createReview(importedAt: date);
      await eventually(
          () async => (await DiscoverItems.get())
              .listMap((e) => e.proto.importedAt.toDateTime()),
          [date]);
    });
  });
}
