import 'package:taste_cloud_functions/taste_functions.dart';

DocumentReference userPrivateDocument(DocumentReference user) {
  return user
      .append(CollectionType.private_documents)
      .document(CollectionType.private_documents.path);
}

Future updateUserPrivateDocument(Transaction transaction,
    DocumentReference user, Map<String, dynamic> data) async {
  await transaction.set(userPrivateDocument(user), data.documentData,
      merge: true);
}
