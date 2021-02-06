import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste_protos/proto_transforms.dart';
import 'package:taste/taste_backend_client/responses/responses.dart';

import 'extensions.dart';

export 'package:taste_protos/proto_transforms.dart';

class TasteTransformProvider with TransformProvider {
  TasteTransformProvider._();
  @override
  DocumentReference createReference(String path) => path.ref;

  @override
  Timestamp createTimestamp(DateTime dateTime) => Timestamp.fromDate(dateTime);

  @override
  bool isReference(value) => value is DocumentReference;

  @override
  bool isSnapshot(value) => value is SnapshotHolder;

  @override
  bool isTimestamp(value) => value is Timestamp;

  @override
  DocumentReference referenceFromSnapshot(dynamic snapshot) =>
      (snapshot as SnapshotHolder).reference;

  @override
  FieldValue get serverTimestamp => FieldValue.serverTimestamp();

  @override
  DateTime timestampDateTime(value) => (value as Timestamp).toDate();

  static TransformProvider initialize() =>
      registerTransformProvider(TasteTransformProvider._());

  @override
  GeoPoint createGeopoint({double latitude, double longitude}) =>
      GeoPoint(latitude, longitude);

  @override
  bool isGeopoint(value) => value is GeoPoint;
}
