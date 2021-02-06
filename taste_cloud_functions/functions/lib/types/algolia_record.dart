import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'algolia_record.g.dart';

@RegisterType()
mixin AlgoliaRecord on FirestoreProto<$pb.AlgoliaRecord> {
  @visibleForTesting
  Map<String, dynamic> get algoliaJSON => {
        '_geoloc': proto.location.geoPoint.algoliaLoc,
        '_tags': proto.tags,
        'record_type': proto.recordType.name,
        'reference': proto.reference.path,
        'objectID': proto.objectId,
      }.ensureAs($pb.AlgoliaJSON())
        ..addAll(proto.payload.toProto3Json() as Map<String, dynamic>);

  AlgoliaIndexReference get index => proto.index.ref;

  static final triggers = trigger<AlgoliaRecord>(
      requiredChangedFields: {'index', 'location', 'payload'},
      create: (r) {
        print('Creating Algolia Record for ${r.proto.objectId}');
        return;
        // return algoliaClient.update(r.index, r.algoliaJSON);
      },
      update: (r, c) {
        print('Updating Algolia Record for ${r.proto.objectId}');
        return;
        // return algoliaClient.update(r.index, r.algoliaJSON);
      },
      delete: (r) {
        print('Deleting Algolia Record for ${r.proto.objectId}');
        return algoliaClient.delete(r.index, r.proto.objectId);
      });
}
