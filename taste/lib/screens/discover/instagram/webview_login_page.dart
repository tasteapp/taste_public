import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:taste/screens/discover/instagram/instagram_auth.dart';

const baseUrl = "https://api.instagram.com/oauth/authorize/";
const testAppClientId = "IG_TEST_APP_CLIENT_ID";
const clientId = "IG_CLIENT_ID";
const redirectUrl = "https://trytaste.app/";
const scope = "user_profile,user_media";

class InstagramWebviewLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String url =
        "$baseUrl?client_id=$clientId&redirect_uri=$redirectUrl&scope=$scope&response_type=code";
    InstagramAuth().signInWithInstagram(context);
    return WebviewScaffold(
      url: url,
      clearCache: true,
      clearCookies: true,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text(
          'Login to Instagram',
          style: TextStyle(color: Colors.white),
        ),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
    );
  }
}
