import 'package:flutter/material.dart';
import 'package:taste/components/nav/nav.dart';
import 'package:taste/screens/set_up_account/set_up_account.dart';
import 'package:taste/utils/utils.dart';

class UserSettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const IconButton(icon: Icon(Icons.edit), onPressed: goToUserSettings);
}

Future goToUserSettings([bool firstLaunch = false]) {
  hideNavBar();
  return quickPush(
      TAPage.edit_account, (_) => SetUpAccountScreen(firstLaunch: firstLaunch));
}
