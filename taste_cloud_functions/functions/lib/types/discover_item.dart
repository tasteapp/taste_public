import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'discover_item.g.dart';

@RegisterType()
mixin DiscoverItem on FirestoreProto<$pb.DiscoverItem>, UserOwned {
  DocumentReference get post => proto.reference.ref;
  DateTime get dailyTasty => proto.awards.dailyTasty.toDateTime();

  @override
  DocumentReference get userReference => proto.user.reference.ref;

  List<$pb.Point> get detectionCenters =>
      proto.firePhotos.listMap((p) => p.center);
}
