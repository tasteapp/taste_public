import 'package:taste_cloud_functions/taste_functions.dart';

void sendMail(
    {String eventId = '',
    Transaction transaction,
    Iterable<String> emails,
    String subject,
    String text}) async {
  final document = CollectionType.mail.coll.document(eventId);
  final data = DocumentData.fromMap({
    'to': emails?.toList() ?? [],
    'message': {
      'subject': subject ?? 'No Subject',
      'text': text ?? 'No body',
    }
  });
  if (transaction != null) {
    transaction.create(document, data);
  } else {
    await document.setData(data);
  }
}
