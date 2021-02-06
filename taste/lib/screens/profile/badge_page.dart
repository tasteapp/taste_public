import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/badge.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste_protos/taste_protos.dart' show Badge_BadgeType;

import 'badge_tile.dart';

class BadgePage extends StatelessWidget {
  const BadgePage({Key key, @required this.badge, @required this.user})
      : super(key: key);
  final Badge badge;
  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(badge.details.description, style: kAppBarTitleStyle),
            centerTitle: true,
            actions: [
              IconButton(
                icon: ProfilePhoto(
                  user: user.reference,
                  radius: 15,
                ),
                onPressed: user.goToProfile,
              )
            ]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(tag: badge, child: badge.sizedIcon(100)),
              ),
              if (badge.details.extraPanel == null)
                null
              else
                () {
                  final panel = badge.details.extraPanel(context, badge, user);
                  return panel == null
                      ? null
                      : Card(
                          margin: const EdgeInsets.all(20.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: panel)));
                }(),
              Card(
                margin: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(badge.details.explanation,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 14.0)),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Hero(
                            tag: HeroBadgeLevelTag(badge),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: badge?.level?.sizedIcon(40) ??
                                  const Icon(Icons.lock,
                                      size: 40, color: Colors.grey),
                            )),
                        Text(
                            user.isMe
                                ? (badge?.level != null
                                    ? 'You have the ${badge.level.toString().split('.').last} for ${badge.details.description}! Keep using Taste to level up!'
                                    : 'Keep using Taste to unlock this badge!')
                                : (badge?.level == null
                                    ? '${user.name} has not unlocked this badge yet.'
                                    : '${user.name} has the ${badge.level.toString().split('.').last} for ${badge.details.description}.'),
                            style: const TextStyle(fontSize: 14.0)),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                  margin: const EdgeInsets.all(20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          "Badge Holders for ${badge.details.description}",
                          presetFontSizes: const [14, 18, 24],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      Flexible(
                        child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 300),
                            child: StreamBuilder<List<Badge>>(
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListView.separated(
                                    itemBuilder: (context, i) {
                                      final badge = snapshot.data[i];
                                      return Container(
                                        color: badge.userReference ==
                                                currentUserReference
                                            ? Colors.lightGreen.withOpacity(0.5)
                                            : null,
                                        child: ListTile(
                                          dense: true,
                                          subtitle: ({
                                                Badge_BadgeType.daily_tasty:
                                                    () => Text(
                                                        '${badge.countValue} ${badge.countValue == 1 ? 'Daily Tasty' : 'Daily Tasties'}'),
                                                Badge_BadgeType.quarantine:
                                                    () => Text(
                                                        '${badge.countValue} Homebody Post${badge.countValue == 1 ? '' : 's'}'),
                                                Badge_BadgeType
                                                        .post_cities_total:
                                                    () => Text(
                                                        '${badge.countValue} ${badge.countValue == 1 ? 'City' : 'Cities'} Posted'),
                                                Badge_BadgeType.city_champion:
                                                    () => Text(
                                                        '${badge.countValue} ${badge.countValue == 1 ? 'City' : 'Cities'}'),
                                                Badge_BadgeType.burgermeister:
                                                    () => Text(
                                                        '${badge.countValue} ${badge.countValue == 1 ? 'Burger' : 'Burgers'} Added'),
                                                Badge_BadgeType.brainiac: () =>
                                                    Text(
                                                        '${badge.countValue} ${badge.countValue == 1 ? 'Auto-Tag' : 'Auto-Tags'} Points'),
                                                Badge_BadgeType.sushinista:
                                                    () => Text(
                                                        '${badge.countValue} Sushi Added'),
                                                Badge_BadgeType.streak_active:
                                                    () => Text(
                                                        '${badge.countValue} Week Streak'),
                                                Badge_BadgeType.regular: () => Text(
                                                    'Regular at ${badge.countValue} ${badge.countValue == 1 ? 'Place' : 'Places'}'),
                                                Badge_BadgeType.herbivore: () =>
                                                    Text(
                                                        '${badge.countValue} ${badge.countValue == 1 ? 'Veggie Post' : 'Veggie Posts'}'),
                                                Badge_BadgeType.ramsay: () => Text(
                                                    '${badge.countValue} ${badge.countValue == 1 ? 'Home Meal' : 'Home Meals'} Posted'),
                                                Badge_BadgeType
                                                        .emoji_flags_level_1:
                                                    () => Text(badge
                                                        .proto.emojiFlags.flags
                                                        .join('')),
                                                Badge_BadgeType
                                                        .commenter_level_1:
                                                    () => Text(
                                                        '${badge.countValue} ${badge.countValue == 1 ? 'Comment' : 'Comments'} Added'),
                                              }[badge.type] ??
                                              () => null)(),
                                          title: FutureBuilder<TasteUser>(
                                              future: badge.user,
                                              builder: (context, snapshot) =>
                                                  snapshot.hasData
                                                      ? Text(snapshot.data.name)
                                                      : Container()),
                                          onTap: () async {
                                            TAEvent
                                                .clicked_badge_leaderboard_tile({
                                              'type': badge.type.name,
                                              'other_user':
                                                  badge.userReference.path
                                            });
                                            await badge.goTo();
                                          },
                                          trailing: (<Badge_BadgeType,
                                                  Widget Function()>{
                                                Badge_BadgeType.quarantine:
                                                    () => Text('#${i + 1}'),
                                                Badge_BadgeType.character: () =>
                                                    FoodSpiritIcon(
                                                        spirit:
                                                            foodlebrity(badge),
                                                        size: 30),
                                              }[badge.type] ??
                                              () => badge.level.icon)(),
                                          leading: Container(
                                            height: 30,
                                            width: 30,
                                            child: FutureBuilder<TasteUser>(
                                                future: badge.user,
                                                builder: (context, snapshot) =>
                                                    snapshot.hasData
                                                        ? ProfilePhoto(
                                                            user: snapshot.data
                                                                ?.reference,
                                                          )
                                                        : Container()),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, i) =>
                                        const Divider(),
                                    itemCount: snapshot.data.length);
                              },
                              stream: badge.leaderboard,
                            )),
                      )
                    ]),
                  ))
            ].withoutNulls,
          ),
        ));
  }
}
