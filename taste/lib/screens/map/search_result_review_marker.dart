import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/fb_places_api.dart';
import 'package:taste/utils/memoize.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'review_marker.dart';

class TopReview with Memoizer {
  TopReview(this.userStorage, this.photoStorage, this.score);
  final String userStorage;
  final String photoStorage;
  final int score;
}

class RestaurantMarkerCacheMarker with ReviewMarker, Memoizer {
  RestaurantMarkerCacheMarker(this.proto, Set<DocumentReference> following) {
    topReview = _topReview(following);
  }
  final $pb.RestaurantMarkerCache proto;
  TopReview topReview;

  @override
  AlgoliaRestaurant get algoliaRestaurant => null;

  @override
  LatLng get location => proto.geoloc.latLng;

  @override
  Future<String> get name async => proto.name;

  @override
  DocumentReference get restaurantRef => proto.reference.ref;

  @override
  int get numFavorites => proto.numFavorites;

  @override
  Future<FirePhoto> get photoUrl async => fixedFirePhoto(proto.topReview.photo);

  @override
  DocumentReference get reference => restaurantRef;

  @override
  Set<DocumentReference> get reviewers =>
      proto.reviewers.map((r) => r.ref).toSet();

  @override
  Future<String> get userUrl async =>
      fixedFirePhoto(proto.topReview.user.thumbnail).url(Resolution.thumbnail);

  TopReview _topReview(Set<DocumentReference> following) {
    final defaultReview = TopReview(proto.topReview?.user?.thumbnail,
        proto.topReview?.photo, proto.topReview?.score);
    if (following == null || proto.reviewers.isEmpty || proto.reviews.isEmpty) {
      return defaultReview;
    }
    final candidates =
        following.intersection(proto.reviewers.map((r) => r.ref).toSet());
    if (candidates.isEmpty) {
      return defaultReview;
    }
    final user = candidates.first;
    final review =
        proto.reviews.firstWhere((r) => r.user.ref == user, orElse: () => null);
    if (review == null) {
      return defaultReview;
    }
    return TopReview(review.userPhoto, review.photo, review.score);
  }

  @override
  int get score => topReview.score;

  @override
  bool get hasPhoto => proto.topReview.photo.isNotEmpty;
}

class FacebookRestaurantMarker with ReviewMarker, Memoizer {
  FacebookRestaurantMarker(this.place);
  final FacebookPlaceResult place;

  @override
  AlgoliaRestaurant get algoliaRestaurant => null;

  @override
  LatLng get location => place.location;

  @override
  Future<String> get name async => place.name;

  @override
  DocumentReference get restaurantRef => null;

  @override
  int get numFavorites => 0;

  @override
  Future<FirePhoto> get photoUrl => null;

  @override
  DocumentReference get reference => null;

  @override
  Set<DocumentReference> get reviewers => {};

  @override
  Future<String> get userUrl => null;

  @override
  int get score => 0;

  @override
  String get key => place.id;

  @override
  bool get hasPhoto => false;
}
