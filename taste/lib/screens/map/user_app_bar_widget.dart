import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/theme/style.dart';

class UserAppBarWidget extends StatelessWidget {
  const UserAppBarWidget({Key key, this.user}) : super(key: key);
  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: ProfilePhoto(
            user: user.reference,
            radius: 25,
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: AutoSizeText(
            user.username,
            style: kAppBarTitleStyle,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
