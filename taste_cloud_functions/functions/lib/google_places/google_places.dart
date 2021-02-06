import 'package:taste_cloud_functions/taste_functions.dart';

final _manager = buildType.isTest
    ? _TestManager()
    : _GooglePlacesManager() as GooglePlacesManager;

mixin GooglePlacesManager {
  Future<List<PlacesSearchResult>> search(double lat, double lng, String term);
}

class _TestManager with GooglePlacesManager {
  @override
  Future<List<PlacesSearchResult>> search(
          double lat, double lng, String term) async =>
      [];
}

class _GooglePlacesManager with GooglePlacesManager {
  final _placesService =
      GoogleMapsPlaces(apiKey: 'GOOGLE_MAPS_API_KEY', httpClient: Client());
  @override
  Future<List<PlacesSearchResult>> search(
      double lat, double lng, String term) async {
    final responseFuture = _placesService.searchNearbyWithRankBy(
        Location(lat, lng), 'distance',
        keyword: term, type: 'food', name: term);
    final response = await responseFuture;
    return response.results.where((r) => r.types.contains('food')).toList();
  }
}

// Return the Google Place API id for the given name and location, or an
// empty string if none is found.
Future<String> getGooglePlaceId(String name, GeoPoint location) async {
  if (name == null || name.isEmpty || location == null) {
    return '';
  }
  final results =
      await _manager.search(location.latitude, location.longitude, name);
  return results.isNotEmpty ? results.first.placeId : '';
}
