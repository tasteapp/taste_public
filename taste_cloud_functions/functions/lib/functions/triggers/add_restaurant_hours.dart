import 'dart:math';

import 'package:taste_cloud_functions/fb_places_manager.dart';
import 'package:taste_cloud_functions/taste_functions.dart';

enum FbResult {
  success,
  failure,
  limitError,
}

Future addRestoHours(BatchedTransaction t) async {
  final restaurants = await CollectionType.restaurants.coll
      .where('attributes.queried_hours', isEqualTo: false)
      .orderBy('popularity_score', descending: true)
      .orderBy('attributes.fb_place_id')
      .select(['attributes'])
      .limit(150)
      .get()
      .then((s) => s.documents.map((e) => Restaurants.make(e, t)).toList());

  print('Processing ${restaurants.length} restaurants');
  var numSuccessful = 0;
  for (var i = 0; i < restaurants.length / 5.0; i++) {
    print('So far: $numSuccessful of ${5 * i} successful');
    final end = min(5 * (i + 1), restaurants.length);
    final locations = restaurants.getRange(5 * i, end);
    final results = await locations.futureMap(updateHours);
    numSuccessful += results.where((r) => r == FbResult.success).length;
    // If we hit a rate limit stop the entire job.
    if (results.any((r) => r == FbResult.limitError)) {
      print('Stopping due to a Facebook rate limit error');
      break;
    }
    await 3.seconds.wait;
  }
  print('Total: $numSuccessful of ${restaurants.length} successful');
}

Future<FbResult> updateHours(Restaurant resto) async {
  final result = await fbPlaces.getPlaceById(resto.fbPlaceId);
  if (result.limitReached) {
    return FbResult.limitError;
  }
  final place = result?.result;
  if (place == null) {
    print('Failed to update resto with id ${resto.fbPlaceId}');
    await resto.updateSelf({'attributes.queried_hours': true});
    return FbResult.failure;
  }
  await resto.updateSelf({
    'attributes.queried_hours': true,
    'attributes.hours': place.hours.asMap
  });
  return FbResult.success;
}

final addRestaurantHours = tasteFunctions.pubsub
    .schedule('every 5 minutes')
    .onRun((message, context) => autoBatch(addRestoHours));

void register() {
  registerFunction(
      'addRestaurantHours', addRestaurantHours, addRestaurantHours);
}
