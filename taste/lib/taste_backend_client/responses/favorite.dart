import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/responses/responses.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

class Favorite extends SnapshotHolder<$pb.Favorite>
    with UserOwned, ParentHolder {
  Favorite(DocumentSnapshot snapshot) : super(snapshot);
  DocumentReference get restaurantRef => parent;
  @override
  String get parentField => 'restaurant';
}
