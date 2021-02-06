import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';

import 'review_marker.dart';

class FavoriteReviewMarker with ReviewMarker {
  FavoriteReviewMarker(this.restaurant);
  final AlgoliaRestaurant restaurant;

  @override
  AlgoliaRestaurant get algoliaRestaurant => restaurant;

  @override
  LatLng get location => restaurant.location;

  @override
  Future<String> get name async => restaurant.name;

  @override
  DocumentReference get restaurantRef => restaurant.reference;

  @override
  // TODO(i134): Make this accurate. Right now, it doesn't matter as it's not
  // user facing and all we need is that this number > 0.
  int get numFavorites => 1;

  @override
  Future<FirePhoto> get photoUrl async => restaurant.mapPic;

  @override
  DocumentReference get reference => restaurantRef;

  @override
  Future<String> get userUrl => null;

  @override
  bool get hasPhoto => restaurant.mapPic.firebaseStorage.isNotEmpty;
}
