import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/theme/buttons.dart';

class FollowButton extends StatelessWidget {
  const FollowButton(
      {Key key, this.stream, this.displayFollowing = true, this.userReference})
      : super(key: key);
  final ValueStream<bool> stream;
  final bool displayFollowing;
  final DocumentReference userReference;

  @override
  Widget build(BuildContext context) => FutureBuilder<TasteUser>(
        future: userReference.fetch(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return Container(
            height: 32,
            child: user?.isMe ?? true
                ? const SizedBox()
                : StreamBuilder<bool>(
                    stream: stream ?? user.amIFollowing,
                    initialData: stream?.value,
                    builder: (context, snapshot) => !snapshot.hasData
                        ? const SizedBox()
                        : snapshot.data
                            ? (displayFollowing
                                ? TasteButton(
                                    text: 'Following',
                                    onPressed: user.unfollow,
                                    options: kTastePrimaryButtonOptions,
                                  )
                                : Container())
                            : TasteButton(
                                text: 'Follow',
                                onPressed: user.follow,
                                options: kSimpleButtonOptions,
                              ),
                  ),
          );
        },
      );
}
