import 'package:taste_cloud_functions/taste_functions.dart';

const fcmField = 'fcm_tokens';

Future removeTokens(
    Transaction transaction, TasteUser user, Iterable<String> tokens) async {
  if (tokens?.isEmpty ?? true) {
    return;
  }
  await updateUserPrivateDocument(transaction, user.ref,
      {fcmField: Firestore.fieldValues.arrayRemove(tokens.toList())});
}

Future<List<String>> getTokens(Transaction transaction, TasteUser user) async {
  return List.from((await transaction.get(userPrivateDocument(user.ref)))
          .data
          .getList(fcmField) ??
      []);
}
