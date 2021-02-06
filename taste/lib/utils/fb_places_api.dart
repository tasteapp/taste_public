import 'dart:collection';
import 'dart:convert';

import 'package:edit_distance/edit_distance.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:query_params/query_params.dart';
import 'package:s2geometry/s2geometry.dart';
import 'package:taste/providers/account_provider.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/fb_places_whitelist.dart';
import 'package:taste/utils/logging.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' hide LatLng;
import 'package:tuple/tuple.dart';

const _kPlaceApiEndpoint = 'https://graph.facebook.com/v5.0/';
const _kSearchApiEndpoint = 'https://graph.facebook.com/search';
const _kDefaultSearchDistance = 150;
const _kDefaultLimit = 25;
const _kDefaultCategories = '["FOOD_BEVERAGE"]';
const _kDefaultFields =
    'name,hours,location,category_list,engagement,link,phone,website';
const _kAnonClientToken = 'FB_PLACES_API_TOKEN';

enum ProfilePicSource { facebook, cache }

class FacebookPlacesManager {
  FacebookPlacesManager._();

  static final Map<String, FacebookPlaceResult> _fbPlaceLookupCache = {};
  static final Map<String, String> _fbPlacePictureCache = {};
  static FacebookPlacesManager _instance;
  static FacebookPlacesManager get instance =>
      _instance ??= FacebookPlacesManager._();

  String _userAccessToken;

  Future<void> _ensureHasAccessToken() async {
    if (!(await hasConnectedWithFb())) {
      _userAccessToken = _kAnonClientToken;
      return;
    }
    if (!await facebookLogin.isLoggedIn) {
      await FirebaseAuth.instance.signOut();
    }
    _userAccessToken = (await facebookLogin.currentAccessToken).token;
  }

  Future<Tuple2<String, ProfilePicSource>> getProfilePicture(String id) async {
    if (_fbPlacePictureCache.containsKey(id)) {
      return Tuple2(_fbPlacePictureCache[id], ProfilePicSource.cache);
    }
    FacebookPlaceResult result = await getPlaceById(id);
    if (result?.pageId?.isEmpty ?? true) {
      return const Tuple2("", ProfilePicSource.facebook);
    }
    await _ensureHasAccessToken();
    URLQueryParams params = URLQueryParams()
      ..append('access_token', _userAccessToken)
      ..append('type', "large")
      ..append('redirect', '0');
    String url =
        '$_kPlaceApiEndpoint/${result.pageId}/picture?${params.toString()}';
    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        return const Tuple2("", ProfilePicSource.facebook);
      }
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      assert(result is Map);
      final profilePictureData = (result["data"] ?? {}) as Map<String, dynamic>;
      final profilePicture = profilePictureData["url"] as String;
      _fbPlacePictureCache[id] = profilePicture;
      return Tuple2(profilePicture ?? "", ProfilePicSource.facebook);
    } catch (err) {
      logger.e('Exception making FB getPlaceById API request:\n $err');
      return const Tuple2("", ProfilePicSource.facebook);
    }
  }

  Future<FacebookPlaceResult> getPlaceById(String id) async {
    if (_fbPlaceLookupCache.containsKey(id)) {
      return _fbPlaceLookupCache[id];
    }
    await _ensureHasAccessToken();
    URLQueryParams params = URLQueryParams()
      ..append('access_token', _userAccessToken)
      ..append('fields', _kDefaultFields);
    String url = '$_kPlaceApiEndpoint/$id?${params.toString()}';
    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        return null;
      }
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      assert(result is Map);
      final fbPlaceResult = FacebookPlaceResult.from(result);
      _fbPlaceLookupCache[id] = fbPlaceResult;
      return fbPlaceResult;
    } catch (err) {
      logger.e('Exception making FB getPlaceById API request:\n $err');
      return null;
    }
  }

  // Does not take advantage of paging to get more results. Probably not needed.
  Future<List<FacebookPlaceResult>> nearbyPlaces(
      {LatLng location, String term = ""}) async {
    print('fb#nearbyPlaces searching for $term at $location');
    if ((location == null) && (term?.trim()?.isEmpty ?? true)) {
      return [];
    }
    await _ensureHasAccessToken();
    URLQueryParams params = URLQueryParams()
      ..append('access_token', _userAccessToken)
      ..append('type', 'place')
      ..append('fields', _kDefaultFields)
      ..append('limit', _kDefaultLimit);
    if (location != null) {
      params.append(
          'center', [location.latitude, location.longitude].join(','));
    }
    // Both categories and q can't be supplied or FB API returns empty result.
    if (term.isEmpty) {
      params
        ..append('categories', _kDefaultCategories)
        ..append('distance', _kDefaultSearchDistance);
    } else {
      params.append('q', term);
    }
    String url = '$_kSearchApiEndpoint?${params.toString()}';
    print('Url: $url');
    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        logger
            .e('Error in searchPlaces: ${response.statusCode} ${response.body}'
                '\n(lat, lng): ($location)');
        return null;
      }
      var result = jsonDecode(response.body);
      assert(result['data'] is List);
      List<FacebookPlaceResult> results = [];
      for (final item in (result['data'] as Iterable)
          .map((x) => Map<String, dynamic>.from(x as Map))) {
        // For searches, we have to filter to food/beverage place. Since category
        // filtering and searching doesn't seem to be supported at the same time.
        if (term.isNotEmpty && !_isFoodPlace(item)) {
          print('Skipping $item');
          continue;
        }
        final fbResult = FacebookPlaceResult.from(item);
        if (!_isValidFBPlace(fbResult)) {
          continue;
        }
        results.add(fbResult);
      }
      results = _getDedupedResults(results);
      if (location != null) {
        _sortByDistanceToSource(results, location.s2);
      }
      if (results.isEmpty && location != null && term.isNotEmpty) {
        return await nearbyPlaces(term: term);
      }
      return results;
    } catch (e, s) {
      logger.e('Exception making FB searchPlaces API request', e, s);
      return null;
    }
  }

  /// Asserts place is food/beverage valid.
  bool _isFoodPlace(Map<String, dynamic> jsonResult) {
    try {
      return (jsonResult['category_list'] as Iterable).any((c) =>
          isRestaurantCategory(
              c['name'] as String, int.parse(c['id'] as String)));
    } catch (e) {
      Crashlytics.instance.log(['fb failure', e.toString()].toString());
      return false;
    }
  }

  void _sortByDistanceToSource(
      List<FacebookPlaceResult> places, S2LatLng source) {
    places.sort(
      (a, b) {
        double aDist = a.location.s2.getDistance(source).meters;
        double bDist = b.location.s2.getDistance(source).meters;
        return aDist.compareTo(bDist);
      },
    );
  }
}

