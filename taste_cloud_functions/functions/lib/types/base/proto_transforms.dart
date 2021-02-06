import 'package:taste_cloud_functions/taste_functions.dart'
    hide LatLng, ProtoDData;
import 'package:taste_protos/taste_protos.dart'
    show
        LatLng,
        GeneratedMessage,
        TransformProvider,
        Handler,
        registerTransformProvider,
        ExtensionMap,
        ExtensionProto;

class CloudTransformProvider with TransformProvider {
  @override
  DocumentReference createReference(String path) => path.ref;

  @override
  Timestamp createTimestamp(DateTime dateTime) =>
      Timestamp.fromDateTime(dateTime);

  @override
  bool isReference(value) => value is DocumentReference;

  @override
  bool isSnapshot(value) => value is SnapshotHolder;

  @override
  bool isTimestamp(value) => value is Timestamp;

  @override
  DocumentReference referenceFromSnapshot(dynamic snapshot) =>
      (snapshot as SnapshotHolder).ref;

  @override
  Timestamp get serverTimestamp => tasteServerTimestamp();

  @override
  DateTime timestampDateTime(value) => (value as Timestamp).toDateTime();

  CloudTransformProvider._();
  static void initialize() =>
      registerTransformProvider(CloudTransformProvider._());

  @override
  GeoPoint createGeopoint({double latitude, double longitude}) =>
      GeoPoint(latitude, longitude);

  @override
  bool isGeopoint(value) => value is GeoPoint;

  @override
  List<Handler> get additionalHandlers => [_tasteResponseHandler];
}

final _tasteResponseHandler = Handler(
    (m) => m is TasteResponse, (m, next) => next((m as TasteResponse).proto));

extension LatLngGeoPoint on LatLng {
  GeoPoint get geoPoint => GeoPoint(latitude, longitude);
}

extension ProtoDData on DocumentData {
  T asProto<T extends GeneratedMessage>(T message) => toMap().asProto(message);
}

extension DSE on DocumentSnapshot {
  T asProto<T extends GeneratedMessage>(T message) => data.asProto(message);
}

extension DSIE on DocumentSnapshot {
  T asProto<T extends GeneratedMessage>(T message) => data.asProto(message);
}

extension GenMsgDocData on GeneratedMessage {
  DocumentData get documentData => asMap.documentData;
}
