import 'package:flutter/material.dart';
import 'package:taste/screens/discover/instagram/instagram_actions.dart';
import 'package:taste/screens/discover/instagram/instagram_tile.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/theme/style.dart';

class InstagramSettingsDialog extends StatelessWidget {
  const InstagramSettingsDialog({Key key, this.user}) : super(key: key);

  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return TasteDialog(
      scrollable: true,
      content: Column(
        children: [
          const SizedBox(height: 10.0),
          const Center(
            child: Text(
              "Linked Account",
              style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            children: [
              const SizedBox(width: 20),
              InstagramSubtitle(user: user)
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: const Alignment(0.95, 0.0),
            child: InkWell(
              onTap: () => unlink(context, user),
              child: const Text(
                "Unlink",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
            ),
          )
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 20.0),
    );
  }
}
