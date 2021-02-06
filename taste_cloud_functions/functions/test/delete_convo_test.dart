import 'utilities.dart';

void main() {
  group('delete-convo', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('delete-convo', () async {
      final fixture = Fixture();
      final convo = await fixture.conversation;
      expect((await convo.refetch).exists, true);
      await (await fixture.user).deleteSelf();
      await eventually(Conversations.get, isEmpty);
    });
  });
}
