import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show Like;

part 'like.g.dart';

@RegisterType()
mixin Like
    on
        FirestoreProto<$pb.Like>,
        ParentUpdater,
        UserOwned,
        ParentHolder,
        UniqueUserIndexed {
  static final triggers = trigger<Like>(
    create: (r) => [
      r.notifyOwner(),
      r.updateParents(),
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

  bool get isComment => parent.isA(CollectionType.comments);

  Future notifyOwner() async {
    final liker = await user;
    final liked = ({
      HomeMeals.collectionType: reviewOrHomeMeal,
      Reviews.collectionType: reviewOrHomeMeal,
      Comments.collectionType: Comments.make,
    }[parent.collectionType](await getRef(parent), transaction) as UserOwned);
    final notifiedUser = await liked.user;
    if (notifiedUser == liker) {
      return;
    }
    final snippet =
        (liked is Comment ? liked.text : (liked as Review).dish).ellipsis(50);
    final name = liker.usernameOrName;
    final description = isComment ? 'comment' : 'post';
    await notifiedUser.sendNotification(
      notificationType: NotificationType.like,
      title: '$name liked your $description',
      body: '$name liked "$snippet"',
      documentLink: ref,
    );
  }
}
