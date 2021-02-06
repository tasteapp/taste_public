import 'package:taste_cloud_functions/taste_functions.dart';

mixin TransactionHolder {
  BatchedTransaction get transaction;
  Future<DocumentSnapshot> getRef(DocumentReference ref) =>
      transaction.get(ref);
  Future<DocumentSnapshot> getStringRef(String ref) =>
      getRef(firestore.document(ref));
  String get eventId => transaction.eventId;
}
