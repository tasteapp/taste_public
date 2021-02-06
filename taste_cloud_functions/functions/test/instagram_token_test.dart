import 'utilities.dart';

void main() {
  setUp(setupEmulator);
  tearDown(tearDownEmulator);
  test('token', () async {
    final fixture = Fixture();
    final user = await fixture.createUser(username: 'jack');

    await fixture.createInstaPost(user: user, createdTime: DateTime(2018));
    await (await InstagramTokens.createNew(quickTrans,
            data: {
              'user': user.ref,
              'user_id': user.username,
              'token': 'gobbledygook',
              'username': user.username,
            }.documentData))
        .updateSelf({'import_status': 'start'});
    await eventually(
        () async =>
            (await CollectionType.instagram_username_requests.coll.get())
                .documents
                .listMap((s) => s.data.toMap()),
        [
          {
            'username': 'jack',
            'set_location_request': true,
            'most_recent_post_date': DateTime(2018).timestamp
          }
        ]);
  });
}
