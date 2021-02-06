import 'utilities.dart';

const emailMd5 = 'd10ca8d11301c2f4993ac2279ce4b930';

Future hasTagUpdates(Set<String> add, Set<String> remove) =>
    lastMailchimpEventWas(
        '/lists/$mailchimpAudience/members/$emailMd5/tags', 'post', {
      'tags': [
        ...add.map((a) => {'name': a, 'status': 'active'}),
        ...remove.map((a) => {'name': a, 'status': 'inactive'}),
      ]
    });
Future hasMemberUpdate(String method, dynamic argsMatcher) =>
    lastMailchimpEventWas(
        '/lists/$mailchimpAudience/members/$emailMd5', method, argsMatcher);
Future lastMailchimpEventWas(
    String path, String method, dynamic argsMatcher) async {
  await eventually(
      () async => (await mailchimpTestLog)?.lastWhere(
          (e) => e['path'] == path && e['method'] == method,
          orElse: () => <String, dynamic>{})['args'],
      argsMatcher,
      duration: 15.seconds);
  await clearMailchimpTestLog;
}

void main() {
  setUp(setupEmulator);
  tearDown(tearDownEmulator);
  test('member-updates', () async {
    final user = await Fixture().createUser(
        email: 'a@a.com', username: 'first', name: 'First Last Name');
    await hasMemberUpdate(
      'put',
      {
        'email_address': 'a@a.com',
        'status': 'subscribed',
        'merge_fields': {
          'FNAME': 'First',
          'LNAME': 'Last Name',
          'USERNAME': 'first',
          'UID': user.uid,
        },
      },
    );
    await user.updateSelf({'vanity.display_name': 'Newest New Name'});
    await hasMemberUpdate(
      'put',
      {
        'email_address': 'a@a.com',
        'status': 'subscribed',
        'merge_fields': {
          'FNAME': 'Newest',
          'LNAME': 'New Name',
          'USERNAME': 'first',
          'UID': user.uid,
        },
      },
    );
    await user.updateSelf({'vanity.username': 'super'});
    await hasMemberUpdate(
      'put',
      {
        'email_address': 'a@a.com',
        'status': 'subscribed',
        'merge_fields': {
          'FNAME': 'Newest',
          'LNAME': 'New Name',
          'USERNAME': 'super',
          'UID': user.uid,
        },
      },
    );
  });
  test('tags', () async {
    final user = await Fixture().createUser(email: 'a@a.com');
    Future tags() async => (await MailchimpUserSettings.get(
            queryFn: (q) => q.where('user', isEqualTo: user.ref)))
        ?.first
        ?.tags;
    await user.updateMailchimpTags(add: {'a'});
    expect(await tags(), {'a'});
    await hasTagUpdates({'a'}, {});

    await user.updateMailchimpTags(add: {'b'});
    expect(await tags(), {'a', 'b'});
    await hasTagUpdates({'b'}, {});

    await user.updateMailchimpTags(add: {'b'});
    expect(await tags(), {'a', 'b'});

    await user.updateMailchimpTags(remove: {'c'});
    expect(await tags(), {'a', 'b'});

    await user.updateMailchimpTags(remove: {'a'});
    expect(await tags(), {'b'});
    await hasTagUpdates({}, {'a'});
  });
}
