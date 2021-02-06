import 'package:taste_protos/taste_protos.dart' as $pb;
import 'package:taste_protos/extensions.dart';

List<$pb.FoodType> getFoodTypes(List<$pb.ImageLabel> labels) {
  List<$pb.FoodType> types;

  types = labels
      .where((element) => foodTypesWhitelist.contains(element.label))
      .where((element) => element.confidence > foodTypesCutoffs[element.label])
      .map((e) => foodTypesRemap[e.label] ?? toFoodType(e.label))
      .toSet()
      .toList();
  return types;
}

class FoodTypesLists {
  final List<$pb.FoodType> foodTypes = [];
  final List<int> foodTypesPhotoIndices = [];
}

FoodTypesLists getFoodTypesLists(List<$pb.InstagramImage> images) {
  final lists = FoodTypesLists();
  for (final imgEntry in images.enumerate) {
    final imgIdx = imgEntry.key;
    final img = imgEntry.value;
    final t = getFoodTypes(img.mlLabels);
    final l = t.length;
    lists.foodTypes.addAll(t);
    lists.foodTypesPhotoIndices.addAll(List.filled(l, imgIdx));
  }
  return lists;
}
