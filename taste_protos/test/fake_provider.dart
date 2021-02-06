import 'package:taste_protos/proto_transforms.dart';
import 'package:taste_protos/taste_protos.dart';

class FakeTimestamp {
  FakeTimestamp(this.d);
  final DateTime d;
}

class TestGeoPoint {
  final double latitude;
  final double longitude;

  TestGeoPoint(this.latitude, this.longitude);
}

class FakeProvider with TransformProvider {
  @override
  dynamic createReference(String path) {
    return {'path': path};
  }

  @override
  dynamic createTimestamp(DateTime dateTime) => FakeTimestamp(dateTime);

  @override
  bool isReference(value) {
    return false;
  }

  @override
  bool isSnapshot(value) {
    return false;
  }

  @override
  bool isTimestamp(value) => value is FakeTimestamp;

  @override
  dynamic referenceFromSnapshot(snapshot) {
    return null;
  }

  @override
  dynamic get serverTimestamp => null;

  @override
  DateTime timestampDateTime(value) => (value as FakeTimestamp).d;

  @override
  TestGeoPoint createGeopoint({double latitude, double longitude}) {
    return TestGeoPoint(latitude, longitude);
  }

  @override
  bool isGeopoint(value) => value is TestGeoPoint;
}

void testSetup() => registerTransformProvider(FakeProvider());
