import 'package:node_http/node_http.dart' as http;
import 'package:s2geometry/s2geometry.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart';

// TODO(team): DEPRECATED endpoint!! Remove before May.
const _kPlaceApiEndpoint = 'https://graph.facebook.com/v5.0/';
const _kSearchApiEndpoint = 'https://graph.facebook.com/search';
const _kDefaultSearchDistance = 150;
const _kDefaultLimit = 25;
const _kCategoryListKey = 'category_list';
const _kDefaultCategories = '["FOOD_BEVERAGE"]';
const _kDefaultFields =
    'name,hours,location,category_list,engagement,link,phone,website';
const _kAnonClientToken = 'FB_ACCESS_TOKEN';

const fbPlacesWhitelist = {
  1083443491742919, // Bubble Tea Shop
  110113695730808, // Chicken Joint
  1194170890614519, // Gelato Shop
  127892053948220, // Cafeteria
  1432016430178110, // Kebab Shop
  144535972273084, // Brewery
  1545764135732572, // Bagel Shop
  164049010316507, // Gastropub
  1742050506043834, // Shaved Ice Shop
  176527262444235, // Farmers Market
  1848365298810025, // Noodle House
  187153754656815, // Dessert Shop
  188296324525457, // Sandwich Shop
  188334264523313, // Deli
  191478144212980, // Dance & Night Club
  198367566846946, // Steakhouse
  200863816597800, // Ice Cream Shop
  203462172997785, // Tea Room
  203743122984241, // Beer Garden
  2053716798185981, // Donut Shop
  207290352633942, // Jazz & Blues Club
  209630435729071, // Winery/Vineyard
  212285478786733, // Hot Dog Joint
  215290398491661, // Frozen Yogurt Shop
  218693881483234, // Pub
  2224, // Wine/Spirits
  248856718821424, // Irish Pub
  265658020466414, // Speakeasy
  325310894151007, // Cupcake Shop
  138756772860047, // Creperie
};

final stateAbbreviations = BiMap<String, String>()
  ..addAll({
    'Alabama': 'AL',
    'Alaska': 'AK',
    'Arizona': 'AZ',
    'Arkansas': 'AR',
    'California': 'CA',
    'Colorado': 'CO',
    'Connecticut': 'CT',
    'Delaware': 'DE',
    'Florida': 'FL',
    'Georgia': 'GA',
    'Hawaii': 'HI',
    'Idaho': 'ID',
    'Illinois': 'IL',
    'Indiana': 'IN',
    'Iowa': 'IA',
    'Kansas': 'KS',
    'Kentucky': 'KY',
    'Louisiana': 'LA',
    'Maine': 'ME',
    'Maryland': 'MD',
    'Massachusetts': 'MA',
    'Michigan': 'MI',
    'Minnesota': 'MN',
    'Mississippi': 'MS',
    'Missouri': 'MO',
    'Montana': 'MT',
    'Nebraska': 'NE',
    'Nevada': 'NV',
    'New Hampshire': 'NH',
    'New Jersey': 'NJ',
    'New Mexico': 'NM',
    'New York': 'NY',
    'North Carolina': 'NC',
    'North Dakota': 'ND',
    'Ohio': 'OH',
    'Oklahoma': 'OK',
    'Oregon': 'OR',
    'Pennsylvania': 'PA',
    'Rhode Island': 'RI',
    'South Carolina': 'SC',
    'South Dakota': 'SD',
    'Tennessee': 'TN',
    'Texas': 'TX',
    'Utah': 'UT',
    'Vermont': 'VT',
    'Virginia': 'VA',
    'Washington': 'WA',
    'West Virginia': 'WV',
    'Wisconsin': 'WI',
    'Wyoming': 'WY',
    'Commonwealth/Territory:': 'Abbreviation:',
    'District of Columbia': 'DC',
    'Marshall Islands': 'MH',
  });

extension AddressExtension on Restaurant_Attributes_Address {
  String get simple => (country == 'United States'
          ? [
              city,
              stateCode,
            ]
          : [
              city ?? state,
              country,
            ])
      .withoutEmpties
      .join(', ');
  String get detailed => [street, simple].withoutEmpties.join(', ');

  String get stateCode => stateAbbreviations[state] ?? state;
}

