import 'package:flutter/material.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/collection_type.dart';

import 'leaderboard_help_button.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key key, this.user}) : super(key: key);
  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard", style: kAppBarTitleStyle),
        centerTitle: true,
        actions: [LeaderboardHelpButton()],
      ),
      body: FutureBuilder<List<TasteUser>>(
        future: CollectionType.users.coll
            .orderBy('score', descending: true)
            .limit(50)
            .fetch(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
              children: ListTile.divideTiles(
                  context: context,
                  tiles: snapshot.data.asMap().entries.map((entry) {
                    final rank = entry.key + 1;
                    final user = entry.value;
                    final style = TextStyle(
                        fontWeight: user.reference == this?.user?.reference
                            ? FontWeight.bold
                            : null);
                    return Container(
                      color: user.reference == this.user.reference
                          ? kTasteBrandColor.withOpacity(0.5)
                          : null,
                      child: ListTile(
                          onTap: user.goToProfile,
                          leading:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            Text(
                              rank.toString(),
                              style: style,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ProfilePhoto(
                                user: user.reference,
                                radius: 20,
                              ),
                            ),
                          ]),
                          title: Text(
                            user.name ?? "Anonymous",
                            style: style,
                          ),
                          trailing: Text(user.score?.toString() ?? "No score?",
                              style: style)),
                    );
                  })).toList());
        },
      ),
    );
  }
}
