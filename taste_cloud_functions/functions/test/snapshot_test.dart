import 'utilities.dart';

void main() {
  group('snapshot', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('double set self', () async {
      final ref = 'restaurants/b'.ref;
      await ref.setData(DocumentData());
      await BatchedTransaction.batchedTransaction('event', (t) async {
        final holder = SnapshotHolder(await ref.get(), t, ref.collectionType);
        await holder.updateSelf({'x': 3});
        await holder.updateSelf({'y': 4});
      });
      expect((await ref.get()).data.toMap(),
          equals({'x': 3, 'y': 4, '_extras': anything}));
    });
  });
}
