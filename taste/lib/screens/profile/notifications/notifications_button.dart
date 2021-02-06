import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/utils.dart';

import 'notifications_page.dart';
import 'taste_notification_document.dart';

class NotificationsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TasteNotificationDocument>>(
        stream: CollectionType.notifications.coll.forMe
            .where('seen', isEqualTo: false)
            .stream(),
        initialData: const [],
        builder: (context, snapshot) {
          final hasNotifications = snapshot.data?.isNotEmpty ?? false;
          final icon = hasNotifications
              ? Icons.notifications_active
              : Icons.notifications_none;
          final iconColor = hasNotifications ? kSecondaryButtonColor : null;
          return IconButton(
              icon: Icon(
                icon,
                color: iconColor,
              ),
              onPressed: () async {
                final batch = Firestore.instance.batch();
                (snapshot.data ?? []).forEach(
                    (n) => batch.updateData(n.reference, {'seen': true}));
                unawaited(batch.commit());
                await quickPush(
                    TAPage.notifications, (context) => NotificationsPage());
              });
        });
  }
}
