import 'dart:math';

import 'package:taste_cloud_functions/instagram_util.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart';

Future<Map<String, dynamic>> getFoodStatus(Map<String, dynamic> data) async {
  final request = data.asProto(GetIsFoodStatusRequest());
  if (request.urls.isEmpty) {
    throw CloudFnException('Empty URL');
  }
  final foodStatus = <bool>[];
  for (var i = 0; i < request.urls.length / 5.0; i++) {
    final end = min(5 * (i + 1), request.urls.length);
    final urls = request.urls.getRange(5 * i, end);
    foodStatus.addAll(await urls.futureMap((u) async {
      if (u.isEmpty) {
        return false;
      }
      print('Starting: $u');
      final imageBytes = await tasteStorage.urlBytes(u);
      print('Got bytes: $u');
      final mlLabels = await getImageLabels(imageBytes);
      print('Got image labels: $u');
      return isFoodOrDrink(mlLabels);
    }));
  }
  return (GetIsFoodStatusResponse()
        ..fractionFood = foodStatus.where((s) => s).length / foodStatus.length)
      .asMap;
}

final getIsFoodStatus = functions.https
    .onCall((data, context) => getFoodStatus(data as Map<String, dynamic>));

void register() {
  registerFunction('getIsFoodStatus', getIsFoodStatus, getIsFoodStatus);
}
