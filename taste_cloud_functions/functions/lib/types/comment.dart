import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show Comment;
part 'comment.g.dart';

@RegisterType()
mixin Comment
    on
        FirestoreProto<$pb.Comment>,
        ParentUpdater,
        Likeable,
        UserOwned,
        ParentHolder {
  static final triggers = trigger<Comment>(
    update: (r, c) => [
      r.updateParents(),
      c.fieldChanged('text') ? r.notifyParticipants(update: true) : null,
    ].withoutNulls,
    create: (r) => [
      r.updateParents(),
      r.notifyParticipants(),
      r.user.then((user) => user.updateUserBadges()),
    ],
    delete: (r) => [
      r.updateParents(),
      r.deleteDynamic(r.likes),
      r.deleteLinkedNotifications()
    ],
  );
  String get text => proto.text;
  Future<Review> get review async =>
      reviewOrHomeMeal(await getRef(reviewRef), transaction);

  Future<Set<TasteUser>> get participants async =>
      {await user, ...await taggedUsers};

  DocumentReference get reviewRef => parent;

  Future<List<TasteUser>> get taggedUsers =>
      protoWrap(proto.taggedUsers, TasteUsers.make);

  Future notifyParticipants({bool update}) async {
    final commenter = await user;
    final review = await this.review;
    final taggedUsers = await this.taggedUsers;
    final name = commenter.usernameOrName;
    final verb = taggedUsers.contains(user) ? 'tagged you' : 'commented';
    final title = '$name $verb on ${review.dish}';
    await {...await review.participants, ...taggedUsers}
        .difference({commenter}).futureMap((user) => user.sendNotification(
              notificationType: NotificationType.comment,
              title: title,
              body: '$title: "${text.ellipsis(50)}"',
              documentLink: ref,
              update: update,
            ));
  }

  Future<List<TasteNotification>> get notifications => TasteNotifications.get(
      trans: transaction,
      queryFn: (q) => q.where('document_link', isEqualTo: ref));

  Future edit(String text) async {
    await updateSelf({'text': text});
  }

  @override
  Future<List<DocumentReference>> get referencesToUpdate async => [reviewRef];
}
