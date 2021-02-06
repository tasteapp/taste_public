import 'package:flutter/material.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/utils.dart';

import 'contest_page.dart';

class DailyTastyBadge extends StatelessWidget {
  const DailyTastyBadge({Key key, this.size = 20, this.today = false})
      : super(key: key);
  final double size;
  final bool today;

  @override
  Widget build(BuildContext context) => Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
          onTap: () {
            TAEvent.tapped_daily_tasty_logo();
            quickPush(
              TAPage.daily_tasty,
              (_) => const ContestPage(),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(size / 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                today
                    ? Text("Today's ", style: TextStyle(fontSize: size))
                    : null,
                DailyTastyBadgeInner(size: size),
              ].withoutNulls,
            ),
          )));
}

class DailyTastyBadgeInner extends StatelessWidget {
  const DailyTastyBadgeInner({
    Key key,
    @required this.size,
    this.twoLines = false,
  }) : super(key: key);

  final double size;
  final bool twoLines;

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          text: "Daily".append(twoLines ? '\n' : ''),
          children: const [
            TextSpan(
                text: "Tasty", style: TextStyle(color: kTasteBrandColorLeft))
          ],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: size),
        ),
        textAlign: TextAlign.center,
        style: TextStyle(height: twoLines ? 0.95 : null),
      );
}
