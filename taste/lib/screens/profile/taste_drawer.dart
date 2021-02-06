import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:share/share.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/screens/log_in/connect_account_screen.dart';
import 'package:taste/screens/profile/notifications/user_settings_button.dart';
import 'package:taste/screens/report_bug/report_bug.dart';
import 'package:taste/screens/report_bug/talk_to_us.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/taste_backend_client/value_stream_builder.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' show BugReportType;

const _overlayColor = Color(0xFFFAFAFA);

class TasteDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MediaQuery.removePadding(
        context: context,
        // DrawerHeader consumes top MediaQuery padding.
        removeTop: true,
        child: Drawer(
          child: Container(
            color: _overlayColor,
            child: ListView(
                children: ListTile.divideTiles(
                        context: context,
                        tiles: [
                          _DrawerHeader(),
                          // InstagramImportTile(),
                          _DailyDigestTile(),
                          ListTile(
                              leading: const Icon(Icons.bug_report),
                              title: const Text('Report a bug'),
                              onTap: () {
                                Navigator.pop(context);
                                TAEvent.clicked_report_bug();
                                quickPush(
                                    TAPage.report_bug,
                                    (_) => const UserReportScreen(
                                        type: BugReportType.bug_report));
                              }),
                          ListTile(
                              leading: const Icon(Icons.feedback),
                              title: const Text('Talk with us!'),
                              onTap: () async {
                                Navigator.pop(context);
                                final user = await cachedLoggedInUser;
                                await quickPush(TAPage.talk_with_us,
                                    (_) => TalkToUsPage(user: user));
                              }),
                          ListTile(
                              leading: const Icon(Icons.people),
                              title: const Text('Invite Friends'),
                              onTap: () async {
                                Navigator.pop(context);
                                TAEvent.clicked_share_taste();
                                await Share.share(
                                    'Check out Taste @ https://trytaste.app!');
                              }),
                          const SignOutTile()
                        ].withoutNulls)
                    .toList()),
          ),
        ),
      );
}

class _DrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.copyWith(
                bodyText1: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        child: ValueStreamBuilder<TasteUser>(
            stream: tasteUserStream,
            builder: (context, snapshot) {
              return InkWell(
                  onTap: goToUserSettings,
                  child: Container(
                    color: kPrimaryButtonColor,
                    padding: const EdgeInsets.only(top: 30),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(children: <Widget>[
                        Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              ProfilePhoto(
                                  radius: 50, user: snapshot.data.reference),
                              Card(
                                  color: Colors.white.withOpacity(0.8),
                                  elevation: 5,
                                  shape: const CircleBorder(),
                                  child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.edit, size: 14)))
                            ]),
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(snapshot.data?.name ?? '',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      (snapshot.data?.username ?? '').isEmpty
                                          ? ''
                                          : '@${snapshot.data.username}',
                                      style: const TextStyle(
                                          color: Colors.white))),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Edit Account",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              )
                            ]))
                      ]),
                    ),
                  ));
            }),
      );
}

class DrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
      icon: Icon(Icons.menu, color: Colors.black.withOpacity(0.75)),
      onPressed: () => Scaffold.of(context).openDrawer());
}

class _DailyDigestTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ValueStreamBuilder<TasteUser>(
        stream: tasteUserStream,
        builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: ListTile(
            onTap: () => snapshot.data.reference.updateData({
              'daily_digest.enabled':
                  !(snapshot.data?.proto?.dailyDigest?.enabled ?? false)
            }),
            title: const Text("Daily Digest"),
            subtitle: const Text(
                "Get notified on new posts from people you care about"),
            leading: snapshot.data?.proto?.dailyDigest?.enabled ?? false
                ? const Icon(Icons.check_box, color: Colors.blue)
                : const Icon(Icons.check_box_outline_blank),
          ),
        ),
      );
}

class SwitchAccountTile extends StatelessWidget {
  const SwitchAccountTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<TasteUser>(
        stream: tasteUserStream,
        builder: (context, snapshot) => snapshot.data?.proto?.guestMode ?? false
            ? const ConnectAccountTile()
            : const SignOutTile(),
      );
}

class SignOutTile extends StatelessWidget {
  const SignOutTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
      leading: const Icon(FontAwesome.sign_out),
      title: const Text('Sign out'),
      onTap: FirebaseAuth.instance.signOut);
}

class ConnectAccountTile extends StatelessWidget {
  const ConnectAccountTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
      leading: const Icon(FontAwesome.link),
      title: const Text('Connect Account'),
      onTap: () =>
          TAPage.connect_account_page(widget: const ConnectAccountScreen()));
}
