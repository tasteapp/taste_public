import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:google_maps_webservice/places.dart";
import 'package:http/http.dart' if (dart.library.js) 'node_client.dart';
import 'package:taste/utils/logging.dart';

export "package:google_maps_webservice/places.dart" show Location;

const placesApiKey = "GOOGLE_PLACES_API_KEY";

class GooglePlacesManager {
  GooglePlacesManager._();
  static GooglePlacesManager _instance;
  static GooglePlacesManager get instance =>
      _instance ??= GooglePlacesManager._();
  final _placesService =
      GoogleMapsPlaces(apiKey: placesApiKey, httpClient: Client());

  Future<List<PlacesSearchResult>> search(LatLng location, String term) async {
    PlacesSearchResponse response = await _placesService.searchNearbyWithRankBy(
      Location(location.latitude, location.longitude),
      "distance",
      keyword: term,
      name: term,
    );
    logger.d(
        "Google Places search term: $term, num responses: ${response.results.length}");
    return response.results;
  }

  Future<List<String>> getPlacePhotos(
      String placeId, double maxHeight, double maxWidth) async {
    final details =
        await _placesService.getDetailsByPlaceId(placeId, fields: ["photos"]);
    return details.result.photos
        .map((p) => _placesService.buildPhotoUrl(
            photoReference: p.photoReference,
            maxHeight: maxHeight.round(),
            maxWidth: maxWidth.round()))
        .toList();
  }
}
