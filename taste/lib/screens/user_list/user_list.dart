import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/screens/profile/components/follow_button.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/utils.dart';

mixin UserListUser {
  String get name;
  bool get isMe;
  DocumentReference get reference;
  String get userListPhoto;
  static UserListUser make(String name, bool isMe, DocumentReference reference,
          String userListPhoto) =>
      _UserListUser(name, isMe, reference, userListPhoto);
}

class _UserListUser implements UserListUser {
  const _UserListUser(this.name, this.isMe, this.reference, this.userListPhoto);
  @override
  final String userListPhoto;
  @override
  final bool isMe;
  @override
  final String name;
  @override
  final DocumentReference reference;
}

class UserList extends StatelessWidget {
  const UserList(
      {Key key, @required this.title, @required this.users, this.meWidget})
      : super(key: key);

  final String title;
  final List<UserListUser> users;
  final Widget meWidget;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title, style: kAppBarTitleStyle),
          centerTitle: true,
        ),
        body: UserListBody(
          users: meWidget == null
              ? users
              : users.iTupleSort((t, i) => [t.isMe ? 0 : 1, i]),
          meWidget: meWidget,
        ),
      );
}

class UserListBody extends StatelessWidget {
  const UserListBody({
    Key key,
    @required this.users,
    this.meWidget,
  }) : super(key: key);
  final Widget meWidget;
  final List<UserListUser> users;

  @override
  Widget build(BuildContext context) => ListView.builder(
        cacheExtent: MediaQuery.of(context).size.height * 3,
        itemBuilder: (context, i) => UserListEntry(users[i],
            button: meWidget != null && users[i].isMe ? meWidget : null),
        itemCount: users.length,
      );
}

class UserListEntry extends StatelessWidget {
  UserListEntry(this.user, {this.button, Key key})
      : super(key: key ?? ValueKey(user.reference));

  final UserListUser user;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    final tag = Object();
    return ListTile(
        key: Key(user.reference.path),
        title: Text(
          user.name,
          style: const TextStyle(
              fontFamily: "Quicksand", fontWeight: FontWeight.normal),
        ),
        leading: ProfilePhoto(
          radius: 20,
          user: user.reference,
          path: user.userListPhoto,
          tapToProfileHero: true,
          hero: tag,
        ),
        onTap: () async => goToUserProfile(user.reference, hero: tag),
        trailing: button ??
            (user.isMe
                ? const SizedBox()
                : FollowButton(userReference: user.reference)));
  }
}
