import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/components/taste_progress_indicator.dart';
import 'package:taste/providers/account_provider.dart';
import 'package:taste/providers/firebase_user_provider.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/loading.dart';

import '../connect_account_screen.dart';

const double kSignInButtonWidth = 240.0;

/// Returns a themed sign in button with the named arguments.
class ThemeSignInButton extends StatelessWidget {
  const ThemeSignInButton({
    Key key,
    @required this.text,
    this.iconPath,
    @required this.type,
    this.buttonColor = Colors.white,
    this.textColor = Colors.black,
    this.icon,
    this.hasBorder = false,
  })  : assert((icon == null) ^ (iconPath == null)),
        super(key: key);
  final String text;
  final String iconPath;
  final LoginType type;
  final Color buttonColor;
  final Color textColor;
  final Icon icon;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    final leadingIcon = icon ??
        Image.asset(
          iconPath,
          height: 20,
        );
    return Visibility(
      visible: !isConnecting(context) || type.canLink,
      child: ButtonTheme(
        minWidth: kSignInButtonWidth,
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
        buttonColor: buttonColor,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: kSignInButtonWidth,
          ),
          child: RaisedButton(
            onPressed:
                isConnecting(context) ? type.onLink(context) : type.onSignIn,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: hasBorder
                  ? BorderSide(width: 2.0, color: Colors.grey[300])
                  : BorderSide.none,
            ),
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 15),
                leadingIcon,
                Expanded(
                  child: AutoSizeText(
                    text,
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 15,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInFacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const ThemeSignInButton(
        buttonColor: Color(0xFF4267B2),
        textColor: Colors.white,
        type: LoginType.fb,
        text: 'Sign in with Facebook',
        iconPath: 'assets/3p_icons/fb-logo.png',
      );
}

class SignInAppleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const ThemeSignInButton(
        buttonColor: kDarkGrey,
        textColor: Colors.white,
        type: LoginType.apple,
        text: 'Sign in with Apple',
        iconPath: 'assets/3p_icons/apple-logo.png',
      );
}

class SignInGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const ThemeSignInButton(
        buttonColor: Colors.white,
        textColor: kDarkGrey,
        type: LoginType.google,
        text: 'Sign in with Google',
        iconPath: 'assets/3p_icons/google-logo.png',
        hasBorder: true,
      );
}

class GuestModeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const ThemeSignInButton(
        buttonColor: Colors.white,
        textColor: kDarkGrey,
        type: LoginType.guest,
        text: 'Proceed as Guest',
        icon: Icon(Icons.person),
        hasBorder: true,
      );
}

class SignInEmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const ThemeSignInButton(
        buttonColor: Colors.white,
        textColor: kDarkGrey,
        type: LoginType.email,
        text: 'Dev: Sign in with Email',
        icon: Icon(Icons.email),
      );
}

const _spinner = TasteLargeCircularProgressIndicator();

extension on LoginType {
  void onSignIn() {
    TAEvent.clicked_sign_in({'type': key});
    spinner(login, spinner: _spinner, onError: (_, __) {
      TAEvent.failed_sign_in({'type': key});
      snackBarString(
          'Error signing in... please try again or report the issue to '
          'team@trytaste.app.');
    });
  }

  Future Function() onLink(BuildContext context) => () async {
        TAEvent.clicked_link_account({'type': key});
        var failed = false;
        await spinner(
            () async => link(await tasteFirebaseUser
                .valueMap(
                    (u) => u.maybeWhen(user: identity, orElse: () => null))
                .withoutNulls
                .first), onError: (_, __) {
          failed = true;
          TAEvent.failed_link_account({'type': key});
          snackBarString(
              'Error linking account... please try again or report the issue to '
              'team@trytaste.app.');
        });
        if (!failed) {
          snackBarString('Successfully linked new account!');
          Navigator.pop(context);
        }
      };
}
