import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'taste_notification.dart';

class TasteNotificationDocument extends SnapshotHolder<$pb.Notification>
    with TasteNotificationMixin {
  TasteNotificationDocument(DocumentSnapshot s) : super(s);

  @override
  String get body => proto.body;
  @override
  DocumentReference get documentLink => proto.documentLink.ref;

  @override
  $pb.NotificationType get explicitNotificationType =>
      proto.hasNotificationType() ? proto.notificationType : null;

  @override
  DocumentReference get notificationDocument => reference;

  @override
  String get title => proto.title;

  @override
  DocumentReference get user => proto.user.ref;
}
