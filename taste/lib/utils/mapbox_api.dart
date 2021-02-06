import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pedantic/pedantic.dart';
import 'package:taste_protos/extensions.dart';

const _token = 'MAPBOX_API_TOKEN';

enum MapboxDataType {
  country,
  region,
  postcode,
  district,
  place,
  locality,
  neighborhood,
  address,
  poi
}

class MapboxAutocompleteResult {
  const MapboxAutocompleteResult({
    this.fullName,
    this.data,
    this.name,
    this.location,
    this.type,
  });

  final Map<String, dynamic> data;

  /// Short name.
  final String name;

  /// Includes address.
  final String fullName;
  final LatLng location;
  final MapboxDataType type;

  @override
  String toString() {
    return '$name @ $location ($type)';
  }
}

/// Contains useful static functions for working with the Mapbox API. One thing
/// to keep in mind when working with Mapbox is that they use the lng,lat
/// "convention" for probably some made up and b.s. pedantic reason.
class MapBoxApi {
  static Future<List<MapboxAutocompleteResult>> autocomplete(
      String term, LatLng location) async {
    final uri = Uri(
      scheme: 'https',
      host: 'api.mapbox.com',
      path: 'geocoding/v5/mapbox.places/$term.json',
      queryParameters: {
        'access_token': _token,
        'autocomplete': 'true',
        'proximity': location == null
            ? null
            : '${location.longitude},${location.latitude}',
      }.withoutNulls,
    );
    print('sending query: $uri');
    var response = await http.get(uri);
    if (response.statusCode != 200) {
      unawaited(Crashlytics.instance.recordError(
          'Error with MapBox autocomplete: '
          '${response.statusCode}: ${response.reasonPhrase}',
          null));
      return [];
    }
    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
    final result = <MapboxAutocompleteResult>[];
    print('Response data: $responseBody');
    for (final feature in responseBody['features']) {
      final featureMap = feature as Map<String, dynamic>;
      final coordinates = (featureMap['geometry']
          as Map<String, dynamic>)['coordinates'] as List<dynamic>;
      result.add(MapboxAutocompleteResult(
        data: featureMap,
        name: featureMap['text'] as String,
        fullName: featureMap['place_name'] as String,
        location: LatLng(
          (coordinates[1] as num).toDouble(),
          (coordinates[0] as num).toDouble(),
        ),
        type: MapboxDataType.values
            .where((x) =>
                x.toString().replaceAll('MapboxDataType.', '') ==
                featureMap['place_type'][0] as String)
            .firstOrNull,
      ));
      print(result[result.length - 1]);
    }
    return result;
  }

  static String getMapBoxStaticTileUrl(
    LatLng location, {
    int width = 600,
    int height = 200,
  }) {
    final locationString = '${location.longitude},${location.latitude}';
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/'
        'pin-l+000($locationString)/$locationString,13/'
        '${width}x$height?access_token=$_token';
  }
}
