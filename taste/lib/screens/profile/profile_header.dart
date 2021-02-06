import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:taste/components/abuse/report_content.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/screens/connect_users/find_friends.dart';
import 'package:taste/screens/discover/discover.dart';
import 'package:taste/screens/messaging/messages_page.dart';
import 'package:taste/screens/messaging/new_conversation_page.dart';
import 'package:taste/screens/profile/notifications/notifications_button.dart';
import 'package:taste/screens/profile/taste_drawer.dart';
import 'package:taste/screens/profile/user_rank_widget.dart';
import 'package:taste/screens/user_list/user_list.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/taste_backend_client/value_stream_builder.dart';
import 'package:taste/theme/buttons.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/fire_photo.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste/utils/taste_bottom_sheet.dart';
import 'package:taste/utils/utils.dart';

import 'components/follow_button.dart';
import 'components/user_map_view_button.dart';
import 'notifications/user_settings_button.dart';
import 'profile.dart';
import 'streak_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key key, this.tasteUser}) : super(key: key);

  final TasteUser tasteUser;

  @override
  Widget build(BuildContext context) {
    final profilePage = ProfilePage.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        bottom: 10,
        right: 4,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 45,
            padding: const EdgeInsets.only(top: 15.0),
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: AutoSizeText(
                    tasteUser.name,
                    maxFontSize: 18,
                    minFontSize: 12,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: "Quicksand",
                        color: Color(0xff2f3542),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                if (!Navigator.canPop(context))
                  Align(
                    alignment: const Alignment(-0.97, -1.0),
                    child: DrawerButton(),
                  ),
                if (Navigator.canPop(context))
                  Align(
                    alignment: const Alignment(-0.97, -1.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      tasteUser.isMe
                          ? IconButton(
                              icon: StreamBuilder<bool>(
                                stream: hasUnseenMessagesStream,
                                initialData: false,
                                builder: (_, snapshot) {
                                  return snapshot.data
                                      ? const Icon(FontAwesome.comment,
                                          color: kSecondaryButtonColor)
                                      : const Icon(FontAwesome.comment_o);
                                },
                              ),
                              onPressed: () => quickPush(TAPage.conversations,
                                  (_) => const MessagesPage()),
                            )
                          : MoreUserOptionsButton(user: tasteUser),
                      tasteUser.isMe
                          ? Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: NotificationsButton())
                          : null
                    ].withoutNulls,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 20.0,
            child: Center(
              child: Text(
                "@${tasteUser.username}",
                style: const TextStyle(
                    fontFamily: "Quicksand",
                    color: kTasteBrandColor, // const Color(0xff2f3542),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: ((tasteUser.profileImage(thumb: false)?.isEmpty ??
                                  true) &&
                              (!tasteUser.isMe))
                          ? null
                          : () => quickPush(
                                TAPage.profile_photo,
                                (context) => Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: Colors.black,
                                    brightness: Brightness.dark,
                                    iconTheme: const IconThemeData(
                                      color: Colors.white,
                                    ),
                                    actions: tasteUser.isMe
                                        ? [UserSettingsButton()]
                                        : [],
                                  ),
                                  body: Container(
                                    color: Colors.black,
                                    alignment: Alignment.center,
                                    child: PhotoView.customChild(
                                      minScale: 1.0,
                                      maxScale: 1.0,
                                      child: fixedFirePhoto(tasteUser
                                              .profileImage(thumb: false))
                                          .progressive(
                                        Resolution.full,
                                        Resolution.medium,
                                        BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      child: Container(
                        width: 95,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Hero(
                                    tag: profilePage.widget.heroTag ??
                                        ProfilePictureHeroTag(
                                            tasteUser.reference),
                                    child: ProfilePhoto(
                                        user: tasteUser.reference,
                                        radius: 40.0))),
                            StreakButton(user: tasteUser)
                          ],
                        ),
                      ),
                    ),
                    UserRankWidget(user: tasteUser),
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ProfileSummaries(
                    tasteUser: tasteUser,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileSummaries extends StatelessWidget {
  const ProfileSummaries({Key key, @required this.tasteUser}) : super(key: key);

  final TasteUser tasteUser;

  @override
  Widget build(BuildContext context) {
    final profilePage = ProfilePage.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Row(
            children: <Widget>[
              StreamBuilder<int>(
                stream: profilePage.postCount,
                initialData: profilePage.postCount.value,
                builder: (context, snapshot) {
                  return Expanded(
                    flex: 5,
                    child: NumberSummary(
                        present: snapshot.hasData,
                        number: snapshot.data,
                        text: "POSTS"),
                  );
                },
              ),
              ValueStreamBuilder<Set<DocumentReference>>(
                stream: profilePage.followers,
                builder: (context, snapshot) {
                  final list = snapshot.data?.toList() ?? [];
                  return Expanded(
                    flex: 5,
                    child: FlatButton(
                      onPressed: list.isEmpty
                          ? null
                          : () async {
                              final users = await spinner(() =>
                                  list.futureMap((t) => t.fetch<TasteUser>()));
                              return quickPush(
                                TAPage.followers_list,
                                (context) => UserList(
                                  users: users,
                                  title: "${tasteUser.nameAsOwner} followers",
                                ),
                              );
                            },
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: NumberSummary(
                          present: snapshot.hasData,
                          number: list.length,
                          text: "FOLLOWERS"),
                    ),
                  );
                },
              ),
              ValueStreamBuilder<Set<DocumentReference>>(
                stream: profilePage.following,
                builder: (context, snapshot) {
                  final list = snapshot.data?.toList() ?? [];
                  return Expanded(
                    flex: 5,
                    child: FlatButton(
                      onPressed: list.isEmpty
                          ? null
                          : () async {
                              final users = await spinner(() =>
                                  list.futureMap((t) => t.fetch<TasteUser>()));
                              return quickPush(
                                  TAPage.following_list,
                                  (_) => UserList(
                                        users: users,
                                        title: "${tasteUser.name} follows",
                                      ));
                            },
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: NumberSummary(
                          present: snapshot.hasData,
                          number: list.length,
                          text: "FOLLOWING"),
                    ),
                  );
                },
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ),
        const SizedBox(height: 22.0),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(flex: 1, child: Container()),
              if (tasteUser.isMe)
                Expanded(
                  flex: 26,
                  child: FindFriendsButton(tasteUser: tasteUser),
                )
              else
                Expanded(
                  flex: 26,
                  child: FollowButton(
                      userReference: tasteUser.reference,
                      stream: profilePage.amIFollowing),
                ),
              Expanded(flex: 5, child: Container()),
              Expanded(
                flex: 26,
                child: TasteButton(
                  text: "${tasteMapButtonPrefix()} Map",
                  options: kTastePrimaryButtonOptions,
                  onPressed: () async => goToUserMapView(context, tasteUser),
                ),
              ),
              Expanded(flex: 3, child: Container()),
            ],
          ),
        ),
      ],
    );
  }

  String tasteMapButtonPrefix() {
    if (tasteUser.firstName.length > 6) {
      return "Taste";
    }
    return tasteUser.nameAsOwner;
  }
}

