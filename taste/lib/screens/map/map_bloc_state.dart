import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiver/collection.dart';
import 'package:quiver/iterables.dart';
import 'package:taste/screens/map/map_page.dart';
import 'package:taste/utils/fixed_size_queue.dart';
import 'package:taste/utils/utils.dart';

import 'cluster.dart';
import 'review_marker.dart';

class ScrollerState {
  final historyLengthNotifier = ValueNotifier(0);
  final List<ReviewMarker> history = [];

  bool isAnimating = false;
  int get itemCount => history.length;
  final controller = PageController(viewportFraction: 0.9);
  ReviewMarker marker(int page) =>
      page >= history.length ? null : history[page];

  Future _jumpTo(ReviewMarker marker, Iterable<ReviewMarker> candidates) async {
    if (marker == null) {
      history.clear();
      historyLengthNotifier.value = 0;
      return;
    }

    if (!history.contains(marker)) {
      history
        ..clear()
        ..add(marker);
    }
    final index = history.indexOf(marker);
    if (controller.hasClients) {
      isAnimating = true;
      await controller.animateToPage(index,
          duration: const Duration(seconds: 1), curve: Curves.elasticOut);
      isAnimating = false;
    }

    if (index == history.length - 1) {
      final candidate = min<ReviewMarker>(
          candidates.where((marker) => !history.contains(marker)).toList(),
          (a, b) => latLngDistance(marker.location, a.location)
              .compareTo(latLngDistance(marker.location, b.location)));
      if (candidate != null) {
        history.add(candidate);
      }
    }
    final candidatesSet = candidates.toSet();
    history.removeWhere((marker) => !candidatesSet.contains(marker));
    historyLengthNotifier.value = history.length;
  }
}

class MapBlocState {
  MapBlocState() {
    scrollerState = ScrollerState();
  }
  ScrollerState scrollerState;
  final cameraPositionQueue = FixedSizeQueue<CameraPosition>(10);
  final boundsQueue = FixedSizeQueue<LatLngBounds>(10);
  final idledBoundsQueue = FixedSizeQueue<LatLngBounds>(10);
  final _activeMarkerQueue = FixedSizeQueue<ReviewMarker>(10);
  final markerPressedQueue = FixedSizeQueue<ReviewMarker>(10);
  final mapPageStateQueue = FixedSizeQueue<MapPageState>(10);
  final Map<ReviewMarker, Cluster> clusters = {};
  final LruMap<String, ReviewMarker> markers = LruMap(maximumSize: 1000);
  final idleController = StreamController();
  Stream _idled;

  bool onlyFollowing = false;
  bool onlyBlackOwned = false;
  Future<Set<DocumentReference>> followingSet;

  Future<Set<DocumentReference>> get following async =>
      onlyFollowing ? await followingSet : null;

  bool doubleZoomBlock = false;

  Stream get idled => _idled ??= idleController.stream.asBroadcastStream();

  bool isFlying = false;
  bool loading = false;

  void didIdle(LatLngBounds bounds) {
    idleController.add(null);
    idledBoundsQueue.add(bounds);
  }

  Future updateActiveMarker(ReviewMarker marker) async {
    _activeMarkerQueue.add(marker);
    await scrollerState._jumpTo(marker,
        (await maybeFilterMarkers).where((review) => review.reference != null));
  }

  Future deactiveMarker() async {
    await updateActiveMarker(null);
  }

  ReviewMarker get activeMarker => _activeMarkerQueue.head;
  Iterable<ReviewMarker> get activeMarkerHistory => _activeMarkerQueue.toList();
  Future<Iterable<ReviewMarker>> get maybeFilterMarkers async {
    final following = await this.following;
    if (following == null) {
      return markers.values;
    }
    return markers.values.where((m) {
      return m.reviewers != null &&
          m.reviewers.intersection(following).isNotEmpty;
    });
  }
}
