import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/memoize.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

mixin TasteNotificationMixin implements Memoizer {
  String get body;
  String get title;
  DocumentReference get documentLink;
  DocumentReference get notificationDocument;
  $pb.NotificationType get explicitNotificationType;
  DocumentReference get user;
}

class TasteNotification with TasteNotificationMixin, Memoizer {
  TasteNotification(this.proto);
  final $pb.FcmMessage proto;
  @override
  @override
  String get body => proto.notification.body;

  @override
  DocumentReference get documentLink => proto.extras.documentLink.ref;

  @override
  $pb.NotificationType get explicitNotificationType =>
      proto.extras.notificationType;

  @override
  DocumentReference get notificationDocument =>
      proto.extras.notificationPath.ref;

  @override
  String get title => proto.notification.title;

  @override
  DocumentReference get user => proto.extras.user.ref;
}

extension on $pb.FcmMessage {
  $pb.FcmExtras get extras =>
      Map<String, dynamic>.from(jsonDecode(data.extras) as Map)
          .asProto($pb.FcmExtras());
}
