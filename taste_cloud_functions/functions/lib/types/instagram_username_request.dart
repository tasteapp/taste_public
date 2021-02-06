import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'instagram_username_request.g.dart';

@RegisterType()
mixin InstagramUsernameRequest on FirestoreProto<$pb.InstagramUsernameRequest> {
}
