import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/screens/discover/components/review_in_list_widget.dart';
import 'package:taste/screens/discover/components/score_animation.dart';
import 'package:taste/screens/discover/discover.dart';
import 'package:taste/screens/profile/profile.dart';
import 'package:taste/screens/profile/simple_review_widget.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/daily_tasty_vote.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/logging.dart';
import 'package:taste/utils/posts_list_provider.dart';
import 'package:taste/utils/quick_stateful_widget.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/photo_regexp.dart';
import 'package:timezone/timezone.dart' as tz;

import 'daily_tasty_badge.dart';

class ContestPage extends StatelessWidget {
  const ContestPage();
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                bottom: const TabBar(
                  tabs: [
                    Tab(text: "Play now!"),
                    Tab(text: "Today"),
                    Tab(text: "Past Winners"),
                  ],
                ),
                title: const DailyTastyBadgeInner(size: 20),
                actions: [HelpButton()]),
            body: TabBarView(
                children: [VotingSection(), Leaderboard(), PreviousWinners()]
                    .enumerate
                    .entryMap((i, w) => TabKeepAliveWidget(w, i))
                    .toList())),
      );
}

final _la = tz.getLocation('America/Los_Angeles');
const _duration = Duration(days: 1);
final _beginning = DateTime(1970);

class Title extends StatelessWidget {
  const Title(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: AutoSizeText(text,
          style: const TextStyle(fontSize: 40),
          maxFontSize: 40,
          minFontSize: 14,
          maxLines: 1,
          overflow: TextOverflow.ellipsis));
}

class _Leader with EquatableMixin {
  _Leader(this.reference, this.review, this.votes);
  final Review review;
  final DocumentReference reference;
  final List<DailyTastyVote> votes;
  double get score =>
      normalizeDailyTastyVote(votes.average((t) => t.score), votes.length);
  int get voteCount => votes.length;

  String get path => reference.path;
  Stream<_Leader> stream() =>
      reference.stream<Review>().map((r) => _Leader(reference, r, votes));

  @override
  List<Object> get props => [review.path, voteCount];
}

class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TimeLeftWidget(),
        StreamBuilder<List<_Leader>>(
          stream: CollectionType.discover_items.coll
              .visible(context)
              .orderBy('awards.daily_tasty', descending: true)
              .limit(2)
              .stream<DiscoverItem>()
              .map((d) =>
                  d.listMap((d) => d.proto.awards.dailyTasty.toDateTime()))
              .map((s) => s.reversed.toList())
              .switchMap((previousTimes) {
            final now = DateTime.now();
            // The earliest eligible time for a post.
            final earliestPostTime = previousTimes.firstOrNull?.subtract(
                    previousTimes.length == 1 ? _duration : const Duration()) ??
                _beginning;
            // The latest eligible time for a post.
            final latestPostTime =
                previousTimes.lastOrNull ?? now.subtract(_duration);
            return [
              CollectionType.discover_items.coll
                  .visible(context)
                  .where('date', isGreaterThanOrEqualTo: earliestPostTime)
                  .where('date', isLessThanOrEqualTo: latestPostTime)
                  .where('is_instagram_post', isEqualTo: false)
                  .stream<DiscoverItem>(),
              CollectionType.discover_items.coll
                  .visible(context)
                  .where('imported_at',
                      isGreaterThanOrEqualTo: earliestPostTime)
                  .where('imported_at', isLessThanOrEqualTo: latestPostTime)
                  .where('is_instagram_post', isEqualTo: true)
                  .stream<DiscoverItem>()
                  .map((posts) => posts
                      .groupBy((input) => input.userReference)
                      .values
                      .expand((posts) => posts
                          .sorted((post) => post.createTime, desc: true)
                          .take(5)))
            ]
                .combineLatest
                .map((x) => x.flatten)
                .map((s) => s.keyOn((s) => s.postReference))
                .switchMap((eligibleReviews) => CollectionType
                    .daily_tasty_votes.coll
                    .where('date', isGreaterThanOrEqualTo: earliestPostTime)
                    .stream<DailyTastyVote>()
                    .map((votes) => votes
                        .where((v) => eligibleReviews.containsKey(v.post))
                        .groupBy((v) => v.post)
                        .entries
                        .entryMap(
                            (review, votes) => _Leader(review, null, votes))
                        // Tie-break by path to get sort stability.
                        .tupleSort((e) => [e.score, e.path], desc: true)
                        .take(4))
                    .deepMap((t) => t.stream()));
          }).distinct(listEquals),
          builder: (context, snapshot) => !snapshot.hasData
              ? const Center(child: CircularProgressIndicator())
              : snapshot.data.isEmpty
                  ? Container(
                      padding: const EdgeInsets.all(30),
                      alignment: Alignment.center,
                      child: const Text(
                          "No votes yet for today! Check back later"))
                  : PostsListProvider(
                      posts: snapshot.data.listMap((l) => l.review),
                      child: Wrap(
                        alignment: snapshot.data.length.isOdd
                            ? WrapAlignment.spaceBetween
                            : WrapAlignment.spaceEvenly,
                        children: snapshot.data.enumerate.listMap(
                          (r) => Padding(
                            key: ValueKey(r.value),
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Container(
                                    height: 250,
                                    child: SimpleReviewWidget(
                                        review: r.value.review,
                                        showMulti: false)),
                                Positioned.fill(
                                  bottom: null,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            elevation: 10,
                                            shape: const CircleBorder(
                                                side: BorderSide(
                                                    color: Colors.white,
                                                    width: 1)),
                                            child: ProfilePhoto(
                                                radius: 15,
                                                padding: EdgeInsets.zero,
                                                tapToProfileHero: true,
                                                user: r.value.review
                                                    .userReference)),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              r.key.place,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 3,
                                                    )
                                                  ],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30),
                                            ),
                                            Text(
                                              '${r.value.score.toStringAsPrecision(2)}/5.0',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 1,
                                                    )
                                                  ],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: FlatButton.icon(
            icon: const Icon(Icons.help_outline),
            label: const Text("Where is my post?"),
            onPressed: faq(context),
          ),
        ),
      ],
    );
  }
}