class FacebookPlaceResult with EquatableMixin {
  FacebookPlaceResult({
    @required this.id,
    @required this.name,
    @required this.street,
    @required this.city,
    @required this.state,
    @required this.country,
    @required this.location,
    @required this.engagementCount,
    @required this.hours,
    @required this.categories,
    @required this.pageId,
    this.phone,
    this.website,
  });

  final String id;
  final String name;
  final String street;

  /// Will look like the following:
  /// [
  ///   {
  ///      "key": "tue_1_open",
  ///      "value": "11:30"
  ///   },
  ///   {
  ///      "key": "tue_1_close",
  ///      "value": "21:00"
  ///   },
  ///  ...
  final Map<String, dynamic> hours;
  final List<String> categories;
  final String city;
  final String state;
  final String country;
  final LatLng location;
  final int engagementCount;
  final String pageId;
  final String phone;
  final String website;

  String get detailedAddress => address.detailed;
  Restaurant_Attributes_Address get address => {
        'street': street,
        'city': city,
        'state': state,
        'country': country,
        'source': Restaurant_Attributes_Address_Source.facebook,
        'source_location': {
          'latitude': location.latitude,
          'longitude': location.longitude,
        }
      }.asProto(Restaurant_Attributes_Address());

  static FacebookPlaceResult from(Map<String, dynamic> result) {
    final location = result['location'] ?? {};
    final engagement = result['engagement'] ?? {};
    Map<String, String> hours = {};
    for (final hour in result["hours"] ?? []) {
      final hourMap = hour as Map<String, dynamic>;
      if (!hourMap.containsKey("key") || !hourMap.containsKey("value")) {
        continue;
      }
      hours[hourMap["key"] as String] = hourMap["value"] as String;
    }
    List<String> categories = [];
    for (final category in result["category_list"] ?? []) {
      if (category is Map<String, dynamic> && category.containsKey("name")) {
        categories.add(category["name"] as String);
      }
    }
    String link = (result["link"] ?? "") as String;
    List<String> segments =
        Uri.parse(link).pathSegments.where((s) => s.isNotEmpty).toList();
    String pageId = segments.isNotEmpty ? segments.last : "";
    return FacebookPlaceResult(
      id: result['id'] as String,
      name: result['name'] as String,
      street: location['street'] as String,
      city: location['city'] as String,
      state: location['state'] as String,
      country: location['country'] as String,
      location: LatLng(
        (location['latitude'] ?? 0.0) as double,
        (location['longitude'] ?? 0.0) as double,
      ),
      engagementCount: engagement['count'] as int ?? 0,
      hours: hours,
      categories: categories,
      pageId: pageId,
      phone: result['phone'] as String ?? '',
      website: result['website'] as String ?? '',
    );
  }

  @override
  List<Object> get props => [id];

  @override
  String toString() => [
        id,
        name,
        street,
        city,
        state,
        country,
        location,
        engagementCount
      ].toString();

  List<String> get restaurantCategories => categories
      .map((c) {
        final split = c.toLowerCase().split(" ");
        if (split.length <= 1) {
          return null;
        }
        return split.last == 'restaurant'
            ? split.take(split.length - 1).join(" ")
            : null;
      })
      .withoutNulls
      .toList();
}

