import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:taste/screens/discover/instagram/webview_login_page.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/insta_post.dart';
import 'package:taste/taste_backend_client/responses/instagram_token.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;
import 'package:tuple/tuple.dart';

Future<InstagramToken> login(BuildContext context, TasteUser user) async {
  final code = await quickPush<String>(
      TAPage.insta_web_login_page, (context) => InstagramWebviewLoginPage());
  if (code == null) {
    TAEvent.cancelled_instagram_link();
    return null;
  }
  TAEvent.linked_instagram();
  return createOrUpdateInstagramToken(code);
}

Future unlink(BuildContext context, TasteUser user) async {
  final shouldUnlink = await showDialog<bool>(
        context: context,
        builder: (context) => TasteDialog(
          title:
              "Are you sure you want to unlink your Instagram account?\n\nThis will prevent any new Instagram posts from being imported.",
          buttons: [
            TasteDialogButton(
                text: 'Cancel',
                color: Colors.black,
                onPressed: () => Navigator.of(context).pop(false)),
            TasteDialogButton(
                text: 'Unlink',
                color: Colors.red,
                onPressed: () => Navigator.of(context).pop(true)),
          ],
        ),
      ) ??
      false;
  if (!shouldUnlink) {
    return;
  }
  TAEvent.unlinked_instagram();
  await user.reference.updateData({'instagram_info': FieldValue.delete()});
  final token = await getInstagramToken();
  if (token != null) {
    await token.delete();
  }
  Navigator.pop(context);
}

class InstagramImportDialog extends StatelessWidget {
  const InstagramImportDialog({Key key, this.token}) : super(key: key);

  final InstagramToken token;

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(8.0),
        child: TasteDialog(
          scrollable: true,
          title:
              'Your Instagram posts should show up in your profile within a few minutes!',
        ),
      );
}

Future updateInstagramInfo({TasteUser user, InstagramToken token}) async {
  if (!user.proto.instagramInfo.hasDisplayName()) {
    final profileInfo = await getProfileInfo(token.proto.username);
    if (profileInfo == null) {
      return;
    }
    await updateProfile(user, profileInfo);
  }
}

class ProfileInfo {
  String displayName;
  String profilePic;
  bool isPrivate;
  int numFollowers;
  int numFollowing;
}

Future<ProfileInfo> getProfileInfo(String username) async {
  try {
    final url = 'https://www.instagram.com/$username/?__a=1';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body) as Map<String, dynamic>;
    final user = body['graphql']['user'] as Map<String, dynamic>;
    return ProfileInfo()
      ..displayName = user['full_name'] as String
      ..profilePic = user['profile_pic_url'] as String
      ..isPrivate = user['is_private'] as bool
      ..numFollowers = user['edge_followed_by']['count'] as int
      ..numFollowing = user['edge_follow']['count'] as int;
  } catch (e) {
    print('Error reading profile info for $username: $e. Treating as private');
    return null;
  }
}

Future updateProfile(TasteUser user, ProfileInfo profile) async {
  FirePhoto profilePhoto;
  try {
    if (profile.profilePic != null) {
      var response = await http.get(profile.profilePic);
      var documentDirectory = await getApplicationDocumentsDirectory();
      var filePath = '${documentDirectory.path}/instagram_profile_pic.jpg';
      final file = File(filePath)..writeAsBytesSync(response.bodyBytes);
      profilePhoto = await uploadPhoto(file);
    }
  } catch (e) {
    print('Error getting profile pic: $e');
  }
  final update = {
    'instagram_info.profile_pic': profilePhoto.asMap,
    'instagram_info.display_name': profile.displayName,
    'instagram_info.num_followers': profile.numFollowers,
    'instagram_info.num_following': profile.numFollowing,
    'instagram_info.is_private': profile.isPrivate,
  };
  if (!user.proto.vanity.hasFirePhoto()) {
    update['vanity.fire_photo'] = profilePhoto.asMap;
  }
  if (user.name.isEmpty) {
    update['vanity.full_name'] = profile.displayName;
  }
  await user.reference.updateData(update.withoutNulls);
}

Future updateInstaPost(InstaPost post) async {
  int newNumUpdates = post.proto.numUpdateAttempts + 1;
  await post.reference.updateData({'num_update_attempts': newNumUpdates});
  final extraInfo = await getExtraInfo(post);
  if (extraInfo == null) {
    await post.reference.updateData({'tried_extra_info': true});
    return;
  }
  await post.reference.updateData({
    'likes': extraInfo.numLikes,
    'instagram_location': extraInfo.location.asMap,
    'tried_extra_info': true
  }.withoutNulls);
}

class ExtraInfo {
  $pb.InstagramLocation location;
  int numLikes;
}

Future<ExtraInfo> getExtraInfo(InstaPost post) async {
  final extraInfo = ExtraInfo();
  try {
    final postUrl = '${post.proto.link}?__a=1';
    final response = await http.get(Uri.parse(postUrl));
    final body = json.decode(response.body) as Map<String, dynamic>;
    final media = body['graphql']['shortcode_media'] as Map<String, dynamic>;
    if (media.containsKey('edge_media_preview_like')) {
      extraInfo.numLikes = media['edge_media_preview_like']['count'] as int;
    }
    if (!media.containsKey('location')) {
      return null;
    }
    final loc = media['location'];
    if (media['location'] is! Map) {
      return null;
    }
    final location = loc as Map<String, dynamic>;
    if (!location.containsKey('id') || (location['id'] as String).isEmpty) {
      return null;
    }
    final locationId = location['id'] as String;
    final instagramLocation = await getExistingInstagramLocation(locationId);
    extraInfo.location =
        instagramLocation?.proto ?? await createInstagramLocation(locationId);
    return extraInfo;
  } catch (e) {
    print('Error getting additional info: $e');
    return null;
  }
}

Future<$pb.InstagramLocation> createInstagramLocation(String id) async {
  final url = 'https://www.instagram.com/explore/locations/$id/?__a=1';
  final response = await http.get(Uri.parse(url));
  final body = json.decode(response.body) as Map<String, dynamic>;
  final location = body['graphql']['location'] as Map<String, dynamic>;
  final name = location['name'] as String;
  String address;
  List<String> posts = [];
  try {
    address = location['address_json'] as String;
    final topPosts =
        location["edge_location_to_top_posts"]["edges"] as List<dynamic>;
    final topCodes = topPosts.map((e) => e["node"]["shortcode"] as String);
    posts.addAll(topCodes);
    final allPosts =
        location["edge_location_to_media"]["edges"] as List<dynamic>;
    final bestRecentCodes = allPosts
        .map((e) => Tuple2(e["node"]["shortcode"] as String,
            e["node"]["edge_media_preview_like"]["count"] as int))
        .sorted((e) => e.item2)
        .reversed
        .take(60)
        .map((e) => e.item1);
    posts.addAll(bestRecentCodes);
  } catch (e) {
    print("Error reading address or posts: $e");
  }
  final loc = $pb.LatLng()
    ..latitude = location['lat'] as double
    ..longitude = location['lng'] as double;
  final instagramLocation = $pb.InstagramLocation()
    ..id = id
    ..name = name
    ..location = loc;
  if (address != null) {
    instagramLocation.address = address;
  }
  if (posts.isNotEmpty) {
    instagramLocation.postCodes.addAll(posts);
  }
  await backendCreateInstagramLocation(instagramLocation);
  return instagramLocation;
}
