import 'package:flutter/material.dart';
import 'package:taste/screens/connect_users/fb_friends.dart';
import 'package:taste/screens/connect_users/find_contacts.dart';
import 'package:taste/screens/connect_users/recommendations.dart';
import 'package:taste/screens/user_list/user_list.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/theme/buttons.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/utils.dart';

import '../../app_config.dart';

class FindFriendsButton extends StatelessWidget {
  const FindFriendsButton({Key key, @required this.tasteUser})
      : super(key: key);
  final TasteUser tasteUser;

  @override
  Widget build(BuildContext context) {
    return TasteButton(
      text: "Find Friends",
      options: kTastePrimaryButtonOptions,
      onPressed: () => quickPush(
          TAPage.find_friends, (context) => const FindFriendsWidget()),
    );
  }
}

class FindFriendsWidget extends StatelessWidget {
  const FindFriendsWidget();

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const Tab(text: "Suggestions"),
      const Tab(text: "From Contacts"),
    ];
    final recs = recommendations(context);
    final tabViews = [
      recs == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<TasteUser>>(
              stream: recs.streamCombine((r) => r.stream()),
              builder: (context, snapshot) {
                return UserListBody(users: snapshot.data ?? []);
              }),
      const FindContacts(),
    ];
    if (isDev) {
      tabs.add(Tab(
        icon: Image.asset(
          'assets/3p_icons/fb-logo-color.png',
          height: 20,
        ),
      ));
      tabViews.add(const FacebookFriends());
    }
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Find Friends", style: kAppBarTitleStyle),
          centerTitle: true,
          bottom: TabBar(tabs: tabs),
        ),
        body: TabBarView(children: tabViews),
      ),
    );
  }
}
