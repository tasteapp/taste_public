import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taste/screens/user_list/user_list.dart';
import 'package:taste/taste_backend_client/responses/parent_user_index.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/gen/firestore.pb.dart' as $pb;

import 'badge.dart';
import 'discover_item.dart';
import 'responses.dart';
import 'taste_bud_group.dart';

class TasteUser extends SnapshotHolder<$pb.TasteUser> implements UserListUser {
  TasteUser._(DocumentSnapshot snapshot)
      : _followable = followable(snapshot),
        super(snapshot);
  final ParentUserIndex _followable;
  String get email => proto.email;
  Stream<List<DiscoverItem>> get bookmarks => CollectionType.bookmarks.coll
      .forUser(reference)
      .byCreated
      .limit(100)
      .stream<Bookmark>()
      .deepMap((b) => b.discoverItem);
  Stream<List<DiscoverItem>> get allPosts => CollectionType.discover_items.coll
      .visible()
      .where('user.reference', isEqualTo: reference)
      .orderBy('date', descending: true)
      .stream();
  Stream<List<DiscoverItem>> get restaurantPosts =>
      allPosts.listWhere((x) => !x.isHomeCooked);
  Stream<List<DiscoverItem>> get borReviews =>
      allPosts.listWhere((x) => x.proto.blackOwned);

  int get score => proto.score;

  Stream<int> get rank => CollectionType.users.coll
      .where('score', isGreaterThan: score)
      .limit(200)
      .snapshots(includeMetadataChanges: false)
      .map((s) => s.documents.length + 1)
      .distinct();
  String get firstName => name.split(' ')[0];

  Stream<FoodSpirit> get foodSpirit => badge($pb.Badge_BadgeType.character)
      .map((event) => event == null ? null : foodlebrity(event));

  Stream<Review> get topReview => Rx.combineLatest<List<Review>, Review>(
      [CollectionType.reviews, CollectionType.home_meals].map((collection) =>
          collection.coll
              .forUser(reference)
              .orderBy('score', descending: true)
              .limit(1)
              .stream()),
      (a) => a.flatten.max((t) => t.score));

  Stream<Map<$pb.Badge_BadgeType, Badge>> get badges =>
      CollectionType.badges.coll
          .forUser(reference)
          .stream<Badge>()
          .map((a) => a.where((b) => badgeWhitelist.contains(b.type)).toList())
          .map((event) =>
              event.asMap().map((_, value) => MapEntry(value.type, value)));

  String get meOrName => isMe ? 'me' : name ?? '';
  String get meOrUsername => isMe ? 'me' : usernameOrName;
  String get usernameOrName =>
      username?.isEmpty ?? true ? name : username ?? '';
  String get uid => proto.uid ?? reference.documentID;

  void goToProfile({Object hero}) => goToUserProfile(reference, hero: hero);

  Stream<List<Review>> _dailyTasty(CollectionType type) => type.coll
      .forUser(reference)
      .orderBy('awards.daily_tasty', descending: true)
      .stream();
  Stream<List<Review>> get myDailyTastys =>
      Rx.combineLatest2<List<Review>, List<Review>, List<Review>>(
          _dailyTasty(CollectionType.reviews),
          _dailyTasty(CollectionType.home_meals),
          (a, b) =>
              a.mergeSorted(b, (a) => -a.createdAtTimestamp.seconds).toList());
  Stream<Badge> badge($pb.Badge_BadgeType type) =>
      badges.map((event) => event[type]);

  Stream<List<Review>> get homeMeals => CollectionType.home_meals.coll
      .visible()
      .forUser(reference)
      .byCreated
      .stream();

  String profileImage({bool thumb = true}) =>
      proto.vanity.firePhoto
          .url(thumb ? Resolution.thumbnail : Resolution.medium) ??
      proto.photoUrl;

  String instagramProfileImage({bool thumb = true}) =>
      proto.instagramInfo.profilePic
          .url(thumb ? Resolution.thumbnail : Resolution.full);

  Stream<int> get numInstaPosts => CollectionType.insta_posts.coll
      .forUser(reference)
      .where('user_id', isEqualTo: proto.instagramInfo.userId)
      .where('has_review', isEqualTo: true)
      .count;

  Stream<TasteUser> get stream => reference.snapshots().map(TasteUser.from);

  @override
  bool get isMe => reference.path == currentUserReference.path;

  Stream<bool> get amIFollowing => CollectionType.followers.coll
      .where('follower', isEqualTo: currentUserReference)
      .where('following', isEqualTo: reference)
      .limit(1)
      .snapshots()
      .map((s) => s.documents.isNotEmpty);

  Stream<List<DocumentReference>> get tasteBuds => CollectionType
      .taste_bud_groups.coll
      .where('user', isEqualTo: reference)
      .stream<TasteBudGroup>()
      .map((s) => s.firstOrNull?.proto?.tasteBuds?.listMap((t) => t.bud.ref));

  Stream<Set<DocumentReference>> get followers => fetchFollowers(reference);
  Stream<Set<DocumentReference>> get following => fetchFollowing(reference);
  Stream<List<Restaurant>> get favorites => favoritesStream(user: reference);
  // TODO(jackdreilly): either only use vanity field or move all fields
  // into user object and avoid this mess.
  @override
  String get name => proto.vanity.displayName.ifEmpty(proto.displayName);
  // Return the 's version of name. Accounting for self and names ending in 's'.
  String get nameAsOwner =>
      isMe ? 'Your' : "$firstName'${firstName.endsWith('s') ? '' : 's'}";
  String get username => proto.vanity.username;
  bool get hasSetUpAccount => proto.vanity.hasSetUpAccount;
  String get phoneNumber => proto.vanity.phoneNumber;
  bool get hasPhoneNumber => proto.vanity.hasPhoneNumber();
  static TasteUser from(DocumentSnapshot snapshot) => TasteUser._(snapshot);

  Future block({String text}) => reportContentCall(reference, text: text);

  Future follow() => _followable.toggle(true);
  Future unfollow() => _followable.toggle(false);

  Future updatePrivate(Map<String, dynamic> data) => reference
      .collection(CollectionType.private_documents.name)
      .document(CollectionType.private_documents.name)
      .setData(data, merge: true);

  @override
  String get userListPhoto => profileImage();
}
