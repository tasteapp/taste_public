import 'utilities.dart';

void main() {
  group('diff-update', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('shuffle', () async {
      final review = await Fixture().review;
      await review.updateSelf({
        'emojis': ['a', 'b']
      });
      expect((await review.refetch).data.toMap()['emojis'], ['a', 'b']);
      await review.updateSelf({
        'emojis': ['b', 'a']
      });
      expect((await review.refetch).data.toMap()['emojis'], ['b', 'a']);
    });

    test('diff updates', () async {
      final snapshot = SnapshotHolder(
          SimpleSnapshot(
              {
                'a': [1, 2, 3],
                'b': {'c': 'd'},
                'e': 'f',
                'g': null,
              }.documentData,
              'bookmarks/a'.ref),
          quickTrans,
          CollectionType.bookmarks,
          checkExists: false);
      expect(
          snapshot.diffUpdate({
            'a': [1, 2, 3]
          }),
          isEmpty);
      expect(
          snapshot.diffUpdate({
            'a': [1, 2, 2]
          }),
          equals({
            'a': [1, 2, 2]
          }));
      expect(
          snapshot.diffUpdate({
            'a': [1, 2, 3],
            'b': 4
          }),
          equals({'b': 4}));
      expect(
          snapshot.diffUpdate({
            'a': [1, 2, 3],
            'b': {'c': 'd'},
            'e': 'f'
          }),
          isEmpty);
      expect(
          snapshot.diffUpdate({
            'a': [1, 2, 3],
            'b': {'c': 'd', 'd': 'e'},
            'e': 'f'
          }),
          equals({
            'b': {'d': 'e'}
          }));
      expect(
          snapshot.diffUpdate({
            'b': {'c': 'd', 'd': 'e'},
          }),
          equals({
            'b': {'d': 'e'}
          }));
      expect(
          snapshot.diffUpdate({
            'b': {},
          }),
          isEmpty);
      expect(
          snapshot.diffUpdate({
            'e': null,
          }),
          equals({'e': null}));
      expect(
          snapshot.diffUpdate({
            'g': null,
          }),
          isEmpty);
      expect(
          snapshot.diffUpdate({
            'g': {'h': null},
          }),
          equals({
            'g': {'h': null},
          }));
    });
  });
}
