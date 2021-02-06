import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/algolia/client.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/screens/map/map_utils.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/restaurant.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/ranking.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart'
    show
        CoverPhoto,
        PlaceType,
        FoodType,
        PlaceCategory,
        FoodFinderAction_ActionType;
import 'package:web_mercator_dart/web_mercator_tiles.dart';

part 'food_finder_manager.freezed.dart';

const kDefaultFilterRadius = 2.0;
const kMaxSearchRadius = 30.0;
const kZerosLocation = LatLng(0.0, 0.0);

@freezed
abstract class FoodFinderEvent with _$FoodFinderEvent {
  const factory FoodFinderEvent.setQueryResults(RestoQueryResults results) =
      _SetQueryResults;
  const factory FoodFinderEvent.setCurrentRestos(
      List<AlgoliaRestaurant> restos) = _SetCurrentRestos;
  const factory FoodFinderEvent.setCurrentIndex(int newIndex) =
      _SetCurrentIndex;
  const factory FoodFinderEvent.setMaybeList(
      List<AlgoliaRestaurant> newMaybeList) = _SetMaybeList;
  const factory FoodFinderEvent.addToMaybeList(List<CoverPhoto> coverPhotos) =
      _AddToMaybeList;
  const factory FoodFinderEvent.removeFromMaybeList(AlgoliaRestaurant resto) =
      _RemoveFromMaybeList;
  const factory FoodFinderEvent.clearMaybeList() = _ClearMaybeList;
  const factory FoodFinderEvent.setNoList(Set<AlgoliaRestaurant> newNoList) =
      _SetNoList;
  const factory FoodFinderEvent.addToNoList(List<CoverPhoto> coverPhotos) =
      _AddToNoList;
  const factory FoodFinderEvent.setLocation(LocationInfo location) =
      _SetLocation;
  const factory FoodFinderEvent.setFilters(FoodFilters newFilters) =
      _SetFilters;
  const factory FoodFinderEvent.setIsLoading(bool isLoading) = _SetIsLoading;
  const factory FoodFinderEvent.setActiveDiscoverItem(
          DocumentReference restoReference, int newActiveDiscoverItem) =
      _SetActiveDiscoverItem;
  const factory FoodFinderEvent.toggleShowMap() = _ToggleShowMap;
}

@freezed
abstract class FoodFinderState with _$FoodFinderState {
  factory FoodFinderState({
    Set<AlgoliaRestaurant> allRestos,
    List<AlgoliaRestaurant> currentRestos,
    int currentIndex,
    double queriedRadius,
    List<AlgoliaRestaurant> maybeList,
    Set<AlgoliaRestaurant> noList,
    LocationInfo location,
    FoodFilters filters,
    bool isLoading,
    Map<DocumentReference, int> activeDiscoverItemMap,
    String sessionId,
    bool showMap,
  }) = _Create;
  FoodFinderState._();

  @override
  String toString() => [
        "Num restos: ${allRestos.length}",
        "Num current restos: ${currentRestos.length}",
        "Current resto: ${currentIndex >= currentRestos.length - 1 ? "" : currentResto?.name ?? ""}",
        "Current index: $currentIndex",
        "Queried radius: $queriedRadius",
        "Maybe list length: ${maybeList.length}",
        "No list length: ${noList.length}",
        "Location: $location",
        "FoodFilters: $filters",
        "Is loading: $isLoading",
        "Active discover items: $activeDiscoverItemMap",
      ].join("\n");

  AlgoliaRestaurant get currentResto => currentRestos[currentIndex];
  Set<AlgoliaRestaurant> get excludeList => maybeList.toSet()..addAll(noList);

  bool get restosValid =>
      currentRestos.isNotEmpty && currentRestos.length > currentIndex;

  bool get hasFilters => filters.hasFilters;

  double newRadius(RestoQueryResults results) => filters.placeTypes.isEmpty
      ? max(queriedRadius, results.filters.radius)
      : queriedRadius;

  List<String> get currentRestoIds =>
      currentRestos.map((e) => e.fbPlaceId).toList();

  LatLngBounds get restoBounds =>
      pointsBounds(currentRestos.map((r) => r.location));

  Future createFoodFinderAction(
      List<CoverPhoto> coverPhotos, FoodFinderAction_ActionType action,
      {AlgoliaRestaurant resto}) async {
    final now = DateTime.now();
    await CollectionType.food_finder_actions.coll.add({
      'user': currentUserReference,
      'restaurant': resto?.reference ?? currentResto.reference,
      'discoverItems': coverPhotos.map((d) => d.reference.ref).toList(),
      'active_discover_item_index':
          activeDiscoverItemMap[currentResto.reference] ?? 0,
      '_extras': {
        'created_at': now,
        'updated_at': now,
      },
      'action': action.name,
      'time': now,
      'session_id': sessionId,
    });
  }
}

