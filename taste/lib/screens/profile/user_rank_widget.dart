import 'package:flutter/material.dart';
import 'package:taste/components/icons.dart';
import 'package:taste/screens/character_level_page.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/utils.dart';

const _style = TextStyle(
    color: Color(0xffb0b2b7), fontSize: 12.0, fontWeight: FontWeight.w600);

class UserRankWidget extends StatelessWidget {
  const UserRankWidget({Key key, this.user}) : super(key: key);
  final TasteUser user;

  @override
  Widget build(BuildContext context) => FlatButton(
      onPressed: () {
        TAEvent.tapped_user_rank({'rank_user': user.reference.path});
        quickPush(TAPage.user_leaderboard_page,
            (_) => CharacterLevelPage(user: user));
      },
      child: StreamBuilder<int>(
          stream: user.rank,
          builder: (c, s) => Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(FireIcons.fire,
                      size: 10.0, color: Color(0xfff45e34)),
                ),
                const Text("Rank: ", style: _style),
                !s.hasData ? null : Text("${s.data}", style: _style),
              ].withoutNulls)));
}
