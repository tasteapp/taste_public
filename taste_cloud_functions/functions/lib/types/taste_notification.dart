import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show Notification;
import 'package:taste_protos/taste_protos.dart'
    show FcmMessage_Data, FcmExtras, ClickAction, Notification_FCMSettings;

part 'taste_notification.g.dart';

@RegisterType()
mixin TasteNotification on FirestoreProto<$pb.Notification>, UserOwned {
  static final triggers = trigger<TasteNotification>(
    create: (n) => n._sendFCM(),
    update: (n, c) => n.proto.fcmSettings ==
                Notification_FCMSettings.fcm_settings_on_all_events &&
            c.fieldsChanged({'body', 'title'})
        ? n._sendFCM()
        : null,
  );

  Future _sendFCM() async {
    final sender =
        (buildType == BuildType.test) ? FakeNotificationsSender() : FcmSender();
    final expiredTokens = await sender.send(await asFcmMessages);
    addOperation(ref, transaction, eventId,
        {'expired_tokens': expiredTokens, 'operation': 'sent'});
    await removeTokens(transaction, await user, expiredTokens);
  }

  Map<String, String> get _dataMap {
    final proto = FcmMessage_Data()
      ..clickAction = ClickAction.FLUTTER_NOTIFICATION_CLICK;
    final extras = FcmExtras()
      ..documentLink = this.proto.documentLink.path
      ..user = this.proto.user.path;
    if (this.proto.hasNotificationType()) {
      extras.notificationType = this.proto.notificationType;
    }
    extras.notificationPath = path;
    proto.setExtras(extras);
    return Map.from(proto.asJson);
  }

  String get body => proto.body;
  String get title => proto.title;

  Future<List<DartFcmMessage>> get asFcmMessages async {
    return (await (await user).tokens)
        .map(_asFcmMessage)
        .toList(growable: false);
  }

  DartFcmMessage _asFcmMessage(String token) {
    return DartFcmMessage(
        token: token,
        dataMap: _dataMap,
        notification: Notification(
          body: body,
          title: title,
        ));
  }

  Future update({String title, String body}) =>
      updateSelf({'body': body, 'title': title}.withoutNulls);
}

extension on FcmMessage_Data {
  void setExtras(FcmExtras extras) => this.extras = jsonEncode(extras.asJson);
}
