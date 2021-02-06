import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/algolia/config.dart';
import 'package:taste/algolia/search_result.dart';
import 'package:taste_protos/taste_protos.dart' hide LatLng;

import '../app_config.dart';

class AlgoliaClient {
  AlgoliaClient(this.config)
      : algolia = Algolia.init(apiKey: config.apiKey, applicationId: config.id);
  final AlgoliaConfig config;
  final Algolia algolia;

  Future<List<SearchResult>> search({
    String term,
    LatLngBounds bounds,
    LatLng location,
    int radiusMeters,
    int hitsPerPage = 300,
    Set<String> tags,
    Set<DocumentReference> following,
    @required String index,
  }) async {
    AlgoliaQuery query = algolia.index(index);
    if (following != null) {
      query = query.setFacetFilter(createFollowingFilter(following));
    }
    if (location != null) {
      query =
          query.setAroundLatLng("${location.latitude},${location.longitude}");
      if (bounds == null && radiusMeters == null) {
        query = query.setAroundRadius('all');
      }
      if (radiusMeters != null) {
        query = query.setAroundRadius(radiusMeters);
      }
    }
    if (bounds != null) {
      query = query.setInsideBoundingBox(toBoxes(bounds));
    }
    query = query.setHitsPerPage(hitsPerPage);
    if (term != null) {
      query = query.search(term);
    }
    for (final String tag in tags ?? <String>{}) {
      query = query.setTagFilter(tag);
    }
    final result = await query.getObjects().catchError((e, StackTrace s) {
      Crashlytics.instance.recordError(e, s, context: {
        'reason': 'algolia search',
        'term': term,
        'query': query.parameters.toString()
      });
      return null;
    });
    return (result?.hits ?? [])
        .map((hit) => SearchResult(
            Firestore.instance
                .document(hit.data['reference'] as String ?? hit.objectID),
            hit.data))
        .toList(growable: false);
  }

  Future<List<AlgoliaRestaurant>> searchRestos(
      {LatLng location,
      int radiusMeters,
      int hitsPerPage = 150,
      Set<PlaceType> placeTypes,
      Set<FoodType> foodTypes,
      Set<PlaceCategory> placeCategories,
      Set<String> deliveryProviders}) async {
    AlgoliaQuery query = algolia.index('restaurants');
    if (placeTypes != null && placeTypes.isNotEmpty) {
      query = query.setFacetFilter(createPlaceTypeFilter(placeTypes));
    }
    if (foodTypes != null && foodTypes.isNotEmpty) {
      query = query.setFacetFilter(createFoodTypeFilter(foodTypes));
    }
    if (placeCategories != null && placeCategories.isNotEmpty) {
      query = query.setFacetFilter(createCategoriesFilter(placeCategories));
    }
    if (deliveryProviders != null && deliveryProviders.isNotEmpty) {
      query =
          query.setFacetFilter(createDeliveryProviderFilter(deliveryProviders));
    }
    if (location != null) {
      query =
          query.setAroundLatLng("${location.latitude},${location.longitude}");
      query = query.setAroundRadius(radiusMeters ?? 'all');
    }
    query = query.setHitsPerPage(hitsPerPage);
    query = query.setTagFilter('restaurant');
    final result = await query.getObjects().catchError((e, StackTrace s) {
      Crashlytics.instance.recordError(e, s, context: {
        'reason': 'algolia restaurant search',
        'query': query.parameters.toString()
      });
      return null;
    });
    return (result?.hits ?? [])
        .map(AlgoliaRestaurant.fromResult)
        .toList(growable: false);
  }
}

List<String> createPlaceTypeFilter(Set<PlaceType> placeTypes) =>
    placeTypes.map((p) => 'place_types:${p.name}').toList();

List<String> createFoodTypeFilter(Set<FoodType> foodTypes) =>
    foodTypes.map((p) => 'food_types:${p.name}').toList();

List<String> createCategoriesFilter(Set<PlaceCategory> placeCategories) =>
    placeCategories.map((p) => 'place_categories:${p.name}').toList();

List<String> createDeliveryProviderFilter(Set<String> deliveryProvider) =>
    deliveryProvider.map((p) => 'delivery:$p').toList();

List<String> createFollowingFilter(Set<DocumentReference> following) =>
    following.map((f) => 'reviewers:${f.path}').toList();

List<BoundingBox> toBoxes(LatLngBounds bounds) {
  if (bounds.southwest.longitude <= bounds.northeast.longitude) {
    return [
      BoundingBox(
          p1Lat: bounds.northeast.latitude,
          p2Lat: bounds.southwest.latitude,
          p1Lng: bounds.southwest.longitude,
          p2Lng: bounds.northeast.longitude)
    ];
  }
  return [
    BoundingBox(
        p1Lat: bounds.northeast.latitude,
        p2Lat: bounds.southwest.latitude,
        p1Lng: bounds.southwest.longitude,
        p2Lng: 180),
    BoundingBox(
        p1Lat: bounds.northeast.latitude,
        p2Lat: bounds.southwest.latitude,
        p1Lng: -180,
        p2Lng: bounds.northeast.longitude)
  ];
}

final algoliaClient = AlgoliaClient(algoliaConfig);
