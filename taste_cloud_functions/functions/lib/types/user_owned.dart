import 'package:taste_cloud_functions/taste_functions.dart';

mixin UserOwned implements SnapshotHolder {
  Future<TasteUser> get user async =>
      TasteUsers.make(await getRef(userReference), transaction);
  DocumentReference get userReference {
    final reference = data.getReference('user');
    if (reference == null) {
      throw Exception('Document does not have user: $path ${data.toMap()}');
    }
    return reference;
  }
}
