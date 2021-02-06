import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import '../../utils/extensions.dart';
import 'responses.dart';

class Bookmark extends SnapshotHolder<$pb.Bookmark>
    with ParentHolder, UserOwned {
  Bookmark(DocumentSnapshot snapshot) : super(snapshot);

  Stream<Review> get review => parent.stream();

  Stream<DiscoverItem> get discoverItem => reviewDiscoverItem(parent);
}
