import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_bloc.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({Key key, this.initialPosition}) : super(key: key);
  static const INITIAL_ZOOM = 15.0;

  final CameraPosition initialPosition;
  MapBloc getBloc(BuildContext context) => MapBloc.of(context);

  @override
  Widget build(BuildContext context) {
    final bloc = getBloc(context);
    return GoogleMap(
      initialCameraPosition: initialPosition,
      onMapCreated: (controller) => bloc.onMapCreated(context, controller),
      onCameraIdle: () => bloc.onCameraIdle(context),
      onCameraMove: (cameraPosition) =>
          bloc.onCameraMove(context, cameraPosition),
      onTap: (latLng) => bloc.onTap(context, latLng),
      compassEnabled: false,
      indoorViewEnabled: false,
      mapToolbarEnabled: false,
      myLocationButtonEnabled: false,
      mapType: MapType.normal,
      trafficEnabled: false,
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
      myLocationEnabled: true,
    );
  }
}
