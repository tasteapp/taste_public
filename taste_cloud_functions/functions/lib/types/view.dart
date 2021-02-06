import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show View;

part 'view.g.dart';

@RegisterType()
mixin View on FirestoreProto<$pb.View>, UserOwned, ParentHolder {}