// Follow -> Message button change feels weird. Leaving code here in case we
// can make it work.
class FollowOrMessageButton extends StatelessWidget {
  const FollowOrMessageButton({
    Key key,
    this.amIFollowing,
    this.tasteUser,
  }) : super(key: key);

  final ValueStream<bool> amIFollowing;
  final TasteUser tasteUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: amIFollowing,
        initialData: false,
        builder: (_, snapshot) {
          return snapshot.data
              ? Expanded(
                  flex: 26,
                  child: TasteButton(
                    text: 'Message',
                    onPressed: () => startConversation(
                      otherUser: tasteUser,
                    ),
                    options: kSimpleButtonOptions,
                  ),
                )
              : Expanded(
                  flex: 26,
                  child: FollowButton(
                      userReference: tasteUser.reference, stream: amIFollowing),
                );
        });
  }
}

class NumberSummary extends StatelessWidget {
  const NumberSummary(
      {Key key,
      @required this.number,
      @required this.text,
      @required this.present})
      : super(key: key);

  final int number;
  final String text;
  final bool present;

  String get countString => number?.toString() ?? '';

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Visibility(
        maintainAnimation: true,
        maintainSize: true,
        maintainState: true,
        visible: present,
        child: Text(
          countString,
          style: const TextStyle(
              fontFamily: "Quicksand",
              color: Color(0xff2f3542),
              fontSize: 18.0,
              fontWeight: FontWeight.w700),
        ),
      ),
      const SizedBox(height: 5.0),
      Text(
        text,
        style: const TextStyle(
            fontFamily: "Quicksand",
            color: Color(0xffb0b2b7),
            fontSize: 12.0,
            fontWeight: FontWeight.w600),
      )
    ]);
  }
}

class MoreUserOptionsButton extends StatelessWidget {
  const MoreUserOptionsButton({Key key, @required this.user}) : super(key: key);
  final TasteUser user;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: !user.isMe,
        child: IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => showTasteBottomSheetWithItems(
            context,
            [
              TasteBottomSheetItem(
                title: 'Message',
                callback: () => startConversation(
                  otherUser: user,
                ),
              ),
              TasteBottomSheetItem(
                title: 'Report User',
                callback: () => reportContent(context, user),
              ),
            ],
          ),
        ),
      );
}
