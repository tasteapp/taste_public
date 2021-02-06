import 'utilities.dart';

void main() {
  group('user algolia', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('user algolia record', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final record = await first(CollectionType.algolia_records.coll);
      expect(record, isNotNull);
      expect(
          record.data.toMap(),
          equals({
            'index': 'discover',
            'object_id': 'user ${user.path}',
            'record_type': 'user',
            'tags': ['user', 'discover'],
            'reference': user.ref,
            'payload': {
              'name': 'Test User',
              'username': '',
              'profile_pic_url': 'http://test-user-photo'
            },
            '_extras': anything,
          }));
    });
  });
}
