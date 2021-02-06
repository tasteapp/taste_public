import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quiver/iterables.dart' as quiver;
import 'package:stream_transform/stream_transform.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/food_finder/food_finder_manager.dart';
import 'package:taste/screens/map/favorite_review_marker.dart';
import 'package:taste/screens/map/map_utils.dart';
import 'package:taste/screens/map/review_snapshot_review_marker.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/screens/restaurant/restaurant_page.dart';
import 'package:taste/screens/review/review.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/map.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/fb_places_api.dart';
import 'package:taste/utils/logging.dart';
import 'package:taste/utils/memoize.dart';
import 'package:taste/utils/utils.dart';
import 'package:vector_math/vector_math.dart';

import 'cluster.dart';
import 'map_bloc_state.dart';
import 'map_page.dart';
import 'map_utils.dart';
import 'restaurant_preview.dart';
import 'review_marker.dart';
import 'search_result_review_marker.dart';
import 'taste_marker.dart';

class MapBloc with Memoizer {
  MapBloc(BuildContext context,
      {this.reviews,
      this.user,
      this.manager,
      this.favorites = const [],
      this.initialRestaurant})
      : assert(!(reviews == null &&
            favorites == null &&
            initialRestaurant == null)),
        ratio = _computeRatio(context),
        size = MediaQuery.of(context).size {
    if (manager != null) {
      subscription = manager.listen((s) async {
        var shouldUpdateMarkers = false;
        if (!const ListEquality().equals(
            s.currentRestoIds, foodFinderState?.currentRestoIds ?? [])) {
          shouldUpdateMarkers = true;
        }
        foodFinderState = s;
        setLoading(foodFinderState.isLoading);
        if (shouldUpdateMarkers) {
          await updateMarkers(
              foodFinderState.currentRestos
                  .map((favorite) => FavoriteReviewMarker(favorite))
                  .toList(),
              clearMarkers: true);
        }
      });
      foodFinderState = manager.state;
    }
    state.followingSet =
        fetchFollowing().first.then((s) => {...s, currentUserReference});
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_disposed) {
        timer.cancel();
        return;
      }
      _moveStream.add(lastPosition);
    });
    _moveStream.stream
        .audit(const Duration(milliseconds: 10))
        .listen((cameraPosition) async {
      state.cameraPositionQueue.add(cameraPosition);
      await update();
      state.boundsQueue.add(await computeBounds);
      await update();
    });
  }
  bool _disposed = false;
  FoodFinderState foodFinderState;
  StreamSubscription<FoodFinderState> subscription;

  static const minDistance = 100.0;
  static const tapDistance = minDistance * 0.6;

  ReviewMarker get activeMarker => state.activeMarker;
  LatLngBounds get lastBounds => state.boundsQueue.head;
  CameraPosition get lastPosition => state.cameraPositionQueue.head;

  bool get showOverlays => user == null;

  final MapBlocState state = MapBlocState();
  final double ratio;

  final Size size;
  void setLoading(bool loading) => state.loading = loading;
  final List<Post> reviews;
  final TasteUser user;
  final List<AlgoliaRestaurant> favorites;
  final FoodFinderManager manager;
  final Restaurant initialRestaurant;

  Future<double> get estimatedZoom async =>
      calculateZoomToFit(await bounds, size) * 1.05;

  static double _computeRatio(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
        return 1;
      default:
        return 1 / MediaQuery.of(context).devicePixelRatio;
    }
  }

  bool get isUserMap => false;

  Future<GoogleMapController> get mapControllerFuture =>
      mapControllerCompleter.future;
  final mapControllerCompleter = Completer<GoogleMapController>();

  Map<String, ReviewMarker> get markers => state.markers;

  Future<LatLng> get currentCenter async {
    final bounds = await this.bounds;
    return center(bounds);
  }

  Future<LatLngBounds> get bounds async {
    final lastBounds = this.lastBounds;
    if (lastBounds == null) {
      final bounds = await computeBounds;
      state.boundsQueue.add(bounds);
      await update();
      return bounds;
    }
    return lastBounds;
  }

  static MapBloc of(BuildContext context) =>
      Provider.of<MapBloc>(context, listen: false);

  Future onMapCreated(
      BuildContext context, GoogleMapController controller) async {
    mapControllerCompleter.complete(controller);
    await controller.setMapStyle(kTasteMapStyle);
    if (initialRestaurant != null) {
      final review =
          (await initialRestaurant.reviews.first).max((r) => r.score);
      if (review == null) {
        final place = await initialRestaurant?.fbPlace;
        if (place != null) {
          await goToFacebookResult(place, fly: false);
          return;
        }
      }
      final marker = ReviewSnapshotReviewMarker(review);
      state.markers[marker.restaurantRef.path] = marker;
      await update();
      await updateActive(marker, fly: false, scrollChange: false);
      return;
    }
    final favoritesRefs = (favorites ?? []).map((f) => f.reference).toSet();
    await updateMarkers(
        (reviews?.map<ReviewMarker>((review) => ReviewSnapshotReviewMarker(
                      review,
                      isFavorited: favoritesRefs.contains(review.restaurantRef),
                    )) ??
                [])
            .toList()
              ..addAll(
                  favorites.map((favorite) => FavoriteReviewMarker(favorite))));
  }

  Future onCameraIdle(BuildContext context) async {
    state.didIdle(await bounds);
    await update();
    maybeDeactivateOnZoom();
  }

  final _moveStream = StreamController<CameraPosition>();

  void onCameraMove(BuildContext context, CameraPosition cameraPosition) {
    _moveStream.add(cameraPosition);
  }

  Future<ReviewMarker> markerAtLocation(LatLng latLng) async {
    final offset = await toOffset(latLng);
    return quiver
        .min<TasteMarkerData>(
            (await markerData)
                .where((marker) =>
                    state.clusters.keys.contains(marker.reviewMarker))
                .where((marker) =>
                    marker.position.distanceTo(offset) < tapDistance),
            (a, b) => a.position
                .distanceTo(offset)
                .compareTo(b.position.distanceTo(offset)))
        ?.reviewMarker;
  }

  Future onTap(BuildContext context, LatLng latLng) async {
    final tappedMarker = await markerAtLocation(latLng);
    if (tappedMarker != null) {
      await onMarkerPressed(context, tappedMarker);
      return;
    }
    TAEvent.map_tap({'location': '${latLng.latitude},${latLng.longitude}'});
    await state.deactiveMarker();
    state.markerPressedQueue.add(null);
    await update();
  }

  static Future<LatLng> mapCenter(BuildContext context) =>
      of(context).currentCenter;

  Future<LatLngBounds> get computeBounds async =>
      (await mapControllerFuture).getVisibleRegion();

  static Future goToMyLocationClicked(BuildContext context) async {
    TAEvent.map_my_location();
    await of(context)._goToMyLocationClicked;
    final status = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse);
    if (status == PermissionStatus.neverAskAgain) {
      await showDialog(
          context: context,
          builder: (context) => TasteDialog(
                title: "Enable Location Services",
                content: const Text(
                    "For a better experience, please enable location services in application settings"),
                buttons: [
                  TasteDialogButton(
                      onPressed: () => Navigator.pop(context), text: 'Cancel'),
                  TasteDialogButton(
                      onPressed: () {
                        Navigator.pop(context);
                        PermissionHandler().openAppSettings();
                      },
                      text: 'Go To Settings')
                ],
              ));
    }
  }

  Future get _goToMyLocationClicked async {
    // setLoading(true);
    await update();
    if ((await requestLocationPermissions).isEnabled) {
      return flyTo(await myLocation());
    }
  }

  Future updateMarkers(List<ReviewMarker> reviewMarkers,
      {bool stay, bool clearMarkers = false}) async {
    if (clearMarkers ?? false) {
      state.markers.clear();
    }
    for (final marker in reviewMarkers) {
      state.markers.putIfAbsent(marker.key, () => marker);
    }
    if (!(stay ?? false)) {
      await flyToBox(blocMarkersBounds);
    }
    await update();
  }

  LatLngBounds get blocMarkersBounds => state.markers.isEmpty
      ? lastBounds
      : pointsBounds(state.markers.values.map((marker) => marker.location));

  Future update() async {
    final next = await computeState;
    state.mapPageStateQueue.add(next);
    controller.add(next);
  }

  Future<MapPageState> get computeState async {
    final hasActive = activeMarker != null;
    return MapPageState(
        user: user,
        showOverlays: showOverlays && !hasActive,
        showRestaurantScroller:
            hasActive && activeMarker is! FacebookRestaurantMarker,
        markerData: await markerData,
        bounds: lastBounds,
        position: lastPosition,
        isLoading: state.loading);
  }

  // Parts of the code can temporarily disable the preference of markers to stay
  // in their last cluster by setting this to true.
  //
  // It will be set back to false after one loop of [markerData()].
  //
  // This is useful to undo undesirably large clusters, particularly when
  // clicking on a cluster, where it would be better if the cluster size were
  // small to permit a better zoom-fit.
  bool disableClusterAffinity = false;

  Future<List<TasteMarkerData>> get markerData async {
    if (lastBounds == null) {
      return [];
    }

    final bounds = lastBounds;
    final startMarkers = (await state.maybeFilterMarkers)
        .where((marker) =>
            toS2Rect(expand(bounds, 1.2)).contains(toS2LatLng(marker.location)))
        .toList(growable: false)
        .tupleSort(
            (marker) => [
                  marker == activeMarker,
                  marker.hasPhoto,
                  marker.score,
                  cluster(marker)?.parent == marker,
                  cluster(marker)?.fanned?.contains(marker) ?? false,
                  marker.numFavorites ?? 0,
                  marker.reference?.path ?? '',
                ].listMap((i) => i is bool ? (i ? 1 : 0) : i as Comparable),
            desc: true);
    if (activeMarker != null &&
        !startMarkers.contains(activeMarker) &&
        !state.isFlying) {
      await state.deactiveMarker();
    }
    final isAnyActive = activeMarker != null;
    final positions = Map.fromEntries(await Future.wait(startMarkers.map(
        (marker) async => MapEntry(marker, await toOffset(marker.location)))));
    final parents = startMarkers.fold<Set<ReviewMarker>>({}, (parents, marker) {
      if (marker == activeMarker) {
        parents.add(marker);
        return parents;
      }
      final position = positions[marker];
      if (parents.every(
          (parent) => positions[parent].distanceTo(position) >= minDistance)) {
        parents.add(marker);
        return parents;
      }
      return parents;
    });

    final clusters =
        startMarkers.fold<Map<ReviewMarker, Cluster>>({}, (clusters, marker) {
      Map<ReviewMarker, Cluster> add(ReviewMarker parent,
          [ReviewMarker child]) {
        final cluster =
            clusters.putIfAbsent(parent, () => Cluster.init(parent));
        if (child != null) {
          cluster.add(child);
        }
        return clusters;
      }

      if (parents.contains(marker)) {
        return add(marker);
      }
      final position = positions[marker];
      final previousParent = cluster(marker)?.parent;
      if (!disableClusterAffinity &&
          parents.contains(previousParent) &&
          positions[previousParent].distanceTo(position) < minDistance * 1.3) {
        return add(previousParent, marker);
      }

      return add(
          clusters.values
              .firstWhere((cluster) =>
                  (positions[cluster.parent]?.distanceTo(position) ??
                      double.infinity) <
                  minDistance)
              .parent,
          marker);
    }).values;
    clusters.where((cluster) {
      cluster.fanned.clear();
      if (cluster.parent == activeMarker) {
        return false;
      }
      final position = positions[cluster.parent];
      const rightAngle = pi / 2;
      final offset = (Vector2(1, 1) * minDistance * 0.56)
        ..multiply(Vector2(cos(rightAngle), sin(rightAngle)));
      return clusters.every((otherCluster) {
        return (otherCluster == cluster) ||
            ((position - offset).distanceTo(positions[otherCluster.parent]) >
                minDistance * 0.7);
      });
    }).forEach((cluster) => cluster.fanned
      ..clear()
      ..addAll(cluster.children.take(2)));
    state.clusters.clear();
    state.clusters.addEntries(clusters.expand((cluster) => [
          MapEntry(cluster.parent, cluster),
          ...cluster.children.map((marker) => MapEntry(marker, cluster))
        ]));

    final visible = clusters.expand((cluster) {
      final parent = TasteMarkerData(
          isOffstage: false,
          clusterCount: cluster.children.length,
          isActive: cluster.parent == activeMarker,
          isAnyActive: isAnyActive,
          isFanned: false,
          reviewMarker: cluster.parent,
          position: positions[cluster.parent]);
      final fanned = cluster.fanned;
      final fannedCount = fanned.length;
      final fannedData = fanned.asMap().entries.map((entry) {
        final i = entry.key;
        final marker = entry.value;
        final angle = fannedCount == 1 ? pi / 2 : (2 * pi) / 10 * (2 + i);
        final offset = (Vector2(1, 1) * minDistance * 0.56)
          ..multiply(Vector2(cos(angle), sin(angle)));

        return TasteMarkerData(
            isOffstage: false,
            clusterCount: 0,
            isActive: false,
            isAnyActive: isAnyActive,
            isFanned: true,
            reviewMarker: marker,
            position: positions[cluster.parent] - offset);
      });
      return [parent, ...fannedData];
    }).toList();
    final invisible = state.scrollerState.history
        .toSet()
        .difference(visible.map((r) => r.reviewMarker).toSet())
        .map((marker) {
      return TasteMarkerData(
          isOffstage: true,
          clusterCount: 1,
          // Pre-download hi-res if coming up in queue.
          isActive: true,
          isAnyActive: isAnyActive,
          isFanned: false,
          reviewMarker: marker,
          position: Vector2(0, 0));
    });
    disableClusterAffinity = false;
    return visible..addAll(invisible);
  }

  Future flyTo(LatLng latLng) async {
    await flyProtect(() async {
      await (await mapControllerFuture)
          .animateCamera(await cameraUpdate(latLng));
    });
  }

  Future flyProtect(Future Function() fn) async {
    // setLoading(true);
    state.isFlying = true;
    await fn();
    await state.idled.first.timeout(const Duration(seconds: 3), onTimeout: () {
      logger.d("Time out");
    });
    state.isFlying = false;
    // setLoading(false);
  }

  bool shouldZoom(LatLngBounds bounds) {
    if (bounds == null) {
      return false;
    }
    return area(bounds) > 100;
  }

  Future flyToBox(LatLngBounds bounds) async {
    await flyProtect(() async {
      if (!shouldZoom(bounds)) {
        LatLng boundsCenter = center(bounds);
        await (await mapControllerFuture)
            .animateCamera(await cameraUpdate(boundsCenter));
      } else {
        await (await mapControllerFuture).animateCamera(
            CameraUpdate.newLatLngBounds(bounds, size.width * 0.2));
      }
    });
  }

  static const flyZoom = 13.0;

  Future goToFacebookResult(FacebookPlaceResult fbPlace,
      {bool fly = true}) async {
    TAEvent.map_go_to_search_result(
        {'reference': fbPlace.id, 'facebook': true});
    await updateActive(null);
    if (fly) {
      await flyTo(fbPlace.location);
    }
    final marker = markers.putIfAbsent(
        fbPlace.id, () => FacebookRestaurantMarker(fbPlace));
    await updateActive(marker);
  }

  Future updateActive(ReviewMarker marker,
      {bool fly = false, bool scrollChange = false}) async {
    if (scrollChange && marker != null) {
      state.doubleZoomBlock = true;
      LatLngBounds includeBounds =
          computeLatLngBounds(state.activeMarker?.location, marker?.location);
      if (shouldZoomToInclude(includeBounds)) {
        await flyToBox(includeBounds);
        await Future.delayed(const Duration(milliseconds: 500));
      }
      await state.updateActiveMarker(marker);
      await flyTo(marker.location);
      await update();
      Future.delayed(
          const Duration(seconds: 2), () => state.doubleZoomBlock = false);
      return;
    }
    if (fly && marker != null) {
      await flyTo(marker.location);
    }
    await state.updateActiveMarker(marker);
    await update();
  }

  Future<Vector2> toOffset(LatLng latLng) async {
    final controller = await mapControllerFuture;
    final pixels = await controller.getScreenCoordinate(latLng);
    return Vector2(pixels.x * ratio, pixels.y * ratio);
  }

  bool get hasActiveMarker => state.activeMarker != null;

  bool get tappedManyConsecutive {
    if (state.markerPressedQueue.head == null) {
      return false;
    }
    return state.markerPressedQueue
            .take(3)
            .takeWhile((x) => x == state.markerPressedQueue.head)
            .length ==
        3;
  }

  Cluster cluster(ReviewMarker marker) => state.clusters[marker];

  Future onMarkerPressed(BuildContext context, ReviewMarker tasteMarker) async {
    disableClusterAffinity = true;
    TAEvent.map_marker_tap({'marker': tasteMarker.key});
    state.markerPressedQueue.add(tasteMarker);
    if (tasteMarker == activeMarker) {
      await pushMarkerPage(context, tasteMarker);
      return;
    }
    final cluster = this.cluster(tasteMarker);
    final clusterBounds = cluster != null
        ? pointsBounds(
            cluster.parentAndChildren.map((marker) => marker.location))
        : null;
    final isNonEmptyCluster = cluster?.children?.isNotEmpty ?? false;
    final haventTappedALot = !tappedManyConsecutive;
    final notZoomedIn = shouldZoom(clusterBounds);
    if (isNonEmptyCluster && haventTappedALot && notZoomedIn) {
      await flyToBox(clusterBounds);
      return;
    }
    await updateActive(tasteMarker);
    await flyTo(tasteMarker.location);
  }

  Future tappedPreview(BuildContext context, int pageNumber) async {
    final marker = scrollerMarker(pageNumber);
    await pushMarkerPage(context, marker);
  }

  Future pushMarkerPage(BuildContext context, ReviewMarker marker) async {
    TAEvent.map_tapped_preview({'marker': marker?.reference?.path ?? ""});
    if (marker is FacebookRestaurantMarker) {
      TAEvent.fb_only_resto({'id': marker.place.id});
      return goToRestaurantPage(fbPlaceResult: marker.place);
    }
    await goToRestaurantPage(restaurant: await marker.restaurantRef.fetch());
  }

  ReviewMarker scrollerMarker(int page) => state.scrollerState.marker(page);

  static Future reviewClicked(BuildContext context, Review review) async {
    TAEvent.map_review_clicked({'review': review.reference.path ?? ""});
    hideSnackBar();
    await goToReviewPage(ReviewPageInput.review(review));
  }

  static Stream<MapPageState> stream(BuildContext context) {
    final bloc = of(context);
    return bloc._stream ??= bloc.controller.stream;
  }

  final controller = StreamController<MapPageState>();
  Stream<MapPageState> _stream;

  void maybeDeactivateOnZoom() {
    if (activeMarker == null) {
      return;
    }
    if (state.isFlying || state.doubleZoomBlock) {
      return;
    }
    final lastIdled = state.idledBoundsQueue.take(2).toList();
    if (lastIdled.length < 2) {
      return;
    }
    final areaRatio = area(lastIdled[0]) / area(lastIdled[1]);

    if (areaRatio < 1.1) {
      return;
    }
    state.deactiveMarker();
    update();
  }

  Future onPreviewPageChanged(int page) async {
    if (state.scrollerState.isAnimating) {
      return;
    }
    if (activeMarker == null) {
      return;
    }
    final marker = scrollerMarker(page);
    TAEvent.map_preview_changed(
        {'marker': marker.reference.path ?? "", 'page': page});
    await updateActive(marker, scrollChange: true);
  }

  Future<bool> isFullyVisible(ReviewMarker marker) async {
    final visible = lastBounds?.contains(marker.location) ?? true;
    if (!visible) {
      return false;
    }

    Vector2 position = await toOffset(marker.location);
    double widgetHeight =
        kActiveImageSize + kActiveImagePadding + kTitlePadding;
    double widgetWidth = kActiveImageSize + kActiveImagePadding;
    double availableHeight =
        size.height - kBottomNavigationBarHeight - kRestaurantPreviewHeight;
    double availableWidth = size.width;
    if (position.y < widgetHeight / 2 ||
        (availableHeight - position.y) < widgetHeight / 2) {
      return false;
    }
    if (position.x < widgetWidth / 2 ||
        (availableWidth - position.x) < widgetWidth / 2) {
      return false;
    }

    return visible;
  }

  LatLngBounds computeLatLngBounds(LatLng pointA, LatLng pointB) {
    if (pointA == null || pointB == null) {
      return null;
    }
    double minLat = min(pointA.latitude, pointB.latitude);
    double minLng = min(pointA.longitude, pointB.longitude);
    double maxLat = max(pointA.latitude, pointB.latitude);
    double maxLng = max(pointA.longitude, pointB.longitude);
    return LatLngBounds(
        southwest: LatLng(minLat, minLng), northeast: LatLng(maxLat, maxLng));
  }

  // Only zoom to include if we're zooming out. This means either the height
  // or width of the new bounds is greater than that of the last bounds.
  bool shouldZoomToInclude(LatLngBounds bounds) {
    LatLngBounds lastBounds = this.lastBounds;
    if (bounds == null || lastBounds == null) {
      return false;
    }

    double boundsHeight = bounds.northeast.latitude - bounds.southwest.latitude;
    double boundsWidth =
        bounds.northeast.longitude - bounds.southwest.longitude;
    double lastBoundsHeight =
        lastBounds.northeast.latitude - lastBounds.southwest.latitude;
    double lastBoundsWidth =
        lastBounds.northeast.longitude - lastBounds.southwest.longitude;

    return boundsHeight > lastBoundsHeight || boundsWidth > lastBoundsWidth;
  }

  Future<CameraUpdate> cameraUpdate(LatLng latLng) async {
    final zoom = max(flyZoom, lastPosition?.zoom ?? await estimatedZoom);
    return CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: zoom));
  }

  void dispose(BuildContext context) {
    _disposed = true;
    subscription.cancel();
  }
}
