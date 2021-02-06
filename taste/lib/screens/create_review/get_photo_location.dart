import 'dart:io';

import 'package:exif/exif.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/utils/logging.dart';

Future<LatLng> getLocationData(File file) async {
  try {
    Map<String, IfdTag> exifData = await readExifFromFile(file);
    IfdTag lat = exifData["GPS GPSLatitude"];
    IfdTag lng = exifData["GPS GPSLongitude"];
    IfdTag latRef = exifData["GPS GPSLatitudeRef"];
    IfdTag lngRef = exifData["GPS GPSLongitudeRef"];
    if (lat != null && lng != null && latRef != null && lngRef != null) {
      return _getLatLng(List.from(lat.values), List.from(lng.values),
          List.from(latRef.values), List.from(lngRef.values));
    }
    return null;
  } catch (e) {
    logger.e("Error reading location data: $e");
    return null;
  }
}

LatLng _getLatLng(List<Ratio> latitude, List<Ratio> longitude, List<int> latRef,
    List<int> lngRef) {
  if (latitude.length != 3 ||
      longitude.length != 3 ||
      latRef.length != 1 ||
      lngRef.length != 1) {
    return null;
  }

  bool isNorth = String.fromCharCode(latRef[0]) == "N";
  bool isEast = String.fromCharCode(lngRef[0]) == "E";

  double lat = 0.0;
  double lng = 0.0;
  int base = 1;
  for (int i = 0; i < 3; i++) {
    lat += ratioToDouble(latitude[i]) / base;
    lng += ratioToDouble(longitude[i]) / base;
    base *= 60;
  }

  if (lat == 0 || lng == 0) {
    return null;
  }

  lat = isNorth ? lat : -1 * lat;
  lng = isEast ? lng : -1 * lng;

  return LatLng(lat, lng);
}

double ratioToDouble(Ratio ratio) {
  return ratio.numerator / ratio.denominator;
}