class LocationInfo {
  const LocationInfo({this.name = "", this.currentLocation, this.setLocation});
  final String name;
  final LatLng currentLocation;
  final LatLng setLocation;

  @override
  String toString() =>
      "\"${name.isNotEmpty ? name : "Your Location"}\", $location}";

  LatLng get location => setLocation ?? currentLocation;

  bool equals(LocationInfo other) =>
      name == other.name &&
      currentLocation == other.currentLocation &&
      setLocation == other.setLocation;

  static LocationInfo get empty =>
      const LocationInfo(name: "", currentLocation: kZerosLocation);

  LocationInfo withoutSetLocation() =>
      LocationInfo(name: name, currentLocation: currentLocation);

  LocationInfo withSetLocation(String newName, LatLng location) => LocationInfo(
      name: newName, currentLocation: currentLocation, setLocation: location);
}

class RestoQueryResults with EquatableMixin {
  RestoQueryResults(
      {this.allRestos, this.currentRestos, this.location, this.filters});
  final Set<AlgoliaRestaurant> allRestos;
  final List<AlgoliaRestaurant> currentRestos;
  final LocationInfo location;
  final FoodFilters filters;

  RestoQueryResults copyWith(
          {Set<AlgoliaRestaurant> newAllRestos,
          List<AlgoliaRestaurant> newCurrentRestos,
          LocationInfo newLocation,
          FoodFilters newFilters,
          double newRadius}) =>
      RestoQueryResults(
          allRestos: newAllRestos ?? allRestos,
          currentRestos: newCurrentRestos ?? currentRestos,
          location: newLocation ?? location,
          filters: newFilters ?? filters);

  @override
  List<Object> get props => [...allRestos, ...currentRestos, location];
}

class FoodFilters with EquatableMixin {
  FoodFilters({
    this.radius = kDefaultFilterRadius,
    this.placeTypes = const {},
    this.foodTypes = const {},
    this.placeCategories = const {},
    this.onlyDelivery = false,
    this.openNow = false,
    this.deliveryProviders = const {},
  });

  final double radius;
  final Set<PlaceType> placeTypes;
  final Set<FoodType> foodTypes;
  final Set<PlaceCategory> placeCategories;
  final bool onlyDelivery;
  final bool openNow;
  final Set<String> deliveryProviders;

  @override
  String toString() => [
        "Radius: $radius",
        "Place types: ${placeTypes.join(",")}",
        "Food types: ${foodTypes.join(",")}",
        "Categories: ${placeCategories.join(",")}",
        "Only delivery: $onlyDelivery",
        "Open now: $openNow",
        "Delivery services : ${deliveryProviders.join(",")}"
      ].join("\n");

  Set<PlaceType> get getAllPlaceTypes => placeTypes.isNotEmpty
      ? placeTypes
      : [
          if (placeCategories.contains(PlaceCategory.restaurants))
            restaurantPlaceTypes,
          if (placeCategories.contains(PlaceCategory.cafes)) kCafePlaceTypes,
          if (placeCategories.contains(PlaceCategory.desserts))
            kDessertBakeryPlaceTypes,
          if (placeCategories.contains(PlaceCategory.bars)) kBarPlaceTypes,
        ].flatten.toSet();

  bool equals(FoodFilters other) =>
      other != null &&
      radius == other.radius &&
      setEquals(placeTypes, other.placeTypes) &&
      setEquals(foodTypes, other.foodTypes) &&
      setEquals(placeCategories, other.placeCategories) &&
      onlyDelivery == other.onlyDelivery &&
      openNow == other.openNow &&
      setEquals(deliveryProviders, other.deliveryProviders);

  FoodFilters copyWith(
          {double newRadius,
          Set<PlaceType> newPlaceTypes,
          Set<FoodType> newFoodTypes,
          Set<PlaceCategory> newPlaceCategories,
          bool newOnlyDelivery,
          bool newOpenNow,
          Set<String> newDeliveryProviders}) =>
      FoodFilters(
          radius: newRadius ?? radius,
          placeTypes: newPlaceTypes ?? placeTypes,
          foodTypes: newFoodTypes ?? foodTypes,
          placeCategories: newPlaceCategories ?? placeCategories,
          onlyDelivery: newOnlyDelivery ?? onlyDelivery,
          openNow: newOpenNow ?? openNow,
          deliveryProviders: newDeliveryProviders ?? deliveryProviders);

