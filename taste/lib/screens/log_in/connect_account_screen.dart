import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:taste/app_config.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/extensions.dart';

import 'components/buttons.dart';

bool isConnecting(BuildContext context) {
  try {
    return Provider.of<_Wrap>(context).link;
  } catch (_) {
    return false;
  }
}

class ConnectAccountScreen extends StatelessWidget {
  const ConnectAccountScreen();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Connect Account",
              style: kAppBarTitleStyle,
            )),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: LoginButtonsGroup(connect: true),
          ),
        ),
      );
}

class LoginButtonsGroup extends StatelessWidget {
  const LoginButtonsGroup({
    Key key,
    @required this.connect,
  }) : super(key: key);
  final bool connect;

  @override
  Widget build(BuildContext context) => Provider.value(
        value: _Wrap(connect),
        child: Column(
          children: [
            SignInFacebookButton(),
            const SizedBox(height: 10),
            Platform.isIOS ? SignInAppleButton() : SignInGoogleButton(),
            const SizedBox(height: 10),
            GuestModeButton(),
            isDev ? SignInEmailButton() : null,
          ].withoutNulls,
        ),
      );
}

class _Wrap {
  _Wrap(this.link);
  final bool link;
}
