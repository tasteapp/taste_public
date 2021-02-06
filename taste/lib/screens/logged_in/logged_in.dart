import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deferrable/deferrable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taste/components/nav/nav.dart';
import 'package:taste/components/taste_progress_indicator.dart';
import 'package:taste/providers/account_provider.dart';
import 'package:taste/providers/remote_config.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/character_level_dialog.dart';
import 'package:taste/screens/connect_users/ask_phone_number.dart';
import 'package:taste/screens/log_in/components/not_supported_page.dart';
import 'package:taste/screens/profile/notifications/user_settings_button.dart';
import 'package:taste/screens/profile/profile.dart';
import 'package:taste/screens/set_up_account/set_up_account.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/badge.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/taste_backend_client/value_stream_builder.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/debug.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' show TAPage;

class LoggedInView extends StatefulWidget {
  const LoggedInView();

  @override
  State<StatefulWidget> createState() {
    return _LoggedInViewState();
  }
}

class _LoggedInViewState extends State<LoggedInView> with Deferrable {
  Timer timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      while (!isDisposed) {
        // Don't refactor this, as we explicitly need to make sure
        // scheduledChecks() does not have concurrent calls.
        await scheduledChecks();
        await Future.delayed(const Duration(seconds: 15));
      }
    });
    defer(foodSpiritStream.withoutNulls
        .pairwise()
        .where((a) => a.first?.b?.uid == a.last?.b?.uid)
        .map((p) => p.a)
        .where((pair) {
          final scoreA = pair.first?.score ?? -1;
          final scoreB = pair.last?.score ?? -1;
          return scoreA >= 0 && scoreB >= 0 && scoreA < scoreB;
        })
        .map((pair) => pair.last)
        .listen((spirit) => showDialog(
            context: context,
            useRootNavigator: true,
            builder: (_) => CharacterLevelDialog(spirit: spirit)))
        .cancel);
  }

  Future<void> scheduledChecks() async {
    // Ensure load from server since cached result could lead to bad user
    // experience.
    final user =
        TasteUser.from(await currentUserReference.get(source: Source.server));

    // Ensure fb_id is stored on user.
    if (await hasConnectedWithFb() && (user.proto.fbId ?? '').isEmpty) {
      final accessToken = await facebookLogin.currentAccessToken;
      final response = await http.get('https://graph.facebook.com/v6.0/me?'
          'access_token=${accessToken.token}');
      if (response.statusCode == 200) {
        final userId = jsonDecode(response.body)["id"];
        await user.reference.updateData({'fb_id': userId});
      }
    }
    final prefs = await SharedPreferences.getInstance();
    String phoneNumber = user.phoneNumber;
    if (phoneNumber.isEmpty &&
        (prefs.getBool('has_asked_phone_number') ?? false)) {
      unawaited(prefs.setBool('has_asked_phone_number', true));
      await quickPush(
          TAPage.ask_phone_number, (_) => const AskPhoneNumberWidget());
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TasteUser>(
      stream: tasteUserStream,
      initialData: tasteUserStream.value,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: TasteLargeCircularProgressIndicator());
        }
        final tasteUser = snapshot.data;
        if (!tasteUser.hasSetUpAccount) {
          return const SetUpAccountScreen(firstLaunch: true);
        }
        return FutureBuilder<bool>(
          future: isVersionSupported(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: TasteLargeCircularProgressIndicator());
            }
            if (!snapshot.data) {
              return const Center(child: NotSupportedPage());
            }
            return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    const TabbedPage(),
                    Visibility(
                      visible: tasteDebugMode(context),
                      child: Container(height: 3, color: Colors.red),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }
}

final inactiveColor = kDarkGrey.withOpacity(0.75);
const activeNavColor = Color(0xFF59794E);

class NavIcon extends StatelessWidget {
  const NavIcon(this.icon, [this.active = false]) : super();
  final IconData icon;
  final bool active;

  Color get color => active ? activeNavColor : inactiveColor;
  double get size => active ? 30 : 26;

  @override
  Widget build(BuildContext context) => Icon(icon, color: color, size: size);
}

class HomeUserWidget extends StatelessWidget {
  const HomeUserWidget();
  @override
  Widget build(BuildContext context) {
    return ValueStreamBuilder<TasteUser>(
      stream: tasteUserStream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ProfilePage(tasteUser: snapshot.data);
      },
    );
  }
}
