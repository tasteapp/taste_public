import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'instagram_post.g.dart';

@RegisterType()
mixin InstagramPost on FirestoreProto<$pb.InstagramPost>
    implements SpatialIndexed {
  static final triggers = trigger<InstagramPost>(
    create: (r) => r.updateIndex(),
    update: (r, c) => c.fieldChanged('location') || !r.proto.hasSpatialIndex()
        ? r.updateIndex()
        : null,
  );
  @override
  GeoPoint get indexLocation => proto.location.geoPoint;
  Future updateIndex() =>
      updateSelf({'spatial_index': spatialIndex}.ensureAs(prototype));
}
