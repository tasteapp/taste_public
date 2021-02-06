import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/components/taste_progress_indicator.dart';
import 'package:taste/screens/profile/leaderboard_page.dart';
import 'package:taste/screens/profile/simple_review_widget.dart';
import 'package:taste/taste_backend_client/responses/badge_type.dart';
import 'package:taste/taste_backend_client/responses/review.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' show Badge_BadgeType;

import 'profile/leaderboard_help_button.dart';

class CharacterLevelPage extends StatelessWidget {
  const CharacterLevelPage({Key key, @required this.user}) : super(key: key);
  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          user.meOrUsername,
          maxLines: 1,
          style: kAppBarTitleStyle,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.score),
              onPressed: () => goToLeaderboard(context, user))
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ScoreCard(user: user),
                LevelCard(user: user),
                BestReviewCard(user: user),
              ].withoutNulls,
            ),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({Key key, @required this.title, @required this.body})
      : super(key: key);
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: const TextStyle(fontSize: 20)),
            ),
            body,
          ],
        ),
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  const ScoreCard({Key key, this.user}) : super(key: key);
  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return _Card(
        title: "Score: ${user.score}",
        body: Column(children: [
          const SizedBox(height: 8),
          StreamBuilder<int>(
            stream: user.rank,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return Text("Rank: ${snapshot.data}",
                  style: const TextStyle(fontSize: 20));
            },
          ),
          const SizedBox(height: 8),
          RaisedButton.icon(
            color: Colors.grey[200],
            icon: const Icon(Icons.score),
            label: const Text("Leaderboard"),
            onPressed: () => goToLeaderboard(context, user),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Climb the leaderboard by sharing your taste:"
              " Make posts, make friends, and ❤️ what they're putting out there"
              " on Taste!",
            ),
          ),
          LeaderboardHelpButton(),
        ]));
  }
}

class LevelCard extends StatelessWidget {
  const LevelCard({Key key, @required this.user}) : super(key: key);
  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FoodSpirit>(
        stream: user.foodSpirit,
        builder: (context, snapshot) {
          final spirit = snapshot.data;
          return InkWell(
            onTap: () async {
              final badge = await user.badge(Badge_BadgeType.character).first;
              if (badge == null) {
                return TAEvent.cannot_find_badge({
                  'badge_user': user.reference.path,
                  'bage_type': Badge_BadgeType.character.name,
                });
              }
              await badge.goTo();
            },
            child: _Card(
              title: "Taste Spirit Food",
              body: Builder(
                builder: (context) => FoodSpiritIcon(
                    spirit: spirit,
                    alignment: Alignment.bottomCenter,
                    size: MediaQuery.of(context).size.shortestSide * 0.5),
              ),
            ),
          );
        });
  }
}

Future goToLeaderboard(BuildContext context, TasteUser user) =>
    quickPush(TAPage.user_leaderboard_page, (_) => LeaderboardPage(user: user));

class BestReviewCard extends StatelessWidget {
  const BestReviewCard({Key key, this.user}) : super(key: key);
  final TasteUser user;

  @override
  Widget build(BuildContext context) => _Card(
      title: "Top-rated post",
      body: StreamBuilder<Review>(
          stream: user.topReview,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: TasteLargeCircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text("This user has not posted yet")),
              );
            }
            final review = snapshot.data;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 250,
                    child: SimpleReviewWidget(review: snapshot.data)),
                const SizedBox(height: 10),
                TopReviewStats(review: review),
              ],
            );
          }));
}

class TopReviewStats extends StatelessWidget {
  const TopReviewStats({
    Key key,
    @required this.review,
  }) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10.0,
          spacing: 15.0,
          children: ["Point", "Comment", "Like", "Bookmark", "View"]
              .zip([
                Stream.value(review.score),
                review.nComments,
                review.likes.map((l) => l.length),
                review.bookmarks.map((l) => l.length),
                review.views
              ])
              .zipMap((t, s) => StreamBuilder<int>(
                  stream: s,
                  builder: (context, snapshot) => Text.rich(TextSpan(children: [
                        TextSpan(
                            text: snapshot.data?.toString() ?? '',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' '.append(t.pluralize(snapshot.data ?? 0))),
                      ]))))
              .toList()),
    );
  }
}
