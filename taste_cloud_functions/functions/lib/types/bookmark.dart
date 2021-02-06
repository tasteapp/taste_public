import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show Bookmark;

part 'bookmark.g.dart';

@RegisterType()
mixin Bookmark
    on
        FirestoreProto<$pb.Bookmark>,
        ParentUpdater,
        UserOwned,
        ParentHolder,
        UniqueUserIndexed {
  Future<Review> get review async =>
      reviewOrHomeMeal(await getRef(parent), transaction);

  static final triggers = trigger<Bookmark>(
    create: (r) => [
      r.updateParents(),
      r.notifyReviewOwner(),
      r.ensureIndexCreated,
    ],
    delete: (r) => [
      r.updateParents(),
      r.ensureIndexDeleted,
      r.deleteLinkedNotifications()
    ],
  );

  @override
  Future<List<DocumentReference>> get referencesToUpdate async => [parent];

  Future notifyReviewOwner() async {
    final bookmarker = await user;
    final review = await this.review;
    final reviewer = await review.user;
    if (reviewer == bookmarker) {
      return;
    }
    final text = 'Your review was just bookmarked by ${bookmarker.name}';
    await reviewer.sendNotification(
      notificationType: NotificationType.bookmark,
      title: 'Post bookmarked',
      body: text,
      documentLink: ref,
    );
  }
}
