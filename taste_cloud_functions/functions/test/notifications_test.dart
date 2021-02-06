import 'utilities.dart';

void main() {
  group('notifications', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('send with notification type', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final notificationReference = await user.sendNotification(
          body: 'test body',
          title: 'test title',
          documentLink: user.ref,
          notificationType: NotificationType.message);
      expect(
          await waitFor(() async {
            final fakeNotifications = await 'fake_notifications'.coll.get();
            print(fakeNotifications.documents
                .map((d) => d.data.toMap())
                .toList());
            return fakeNotifications.isNotEmpty;
          }),
          isTrue);
      final fakeNotification = await first('fake_notifications'.coll.where(
          'payload.notification_path',
          isEqualTo: notificationReference.path));
      expect(fakeNotification, isNotNull);
      final userPath = user.path;
      final token = (await user.tokens).first;
      final notificationPath = notificationReference.path;
      expect(
          fakeNotification.data.toMap(),
          equals({
            'data_map': {
              'extras': allOf(stringContainsInOrder([notificationPath]),
                  stringContainsInOrder([userPath])),
              'click_action': 'FLUTTER_NOTIFICATION_CLICK'
            },
            'token': token,
            'notification': {
              'body': 'test body',
              'title': 'test title',
              'seen': false,
            },
            'payload': {
              'notification_type': 'message',
              'document_link': userPath,
              'notification_path': notificationPath,
              'user': user.path,
            }
          }));
    });
    test('send without notification type', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final notificationReference = await user.sendNotification(
          notificationType: null,
          body: 'test body',
          title: 'test title',
          documentLink: user.ref);
      expect(
          await waitFor(() async {
            final fakeNotifications = await 'fake_notifications'.coll.get();
            print(fakeNotifications.documents
                .map((d) => d.data.toMap())
                .toList());
            return fakeNotifications.isNotEmpty;
          }),
          isTrue);
      final fakeNotification = await first('fake_notifications'.coll.where(
          'payload.notification_path',
          isEqualTo: notificationReference.path));
      expect(fakeNotification, isNotNull);
      final userPath = user.path;
      final token = (await user.tokens).first;
      final notificationPath = notificationReference.path;
      expect(
          fakeNotification.data.toMap(),
          equals({
            'data_map': {
              'extras': allOf(stringContainsInOrder([notificationPath]),
                  stringContainsInOrder([userPath])),
              'click_action': 'FLUTTER_NOTIFICATION_CLICK'
            },
            'token': token,
            'notification': {
              'body': 'test body',
              'title': 'test title',
              'seen': false,
            },
            'payload': {
              'document_link': userPath,
              'notification_path': notificationPath,
              'user': user.path,
            }
          }));
    });
  });
}
