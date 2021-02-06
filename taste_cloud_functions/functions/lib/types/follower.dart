import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'follower.g.dart';

@RegisterType()
mixin Follower
    on
        FirestoreProto<$pb.Follower>,
        ParentHolder,
        UserOwned,
        UniqueUserIndexed {
  static final triggers = trigger<Follower>(
    create: (r) => [
      r.notifyFollowed(),
      r.ensureIndexCreated,
    ],
    delete: (r) => [r.ensureIndexDeleted, r.deleteLinkedNotifications()],
  );

  @override
  DocumentReference get userReference => followerRef;
  @override
  String get parentField => 'following';

  Future<TasteUser> get following async =>
      TasteUsers.make(await getRef(followingRef), transaction);
  Future<TasteUser> get follower async =>
      TasteUsers.make(await getRef(followerRef), transaction);
  DocumentReference get followerRef => proto.follower.ref;
  DocumentReference get followingRef => proto.following.ref;

  Future notifyFollowed() async {
    final follower = await this.follower;
    final following = await this.following;
    final text = '${follower.name} is now following you!';
    await following.sendNotification(
      notificationType: NotificationType.follow,
      title: 'New follower',
      body: text,
      documentLink: follower.ref,
    );
  }
}
