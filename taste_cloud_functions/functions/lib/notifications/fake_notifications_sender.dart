import 'package:taste_cloud_functions/taste_functions.dart';

class FakeNotificationsSender implements NotificationSender {
  /// Sends [messages] and returns any failed tokens.
  @override
  FutureOr<Iterable<String>> send(List<DartFcmMessage> messages) async {
    print(
        'Sending ${messages.length} messages with tokens: ${messages.map((message) => message.token).toList()}');
    for (final message in messages) {
      final data = DocumentData.fromMap({
        'payload': jsonDecode(message.dataMap['extras'] as String),
        'data_map': message.dataMap,
        'token': message.token,
        'notification': {
          'body': message.notification.body,
          'title': message.notification.title,
          'seen': false,
        }
      });
      print(['creating fake message', data.toMap()]);
      await firestore.collection('fake_notifications').add(data);
    }
    return [];
  }
}
