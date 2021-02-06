import 'package:flutter/material.dart';
import 'package:taste/components/abuse/report_content.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';

class BlockUserWidget extends StatelessWidget {
  const BlockUserWidget({Key key, this.user}) : super(key: key);
  final TasteUser user;
  @override
  Widget build(BuildContext context) {
    return ReportContentWidget(
      snapshotHolder: user,
      color: Colors.grey,
      description: 'user',
      notification:
          "We will investigate this user's behavior and update you within 24 hours.",
      action: (context, text) async => user.block(text: text),
    );
  }
}
