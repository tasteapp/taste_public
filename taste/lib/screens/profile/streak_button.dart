import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/taste_backend_client/responses/badge.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste_protos/taste_protos.dart' show Badge_BadgeType;

import 'profile.dart';

class StreakButton extends StatelessWidget {
  const StreakButton({Key key, this.user}) : super(key: key);

  final TasteUser user;

  Stream<Badge> get stream => user.badge(Badge_BadgeType.streak_active);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Badge>(
        stream: stream,
        builder: (context, snapshot) {
          if ((snapshot.data?.countValue ?? 0) < 1) {
            return Container();
          }
          final badge = snapshot.data;
          return InkWell(
            onTap: () {
              TAEvent.tapped_badge_streak_button(
                  {'streak_user': user.reference.path});
              ProfilePageState.goToBadges(context);
            },
            child: StreakBadgeWidget(badge: badge),
          );
        });
  }
}

class StreakBadgeWidget extends StatelessWidget {
  const StreakBadgeWidget({
    Key key,
    @required this.badge,
    double badgeSize,
  })  : size = badgeSize ?? 30,
        super(key: key);

  final Badge badge;
  final double size;

  @override
  Widget build(BuildContext context) => RowSuper(
          alignment: Alignment.bottomRight,
          innerDistance: -size / 2,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: size / 5),
                child: Icon(Icons.whatshot,
                    size: size, color: Colors.orangeAccent)),
            Card(
                elevation: 3,
                shape: const CircleBorder(),
                child: Container(
                    height: size / 2,
                    width: size / 2,
                    alignment: Alignment.center,
                    child: AutoSizeText(badge.countValue.toString(),
                        style: TextStyle(fontSize: size / 2.5),
                        maxFontSize: 22)))
          ]);
}
