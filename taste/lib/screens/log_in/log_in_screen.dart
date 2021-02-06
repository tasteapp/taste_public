import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taste/screens/log_in/intro_tabs.dart';

import 'components/terms_and_policy_text.dart';
import 'connect_account_screen.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              'assets/ui/log_in_yellow_bean_bottom.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.23,
              fit: BoxFit.none,
              scale: 3,
              alignment: Alignment.topCenter,
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 28,
                  child: IntroTabs(),
                ),
                const LoginButtonsGroup(connect: false),
                const Spacer(),
                Expanded(
                  flex: 6,
                  child: Align(
                    alignment: const Alignment(0.0, -0.5),
                    child: TermsAndPolicyText(),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