String toQueryParamsString(Map<String, dynamic> params) {
  return params.mapValue((k, v) => '$k=$v').values.join('&');
}

class FacebookNearbySearchResult {
  const FacebookNearbySearchResult(this.result, this.limitReached);
  final List<FacebookPlaceResult> result;
  final bool limitReached;
}

class FacebookPlaceByIdResult {
  const FacebookPlaceByIdResult(this.result, this.limitReached);
  final FacebookPlaceResult result;
  final bool limitReached;
}

final fbPlaces = buildType.isTest
    ? _FakeMananger()
    : _FacebookPlacesManager() as FacebookPlacesManager;

mixin FacebookPlacesManager {
  Future<FacebookPlaceByIdResult> getPlaceById(String fbPlaceId);

  Future<FacebookNearbySearchResult> nearbyPlaces(
      {double lat, double lng, String term = '', double maxDistanceMeters = 0});
}

class _FakeMananger with FacebookPlacesManager {
  @override
  Future<FacebookPlaceByIdResult> getPlaceById(String fbPlaceId) => null;

  @override
  Future<FacebookNearbySearchResult> nearbyPlaces(
          {double lat,
          double lng,
          String term = '',
          double maxDistanceMeters = 0}) async =>
      const FacebookNearbySearchResult([], false);
}

class _FacebookPlacesManager with FacebookPlacesManager {
  static final Map<String, FacebookPlaceResult> _fbPlaceLookupCache = {};

