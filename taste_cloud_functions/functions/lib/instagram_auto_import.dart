import 'dart:async';
import 'dart:convert';

import 'package:fixnum/fixnum.dart';
import 'package:node_http/node_http.dart' as http;
import 'package:quiver/iterables.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

const String kBaseUrl = 'https://graph.instagram.com';
const String kUserFields = 'fields=username,id';
const String kMediaFields =
    'fields=id,username,caption,media_type,media_url,timestamp,permalink';
const String kCarouselImageFields = 'fields=media_type,media_url';

class InstagramData {
  InstagramData() : posts = [];
  final List<$pb.InstaPost> posts;
  ProfileInfo profile;
}

class ProfileInfo {
  String username;
  String id;
}

String recentMediaUrl(String accessToken) =>
    '$kBaseUrl/me/media?$kMediaFields&access_token=$accessToken';

String postUrl(String postId, String accessToken) =>
    '$kBaseUrl/$postId/children?$kCarouselImageFields&access_token=$accessToken';

String profileUrl(String accessToken) =>
    '$kBaseUrl/me?$kUserFields&access_token=$accessToken';

Future<InstagramData> autoImport(
    TasteUser user, String accessToken, DateTime latestPostTime) async {
  if (buildType.isTest) {
    return InstagramData();
  }
  final data = InstagramData();
  try {
    data.profile = await getBaseProfile(accessToken);
    var url = recentMediaUrl(accessToken);
    while (url.isNotEmpty) {
      final response = await http.get(Uri.parse(url));
      final body = json.decode(response.body) as Map<String, dynamic>;
      await (body['data'] as List).futureMap(
        (postData) async {
          try {
            final post = await createInstagramPost(user,
                postData as Map<String, dynamic>, data.profile.id, accessToken);
            if (post == null) {
              return;
            }
            data.posts.add(post);
          } catch (e) {
            print('Error reading Instagram post: $e');
          }
        },
      );
      if (data.posts.isEmpty) {
        break;
      }
      final oldestTime = min(data.posts.map((t) => t.createdTime.toDateTime()));
      if (latestPostTime != null &&
          oldestTime.millisecondsSinceEpoch <=
              latestPostTime.millisecondsSinceEpoch) {
        break;
      }
      url = ((body['paging'] ?? {})['next'] ?? '') as String;
    }
  } catch (e) {
    print('Error importing from Instagram: $e');
    return null;
  }
  return data;
}

Future<ProfileInfo> getBaseProfile(String accessToken) async {
  final profileResponse = await http.get(Uri.parse(profileUrl(accessToken)));
  final profileData = json.decode(profileResponse.body) as Map<String, dynamic>;
  return ProfileInfo()
    ..username = profileData['username'] as String
    ..id = profileData['id'] as String;
}

Future<$pb.InstaPost> createInstagramPost(TasteUser user,
    Map<String, dynamic> postData, String userId, String accessToken) async {
  final postId = postData['id'] as String;
  final username = postData['username'] as String;
  final seconds =
      (DateTime.parse(postData['timestamp'] as String).millisecondsSinceEpoch /
              1000)
          .round();
  final timestamp = $pb.Timestamp()..seconds = Int64(seconds);
  final caption = postData['caption'] as String ?? '';
  final link = postData['permalink'] as String;
  final mediaType = postData['media_type'] as String;
  if (mediaType == 'VIDEO') {
    return null;
  }
  var images = <$pb.InstagramImage>[];
  if (mediaType == 'CAROUSEL_ALBUM') {
    images = await createInstagramImages(postId, accessToken);
  } else {
    images = [createImage(postData['media_url'] as String)];
  }
  if (images.isEmpty) {
    return null;
  }
  return $pb.InstaPost()
    ..user = user.ref.proto
    ..postId = postId
    ..username = username
    ..images.addAll(images)
    ..createdTime = timestamp
    ..userId = userId
    ..link = link
    ..caption = caption
    ..numFollowers = user.proto.instagramInfo.numFollowers;
}

Future<List<$pb.InstagramImage>> createInstagramImages(
    String postId, String accessToken) async {
  var url = postUrl(postId, accessToken);
  final response = await http.get(Uri.parse(url));
  final body = json.decode(response.body) as Map<String, dynamic>;
  return (body['data'] as List)
      .map(
        (postData) => postData['media_type'] == 'IMAGE'
            ? createImage(postData['media_url'] as String)
            : null,
      )
      .withoutNulls
      .toList();
}

$pb.InstagramImage createImage(String imageUrl) {
  return $pb.InstagramImage()..standardRes = ($pb.ImageInfo()..url = imageUrl);
}
