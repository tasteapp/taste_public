import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'city.g.dart';

@RegisterType(type: CollectionType.cities)
mixin City on FirestoreProto<$pb.City>, AlgoliaBacked {
  @override
  List<AlgoliaRecordID> get algoliaRecordIDs =>
      [AlgoliaRecordID(ref, $pb.AlgoliaRecordType.city)];
  @override
  GeoPoint get algoliaGeoPoint => proto.location.geoPoint;

  Map<String, dynamic> get algoliaPayload => {'name': proto.city};
  Future get updateAlgolia => updateAlgoliaRecord(payload: algoliaPayload);

  static final triggers = trigger<City>(
      create: (r) => r.updateAlgolia,
      update: (r, _) => r.updateAlgolia,
      delete: (r) => r.deleteAlgoliaCache());
}
