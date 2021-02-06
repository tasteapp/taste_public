import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/screens/profile/post_interface.dart';

import 'future_review_marker.dart';

class ReviewSnapshotReviewMarker extends FutureReviewBackendMarker {
  ReviewSnapshotReviewMarker(this.reviewSnapshot, {this.isFavorited = false});
  final Post reviewSnapshot;

  final bool isFavorited;

  @override
  AlgoliaRestaurant get algoliaRestaurant => null;

  @override
  LatLng get location => reviewSnapshot.latLng;

  @override
  Future<String> get name async => reviewSnapshot.restaurantName;

  @override
  DocumentReference get restaurantRef => reviewSnapshot.restaurantRef;

  @override
  Future<Post> get review async => reviewSnapshot;

  @override
  int get numFavorites => isFavorited ? 1 : 0;
}
