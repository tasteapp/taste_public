import 'package:taste_cloud_functions/taste_functions.dart';

Future dailyDigest() => autoBatch((transaction) async {
      final dump = await BatchDump.fetch(transaction, {
        CollectionType.users,
        CollectionType.comments,
        CollectionType.likes,
        CollectionType.bookmarks,
        CollectionType.followers,
        CollectionType.reviews,
        CollectionType.home_meals
      });
      final dayAgo = DateTime.now().subtract(const Duration(days: 1));
      // Posts eligible to be notified about
      final recentPosts = dump.reviews
          .where((r) => r.createdAt.toDateTime().isAfter(dayAgo))
          .groupBy(dump.owner);
      await dump.userRecords
          // this user wants digests
          .where((k, v) => k.getsDigest)
          // find candidate users to notify [user] about
          .mapValue((user, record) =>
              // create a bunch of records mapping a user to a score for an action
              // performed by [user], indicating interest in that user.
              [
                record.following.toMap((t) => [9]),
                record.likes.groupBy((l) {
                  final parent = dump.get(l.parent);
                  if (parent == null) {
                    return null;
                  }
                  return dump.owner(parent is Review
                      ? parent
                      : dump.get<Review>((parent as Comment).reviewRef));
                }).deepMap<int>((v) => v.isComment ? 1 : 2),
                record.bookmarks
                    .groupBy((l) => dump.owner(dump.get<Review>(l.parent)))
                    .deepMap((_) => 1),
                record.comments
                    .groupBy((l) => dump.owner(dump.get<Review>(l.parent)))
                    .deepMap((_) => 3),
              ]
                  .expand((e) => e.entries)
                  // This user made a post today.
                  .where((e) => recentPosts.containsKey(e.key))
                  .multiMap
                  .where((friend, _) => friend != user)
                  // Tally all points for this user
                  .mapValue((k, v) => v.flatten.sum)
                  .where((k, v) => v >= 10)
                  .entries
                  .sorted((e) => -e.value)
                  .map((e) => e.key)
                  .take(3))
          .withoutEmpties
          .entries
          .sideEffect((t) => structuredLog(
                  'daily_digest', transaction.eventId, 'notifications', {
                'notifications': t
                    .map((e) => {
                          'user': {'name': e.key.name, 'ref': e.key.path},
                          'friends': e.value
                              .map((e) => {'name': e.name, 'ref': e.path})
                              .toList()
                        })
                    .toList()
              }))
          .futureMap((user, friends) {
        return user.sendNotification(
            notificationType: NotificationType.daily_digest,
            documentLink: recentPosts[friends.first].first.ref,
            title: 'Daily Digest',
            body: 'New posts from ${friends.map((r) => r.name).join(', ')}');
      });
    });

// void registerDailyDigest() {
//   final fn = tasteFunctions.pubsub
//       .schedule('every 24 hours')
//       .onRun((message, context) => dailyDigest());
//   registerFunction('daily_digest_call', fn, fn);
// }
