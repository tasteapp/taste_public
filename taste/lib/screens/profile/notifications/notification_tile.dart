import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/discover/components/comments_page.dart';
import 'package:taste/screens/profile/notifications/taste_notification.dart';
import 'package:taste/screens/profile/notifications/taste_notification_document.dart';
import 'package:taste/screens/review/review.dart';
import 'package:taste/taste_backend_client/responses/conversation.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/gen/firestore.pbenum.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationTile extends StatelessWidget {
  NotificationTile(this.notification, this.parentContext)
      : super(key: Key(notification.notificationDocument.path));
  final TasteNotificationDocument notification;
  final BuildContext parentContext;

  IconData get icon =>
      {
        NotificationType.bookmark: Icons.bookmark,
        NotificationType.like: Icons.thumb_up,
        NotificationType.follow: Icons.person_add,
        NotificationType.comment: Icons.comment,
        NotificationType.message: Icons.message,
        NotificationType.meal_mate: Icons.people,
        NotificationType.won_daily_tasty: Icons.new_releases,
        NotificationType.conversation: FontAwesome.comment,
        NotificationType.daily_digest: Icons.book,
        NotificationType.recipe_request: FontAwesome.list,
        NotificationType.recipe_added: FontAwesome.list,
      }[notification.explicitNotificationType] ??
      {
        CollectionType.bookmarks: Icons.bookmark,
        CollectionType.likes: Icons.thumb_up,
        CollectionType.followers: Icons.person_add,
        CollectionType.comments: Icons.comment,
        CollectionType.reviews: Icons.rate_review,
        CollectionType.home_meals: Icons.local_dining,
        CollectionType.conversations: FontAwesome.comment,
        CollectionType.users: Icons.person,
      }[notification.documentLink?.type] ??
      Icons.notifications;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(notification.notificationDocument.path),
        onDismissed: (_) => notification.notificationDocument?.delete(),
        child: ListTile(
            leading: Icon(icon),
            title: Text(notification.body),
            subtitle: Text(timeago.format(notification.updateTime)),
            onTap:
                // Don't pop here because it makes [context] invalid.
                // Also, users probably don't want a pop here, because they may be
                // making their way through multiple notifications.
                notificationHyperlink(notification)));
  }
}

typedef NotificationLinkFn = FutureOr Function(
    TasteNotificationMixin notification);

NotificationLinkFn _review(
        Future<MapEntry<Review, bool>> Function(TasteNotificationMixin m)
            reviewBuilder) =>
    (n) async {
      final pair = await spinner(() => reviewBuilder(n));
      final review = pair?.key;
      final goToComments = pair?.value;
      if (!(review?.exists ?? false)) {
        await n.notificationDocument.delete();
        snackBarString('This notification no longer exists.');
        return;
      }
      unawaited(goToReviewPage(ReviewPageInput.review(review)));
      if (goToComments) {
        await CommentsPage.go(await review.discoverItem);
      }
    };

final NotificationLinkFn _bookmark = _review((n) async {
  final bookmark = Bookmark(await n.documentLink.get());
  return !bookmark.exists ? null : MapEntry(await bookmark.review.first, false);
});
final NotificationLinkFn _like = _review((n) async {
  final like = Like(await n.documentLink.get());
  if (!like.exists) {
    return null;
  }
  final parent = await like.parent.get();
  if (!parent.exists) {
    return null;
  }
  if (parent.reference.isA(CollectionType.comments)) {
    return MapEntry(await Comment(parent).review, true);
  }
  return MapEntry(Review(parent), false);
});

final NotificationLinkFn _comment = _review((n) async {
  final comment = await n.documentLink.fetch<Comment>();
  if (!comment.exists) {
    return null;
  }
  return MapEntry(await comment.review, true);
});
final NotificationLinkFn _user = (n) async => goToUserProfile(n.documentLink);
final NotificationLinkFn _conversation = (n) async =>
    (await spinner(() => n.documentLink.fetch<Conversation>())).goToPage();

final NotificationLinkFn _directReview =
    _review((n) async => MapEntry(await n.documentLink.fetch(), false));

Function() notificationHyperlink(TasteNotificationMixin notification) {
  final type = notification.documentLink?.type;
  final callback = <CollectionType, NotificationLinkFn>{
    CollectionType.bookmarks: _bookmark,
    CollectionType.likes: _like,
    CollectionType.reviews: _directReview,
    CollectionType.home_meals: _directReview,
    CollectionType.comments: _comment,
    CollectionType.users: _user,
    CollectionType.conversations: _conversation,
  }[type];
  if (callback == null) {
    return null;
  }
  return () {
    TAEvent.tapped_notification({
      'collection': type?.name,
      'explicit_type': notification.explicitNotificationType?.name
    });
    callback(notification);
  };
}
