import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'responses.dart';

class RecipeRequest extends SnapshotHolder<$pb.RecipeRequest>
    with UserOwned, ParentHolder {
  RecipeRequest._(DocumentSnapshot snapshot) : super(snapshot);
  static RecipeRequest make(DocumentSnapshot snapshot) =>
      RecipeRequest._(snapshot);
}
