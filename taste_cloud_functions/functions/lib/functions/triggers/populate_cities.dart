import 'dart:math';

import 'package:taste_cloud_functions/fb_places_manager.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

class CityInfo {
  const CityInfo(this.city, this.state, this.country, this.location, this.score,
      {this.reference});
  final String city;
  final String state;
  final String country;
  final $pb.LatLng location;
  final double score;
  final DocumentReference reference;

  static CityInfo fromResto($pb.Restaurant resto) {
    if (resto.attributes.address.city.isEmpty ||
        !resto.attributes.hasLocation()) {
      return null;
    }
    return CityInfo(
        resto.attributes.address.city,
        formatState(resto.attributes.address.state),
        resto.attributes.address.country,
        resto.attributes.location,
        resto.popularityScore);
  }

  static CityInfo fromCity($pb.City city, DocumentReference ref) {
    return CityInfo(city.city, formatState(city.state), city.country,
        city.location, city.popularityScore,
        reference: ref);
  }

  static String formatState(String state) {
    if (state.isEmpty || state.length == 2) {
      return state;
    }
    if (stateAbbreviations.containsKey(state)) {
      return stateAbbreviations[state];
    }
    return state;
  }

  String get hashString => '$city|$state|$country';
}

bool cityEquals($pb.City cityA, $pb.City cityB) {
  return cityA.city == cityB.city &&
      cityA.state == cityB.state &&
      cityA.country == cityB.country;
}

CityInfo mergeCityInfo(List<CityInfo> cities) {
  var score = 0.0;
  var sumLat = 0.0;
  var sumLng = 0.0;
  var numPoints = 0;
  for (final city in cities) {
    score += max(1.0, city.score);
    if (city.location != null) {
      sumLat += city.location.latitude;
      sumLng += city.location.longitude;
      numPoints += 1;
    }
  }
  final location = $pb.LatLng()
    ..latitude = sumLat / numPoints
    ..longitude = sumLng / numPoints;
  return CityInfo(cities.first.city, cities.first.state, cities.first.country,
      location, score);
}

Future updateCity(CityInfo oldCity, CityInfo updatedCity,
    BatchedTransaction transaction) async {
  return transaction.update(
      oldCity.reference,
      UpdateData.fromMap({
        'location': {
          'latitude': updatedCity.location.latitude,
          'longitude': updatedCity.location.longitude
        },
        'popularity_score': updatedCity.score,
      }));
}

Future createCity(DocumentReference ref, CityInfo city,
    BatchedTransaction transaction) async {
  final data = DocumentData.fromMap({
    'city': city.city,
    'state': city.state,
    'country': city.country,
    'location': {
      'latitude': city.location.latitude,
      'longitude': city.location.longitude
    },
    'popularity_score': city.score,
  });
  return transaction.create(ref, data);
}

Future batchPopulateAllCities(BatchedTransaction transaction) async {
  // Populates a collection of cities that we have in the Taste database.
  final restos = (await transaction.getQuery(CollectionType.restaurants.coll
          .select(['attributes', 'popularity_score'])))
      .documents
      .map((e) => e.data.asProto($pb.Restaurant()));
  final cities = <String, List<CityInfo>>{};
  restos.forEach((resto) {
    final city = CityInfo.fromResto(resto);
    if (city == null) {
      return;
    }
    if (cities.containsKey(city.hashString)) {
      cities[city.hashString].add(city);
    } else {
      cities[city.hashString] = [city];
    }
  });
  final databaseCities = (await transaction
          .getQuery(CollectionType.cities.coll))
      .documents
      .map((e) => CityInfo.fromCity(e.data.asProto($pb.City()), e.reference));
  final existingCities = <String, CityInfo>{};
  databaseCities.forEach((c) => existingCities[c.hashString] = c);
  for (final city in cities.keys) {
    final cityInfo = mergeCityInfo(cities[city]);
    if (existingCities.containsKey(city)) {
      await updateCity(existingCities[city], cityInfo, transaction);
    } else {
      final newCity = CollectionType.cities.coll.document();
      await createCity(newCity, cityInfo, transaction);
    }
  }
}

void register() {
  final batchPopulateCities = tasteFunctions.pubsub
      .schedule('every 24 hours')
      .onRun((message, context) => autoBatch(batchPopulateAllCities));
  registerFunction(
      'batchPopulateCities', batchPopulateCities, batchPopulateCities);
}
