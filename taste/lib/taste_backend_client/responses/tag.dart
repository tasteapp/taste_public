import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'responses.dart';

class Tag extends SnapshotHolder<$pb.Tag> {
  Tag(DocumentSnapshot snapshot) : super(snapshot);

  String get tag => proto.tag;
  double get score => proto.trendingScore;
  bool get isEmoji => tag.toUpperCase() == tag.toLowerCase();
  String get displayName =>
      "${isEmoji ? '' : '#'}${tag[tag.length - 1] == ',' ? tag.substring(0, tag.length - 1) : tag}";
}
