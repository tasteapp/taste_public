import '../utilities.dart';

Future importMailchimp() async => mailchimp.batch((await TasteUsers.get())
    .map((u) => u.updateMailchimpUserRequest)
    .withoutNulls);
