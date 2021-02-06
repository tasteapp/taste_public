import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/taste_backend_client/backend.dart';

import '../app_config.dart';

final Map<LatLng, Address> _addressCache = {};

Future<Address> getAddress(LatLng location) async {
  if (_addressCache.containsKey(location)) {
    return _addressCache[location];
  }
  final coordinates = Coordinates(location.latitude, location.longitude);
  final address = (await Geocoder.google(googleApiKey)
          .findAddressesFromCoordinates(coordinates))
      .firstOrNull;
  _addressCache[location] = address;
  return address;
}

Future<LatLng> getLocation({String city, String country}) async {
  final coords = (await Geocoder.google(googleApiKey)
          .findAddressesFromQuery('$city, $country'))
      .first
      ?.coordinates;
  return coords == null ? null : LatLng(coords.latitude, coords.longitude);
}
