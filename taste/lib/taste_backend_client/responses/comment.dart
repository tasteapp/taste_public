import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'parent_user_index.dart';
import 'responses.dart';

class Comment extends SnapshotHolder<$pb.Comment> with UserOwned, ParentHolder {
  Comment(DocumentSnapshot snapshot)
      : _likeable = likeable(snapshot),
        super(snapshot);

  static $pb.Comment get newProto => $pb.Comment();
  final ParentUserIndex _likeable;

  Future<Review> get review => parent.fetch();

  String get text => proto.text;

  @override
  Future delete() async {
    if (isNotMine) {
      return false;
    }
    return super.delete();
  }

  Stream<bool> get isLiked => _likeable.exists;
  Future<bool> like(bool enable) => _likeable.toggle(enable);
  Stream<List<TasteUser>> get likes =>
      _likeable.all.asyncMap((l) => l.futureMap((t) => Like(t).user));
  Stream<int> get nLikes => _likeable.all.map((l) => l.length);
}
