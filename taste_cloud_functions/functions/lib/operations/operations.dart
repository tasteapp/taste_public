import 'package:taste_cloud_functions/taste_functions.dart';

CollectionReference operations(DocumentReference document) =>
    document.collection(CollectionType.operations.path);

void addOperation(DocumentReference document, Transaction transaction,
    String eventId, Map<String, dynamic> payload) {
  transaction.create(operations(document).document(eventId),
      DocumentData.fromMap(payload).withExtras);
}
