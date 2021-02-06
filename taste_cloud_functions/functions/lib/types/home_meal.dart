import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'home_meal.g.dart';

@RegisterType(type: CollectionType.home_meals)
mixin HomeMeal
    on
        ParentUpdater,
        FirestoreProto<$pb.Review>,
        Likeable,
        Viewable,
        UserOwned,
        AlgoliaBacked,
        SpatialIndexed,
        Review {
  static final triggers = reviewTriggers<HomeMeal>();
}
