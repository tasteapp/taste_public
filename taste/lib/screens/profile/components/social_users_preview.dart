import 'package:flutter/material.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';

class SocialUsersPreview extends StatelessWidget {
  const SocialUsersPreview({Key key, this.users}) : super(key: key);
  final List<TasteUser> users;
  static const maxUsers = 3;

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return Container(
        height: 0,
        width: 0,
      );
    }
    return Stack(
        children: users.take(maxUsers).toList().asMap().entries.map((entry) {
      final i = entry.key.toDouble();
      final user = entry.value;
      return Padding(
        padding: EdgeInsets.only(left: i * 20),
        child: Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle, boxShadow: [BoxShadow(blurRadius: 2)]),
          child: ProfilePhoto(
            user: user.reference,
            radius: 12,
          ),
        ),
      );
    }).toList());
  }
}
