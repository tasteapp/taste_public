import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show Operation;

part 'operation.g.dart';

@RegisterType()
mixin Operation on FirestoreProto<$pb.Operation>, ParentHolder {
  String get text => proto.text;
  int get status => proto.status;

  static Future<DocumentReference> createOperation(
      {String text, int status, @required SnapshotHolder parent}) async {
    return await parent.addToCollection(
        Operations.collection,
        {
          'text': text,
          'status': status,
          'parent': parent.ref,
        }.ensureAs($pb.Operation()).documentData);
  }
}