  bool get hasFilters =>
      placeTypes.isNotEmpty ||
      foodTypes.isNotEmpty ||
      placeCategories.isNotEmpty ||
      onlyDelivery ||
      radius < kMaxSearchRadius ||
      deliveryProviders.isNotEmpty;

  @override
  List<Object> get props =>
      [...placeTypes, ...foodTypes, radius, ...deliveryProviders];
}

const categoryNameMap = {
  PlaceCategory.restaurants: "Restaurants",
  PlaceCategory.cafes: "Cafes",
  PlaceCategory.desserts: "Desserts",
  PlaceCategory.bars: "Bars",
};
String categoryToString(PlaceCategory c) => categoryNameMap[c];

// Always load Restaurants for up to 10 restaurants ahead.
const _numRestosToPreload = 10;

class FoodFinderManager extends Bloc<FoodFinderEvent, FoodFinderState> {
  FoodFinderManager()
      : _initial = FoodFinderState(
          allRestos: {},
          currentRestos: [],
          currentIndex: 0,
          queriedRadius: 0.0,
          maybeList: [],
          noList: {},
          location: LocationInfo.empty,
          filters: FoodFilters(
              placeTypes: {},
              foodTypes: {},
              placeCategories: {PlaceCategory.restaurants},
              deliveryProviders: {}),
          isLoading: false,
          activeDiscoverItemMap: {},
          sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
          showMap: false,
        ) {
    Timer.periodic(500.millis, (timer) async {
      _restaurantLoadTimer = timer;
      if (_loading || state.currentRestos.isEmpty) {
        return;
      }
      final currentResto = state.currentResto;
      final currentRestoLoaded =
          restoRefToRestaurantStreams[currentResto.reference].value != null;
      final pastFrontier =
          _restaurantFrontier >= state.currentIndex + _numRestosToPreload;
      final endOfList = _restaurantFrontier == state.currentRestos.length - 1;
      if (currentRestoLoaded && (pastFrontier || endOfList)) {
        return;
      }
      _restaurantFrontier =
          !currentRestoLoaded ? state.currentIndex : _restaurantFrontier + 1;
      final resto = state.currentRestos[_restaurantFrontier];
      await loadRestaurant(resto.reference);
    });
  }
  final FoodFinderState _initial;
  Timer _restaurantLoadTimer;
  int _restaurantFrontier = -1;
  bool _loading = false;
  final Map<DocumentReference, BehaviorSubject<Restaurant>>
      restoRefToRestaurantStreams = {};

  Future loadRestaurant(DocumentReference restoReference,
      {bool setLoading = true}) async {
    if (restoRefToRestaurantStreams[restoReference].value != null) {
      return;
    }
    _loading = setLoading || _loading;
    try {
      final startTime = DateTime.now();
      final resto = await restoReference.get().then((r) => Restaurant(r));
      final timeTakenMs = DateTime.now().difference(startTime).inMilliseconds;
      TAEvent.food_finder_discover_items_load({'time_taken_ms': timeTakenMs});
      restoRefToRestaurantStreams[restoReference].add(resto);
    } finally {
      _loading = !setLoading && _loading;
    }
  }

  @override
  Future<void> close() async {
    _restaurantLoadTimer.cancel();
    await super.close();
  }

  Stream<Restaurant> getRestaurant(DocumentReference restoReference) {
    if (!restoRefToRestaurantStreams.containsKey(restoReference)) {
      return restoRefToRestaurantStreams.putIfAbsent(
          restoReference, () => BehaviorSubject.seeded(null));
    }
    return restoRefToRestaurantStreams[restoReference].stream;
  }

  @override
  FoodFinderState get initialState => _initial;

