import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';

mixin ReviewMarker {
  bool get hasPhoto;
  LatLng get location;
  Future<String> get name;
  Future<String> get userUrl;
  Future<FirePhoto> get photoUrl;
  AlgoliaRestaurant get algoliaRestaurant;
  DocumentReference get restaurantRef;
  DocumentReference get reference;
  Set<DocumentReference> get reviewers => null;
  int get numFavorites => 0;

  int get score => 0;

  Future prime() async {
    await Future.wait([name, userUrl, photoUrl]);
  }

  Future<AlgoliaRestaurant> get resto async => algoliaRestaurant != null
      ? Future.value(algoliaRestaurant)
      : restaurantRef
          .fetch<Restaurant>()
          .then(AlgoliaRestaurant.fromRestaurant);

  String get key => reference.path;
}
