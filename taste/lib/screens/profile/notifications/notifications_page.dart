import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/screens/profile/notifications/taste_notification_document.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/style.dart';

import 'clear_notifications_button.dart';
import 'notification_tile.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications", style: kAppBarTitleStyle),
        centerTitle: true,
        actions: [ClearNotificationsButton()],
      ),
      body: StreamBuilder<List<TasteNotificationDocument>>(
          stream: CollectionType.notifications.coll.forMe.stream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final notifications =
                snapshot.data.sorted((t) => t.updateTime, desc: true);
            final hasNotifications = notifications.isNotEmpty;
            if (!hasNotifications) {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(30.0),
                child: AutoSizeText(
                  "No recent notifications!",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ));
            }
            return ListView(
                children: ListTile.divideTiles(
                    context: context,
                    tiles: notifications.map((notification) =>
                        NotificationTile(notification, context))).toList());
          }),
    );
  }
}