  @override
  Stream<FoodFinderState> mapEventToState(FoodFinderEvent event) async* {
    yield event.when(
      setQueryResults: (results) {
        print('setQueryResults called with ${results.allRestos.length} restos');
        final restos = results.allRestos;
        for (final resto in restos) {
          restoRefToRestaurantStreams.putIfAbsent(
              resto.reference, () => BehaviorSubject.seeded(null));
        }
        _restaurantFrontier = -1;
        return state.copyWith(
          allRestos: state.allRestos..addAll(results.allRestos),
          currentRestos: results.currentRestos,
          location: results.location,
          currentIndex: 0,
          queriedRadius: state.filters.placeTypes.isEmpty
              ? max(state.queriedRadius, results.filters.radius)
              : state.queriedRadius,
          filters: results.filters,
          isLoading: false,
        );
      },
      setCurrentRestos: (restos) => state.copyWith(currentRestos: restos),
      setCurrentIndex: (idx) => state.copyWith(currentIndex: idx),
      setMaybeList: (maybeList) => state.copyWith(maybeList: maybeList),
      addToMaybeList: (coverPhotos) {
        if (!state.maybeList.contains(state.currentResto)) {
          state.createFoodFinderAction(
              coverPhotos, FoodFinderAction_ActionType.add_to_list);
        }
        return state.copyWith(
          noList: Set<AlgoliaRestaurant>.of(state.noList)
            ..remove(state.currentResto),
          maybeList: List<AlgoliaRestaurant>.of(
              state.maybeList.contains(state.currentResto)
                  ? state.maybeList
                  : [...state.maybeList, state.currentResto]),
        );
      },
      removeFromMaybeList: (resto) {
        state.createFoodFinderAction(
            [], FoodFinderAction_ActionType.remove_from_list,
            resto: resto);
        return state.copyWith(
            maybeList: List<AlgoliaRestaurant>.of(state.maybeList)
              ..remove(resto));
      },
      clearMaybeList: () {
        state.maybeList.forEach((r) => state.createFoodFinderAction(
              [],
              FoodFinderAction_ActionType.remove_from_list,
              resto: r,
            ));
        return state.copyWith(maybeList: List<AlgoliaRestaurant>.of([]));
      },
      setNoList: (noList) => state.copyWith(noList: noList),
      addToNoList: (coverPhotos) {
        state.createFoodFinderAction(
            coverPhotos, FoodFinderAction_ActionType.pass);
        return state.copyWith(
          noList: Set<AlgoliaRestaurant>.of(state.noList)
            ..add(state.currentResto),
          maybeList: List<AlgoliaRestaurant>.of(state.maybeList)
            ..remove(state.currentResto),
        );
      },
      setLocation: (location) => state.copyWith(location: location),
      setFilters: (filters) => state.copyWith(filters: filters),
      setIsLoading: (isLoading) => state.copyWith(isLoading: isLoading),
      setActiveDiscoverItem: (restoReference, itemIndex) {
        state.activeDiscoverItemMap[restoReference] = itemIndex;
        return state.copyWith(
            activeDiscoverItemMap: state.activeDiscoverItemMap);
      },
      toggleShowMap: () => state.copyWith(showMap: !state.showMap),
    );
  }
}

class StateChanges {
  StateChanges({this.filters, this.location, this.apply = false});
  FoodFilters filters;
  LocationInfo location;
  bool apply;
}

void loadRestaurants(FoodFinderManager bloc, FoodFinderState state,
    {StateChanges changes, bool flexibleRadius = true}) {
  int startTime = DateTime.now().millisecondsSinceEpoch;
  bloc.add(const FoodFinderEvent.setIsLoading(true));
  queryNearbyRestaurants(state,
          foodFilters: changes?.filters,
          locationInfo: changes?.location,
          flexibleRadius: flexibleRadius)
      .asStream()
        ..listen((r) {
          final timeTaken = DateTime.now().millisecondsSinceEpoch - startTime;
          bloc.add(FoodFinderEvent.setQueryResults(r));
          TAEvent.food_finder_load({'time_taken_ms': timeTaken});
          print("Time taken: ${timeTaken / 1000}");
        });
}

Future setNewFilters(FoodFinderManager bloc, FoodFinderState state,
    {FoodFilters newFilters}) async {
  final filters = newFilters ?? state.filters;
  final currentRestos = getCurrentRestos(state.allRestos, state.excludeList,
      state.location, filters.radius, filters);
  bloc
    ..add(const FoodFinderEvent.setCurrentIndex(0))
    ..add(FoodFinderEvent.setFilters(filters))
    ..add(FoodFinderEvent.setCurrentRestos(currentRestos));
}

double restoScore(Restaurant resto, FoodFilters filters, double distance) =>
    resto.popularityScore;

