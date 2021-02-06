import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste/utils/unfocusable.dart';

const kDefaultDescription = 'user';
const kDefaultNotification =
    'We will investigate this content within 24 hours.';

class ReportContentWidget extends StatelessWidget {
  const ReportContentWidget(
      {Key key,
      @required this.snapshotHolder,
      this.description = kDefaultDescription,
      this.notification = kDefaultNotification,
      this.color = Colors.white,
      this.action})
      : super(key: key);
  final SnapshotHolder snapshotHolder;
  final String description;
  final Color color;
  final String notification;

  final Future Function(BuildContext context, String text) action;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.flag,
          color: color.withOpacity(0.6),
        ),
        onPressed: () {
          reportContent(context, snapshotHolder,
              action: action,
              description: description,
              notification: notification);
        });
  }
}

Future reportContent(BuildContext context, SnapshotHolder snapshotHolder,
    {Future Function(BuildContext context, String text) action,
    String description = kDefaultDescription,
    String notification = kDefaultNotification}) async {
  final isOffensive = await showDialog<bool>(
          context: context,
          builder: (context) {
            return TasteDialog(
              title: 'Report offensive content',
              content: Text(
                  'Would you like to report the content of this $description as offensive?'),
              buttons: [
                TasteDialogButton(
                    text: 'Cancel',
                    color: Colors.grey,
                    onPressed: () => Navigator.of(context).pop(false)),
                TasteDialogButton(
                    text: 'Report',
                    color: Colors.red,
                    onPressed: () => Navigator.of(context).pop(true)),
              ],
            );
          }) ??
      false;
  if (!isOffensive) {
    return;
  }
  final text = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return Unfocusable(
          child: TasteDialog(
            title: 'Report offensive content',
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Please provide your reason below:'),
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Explain why this is offensive'),
                    controller: controller,
                    autofocus: true,
                    maxLines: null,
                    onSubmitted: (t) {
                      Navigator.pop(context, t);
                    },
                  )
                ],
              ),
            ),
            buttons: [
              TasteDialogButton(
                  text: 'Cancel',
                  color: Colors.grey,
                  onPressed: () => Navigator.pop(context, null)),
              TasteDialogButton(
                  text: 'Report',
                  color: Colors.red,
                  onPressed: () => Navigator.pop(context, controller.text)),
            ],
          ),
        );
      });
  if (text == null) {
    return;
  }
  unawaited(spinner(() async {
    await (action ??
        (context, text) async =>
            snapshotHolder.report(text: text))(context, text);
  }));
  snackBarString(notification);
}
