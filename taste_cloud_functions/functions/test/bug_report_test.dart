import 'package:taste_protos/taste_protos.dart' show AppMetadata;

import 'utilities.dart';

void main() {
  group('bug-report', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test(
        'big-build-number',
        () => expect(
              {'project_code': '300002951'}.ensureAs(AppMetadata()),
              {'project_code': '300002951'},
            ));

    test('notifications', () async {
      final user = await Fixture().user;
      final coolMessage = 'asdfasdfasdfasdfad';
      await tasteFn(
          'createBugReport',
          {
            'text': coolMessage,
          },
          user);
      expect(
          await testSlackMessages(),
          equals([
            stringContainsInOrder(['Bug Reported', coolMessage])
          ]));
      expect(
          await testGithubMessages(),
          equals([
            stringContainsInOrder(['bug_report', coolMessage])
          ]));
    });
  });
}
