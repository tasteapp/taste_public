import 'package:taste_cloud_functions/taste_functions.dart';

class FcmSender implements NotificationSender {
  @override
  FutureOr<Iterable<String>> send(List<DartFcmMessage> messages) async =>
      messages.isEmpty
          ? []
          : (await messaging.sendAll(messages))
              .responses
              .zip(messages.map((m) => m.token))
              .where((entry) => const {
                    'messaging/invalid-registration-token',
                    'messaging/invalid-argument',
                    'messaging/registration-token-not-registered',
                    'messaging/third-party-auth-error',
                  }.contains(entry.a.error?.code))
              .b
              .sideEffect((t) => structuredLog('send_notifications', null,
                  'remove_fcm_tokens', {'tokens': t.toList()}));
}
