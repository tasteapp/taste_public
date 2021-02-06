import 'dart:convert';

import 'package:node_http/node_http.dart';

import 'build_type.dart';
import 'extensions.dart';

class SlackChannelHooks {
  static const prod = 'SLACK_PROP_WEBHOOK';
  static const dev = 'SLACK_DEV_WEBHOOK';
  static const newUser = 'SLACK_NEW_USER_WEBHOOK';
  static const scraperOutputs = 'SLACK_SCRAPER_WEBHOOK';
}

Future sendSlack(String text, {String hook}) async {
  Future send(String url) => post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );
  if (hook != null) {
    return send(hook);
  }
  return {
    BuildType.prod: () => send(SlackChannelHooks.prod),
    BuildType.dev: () => send(SlackChannelHooks.dev),
    BuildType.test: () =>
        _testColl.document().setData({'text': text}.documentData),
  }[buildType]();
}

final _testColl = 'fake_slack'.coll;

Future<List<String>> testSlackMessages() async => (await _testColl.get())
    .documents
    .map((d) => d.data.getString('text'))
    .toList();