// For debugging, should be null in prod.
//ignore: avoid_init_to_null
double _random = null;
final _r = Random();
double get _seed => _random ?? _r.nextDouble();

class VotingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final seed = _seed;
    final votes = CollectionType.daily_tasty_votes.coll
        .forUser(currentUserReference)
        .orderBy('date', descending: true)
        .limit(200)
        .getDocuments()
        .then((d) => d.documents.listMap((t) => DailyTastyVote(t)))
        .asStream()
        .shareReplay(maxSize: 1);
    return ScoreAnimationWidget(
      // Doesn't look good yet
      enabled: false,
      builder: (context, target, onScored) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        alignment: Alignment.center,
        child: StreamBuilder<List<DiscoverItem>>(
            stream: CollectionType.discover_items.coll
                .visible(context)
                .orderBy('awards.daily_tasty', descending: true)
                .limit(2)
                .stream<DiscoverItem>()
                .map((items) =>
                    items.reversed.listMap((item) => item.dailyTasty))
                .switchMap((previousTimes) {
              final begin = previousTimes.firstOrNull ?? _beginning;
              final end = previousTimes.lastOrNull ??
                  DateTime.now().subtract(_duration);
              return [
                CollectionType.discover_items.coll
                    .visible(context)
                    .orderBy('date', descending: true)
                    .limit(100)
                    .stream<DiscoverItem>(),
                CollectionType.discover_items.coll
                    .visible(context)
                    .where('imported_at', isGreaterThanOrEqualTo: begin)
                    .where('is_instagram_post', isEqualTo: true)
                    .stream<DiscoverItem>()
                    .map((posts) => posts
                        .groupBy((input) => input.userReference)
                        .values
                        .expand((posts) => posts
                            .sorted((post) => post.createTime, desc: true)
                            .take(5)))
              ].combineLatestFlat.map((s) => s.toSet()).switchMap((items) =>
                  votes
                      .map((votes) => votes.map((vote) => vote.post).toSet())
                      .map((votes) => items.tupleSort((item) {
                            final date = [item.createTime, item.importedAt]
                                .withoutNulls
                                .maxSelf;
                            return [
                              // Prioritize items user has not voted for yet
                              !votes.contains(item.postReference),
                              // Priotize posts that haven't expired
                              date.isAfter(begin),
                              // Then prioritize posts whose contest is "active"
                              date.isBefore(end),
                              // Randomize after prioritizations are taken care of.
                              (item.path.hashCode * seed) % 1,
                            ].listMap((i) =>
                                i is Comparable ? i : ((i as bool) ? 0 : 1));
                          }).toList()));
            }).mustFinishIn(const Duration(seconds: 5)),
            builder: (context, snapshot) => snapshot.hasError
                ? () {
                    Crashlytics.instance.recordError(snapshot.error, null);
                    logger.e(snapshot.error);
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Text(
                          "Could not load contestants :(. Please check back later!"),
                    ));
                  }()
                : !snapshot.hasData
                    ? const Center(child: CircularProgressIndicator())
                    : snapshot.data.isEmpty
                        ? Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.all(30.0),
                            child:
                                const Text("No new entries! Check back later!"),
                          )
                        : QuickStatefulWidget<DiscoverItem>(
                            initState: (_) => snapshot.data.first,
                            builder: (context, state) => state.t == null
                                ? Container(
                                    padding: const EdgeInsets.all(30),
                                    alignment: Alignment.topCenter,
                                    child: const Text(
                                        "Thanks for playing! Please check back later to vote for more!"))
                                : Column(
                                    children: [
                                      const Spacer(),
                                      Expanded(
                                        flex: 30,
                                        child: target(
                                          child: CardStack(
                                              reviews: snapshot.data,
                                              activeReview: state.t),
                                        ),
                                      ),
                                      const Spacer(),
                                      Scorer(
                                        onScored: (i) {
                                          if (state.t == null) {
                                            return;
                                          }
                                          // Do not await this, causes blocking animation.
                                          // Must call this before `state.quickSet`.
                                          state.t.vote(i.toDouble());
                                          TAEvent.dt_submit_vote();
                                          onScored(i);
                                          state.quickSet(() {
                                            state.t = snapshot.data
                                                .skipWhile(
                                                    (value) => value != state.t)
                                                .skip(1)
                                                .firstOrNull;
                                            if (state.t == null) {
                                              TAEvent.dt_votes_ran_out({
                                                'count': snapshot.data.length
                                              });
                                            }
                                          });
                                        },
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Spacer(),
                                            Expanded(
                                              flex: 2,
                                              child: Center(
                                                child: HowTasty(),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: NewDailyTasties(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                          )),
      ),
    );
  }
}

class CardStack extends StatelessWidget {
  const CardStack({
    Key key,
    @required this.reviews,
    @required this.activeReview,
  }) : super(key: key);
  final List<DiscoverItem> reviews;
  final DiscoverItem activeReview;

  @override
  Widget build(BuildContext context) => Stack(
      alignment: Alignment.center,
      children: reviews
          .skipWhile((value) => value != activeReview)
          .take(4)
          .toList()
          .reversed
          .enumerate
          .entryMap((index, item) => Positioned.fill(
                key: ValueKey(item),
                left: index * 6.0,
                child: PostVoteCard(active: activeReview == item, item: item),
              ))
          .toList());
}

class Scorer extends StatelessWidget {
  const Scorer({
    Key key,
    @required this.onScored,
  }) : super(key: key);

  final Function(int score) onScored;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: Iterable<int>.generate(5)
              .map((i) => i + 1)
              .listMap((i) => FloatingActionButton(
                    key: ValueKey(i),
                    heroTag: null,
                    elevation: 0,
                    backgroundColor: Color.alphaBlend(
                        kPrimaryButtonColor.withOpacity(0.6 + (i / 5) * 0.4),
                        Colors.white),
                    onPressed: () => onScored(i),
                    splashColor: Colors.white,
                    child: Text(i.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ))),
    );
  }
}

