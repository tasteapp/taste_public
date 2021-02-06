import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:url_launcher/url_launcher.dart';

const _base = 'https://go.crisp.chat';

class TalkToUsPage extends StatefulWidget {
  const TalkToUsPage({Key key, @required this.user}) : super(key: key);
  final TasteUser user;

  String get _url =>
      '$_base/chat/embed/?website_id=CRISP_WEBSITE_ID&locale=en-us';
  String get _pushes => {'nickname': user.name, 'email': user.email}
      .entries
      .where((e) => e.value?.isNotEmpty ?? false)
      .map((e) => jsonEncode([
            'set',
            'user:${e.key}',
            [e.value]
          ]))
      .map((s) => '\$crisp.push($s);')
      .join('\n');

  String get _javascript => '''
var a = setInterval(() => {
    if (typeof \$crisp !== 'undefined') {
        clearInterval(a);
        $_pushes
    }
}, 500);
''';

  @override
  _TalkToUsPageState createState() => _TalkToUsPageState();
}

class _TalkToUsPageState extends State<TalkToUsPage>
    with
        //ignore: prefer_mixin
        WidgetsBindingObserver {
  final plugin = FlutterWebviewPlugin();
  @override
  void initState() {
    super.initState();
    plugin.onStateChanged.listen((state) async {
      if (state.type == WebViewState.finishLoad) {
        await plugin.evalJavascript(widget._javascript);
      }

      if (state.type == WebViewState.shouldStart) {
        if (state.url.startsWith(_base)) {
          return;
        }
        if ({'mailto', 'tel', 'http', 'https'}.any(state.url.startsWith)) {
          await plugin.stopLoading();
          if (await canLaunch(state.url)) {
            await launch(state.url);
            return;
          }
        }
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Handle reload maybe?
    }
  }

  @override
  void dispose() {
    plugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WebviewScaffold(
      appBar: AppBar(title: const Text("Talk With Taste!")), url: widget._url);
}
