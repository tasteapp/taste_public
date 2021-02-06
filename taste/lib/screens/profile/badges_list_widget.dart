import 'package:flutter/material.dart';
import 'package:taste/taste_backend_client/responses/badge.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';

import '../../utils/extensions.dart';
import 'badge_tile.dart';

class BadgesListWidget extends StatelessWidget {
  const BadgesListWidget({Key key, @required this.user}) : super(key: key);

  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Badge>>(
        stream: user.badges.map((l) => l.values
            .tupleSort((b) => [if (b.isInactive) 1 else -1, b.sortRank])
            .toList()),
        initialData: const [],
        builder: (context, snapshot) {
          final badges = snapshot.data ?? [];
          if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                  child: Text(
                "Sorry! We're having trouble loading badges, please check back later.",
                textAlign: TextAlign.center,
              )),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child: CustomScrollView(slivers: <Widget>[
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber above.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: badges
                      .map((b) => BadgeTile(
                            key: b.key,
                            badge: b,
                            user: user,
                          ))
                      .toList()),
            ]),
          );
        });
  }
}