class HowTasty extends StatelessWidget {
  const HowTasty({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: faq(context),
      child: const AutoSizeText("How Tasty?",
          minFontSize: 12,
          maxFontSize: 24,
          maxLines: 1,
          style: TextStyle(fontSize: 20)),
    );
  }
}

class PostVoteCard extends StatelessWidget {
  const PostVoteCard({
    Key key,
    this.active,
    this.item,
  }) : super(key: key);
  final bool active;
  final DiscoverItem item;

  @override
  Widget build(BuildContext context) =>
      QuickStatefulWidget<PreloadPageController>(
        initState: (_) => PreloadPageController(),
        builder: (context, state) {
          final photos = item.firePhotos ?? [];
          final controller = state.t;
          return Card(
            elevation: active ? 5 : 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.white, width: active ? 0.7 : 1)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              onTap: () async {
                final nextPage = (await quickPush<double>(
                  TAPage.dt_expanded_photo_page,
                  (context) => FullPagePhotosView(
                      controller: PreloadPageController(
                          initialPage: controller.page.round()),
                      photos: photos),
                ))
                    .round();
                controller.jumpToPage(nextPage);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Opacity(
                    opacity: active ? 1 : 0.2,
                    child: PreloadPageView(
                        controller: controller,
                        children: photos.listMap((p) => p.progressive(
                              Resolution.medium,
                              Resolution.thumbnail,
                              BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                            ))),
                  ),
                  photos.length < 2
                      ? null
                      : Positioned.fill(
                          bottom: null,
                          top: 8,
                          child: Center(
                            child: SmoothPageIndicator(
                              effect: SlideEffect(
                                  dotHeight: 10,
                                  dotWidth: 10,
                                  radius: 5,
                                  activeDotColor: Colors.white,
                                  dotColor: Colors.white.withOpacity(0.2)),
                              controller: controller,
                              count: photos.length,
                            ),
                          )),
                ].withoutNulls,
              ),
            ),
          );
        },
      );
}