List<AlgoliaRestaurant> filterRestos(
        Set<AlgoliaRestaurant> restos,
        Set<AlgoliaRestaurant> excludeList,
        double radius,
        FoodFilters filters) =>
    restos
        .where((resto) =>
            // Stuff that's not on the maybe list or no list.
            !excludeList.contains(resto) &&
            // Place types filter
            (filters.placeTypes.isEmpty ||
                getRelevantTypes(resto)
                    .keys
                    .toSet()
                    .intersection(filters.placeTypes.toSet())
                    .isNotEmpty) &&
            // Categories filter
            (filters.placeCategories.isEmpty ||
                resto.placeCategories
                    .toSet()
                    .intersection(filters.placeCategories.toSet())
                    .isNotEmpty) &&
            resto.numReviews > 0 &&
            // Delivery providers filter
            (filters.deliveryProviders.isEmpty ||
                resto.deliveryProviders
                    .toSet()
                    .intersection(filters.deliveryProviders.toSet())
                    .isNotEmpty) &&
            // Food types filter
            (filters.foodTypes.isEmpty ||
                resto.foodTypes
                    .toSet()
                    .intersection(filters.foodTypes.toSet())
                    .isNotEmpty))
        .where((resto) => !filters.onlyDelivery || resto.hasDelivery)
        .where((resto) => !filters.openNow || resto.isOpen)
        .toList();

List<AlgoliaRestaurant> distanceFilterRestos(
        List<AlgoliaRestaurant> restos, LocationInfo location, double radius) =>
    restos
        .map((resto) =>
            MapEntry(resto, location.location.distanceMeters(resto.location)))
        .where((r) => r.value < radius * kMetersPerMile)
        .map((r) => r.key)
        .toList();

List<AlgoliaRestaurant> getCurrentRestos(
  Set<AlgoliaRestaurant> restos,
  Set<AlgoliaRestaurant> excludeList,
  LocationInfo location,
  double radius,
  FoodFilters filters,
) {
  var filteredRestos = filterRestos(restos, excludeList, radius, filters);
  var distanceFilteredRestos =
      distanceFilterRestos(filteredRestos, location, radius);
  return RestoRanking.sort(
    restos: distanceFilteredRestos,
    placeTypes: filters.getAllPlaceTypes,
    location: location.location,
  ).sideEffect((t) => 'num restos after ranking: ${t.length}');
}

/// Returns tiles for an array-contains-any query. Note that there is a limit of
/// 10 values in the supplied array for a Firestore array-contains-any query.
/// We start at zoom level 14 and incrementally zoom out until the number of
/// tiles fits within the limit.
List<String> getTilesForQuery(LatLng latLng, double radiusMiles) {
  const _maxTiles = 10;
  var currentZoom = 14;
  List<Tile> result;
  do {
    result = WebMercatorTiles.getTiles(
      latLng.latitude,
      latLng.longitude,
      radiusMiles,
      currentZoom,
    );
    currentZoom -= 1;
  } while (result.length > _maxTiles);
  return result.map((x) => x.token).toList();
}

Future<RestoQueryResults> queryNearby(
    LocationInfo location,
    Set<AlgoliaRestaurant> excludeList,
    FoodFilters filters,
    double radius,
    int minResults,
    {bool flexibleRadius = true,
    int startTime}) async {
  final restos = await algoliaClient
      .searchRestos(
          location: location.location,
          radiusMeters: (radius * kMetersPerMile).round(),
          placeTypes: filters.placeTypes,
          placeCategories: filters.placeCategories,
          hitsPerPage: 100,
          deliveryProviders: filters.deliveryProviders)
      .then((r) => r.toSet());
  print("Num results: ${restos.length}");
  if (flexibleRadius &&
      restos.length < minResults &&
      radius < kMaxSearchRadius) {
    return queryNearby(location, excludeList, filters,
        min(2 * radius, kMaxSearchRadius), minResults,
        startTime: startTime);
  }
  return RestoQueryResults(
    allRestos: restos,
    currentRestos:
        getCurrentRestos(restos, excludeList, location, radius, filters),
    location: location,
    filters: filters.copyWith(newRadius: radius),
  );
}

Future<RestoQueryResults> queryNearbyRestaurants(FoodFinderState state,
    {FoodFilters foodFilters,
    LocationInfo locationInfo,
    bool flexibleRadius = true}) async {
  final filters = foodFilters ?? state.filters;
  final location = locationInfo ?? state.location;
  final startTime = DateTime.now().millisecondsSinceEpoch;
  final loc = location == null || location.location == kZerosLocation
      ? await myLocationStream.withoutNulls
          .map((l) => LocationInfo(currentLocation: l))
          .firstWhere((l) => l.currentLocation != kZerosLocation)
      : location;
  return queryNearby(
      loc,
      state.excludeList,
      filters,
      filters.radius,
      filters.placeTypes.isEmpty &&
              filters.placeCategories.isEmpty &&
              filters.deliveryProviders.isEmpty
          ? 50
          : 10,
      flexibleRadius: flexibleRadius,
      startTime: startTime);
}
