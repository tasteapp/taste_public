import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;
import 'package:taste_protos/taste_protos.dart'
    show Restaurant_Attributes_Address;

import 'discover_item.dart';
import 'responses.dart';

class Review extends SnapshotHolder<$pb.Review>
    with UserOwned, Post<$pb.Review> {
  Review(DocumentSnapshot snapshot) : super(snapshot);
  static Review make(DocumentSnapshot snapshot) => Review(snapshot);
  @override
  String get restaurantName => proto.restaurantName;
  @override
  GeoPoint get geoPoint => isHomeCooked
      ? null
      : (proto.hasRestaurantLocation()
              ? proto.restaurantLocation
              : proto.location)
          .geoPoint;
  @override
  Set<String> get emojis => proto.emojis.toSet();

  @override
  DocumentReference get restaurantRef => proto.restaurant.ref;

  @override
  String get dish => proto.dish;

  @override
  DocumentReference get instaPost => proto.instaPost.ref;
  @override
  $pb.Reaction get reaction => proto.reaction;
  @override
  Stream<Review> get asStream => reference.stream();
  @override
  Restaurant_Attributes_Address get address => proto.address;
  String get rawText => proto.text;
  @override
  String get displayText => proto.displayText;

  @override
  Future<DiscoverItem> get discoverItem =>
      reviewDiscoverItem(reference).firstOrNull;

  @override
  List<DocumentReference> get mealMates =>
      proto.mealMates.listMap((e) => e.ref);

  @override
  Future delete() async {
    if (isNotMine) {
      return false;
    }
    await reference.delete();
  }

  @override
  bool get isHomeCooked => proto.mealType == $pb.Review_MealType.meal_type_home;

  @override
  $pb.Review_DeliveryApp get deliveryApp =>
      proto.hasDeliveryApp() ? proto.deliveryApp : null;

  @override
  DocumentReference get postReference => reference;

  @override
  bool get isFrozen => proto.freezePlace;

  @override
  DateTime get dailyTasty => proto.awards.dailyTasty.toDateTime();

  @override
  String get recipe => proto.recipe;
  Stream<List<Like>> get likes =>
      likeable.all.map((a) => a.map((e) => Like(e)).toList());
  Stream<List<Bookmark>> get bookmarks =>
      bookmarkable.all.map((a) => a.map((e) => Bookmark(e)).toList());
}

Stream<DiscoverItem> reviewDiscoverItem(DocumentReference reference) =>
    CollectionType.discover_items.coll
        .where('reference', isEqualTo: reference)
        .limit(1)
        .stream<DiscoverItem>()
        .map((i) => i.firstOrNull)
        .withoutNulls;
