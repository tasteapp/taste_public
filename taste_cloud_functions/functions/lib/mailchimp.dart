import 'package:mailchimp/mailchimp.dart';

import 'taste_functions.dart';

final mailchimp = buildType.isProd
    ? Mailchimp.forKey('MAILCHIMP_API_KEY')
    : Mailchimp.fake((c) => _fakeColl.add({
          'date': tasteServerTimestamp(),
          'path': c.path,
          'args': c.args,
          'method': enumToString(c.method),
        }.documentData));
const mailchimpAudience = 'MAILCHIMP_AUDIENCE_ID';
final _fakeColl = 'mc'.coll;

Future get clearMailchimpTestLog => _fakeColl
    .get()
    .then((x) => x.documents.futureMap((x) => x.reference.delete()));
Future<List<Map<String, dynamic>>> get mailchimpTestLog async =>
    (await _fakeColl.get()).documents.listMap((x) => x.data.toMap());
