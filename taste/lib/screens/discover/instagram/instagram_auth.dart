import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class InstagramAuth extends ChangeNotifier {
  factory InstagramAuth() => _singleton;
  InstagramAuth._();

  static final InstagramAuth _singleton = InstagramAuth._();

  Future<void> signInWithInstagram(BuildContext context) async {
    final flutterWebviewPlugin = FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((url) async {
      final uri = Uri.parse(url);
      if (url.startsWith('https://trytaste.app/') &&
          uri.queryParameters.containsKey('code')) {
        var _code = uri.queryParameters['code'].replaceAll('#', '');
        await flutterWebviewPlugin.cleanCookies();
        await flutterWebviewPlugin.close();
        Navigator.pop(context, _code);
      }
    });
  }
}