List<FacebookPlaceResult> _getDedupedResults(List<FacebookPlaceResult> places) {
  // Sort by engagementCount (DESC) then ID (ASC) to make de-duping
  // deterministic.
  var sortedPlaces = List<FacebookPlaceResult>.from(places)
    ..sort((a, b) {
      // b compareTo a since descending
      final engagementComparisonResult =
          b.engagementCount.compareTo(a.engagementCount);
      if (engagementComparisonResult != 0) {
        return engagementComparisonResult;
      }
      return a.id.compareTo(b.id);
    });
  // LinkedHashMap remembers insertion order
  Map<String, FacebookPlaceResult> byId =
      LinkedHashMap.from({for (var place in sortedPlaces) place.id: place});

  List<FacebookPlaceResult> dedupedResults = [];
  while (byId.isNotEmpty) {
    FacebookPlaceResult current = byId.entries.first.value;
    byId.remove(current.id);
    List<String> idsToRemove = [];
    // Remove all duplicates.
    for (final place in byId.values) {
      if (place.id == current.id) {
        continue;
      }
      if (areDuplicates(place, current)) {
        idsToRemove.add(place.id);
      }
    }
    idsToRemove.forEach(byId.remove);
    dedupedResults.add(current);
  }
  return dedupedResults;
}

const _kMaxDistanceForDupesMeters = 75;
const _kDupeNameThreshold = 0.34;
const _kDupeNameSoftThreshold = 0.6;
final Levenshtein _levenshtein = Levenshtein();

bool _isValidFBPlace(FacebookPlaceResult a) {
  if (a.location.latitude == 0.0 && a.location.longitude == 0.0) {
    return false;
  }
  return [a.city, a.location, a.name].every((v) => v != null);
}

/// We consider two places as duplicates if they are within 50 meters of one
/// another and the levenshtein distance is < 20% of their length.
/// Note that we trim strings to be the same size.
@visibleForTesting
bool areDuplicates(FacebookPlaceResult a, FacebookPlaceResult b) {
  final levenshteinDist =
      _levenshtein.normalizedDistance(normalizedName(a), normalizedName(b));
  // If names are close enough and addresses match- assume always dupe.
  // Very unlikely that two different places have names that are very
  // similar with and also have the same street address.
  if (levenshteinDist < _kDupeNameThreshold &&
      a.street != null &&
      normalizedStreet(a.street) == normalizedStreet(b.street)) {
    return true;
  }
  // Don't even consider when too far.
  if (a.location.distanceMeters(b.location) > _kMaxDistanceForDupesMeters) {
    return false;
  }
  // When close enough check name similarity.
  if (levenshteinDist < _kDupeNameThreshold) {
    return true;
  }
  // When names are not quite as similar (Bla Bla Bistro vs Bla Bla) do soft
  // name check further confirmed by street name comparison.
  if (levenshteinDist < _kDupeNameSoftThreshold ||
      a.name.startsWith(b.name) ||
      b.name.startsWith(a.name)) {
    // On a soft match, use street address equality to dedupe.
    if (a.street != null &&
        normalizedStreet(a.street) == normalizedStreet(b.street)) {
      return true;
    }
  }
  return false;
}

String normalizedName(FacebookPlaceResult a) {
  // remove commas and periods.
  String normalizedName = a.name.replaceAll(RegExp('[,.]'), '').toLowerCase();
  if (a.city?.isNotEmpty ?? false) {
    normalizedName = normalizedName.replaceAll(a.city.toLowerCase(), '');
  }
  if (a.state?.isNotEmpty ?? false) {
    normalizedName = normalizedName.replaceAll(a.state.toLowerCase(), '');
  }
  return normalizedName.replaceAll('restaurant', '');
}

String normalizedStreet(String streetAddress) {
  if (streetAddress == null) {
    return streetAddress;
  }
  // Loosely based on https://pe.usps.com/text/pub28/28apc_002.htm
  return streetAddress
      .toLowerCase()
      .replaceAll(' street', ' st')
      .replaceAll(' road', ' rd')
      .replaceAll(' avenue', ' ave')
      .replaceAll(' boulevard', ' blvd')
      .replaceAll(' circle', ' cir')
      .replaceAll(' court', ' ct')
      .replaceAll(' expressway', ' expy')
      .replaceAll(' highway', ' hwy')
      .replaceAll(' junction', ' jct');
}

final _categoryInsensitive = RegExp(
    r'(restaurant|coffee|cafe|bakery|diner|hotel|pizza|joint|noodle|gastro|'
    'dessert|winery)',
    caseSensitive: false);
final _categorySensitive = RegExp(r'(Bar|Pub)');

@visibleForTesting
bool isRestaurantCategory(String name, int id) =>
    name.contains(_categorySensitive) ||
    name.contains(_categoryInsensitive) ||
    fbPlacesWhitelist.contains(id);
