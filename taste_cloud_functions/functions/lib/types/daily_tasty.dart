import 'package:taste_cloud_functions/taste_functions.dart';

final _beginning = DateTime.fromMillisecondsSinceEpoch(0);
const _contestDuration = Duration(days: 1);
const _minRequiredGap = Duration(hours: 12);

/// Awards the daily tasty to review with the highest average voting score that
/// hasn't been considered for winning in a previous contest.
Future<DocumentReference> awardDailyTasty() => autoBatch((trans) async {
      final now = DateTime.now();
      // The last two times the daily tasty has been awarded, sorted increasing.
      final previousTimes = (await DiscoverItems.get(
              trans: trans,
              queryFn: (q) =>
                  q.orderBy('awards.daily_tasty', descending: true).limit(2)))
          .reversed
          .map((e) => e.dailyTasty);
      // The earliest eligible time for a post.
      final earliestPostTime = previousTimes.firstOrNull?.subtract(
              previousTimes.length == 1
                  ? _contestDuration
                  : const Duration()) ??
          _beginning;
      // The latest eligible time for a post.
      final latestPostTime =
          previousTimes.lastOrNull ?? now.subtract(_contestDuration);
      if (DateTime.now().difference(latestPostTime) < _minRequiredGap) {
        print('TRIGGERED TWICE ${latestPostTime.millisecondsSinceEpoch}');
        return null;
      }
      final eligibleReviews = [
        ...await DiscoverItems.get(
            trans: trans,
            queryFn: (q) => q
                .where('date', isGreaterThanOrEqualTo: earliestPostTime)
                .where('date', isLessThanOrEqualTo: latestPostTime)
                .where('is_instagram_post', isEqualTo: false)),
        ...await DiscoverItems.get(
            trans: trans,
            queryFn: (q) => q
                .where('imported_at', isGreaterThanOrEqualTo: earliestPostTime)
                .where('imported_at', isLessThanOrEqualTo: latestPostTime)
                .where('is_instagram_post', isEqualTo: true))
      ].map((t) => t.post).toSet();
      final votes = (await DailyTastyVotes.get(
              trans: trans,
              queryFn: (q) =>
                  // All votes on [eligibleReviews] are allowed, even if after
                  // `latestPostTime`
                  q.where('date', isGreaterThanOrEqualTo: earliestPostTime)))
          .where((v) => eligibleReviews.contains(v.parent))
          .toList();
      if (votes.isEmpty) {
        // Voting rolls over to next day.
        return null;
      }
      final winner = votes
          .groupBy((vote) => vote.parent)
          .entries
          // Tie-break by path to have stable sort between front-end and backend.
          .tupleMax((e) => [
                normalizeDailyTastyVote(
                    e.value.average((v) => v.score), e.value.length),
                e.key.path
              ])
          .key;
      await trans.update(
          winner,
          {
            'awards': {'daily_tasty': now.timestamp}
          }.updateData);
      return winner;
    });