  @override
  Future<FacebookPlaceByIdResult> getPlaceById(String id) async {
    if (_fbPlaceLookupCache.containsKey(id)) {
      return FacebookPlaceByIdResult(_fbPlaceLookupCache[id], false);
    }
    final params = {
      'access_token': _kAnonClientToken,
      'fields': _kDefaultFields,
    };
    final url = '$_kPlaceApiEndpoint/$id?${toQueryParamsString(params)}';
    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        print('Error in searchPlaces: ${response.statusCode} ${response.body}');
        print('Reponse headers: ${response.headers}');
        final limitReached = response.body.contains('request limit reached');
        return FacebookPlaceByIdResult(null, limitReached);
      }
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      assert(result is Map);
      final fbPlaceResult = FacebookPlaceResult.from(result);
      _fbPlaceLookupCache[id] = fbPlaceResult;
      return FacebookPlaceByIdResult(fbPlaceResult, false);
    } catch (err) {
      print('Exception making FB getPlaceById API request:\n $err');
      return const FacebookPlaceByIdResult(null, false);
    }
  }

  Future<String> getProfilePicture(String id) async {
    var result = (await getPlaceById(id)).result;
    if (result.pageId.isEmpty) {
      return null;
    }
    final params = {
      'access_token': _kAnonClientToken,
      'type': 'large',
      'redirect': '0',
    };
    var url =
        '$_kPlaceApiEndpoint/${result.pageId}/picture?${toQueryParamsString(params)}';
    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        return null;
      }
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      assert(result is Map);
      final profilePictureData = (result['data'] ?? {}) as Map<String, dynamic>;
      final profilePicture = profilePictureData['url'] as String;
      return profilePicture;
    } catch (err) {
      print('Exception making FB getPlaceById API request:\n $err');
      return null;
    }
  }

  // Does not take advantage of paging to get more results. Probably not needed.
  @override
  Future<FacebookNearbySearchResult> nearbyPlaces(
      {double lat,
      double lng,
      String term = '',
      double maxDistanceMeters = 0}) async {
    final params = {
      'access_token': _kAnonClientToken,
      'type': 'place',
      'fields': _kDefaultFields,
      'limit': _kDefaultLimit,
    };
    if (lat != null && lng != null) {
      params['center'] = '$lat,$lng';
    }
    // Both categories and q can't be supplied or FB API returns empty result.
    if (term.isEmpty) {
      params['categories'] = _kDefaultCategories;
      params['distance'] = _kDefaultSearchDistance;
    } else {
      params['q'] = term;
    }
    final url = '$_kSearchApiEndpoint?${toQueryParamsString(params)}';
    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        print('Error in searchPlaces: ${response.statusCode} ${response.body}'
            '\n(lat, lng): ($lat, $lng)');
        print('Reponse headers: ${response.headers}');
        final limitReached = response.body.contains('request limit reached');
        return FacebookNearbySearchResult(null, limitReached);
      }
      var result = jsonDecode(response.body) as Map<String, dynamic>;
      assert(result['data'] is List);
      var data = result['data'] as List;
      var results = <FacebookPlaceResult>[];
      for (final item in data) {
        final fbResult = FacebookPlaceResult.from(item as Map<String, dynamic>);
        if (!_isValidFBPlace(fbResult)) {
          continue;
        }
        // For searches, we have to filter to food/beverage place. Since category
        // filtering and searching doesn't seem to be supported at the same time.
        if (term.isNotEmpty && !_isFoodPlace(item as Map<String, dynamic>)) {
          continue;
        }
        results.add(fbResult);
      }
      // Don't dedupe for exporter.
      // results = _getDedupedResults(results);
      if (lat != null && lng != null) {
        _sortByDistanceToSource(results, S2LatLng.fromDegrees(lat, lng));
      }
      if (results.isEmpty) {
        return const FacebookNearbySearchResult(null, false);
      }
      if (maxDistanceMeters == 0) {
        return const FacebookNearbySearchResult(null, false);
      }
      final latLng = S2LatLng.fromDegrees(lat, lng);
      final resultLatLng =
          S2LatLng.fromDegrees(results.first.lat, results.first.lng);
      return latLng.getDistance(resultLatLng).meters > maxDistanceMeters
          ? const FacebookNearbySearchResult(null, false)
          : FacebookNearbySearchResult(results, false);
    } catch (e, s) {
      print('Exception making FB searchPlaces API request: $e $s');
      return const FacebookNearbySearchResult(null, false);
    }
  }

  /// Asserts place is food/beverage valid.
  bool _isFoodPlace(Map<String, dynamic> jsonResult) {
    // Returned result contains category_list that looks like the following:
    /*
      "category_list": [
        {
            "id": "184460441595855",
            "name": "Sports Bar"
        },
        {
            "id": "218693881483234",
            "name": "Pub"
        },
        {
            "id": "273819889375819",
            "name": "Restaurant"
        }
      ],
    */
    if (!jsonResult.containsKey(_kCategoryListKey)) {
      // Need category list.
      return false;
    }
    var categoryList = jsonResult[_kCategoryListKey] as List;
    for (final categoryItem in categoryList) {
      var category = categoryItem as Map<String, dynamic>;
      final categoryName = category['name'].toString().toLowerCase();
      if (categoryName.contains('restaurant') ||
          categoryName.contains('coffee') ||
          categoryName.contains('cafe') ||
          categoryName.contains('bakery') ||
          categoryName.contains('diner') ||
          categoryName.contains('hotel') ||
          categoryName.contains('butcher') ||
          categoryName.contains('food') ||
          categoryName.contains('pizza')) {
        return true;
      }
      if (category['name'].toString().contains('Bar')) {
        return true;
      }
      final categoryId = int.parse(category['id'] as String);
      if (fbPlacesWhitelist.contains(categoryId)) {
        return true;
      }
    }
    return false;
  }

  void _sortByDistanceToSource(
      List<FacebookPlaceResult> places, S2LatLng source) {
    places.sort(
      (a, b) {
        final aDist =
            S2LatLng.fromDegrees(a.lat, a.lng).getDistance(source).meters;
        final bDist =
            S2LatLng.fromDegrees(b.lat, b.lng).getDistance(source).meters;
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
    @required this.lat,
    @required this.lng,
    @required this.engagementCount,
    @required this.rawHours,
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
  final List<Map<String, dynamic>> rawHours;
  final List<String> categories;
  final String city;
  final String state;
  final String country;
  final double lat;
  final double lng;
  final int engagementCount;
  final String pageId;
  final String phone;
  final String website;

  Restaurant_Attributes_Address get address => {
        'street': street,
        'city': city,
        'state': state,
        'country': country,
        'source': Restaurant_Attributes_Address_Source.facebook,
        'source_location': {
          'latitude': lat,
          'longitude': lng,
        }
      }.asProto(Restaurant_Attributes_Address());

  static FacebookPlaceResult from(Map<String, dynamic> result) {
    final location = result['location'] ?? {};
    final engagement = result['engagement'] ?? {};
    final hours =
        List<Map<String, dynamic>>.from(result['hours'] as List ?? []);

    final categories = <String>[];
    for (final category in result['category_list'] ?? []) {
      if (category is Map<String, dynamic> && category.containsKey('name')) {
        categories.add(category['name'] as String);
      }
    }
    var link = (result['link'] ?? '') as String;
    var segments =
        Uri.parse(link).pathSegments.where((s) => s.isNotEmpty).toList();
    var pageId = segments.isNotEmpty ? segments.last : '';
    return FacebookPlaceResult(
      id: result['id'] as String,
      name: result['name'] as String,
      street: location['street'] as String,
      city: location['city'] as String,
      state: location['state'] as String,
      country: location['country'] as String,
      lat: location['latitude'] as double,
      lng: location['longitude'] as double,
      engagementCount: engagement['count'] as int ?? 0,
      rawHours: hours,
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
        lat,
        lng,
        engagementCount,
      ].toString();

  List<String> get restaurantCategories => categories
      .map((c) {
        final split = c.toLowerCase().split(' ');
        if (split.length <= 1) {
          return null;
        }
        return split.last == 'restaurant'
            ? split.take(split.length - 1).join(' ')
            : null;
      })
      .withoutNulls
      .toList();

  Restaurant_Hours get hours {
    try {
      final hours = <String, String>{};
      for (final hour in rawHours ?? []) {
        final hourMap = hour as Map<String, dynamic>;
        if (!hourMap.containsKey('key') || !hourMap.containsKey('value')) {
          continue;
        }
        hours[hourMap['key'] as String] = hourMap['value'] as String;
      }
      return getRestaurantHours(hours);
    } catch (e) {
      print('Parsing restaurant hours failed for $id with error $e');
      return Restaurant_Hours()..hasHours = false;
    }
  }
}

Restaurant_HoursInfo getDayHours(Map<String, String> hours, String day) {
  var index = 1;
  final hoursInfo = Restaurant_HoursInfo()..isOpen = false;
  final fbHours = Restaurant_FacebookHours();
  while (true) {
    final openKey = '${day}_${index}_open';
    final closeKey = '${day}_${index}_close';
    if (!hours.containsKey(openKey) || !hours.containsKey(closeKey)) {
      break;
    }
    final open = hours[openKey];
    final close = hours[closeKey];
    hoursInfo.isOpen = true;
    fbHours.hours.add(Restaurant_OpenWindow()
      ..open = open
      ..close = close);
    index += 1;
  }
  if (hoursInfo.isOpen) {
    hoursInfo.fbHours = fbHours;
  }
  return hoursInfo;
}

Restaurant_Hours getRestaurantHours(Map<String, String> hours) {
  final restoHours = Restaurant_Hours();
  if (hours == null || hours.isEmpty) {
    restoHours.hasHours = false;
    return restoHours;
  }
  restoHours
    ..hasHours = true
    ..mon = getDayHours(hours, 'mon')
    ..tue = getDayHours(hours, 'tue')
    ..wed = getDayHours(hours, 'wed')
    ..thu = getDayHours(hours, 'thu')
    ..fri = getDayHours(hours, 'fri')
    ..sat = getDayHours(hours, 'sat')
    ..sun = getDayHours(hours, 'sun');
  return restoHours;
}

bool _isValidFBPlace(FacebookPlaceResult a) {
  return [a.lat, a.lng, a.name].every((v) => v != null);
}

String normalizedName(FacebookPlaceResult a) {
  // remove commas and periods.
  var normalizedName = a.name.replaceAll(RegExp('[,.\']'), '').toLowerCase();
  if (a.city?.isNotEmpty ?? false) {
    normalizedName = normalizedName.replaceAll(a.city.toLowerCase(), '');
  }
  if (a.state?.isNotEmpty ?? false) {
    normalizedName = normalizedName.replaceAll(a.state.toLowerCase(), '');
  }
  return normalizedName
      .replaceAll('restaurant', '')
      .replaceAll(' bar', '')
      .replaceAll(' tavern', '')
      .replaceAll(' cafe', '')
      .replaceAll(' cafÃ©', '')
      .replaceAll(' bakery', '');
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
      .replaceAll(' junction', ' jct');
}
