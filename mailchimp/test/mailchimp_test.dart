import 'package:mailchimp/mailchimp.dart';
import 'package:test/test.dart';

void main() {
  test(
      'smoke',
      () => expect(
          Mailchimp.forKey('a0000000ff0094b500000e6a0bd2ea0-us10'), isNotNull));
}
