import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'responses.dart';

class Photo extends SnapshotHolder<$pb.Photo> with UserOwned {
  Photo(DocumentSnapshot snapshot) : super(snapshot);

  $pb.FirePhoto get firePhoto => proto.firePhoto(reference.proto);
}
