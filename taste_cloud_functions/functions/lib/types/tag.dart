import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show Tag;

part 'tag.g.dart';

@RegisterType()
mixin Tag on FirestoreProto<$pb.Tag> {
  double get score => proto.trendingScore;
  String get tag => proto.tag;
}