class FullPagePhotosView extends StatelessWidget {
  const FullPagePhotosView({
    Key key,
    @required PreloadPageController controller,
    @required this.photos,
  })  : _controller = controller,
        super(key: key);

  final PreloadPageController _controller;
  final List<FirePhoto> photos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: InkWell(
          onTap: () => Navigator.pop(context, _controller.page),
          child: Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: Stack(
              fit: StackFit.expand,
              children: [
                PreloadPageView(
                  controller: _controller,
                  children: photos.listMap(
                    (p) => p.progressive(
                      Resolution.full,
                      Resolution.medium,
                      BoxFit.contain,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                ),
                photos.length < 2
                    ? null
                    : Positioned.fill(
                        bottom: null,
                        top: 8,
                        child: SafeArea(
                          child: Center(
                            child: SmoothPageIndicator(
                              effect: SlideEffect(
                                  dotHeight: 10,
                                  dotWidth: 10,
                                  radius: 5,
                                  activeDotColor: Colors.white,
                                  dotColor: Colors.white.withOpacity(0.2)),
                              controller: _controller,
                              count: photos.length,
                            ),
                          ),
                        ),
                      ),
              ].withoutNulls,
            ),
          ),
        ),
      ),
    );
  }
}

class PreviousWinners extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamBuilder<List<DiscoverItem>>(
      stream: CollectionType.discover_items.coll
          .visible(context)
          .orderBy('awards.daily_tasty', descending: true)
          .limit(50)
          .stream(),
      builder: (context, snapshot) => PostsListProvider(
            posts: snapshot.data ?? [],
            child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                itemBuilder: (_, i) => ReviewInListWidget(
                    key: ValueKey(snapshot.data[i]),
                    discoverItem: snapshot.data[i]),
                itemCount: snapshot.data?.length ?? 0),
          ));
}

class HelpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.info_outline),
        onPressed: faq(context),
      );
}

class TimeLeftWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, _) {
        final nowLA = tz.TZDateTime.now(_la);
        final endLA = tz.TZDateTime(_la, nowLA.year, nowLA.month, nowLA.day)
            .add(_duration);
        final diff = endLA.difference(nowLA);
        if (diff.inSeconds < 60 || (_duration - diff).inSeconds < 60) {
          return const Padding(
              padding: EdgeInsets.all(16.0),
              child: AutoSizeText("Today's contest will end soon...",
                  maxLines: 1,
                  maxFontSize: 40,
                  minFontSize: 20,
                  textAlign: TextAlign.center));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: AutoSizeText.rich(
              TextSpan(text: 'Today\'s Contest ends in ', children: [
                TextSpan(
                    text: [
                      diff.inHours,
                      diff.inMinutes % 60,
                      diff.inSeconds % 60
                    ].map((x) => x.toString().padLeft(2, '0')).join(':'),
                    style: TextStyle(
                      color: kTasteBrandColorLeft,
                      fontWeight: FontWeight.bold,
                      fontFamily: Platform.isIOS ? "Courier" : "monospace",
                    ))
              ]),
              maxLines: 1,
              maxFontSize: 40,
              minFontSize: 20,
              textAlign: TextAlign.center),
        );
      });
}

//ignore: avoid_types_on_closure_parameters
final faq = (BuildContext context) => () => showDialog(
      context: context,
      builder: (dialogContext) => TasteDialog(
          title: "Daily Tasty FAQ",
          scrollable: true,
          buttons: [
            TasteDialogButton(
                text: "Ok",
                color: Colors.grey,
                onPressed: () => Navigator.pop(dialogContext)),
            TasteDialogButton(
                text: "Vote now!",
                onPressed: () {
                  Navigator.pop(dialogContext);
                  DefaultTabController.of(context)?.animateTo(0);
                }),
          ],
          content: Column(
              children: const [
            "How does voting work?",
            "Taste users assign scores to posts between 1 and 5 based on their tastiness. The Daily Tasty is assigned to an eligible post with the highest average score over the contest's duration.",
            "Where is my post?",
            "Posts from the 24 hours preceding the last contest's completion are eligible. If your post is not displayed, it likely means that its eligibility has ended or it will be entered into tomorrow's contest (or you are not in the top 4 unfortunately!).",
            "Why is my post not immediately eligible?",
            "We want to make sure all posts have at least 24 hours to be eligible for winning. To guarantee this, your post must wait up to a day to become eligible. Thanks for your patience!",
          ]
                  .enumerate
                  .entryMap((i, t) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(t,
                          textAlign:
                              i.isEven ? TextAlign.center : TextAlign.justify,
                          style: i.isEven
                              ? const TextStyle(fontWeight: FontWeight.bold)
                              : null)))
                  .toList())),
    );
