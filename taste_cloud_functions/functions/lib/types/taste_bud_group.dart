import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show TasteBudGroup;

part 'taste_bud_group.g.dart';

@RegisterType()
mixin TasteBudGroup on FirestoreProto<$pb.TasteBudGroup>, UserOwned {}
