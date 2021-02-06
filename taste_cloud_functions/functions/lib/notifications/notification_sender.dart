import 'package:taste_cloud_functions/taste_functions.dart';

abstract class NotificationSender {
  /// Sends [messages] and returns any failed tokens.
  FutureOr<Iterable<String>> send(List<DartFcmMessage> messages);
}
