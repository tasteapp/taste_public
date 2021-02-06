import 'package:mailchimp/mailchimp.dart';

final apiKey = 'api-key';
final audience = 'audience';
final emails = ['a@a.com', 'b@b.com'];
final tagsToAdd = {'jack', 'jill'};
final tagsToRemove = {'tom', 'jerry'};
Future main() async {
  print(
    await Mailchimp.forKey(apiKey).batch(
      emails.map(
        (e) => updateTags(
          audience,
          e,
          add: tagsToAdd,
          remove: tagsToRemove,
        ),
      ),
    ),
  );
}
