import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:taste/screens/create_review/take_photo.dart';

LatLng make([double lat, double lng, String latRef, String lngRef]) =>
    Metadata.fromMap({
      'GPSLongitude': lng,
      'GPSLatitude': lat,
      'GPSLongitudeRef': lngRef,
      'GPSLatitudeRef': latRef,
    }).latLng;

void main() {
  test("metadata", () {
    expect(make(), isNull);
    expect(make(0), isNull);
    expect(make(0, 0), isNull);
    expect(make(0, 1), const LatLng(0, 1));
    expect(make(1, 0), const LatLng(1, 0));
    expect(make(1, 2), const LatLng(1, 2));
    expect(make(-1, 2), const LatLng(-1, 2));
    expect(make(-1, -2), const LatLng(-1, -2));
    expect(make(1, -2), const LatLng(1, -2));
    expect(make(1, 2, 'bogus', 'bogus'), const LatLng(1, 2));
    expect(make(1, -2, 'bogus', 'bogus'), const LatLng(1, -2));
    expect(make(-1, 2, 'bogus', 'bogus'), const LatLng(-1, 2));
    expect(make(1, 2, 'North', 'East'), const LatLng(1, 2));
    expect(make(1, 2, 'north', 'east'), const LatLng(1, 2));
    expect(make(1, 2, 'n', 'e'), const LatLng(1, 2));
    expect(make(1, 2, 's', 'e'), const LatLng(-1, 2));
    expect(make(1, 2, 's', 'w'), const LatLng(-1, -2));
    expect(make(1, 2, 's', 'e'), const LatLng(-1, 2));
    expect(make(-1, -2, 'n', 'e'), const LatLng(1, 2));
    expect(make(-1, -2, null, 'e'), const LatLng(-1, 2));
    expect(make(-1, -2, 's', 'w'), const LatLng(-1, -2));
  });
}
