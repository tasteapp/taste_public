import 'dart:math';

import 'package:taste_cloud_functions/fb_places_manager.dart';
import 'package:taste_cloud_functions/instagram_util.dart';
import 'package:taste_cloud_functions/taste_functions.dart';

enum FbResult {
  success,
  failure,
  limitError,
}

Future searchInstagramLocations(BatchedTransaction t) async {
  final instagramLocations = await CollectionType.instagram_locations.coll
      .where('queried_location', isEqualTo: false)
      .orderBy('num_requests', descending: true)
      .orderBy('_extras.updated_at')
      .limit(250)
      .get()
      .then((s) =>
          s.documents.map((e) => InstagramLocations.make(e, t)).toList());

  print('Processing ${instagramLocations.length} locations');
  var numSuccessful = 0;
  for (var i = 0; i < instagramLocations.length / 5.0; i++) {
    print('So far: $numSuccessful of ${5 * i} successful');
    final end = min(5 * (i + 1), instagramLocations.length);
    final locations = instagramLocations.getRange(5 * i, end);
    final results = await locations.futureMap(updateFbLocation);
    numSuccessful += results.where((r) => r == FbResult.success).length;
    // If we hit a rate limit stop the entire job.
    if (results.any((r) => r == FbResult.limitError)) {
      print('Stopping due to a Facebook rate limit error');
      break;
    }
    await 3.seconds.wait;
  }
  print('Total: $numSuccessful of ${instagramLocations.length} successful');
}

Future<FbResult> updateFbLocation(InstagramLocation location) async {
  if (!location.proto.hasName() ||
      !location.proto.hasId() ||
      !location.proto.hasLocation()) {
    await location.updateSelf({'queried_location': true});
    return FbResult.failure;
  }

  final result = await fbPlaces.nearbyPlaces(
      lat: location.proto.location.latitude,
      lng: location.proto.location.longitude,
      term: location.proto.name,
      maxDistanceMeters: 300.0);
  if (result.limitReached) {
    return FbResult.limitError;
  }
  final place = result?.result?.firstOrNull;
  if (place == null) {
    await location.updateSelf({'queried_location': true});
    return FbResult.failure;
  }
  final fbLocation = createFacebookLocation(place);
  await location
      .updateSelf({'fb_location': fbLocation.asMap, 'queried_location': true});
  return FbResult.success;
}

final fbSearchInstagramLocations = tasteFunctions.pubsub
    .schedule('every 5 minutes')
    .onRun((message, context) => autoBatch(searchInstagramLocations));

void register() {
  registerFunction('fbSearchInstagramLocations', fbSearchInstagramLocations,
      fbSearchInstagramLocations);
}
