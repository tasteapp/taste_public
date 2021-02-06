Mailchimp Client for Node runtime.

## Usage

A simple usage example:

```dart
import 'package:mailchimp/mailchimp.dart';

final apiKey = 'apikey';
final audience = 'audience';
final emailsToAdd = ['email1@email.com', 'email2@email.com'];

Future main() async {
  print((await Mailchimp(apiKey)
      .batch(emailsToAdd.map((e) => addMember(audience, e)).toList())));
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/jackdreilly/mailchimp/issues