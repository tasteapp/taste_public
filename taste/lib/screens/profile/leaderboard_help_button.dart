import 'package:flutter/material.dart';
import 'package:taste/utils/utils.dart';

import 'leaderboard_help_page.dart';

class LeaderboardHelpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
      icon: const Icon(Icons.help),
      onPressed: () => quickPush(TAPage.user_leaderboard_help_page,
          (context) => LeaderboardHelpPage()));
}
