import 'package:mailchimp/mailchimp.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb hide AlgoliaRecordType;
import 'package:taste_protos/taste_protos.dart' show AlgoliaRecordType;

import '../update_user_scores.dart';

part 'taste_user.g.dart';

@RegisterType(type: CollectionType.users)
mixin TasteUser on FirestoreProto<$pb.TasteUser>, AlgoliaBacked, ParentUpdater {
  static void registerInternal() {
    final fn = tasteFunctions.pubsub
        .schedule('every 2 hours')
        .onRun((message, context) => updateUserScores());
    registerFunction('update_user_scores', fn, fn);
  }

  String get name {
    return [proto.vanity.displayName, proto.displayName]
        .firstWhere((n) => n.isNotEmpty, orElse: () => '');
  }

  String get username => proto.vanity.username;
  String get usernameOrName =>
      [username, name].withoutNulls.where((e) => e.isNotEmpty).firstOrNull ??
      '';
  String get thumbnail =>
      proto.vanity.firePhoto.firebaseStorage.ifEmpty(proto.photoUrl);

  int get score => proto.score;

  AlgoliaRecordID get recordID => AlgoliaRecordID(ref, AlgoliaRecordType.user);

  DocumentQuery get favoritesQuery =>
      CollectionType.favorites.coll.where('user', isEqualTo: ref);

  Future<List<Favorite>> get favoritesRecords =>
      wrapQuery(favoritesQuery, Favorites.make);

  Future<List<Restaurant>> get favorites async =>
      (await favoritesRecords).futureMap((f) => f.restaurant);

  bool get getsDigest => proto.dailyDigest.enabled;

  MailchimpCall get updateMailchimpUserRequest => email.isEmpty
      ? null
      : putMember(
          mailchimpAudience,
          proto.email,
          firstName: name.split(' ').first,
          lastName: name.split(' ').skip(1).join(' '),
          otherMergeFields: {
            'USERNAME': username,
            'UID': uid,
          },
        );

  String get uid => proto.uid.ifEmpty(ref.documentID);

  Future<List<T>> _userCollection<T extends SnapshotHolder>(
          CollectionType type,
          T Function(DocumentSnapshot snapshot, BatchedTransaction transaction)
              create) async =>
      wrapQuery(type.coll.where('user', isEqualTo: ref), create);

  Future<List<TasteNotification>> get notifications =>
      _userCollection(CollectionType.notifications, TasteNotifications.make);
  Future<List<Like>> get likes =>
      _userCollection(CollectionType.likes, Likes.make);
  Future<List<Comment>> get comments =>
      _userCollection(CollectionType.comments, Comments.make);
  Future<List<Bookmark>> get bookmarks =>
      _userCollection(CollectionType.bookmarks, Bookmarks.make);
  Future<List<Review>> get reviews =>
      _userCollection(CollectionType.reviews, reviewOrHomeMeal);
  Future<List<Review>> get homeMeals =>
      _userCollection(CollectionType.home_meals, reviewOrHomeMeal);
  Future<List<InstaPost>> get instaPosts =>
      _userCollection(CollectionType.insta_posts, InstaPosts.make);
  Future<List<Review>> get allReviews async =>
      [...await reviews, ...await homeMeals];
  Future<List<RecipeRequest>> get recipeRequests async =>
      _userCollection(CollectionType.recipe_requests, RecipeRequests.make);

  Future updateAlgoliaRecords() async {
    if (name.isEmpty && username.isEmpty) {
      return;
    }
    await updateAlgoliaRecord(
        payload: {
      'name': name,
      'username': username,
      'profile_pic_url': thumbnail,
    }.ensureAs($pb.AlgoliaUserRecord()));
  }

  DocumentQuery get followersQuery =>
      CollectionType.followers.coll.where('following', isEqualTo: ref);
  DocumentQuery get followingQuery =>
      CollectionType.followers.coll.where('follower', isEqualTo: ref);

  Future<List<Follower>> get followingRecords async =>
      wrapQuery(followingQuery, Followers.make);
  Future<List<Follower>> get followersRecords async =>
      wrapQuery(followersQuery, Followers.make);

  Future<List<TasteUser>> get followers async =>
      (await followersRecords).futureMap((f) => f.follower);

  Future<List<TasteUser>> get following async =>
      (await followingRecords).futureMap((f) => f.following);

  @override
  List<AlgoliaRecordID> get algoliaRecordIDs => [recordID];

  Future recacheVanityPhoto() async {
    if (!proto.vanity.firePhoto.photoReference.exists &&
        !proto.vanity.photo.exists &&
        proto.photoUrl.isNotEmpty) {
      final cached = await tasteStorage.uploadUrlPhoto(proto.photoUrl,
          'users/$uid/uploads/${DateTime.now().microsecondsSinceEpoch}.jpg');
      await updateSelf({
        'vanity': {
          'photo': cached,
          'fire_photo': cached.firePhoto,
        }
      }.ensureAs(prototype));
    }
    if (proto.vanity.photo.exists &&
        proto.vanity.photo != proto.vanity.firePhoto.photoReference) {
      await updateSelf({
        'vanity': {
          'fire_photo': Photos.make(
                  await proto.vanity.photo.ref.tGet(transaction), transaction)
              .firePhoto
        }
      }.ensureAs(prototype));
    }
  }

  Future maybeUpdateInstagramProfilePic() async {
    if (!proto.vanity.firePhoto.photoReference.exists &&
        !proto.vanity.photo.exists &&
        proto.instagramInfo.profilePicUrl.isNotEmpty) {
      final cached = await tasteStorage.uploadUrlPhoto(
          proto.instagramInfo.profilePicUrl,
          'users/$uid/uploads/${DateTime.now().microsecondsSinceEpoch}.jpg');
      await updateSelf({
        'vanity': {
          'photo': cached,
          'fire_photo': cached.firePhoto,
        }
      }.ensureAs(prototype));
    }
  }

  String get email => proto.email;

  Future syncMailchimp({Change<TasteUser> change, bool delete = false}) async {
    if (delete) {
      if (email.isEmpty) {
        return;
      }
      return deleteMember(mailchimpAudience, email)(mailchimp);
    }
    if (!(change?.fieldsChanged({'vanity.username', 'vanity.display_name'}) ??
        true)) {
      return;
    }
    return updateMailchimpUserRequest?.call(mailchimp);
  }

  static final triggers = trigger<TasteUser>(
      create: (r) => [
            r.syncMailchimp(),
            if (!r.proto.instagramInfo.hasGrantedPermission() ||
                r.proto.instagramInfo.grantedPermission)
              r.updateAlgoliaRecords(),
            r.updateUserBadges(),
            r.recacheVanityPhoto(),
          ],
      update: (r, c) => [
            r.syncMailchimp(change: c),
            if (!r.proto.instagramInfo.hasGrantedPermission() ||
                r.proto.instagramInfo.grantedPermission)
              r.updateAlgoliaRecords(),
            c.fieldsChanged({'vanity.username', 'vanity.name', 'vanity.photo'})
                ? r.updateParents()
                : null,
            r.recacheVanityPhoto(),
            c.fieldsChanged({'instagram_info.profile_pic_url'})
                ? r.maybeUpdateInstagramProfilePic()
                : null,
            c.fieldsChanged({'instagram_info.granted_permission'})
                ? r.updateInstaPosts()
                : null,
            c.fieldsChanged({'instagram_info.biography'}) &&
                    r.proto.instagramInfo.biography.isNotEmpty &&
                    r.proto.instagramInfo.email.isEmpty
                ? r.updateEmailFromBio()
                : null,
          ].withoutNulls,
      delete: (r) => [
            r.syncMailchimp(delete: true),
            ifNotTest(() => admin.auth().deleteUser(r.uid).catchError((e, s) =>
                print([
                  'failed to clean up auth, likely already deleted',
                  e,
                  s
                ]))),
            r.deleteLinkedNotifications(),
            r.deleteAlgoliaCache(),
            r.deleteConversations(),
            r.deleteDynamic([
              r.likes,
              r.comments,
              r.bookmarks,
              r.favoritesRecords,
              r.allReviews,
              r.instaPosts,
              r.followersRecords,
              r.followingRecords,
              r._badgesQuery,
              r.private,
              r.notifications,
              r.recipeRequests,
            ]),
          ]);

  Future deleteConversations() async => (await Conversations.get(
          trans: transaction,
          queryFn: (q) => q.where('members', arrayContains: ref)))
      .futureMap((s) => s.deleteSelf());

  DocumentReference get private => userPrivateDocument(ref);

  Future<DocumentReference> followUser(TasteUser following) async {
    if (following == this) {
      throw CloudFnException('You cannot follow yourself');
    }
    if (await isFollowing(following)) {
      throw CloudFnException('You are already following this user');
    }
    return await addToCollection(
        CollectionType.followers.coll,
        {'following': following.ref, 'follower': ref}
            .ensureAs($pb.Follower())
            .documentData);
  }

  Future<bool> isFollowing(TasteUser following) async =>
      (await followingReference(following)) != null;
  Future<DocumentSnapshot> followingReference(TasteUser following) =>
      existingDocument(CollectionType.followers.coll
          .where('following', isEqualTo: following.ref)
          .where('follower', isEqualTo: ref));

  Future<bool> unfollowUser(TasteUser following) async {
    if (following == this) {
      throw CloudFnException('You cannot unfollow yourself');
    }
    final result = await followingReference(following);
    if (result == null) {
      throw CloudFnException('You are not currently following this user');
    }
    await transaction.delete(result.reference);
    return true;
  }

  Future<int> get numPosts async =>
      (await reviews).length + (await homeMeals).length;

  bool owns(SnapshotHolder snapshot) {
    if (snapshot is Photo) {
      final photo = snapshot;
      if (photo.userReference != ref) {
        return false;
      }
    }
    return true;
  }

  static Future<TasteUser> byUsername(
      String username, BatchedTransaction transaction) async {
    final response = await transaction.getQuery(CollectionType.users.coll
        .where('vanity.username', isEqualTo: username));
    if (response.isEmpty) {
      return null;
    }
    return TasteUsers.make(response.documents.first, transaction);
  }

  Future<TasteNotification> sendNotification({
    @required DocumentReference documentLink,
    @required String title,
    @required String body,
    @required $pb.NotificationType notificationType,
    bool update = false,
    $pb.Notification_FCMSettings fcmSettings,
    bool seen = false,
  }) async {
    fcmSettings ??= $pb.Notification_FCMSettings.fcm_settings_on_create_only;
    if (update ?? false) {
      final existing = (await TasteNotifications.get(
              queryFn: (q) => q
                  .where('document_link', isEqualTo: documentLink)
                  .where('user', isEqualTo: ref)
                  .select([]).limit(1),
              trans: transaction))
          ?.firstOrNull;
      if (existing != null) {
        await existing.updateSelf({
          'title': title,
          'body': body,
          'notification_type': notificationType,
          'fcm_settings': fcmSettings,
        }.withoutNulls.ensureAs(TasteNotifications.emptyInstance));
        return existing;
      }
    }
    return TasteNotifications.createNew(transaction,
        data: {
          'body': body,
          'title': title,
          'document_link': documentLink,
          'notification_type': notificationType,
          'user': ref,
          'seen': seen ?? false,
          'fcm_settings': fcmSettings,
        }.ensureAs(TasteNotifications.emptyInstance).documentData.withExtras);
  }

  Future<List<String>> get tokens =>
      memoize(() => getTokens(transaction, this), 'tokens');
  DocumentQuery get _badgesQuery =>
      CollectionType.badges.coll.where('user', isEqualTo: ref);

  Future<Map<$pb.Badge_BadgeType, Badge>> get badges async =>
      (await wrapQuery(_badgesQuery, Badges.make))
          .asMap()
          .map((_, v) => MapEntry(v.proto.type, v));

  Future<P> _wrap<P extends FirestoreProto>(
          DocumentReference reference, Wrapper<P> wrapper, bool enable) async =>
      wrapper(await transaction.get(reference), transaction, enable);

  Future<Follower> follow(TasteUser user, bool enable) async {
    if (user == this) {
      throw ArgumentError('cannot follow yourself.');
    }
    return _wrap(
        await toggleUnique(
            type: CollectionType.followers,
            parent: user.ref,
            user: ref,
            parentField: 'following',
            userField: 'follower',
            enable: enable),
        Followers.make,
        enable);
  }

  Future<Bookmark> bookmark(Review review, bool enable) async => _wrap(
      await toggleUnique(
          type: CollectionType.bookmarks,
          parent: review.ref,
          user: ref,
          enable: enable),
      Bookmarks.make,
      enable);
  Future<Favorite> favorite(Restaurant restaurant, bool enable) async => _wrap(
      await toggleUnique(
          type: CollectionType.favorites,
          parent: restaurant.ref,
          user: ref,
          parentField: 'restaurant',
          enable: enable),
      Favorites.make,
      enable);

  Future updateInstaPosts() async {
    final instaPosts = await InstaPosts.get(
        trans: transaction,
        queryFn: (q) => q
            .where('user', isEqualTo: ref)
            .where('username', isEqualTo: proto.instagramInfo.username));
    await autoBatch((t) async {
      for (final post in instaPosts) {
        await t.update(
            post.ref,
            UpdateData.fromMap(
                {'hidden': !proto.instagramInfo.grantedPermission}));
      }
    });
  }

  Future updateUserBadges() => RateLimiter.user_badge(ref);

  Future updateUserBadgesRateLimited() async {
    final reviews = (await allReviews).sorted((r) => r.createdAt.seconds);
    return [
      {
        Badge_BadgeType.character: character,
        Badge_BadgeType.brainiac: brainiac,
        Badge_BadgeType.burgermeister: burgermeister,
        Badge_BadgeType.sushinista: sushinista,
        Badge_BadgeType.herbivore: herbivore,
        Badge_BadgeType.regular: theRegular,
        Badge_BadgeType.socialite: socialite,
        Badge_BadgeType.ramsay: ramsay,
        Badge_BadgeType.streak_active: hotStreak,
        Badge_BadgeType.quarantine: quarantine,
        Badge_BadgeType.emoji_flags_level_1: emojiFlags,
        Badge_BadgeType.daily_tasty: dailyTastyBadge,
      }.entries.futureMap((key, value) async =>
          updateBadge(key, genericBadgeWrap(value(reviews)))),
      updateBadge(Badge_BadgeType.commenter_level_1,
          countBadgeWrap(commentsBadge(await comments)))
    ].wait;
  }

  Future updateBadge(
          Badge_BadgeType type, Map<String, dynamic> payload) async =>
      transaction.set((await badge(type)).ref,
          payload.ensureAs(Badges.emptyInstance).documentData.withExtras,
          merge: true);
  Future<Badge> badge(Badge_BadgeType type) async =>
      (await badges)[type] ?? await initBadge(type);
  Future<Badge> initBadge(Badge_BadgeType type) => Badges.createNew(transaction,
      data: (Badges.emptyInstance
            ..type = type
            ..user = ref.proto)
          .documentData);

  Future updatePrivate(Map<String, dynamic> data) =>
      updateUserPrivateDocument(transaction, ref, data);

  @override
  Future<Iterable<DocumentReference>> get referencesToUpdate async {
    final reviews = await this.reviews;
    final comments = await this.comments;
    return comments
        .map((c) => c.reviewRef)
        .followedBy(reviews.map((r) => r.ref))
        .toSet();
  }

  Future updateEmailFromBio() async {
    try {
      final bio = proto.instagramInfo.biography;
      final isValidRegex = RegExp(r'^[a-zA-Z0-9_.@+]*$');
      final emailRegex = RegExp(r'[^@]+@[^@]+\.[^@]+');
      final matches = <String>[];
      for (var i = 9; i < 51; i++) {
        for (var j = 0; j <= bio.length - i; j++) {
          final substr = bio.substring(j, j + i);
          if (isValidRegex.firstMatch(substr) == null) {
            continue;
          }
          if (emailRegex.firstMatch(substr) != null) {
            matches.add(substr);
          }
        }
      }
      if (matches.isNotEmpty) {
        final email = matches.max((t) => t.length);
        await updateSelf({'instagram_info.email': email});
      }
    } catch (e) {
      return;
    }
  }

  Future updateMailchimpTags(
      {Set<String> add = const {}, Set<String> remove = const {}}) async {
    final settingsRef = await _mailchimp;
    if (add.isNotEmpty) {
      await transaction.set(
          settingsRef,
          {
            'user': ref,
            'tags': Firestore.fieldValues.arrayUnion([...add])
          }.documentData,
          merge: true);
    }
    if (remove.isNotEmpty) {
      await transaction.set(
          settingsRef,
          {
            'user': ref,
            'tags': Firestore.fieldValues.arrayRemove([...remove])
          }.documentData,
          merge: true);
    }
  }

  Future<DocumentReference> get _mailchimp => withTransaction((t) async =>
      (await MailchimpUserSettings.get(
              trans: t, queryFn: (q) => q.where('user', isEqualTo: ref)))
          ?.firstOrNull
          ?.ref ??
      MailchimpUserSettings.collection.document());
}

typedef Wrapper<T extends FirestoreProto> = T Function(
    DocumentSnapshot snapshot,
    BatchedTransaction transaction,
    bool checkExists);
