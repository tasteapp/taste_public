import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taste/screens/discover/components/comments_page.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;
import 'package:taste_protos/taste_protos.dart' show DiscoverItem_User;

import 'responses.dart';

class DiscoverItem extends SnapshotHolder<$pb.DiscoverItem>
    with UserOwned, Post {
  DiscoverItem(DocumentSnapshot snapshot) : super(snapshot);

  @override
  DocumentReference get userReference => proto.user.reference.ref;

  @override
  ValueStream<DiscoverItem> get asStream =>
      reference.stream<DiscoverItem>().shareValueSeeded(this);
  Future<Review> get review => proto.reference.ref.get().then(Review.make);
  @override
  bool get isHomeCooked => proto.mealType == $pb.Review_MealType.meal_type_home;

  @override
  Stream<int> get views => reviewMap((r) => r.views);

  @override
  DocumentReference get postReference => proto.reference.ref;

  String get userName => proto.user.name;

  Stream<Review> get reviewStream => postReference.stream();
  @override
  DateTime get dailyTasty => proto.awards.dailyTasty.toDateTime();

  DateTime get importedAt =>
      proto.hasImportedAt() ? proto.importedAt.toDateTime() : null;

  Stream<T> reviewMap<T>(Stream<T> Function(Review review) fn) =>
      review.asStream().switchMap(fn);
  Future<TasteUser> get tasteUser async =>
      TasteUser.from(await proto.user.reference.ref.get());

  static Future<DiscoverItem> wrap(
          BuildContext context, DocumentReference r) async =>
      DiscoverItem(await r.get());

  @override
  Future<DiscoverItem> get discoverItem async => this;

  @override
  String get dish => proto.dish;

  @override
  DocumentReference get instaPost => proto.instaPost.ref;

  @override
  bool get isFrozen => proto.freezePlace;

  @override
  Timestamp get createdAtTimestamp => proto.date.firestoreTimestamp;

  Future goToComments() {
    TAEvent.clicked_comments({'post': postReference.path});
    return quickPush(TAPage.comments_page, (_) => CommentsPage(post: this));
  }

  @override
  String get recipe => proto.review.recipe;

  @override
  DocumentReference get restaurantRef => proto.restaurant.reference.ref;

  @override
  $pb.Restaurant_Attributes_Address get address => proto.restaurant.address;

  @override
  $pb.Review_DeliveryApp get deliveryApp => proto.review.deliveryApp;

  @override
  String get displayText => proto.review.text;

  @override
  Set<String> get emojis => proto.review.emojis.toSet();

  @override
  GeoPoint get geoPoint => proto.location.geoPoint;

  @override
  List<DocumentReference> get mealMates =>
      proto.review.mealMates.mealMates.listMap((r) => r.reference.ref);

  @override
  $pb.Reaction get reaction => proto.review.reaction;

  @override
  String get restaurantName => proto.restaurant.name;
  @override
  Future bookmark(bool enable) async => !(enable ^ isBookmarked)
      ? null
      : bookmarkable.toggle(enable,
          batch: (b) async => b.updateData(reference, {
                'bookmarks': enable
                    ? FieldValue.arrayUnion([
                        (await _discoverItemUserMe).asMap,
                      ])
                    : FieldValue.arrayRemove([
                        proto.bookmarks
                            .firstWhere(
                                (l) => l.reference.ref == currentUserReference,
                                orElse: () => null)
                            ?.asMap
                      ].withoutNulls)
              }));
  @override
  Future like(bool enable) async => !(enable ^ isLiked)
      ? null
      : likeable.toggle(enable,
          batch: (b) async => b.updateData(reference, {
                'likes': enable
                    ? FieldValue.arrayUnion([
                        (await _discoverItemUserMe).asMap,
                      ])
                    : FieldValue.arrayRemove([
                        proto.likes
                            .firstWhere(
                                (l) => l.reference.ref == currentUserReference,
                                orElse: () => null)
                            ?.asMap
                      ].withoutNulls)
              }));
  bool _has(List<DiscoverItem_User> l) =>
      l.firstWhere((l) => l.reference.ref == currentUserReference,
          orElse: () => null) !=
      null;

  bool get isBookmarked => _has(proto.bookmarks);

  bool get isLiked => _has(proto.likes);

  @override
  ValueStream<int> get nComments =>
      asStream.valueMap((c) => c.proto.comments.length);
}

Future<DiscoverItem_User> get _discoverItemUserMe async =>
    cachedLoggedInUser.then((user) => {
          'reference': user.reference,
          'name': user.usernameOrName,
          'photo': user.profileImage(),
        }.asProto(DiscoverItem_User()));
