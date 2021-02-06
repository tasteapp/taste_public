import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/screens/profile/notifications/taste_notification_document.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/loading.dart';

class ClearNotificationsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TasteNotificationDocument>>(
        stream: CollectionType.notifications.coll.forMe.stream(),
        initialData: const [],
        builder: (context, snapshot) {
          final notifications = snapshot.data;
          return Visibility(
            visible: notifications.isNotEmpty,
            child: IconButton(
              icon: const Icon(
                Icons.delete,
              ),
              onPressed: () async {
                final doClear = await showDialog<bool>(
                    context: context,
                    builder: (context) => TasteDialog(
                          title: "Clear all Notifications?",
                          buttons: [
                            TasteDialogButton(
                                text: 'Cancel',
                                onPressed: () => Navigator.pop(context, false)),
                            TasteDialogButton(
                                text: 'Clear',
                                onPressed: () => Navigator.pop(context, true)),
                          ],
                        ));
                if (!doClear) {
                  return;
                }
                unawaited(spinner(() async => (await CollectionType
                        .notifications.coll
                        .forUser(currentUserReference)
                        .getDocuments())
                    .documents
                    .futureMap((s) => s.reference.delete())));
              },
            ),
          );
        });
  }
}
