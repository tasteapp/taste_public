import 'dart:js_util';

import 'package:firebase_functions_interop/firebase_functions_interop.dart'
    show UserRecord;
import 'package:firebase_functions_interop/src/bindings.dart' as js
    show UserRecord;

import 'utilities.dart';

void main() {
  group('create-user', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('create-user', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      await eventually(() => user.badges, hasLength(greaterThan(2)),
          message: (t) => t);
    });

    test('after-auth', () async {
      expect((await 'fake_slack'.coll.get()).documents, isEmpty);
      final user = await createUserRecord(
          UserRecord(jsify({
            'localId': '000885.3ee0ea1d42c9403599c6d95b9fef8c11.2331',
            'uid': '000885.3ee0ea1d42c9403599c6d95b9fef8c11.2331',
            'email': 'michfrank89@gmail.com',
            'displayName': 'Michael  Franklin',
            'emailVerified': false,
            'validSince': '1589585476',
            'disabled': false,
            'lastLoginAt': '1589585477092',
            'createdAt': '1589585476226',
            'customAuth': true,
            'lastRefreshAt': '2020-05-15T23:31:17.092Z'
          }) as js.UserRecord),
          quickTrans);
      expect(user.proto.displayName, 'Michael  Franklin');
      expect(
          user.ref.documentID, '000885.3ee0ea1d42c9403599c6d95b9fef8c11.2331');
      expect((await user.refetch).exists, isTrue);
      expect((await user.private.get()).data.toMap(),
          {'email': 'michfrank89@gmail.com', 'email_verified': false});
      expect(
          (await 'fake_slack'.coll.get()).documents.firstOrNull?.data?.toMap(),
          {'text': startsWith('New user: Michael')});
    });
  });
}
