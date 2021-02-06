import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taste/components/taste_progress_indicator.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/screens/food_finder/filter_chips.dart';
import 'package:taste/screens/food_finder/food_finder_manager.dart';
import 'package:taste/screens/map/google_map_widget.dart';
import 'package:taste/screens/map/map_utils.dart';
import 'package:taste/screens/map/markers_layer.dart';
import 'package:taste/screens/map/restaurant_preview.dart';
import 'package:taste/screens/map/taste_marker.dart';
import 'package:taste/taste_backend_client/responses/restaurant.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/utils.dart';

import 'map_bloc.dart';
import 'user_app_bar_widget.dart';

class MapPageState {
  MapPageState({
    this.markerData,
    this.showOverlays,
    this.showRestaurantScroller,
    this.user,
    this.bounds,
    this.position,
    this.isLoading,
  });

  final List<TasteMarkerData> markerData;
  final bool showOverlays;
  final bool showRestaurantScroller;
  final TasteUser user;
  final LatLngBounds bounds;
  final CameraPosition position;
  final bool isLoading;

  LatLngBounds get markerBounds =>
      pointsBounds(markerData.map((m) => m.reviewMarker.location));

  bool get showSearchNearby {
    if (bounds == null ||
        position == null ||
        position.zoom > 15 ||
        position.zoom < 12) {
      return false;
    }
    final overlapBounds = overlap(markerBounds, bounds);
    if (overlapBounds == null) {
      return true;
    }
    final lats = [
      overlapBounds.southwest.latitude,
      overlapBounds.northeast.latitude
    ];
    final lngs = [
      overlapBounds.southwest.longitude,
      overlapBounds.northeast.longitude
    ];
    final threshBounds = LatLngBounds(
        southwest: fractionAlong(bounds.southwest, bounds.northeast, 0.32),
        northeast: fractionAlong(bounds.southwest, bounds.northeast, 0.68));
    return lats.max((t) => t) < threshBounds.southwest.latitude ||
        lats.min((t) => t) > threshBounds.northeast.latitude ||
        lngs.max((t) => t) < threshBounds.southwest.longitude ||
        lngs.min((t) => t) > threshBounds.northeast.longitude;
  }

  double get boundsRadius =>
      (10 *
              position.target.distanceMeters(bounds.northeast) *
              0.9 /
              kMetersPerMile)
          .round() /
      10;

  static MapPageState get empty => MapPageState(
      markerData: [],
      showOverlays: false,
      showRestaurantScroller: false,
      isLoading: false);
}

class MapPage extends StatefulWidget {
  const MapPage({
    Key key,
    this.mapBlocBuilder,
    this.initialPosition,
    this.initialLocation,
    this.initialZoom,
    this.initialRestaurant,
    this.isFoodFinder = false,
    this.jumpAfter = true,
  }) : super(key: key);

  final MapBloc Function(BuildContext context) mapBlocBuilder;

  final CameraPosition initialPosition;
  final LatLng initialLocation;
  final Restaurant initialRestaurant;
  final bool isFoodFinder;
  final double initialZoom;
  final bool jumpAfter;

  CameraPosition get position {
    if (initialPosition != null) {
      return initialPosition;
    }
    if (initialLocation != null) {
      return CameraPosition(
          zoom: initialZoom ?? GoogleMapWidget.INITIAL_ZOOM,
          target: initialLocation);
    }
    if (initialRestaurant != null) {
      return CameraPosition(
          zoom: GoogleMapWidget.INITIAL_ZOOM,
          target: LatLng(initialRestaurant.location.latitude,
              initialRestaurant.location.longitude));
    }
    return null;
  }

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool showSettingsPanel = false;
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final map = GoogleMapWidget(
        initialPosition: widget.position ??
            CameraPosition(
                target: myLocationStream.value ??
                    const LatLng(37.773972, -122.431297),
                zoom: 10));
    final restaurantPreview = Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: RestaurantPreview(),
      ),
    );
    final noWidget = Container();
    return Provider<MapBloc>(
        dispose: (context, bloc) => bloc.dispose(context),
        create: (_) => widget.mapBlocBuilder == null
            ? MapBloc(context, initialRestaurant: widget.initialRestaurant)
            : widget.mapBlocBuilder(context),
        child: Builder(
          builder: (context) => StreamBuilder<MapPageState>(
            stream: MapBloc.stream(context),
            initialData: MapPageState.empty,
            builder: (context, snapshot) {
              final bloc = MapBloc.of(context);
              final mapPageState = snapshot.data;
              final markerData = mapPageState.markerData;
              final showOverlays = mapPageState.showOverlays;
              final markersLayer = MarkersLayer(
                markerData: markerData,
                mapPageState: mapPageState,
              );
              final mapBody = Stack(children: [
                map,
                IgnorePointer(child: markersLayer),
                if (mapPageState.showRestaurantScroller)
                  restaurantPreview
                else
                  noWidget,
                if (mapPageState.isLoading ?? false)
                  const Center(
                    child: TasteLargeCircularProgressIndicator(size: 100.0),
                  ),
                if (widget.isFoodFinder &&
                        !mapPageState.isLoading &&
                        mapPageState.showSearchNearby ??
                    false)
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: kFoodFinderFiltersHeight),
                        child: SearchAreaButton(
                          onPressed: () => loadRestaurants(
                            bloc.manager,
                            bloc.foodFinderState,
                            changes: StateChanges(
                              filters: bloc.foodFinderState.filters.copyWith(
                                  newRadius: mapPageState.boundsRadius),
                              location: bloc.foodFinderState.location
                                  .withSetLocation("Set From Map",
                                      mapPageState.position.target),
                            ),
                            flexibleRadius: false,
                          ),
                        ),
                      ),
                    ),
                  ),
              ]);
              return widget.isFoodFinder
                  ? mapBody
                  : Scaffold(
                      appBar: snapshot.data.user != null
                          ? AppBar(
                              title: UserAppBarWidget(user: snapshot.data.user),
                              centerTitle: true,
                            )
                          : null,
                      body: mapBody,
                      floatingActionButton: (showOverlays && !showSettingsPanel)
                          ? getActionButtons(context)
                          : noWidget,
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.startFloat,
                    );
            },
          ),
        ));
  }

  Widget getActionButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: mapWithPadding(<Widget>[
        FloatingActionButton(
          onPressed: () => MapBloc.goToMyLocationClicked(context),
          backgroundColor: Colors.white,
          shape: const CircleBorder(side: BorderSide(width: 1.0)),
          child: const Icon(Icons.my_location, color: Colors.black),
        ),
      ], padding: const EdgeInsets.symmetric(vertical: 4)),
    );
  }
}

class SearchAreaButton extends StatelessWidget {
  const SearchAreaButton({this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Colors.transparent)),
      elevation: 8.0,
      child: const Text(
        "Search this area",
        style: TextStyle(
            fontFamily: "Montserrat",
            color: Colors.blue,
            fontSize: 14.0,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
