import 'package:node_http/node_http.dart';
import 'package:taste_cloud_functions/taste_functions.dart';

Future<String> fbCoverPhoto(String id) async => buildType.isTest
    ? 'http://fake-fb-photo'
    : jsonDecode((await get(_pictureUrl(
            (jsonDecode((await get(_linkUrl(id))).body)['link'] as String)
                .split('/')
                .last)))
        .body)['data']['url'] as String;

String _linkUrl(String id) => '$_root$id$_accessToken&fields=link';
String _pictureUrl(String id) =>
    '$_root$id/picture$_accessToken&type=large&redirect=0';
const _accessToken = '?access_token=FB_ACCESS_TOKEN';
const _root = 'https://graph.facebook.com/v5.0/';
