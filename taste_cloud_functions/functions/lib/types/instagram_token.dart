import 'package:node_http/node_http.dart' as http;
import 'package:taste_cloud_functions/instagram_auto_import.dart';
import 'package:taste_cloud_functions/instagram_util.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'instagram_token.g.dart';

// Test App Client Id
// const kInstagramClientId = '263671474759798';
// const kInstagramClientSecret = '25e2c0711c1bd3af463f6b18540f0f4b';

// Prod Client Id
const kInstagramClientId = '1407366042777469';
const kInstagramClientSecret = 'd6cdedda49b29b6896bd2eb277f702d6';

@RegisterType()
mixin InstagramToken on FirestoreProto<$pb.InstagramToken>, UserOwned {
  static final triggers = trigger<InstagramToken>(
    create: buildType.isTest ? null : (r) => [r.generateAccessToken()],
    update: (r, c) => [
      r.maybeAutoImportPosts(c),
      if (buildType.isNotTest) r.maybeGenerateAccessToken(c)
    ],
  );

  Future generateAccessToken() async {
    final timestamp = DateTime.now().timestamp;
    final accessToken = await getAccessToken(proto.code);
    if (accessToken.isNotEmpty) {
      await updateSelf(
          {'token': accessToken, 'token_status': 'short_term_token'});
    } else {
      await updateSelf({'token_status': 'token_failed'});
      throw Exception('Failed to get user access token');
    }
    final profile = await getBaseProfile(accessToken);
    await updateSelf({
      'time_acquired': timestamp,
      'expires_in': 3600,
      'username': profile.username,
      'user_id': profile.id,
    });
    await addUserInstagramInfo(profile);
    final longTermToken = await getLongTermAccessToken(accessToken);
    if (longTermToken == null) {
      return;
    }
    await updateSelf({
      'token': longTermToken.token,
      'token_status': 'long_term_token',
      'time_acquired': timestamp,
      'expires_in': longTermToken.expiresIn
    });
  }

  Future maybeGenerateAccessToken(Change<InstagramToken> change) async {
    if (change.fieldChanged('code')) {
      await generateAccessToken();
    }
  }

  Future maybeAutoImportPosts(Change<InstagramToken> change) async {
    if (change.fieldChanged('import_status') &&
        proto.importStatus == $pb.InstagramToken_ImportStatus.start &&
        proto.hasToken()) {
      await updateSelf({'import_status': 'running'});
      await autoImportPosts();
      await updateSelf({'import_status': 'complete'});
    }
  }

  Future autoImportPosts() async {
    final user = await TasteUsers.forRef(userReference, transaction);
    final previousImports =
        await instaPosts(userReference, proto.username, transaction);
    final latestPostTime =
        previousImports.map((x) => x.proto.createdTime.toDateTime()).maxSelf;
    final posts = await autoImport(user, proto.token, latestPostTime);
    final numNewPosts = await autoBatch(
        (t) => createInstaPosts(posts.posts, previousImports, t));
    if (numNewPosts == 0) {
      return;
    }
    // Wait 30 seconds then create document that triggers the function to create location.
    await 30.seconds.wait;
    await transaction.set(
        CollectionType.instagram_username_requests.coll
            .document(proto.username),
        {
          'username': proto.username,
          'most_recent_post_date': latestPostTime,
          'set_location_request': true
        }.ensureAs($pb.InstagramUsernameRequest()).documentData);
  }

  Future deleteInstagramPosts() async {
    final posts = await instaPosts(userReference, proto.username, transaction);
    await posts.futureMap((p) async => await p.deleteSelf());
  }

  Future<String> getAccessToken(String code) async {
    final body = {
      'client_id': kInstagramClientId,
      'client_secret': kInstagramClientSecret,
      'code': code,
      'redirect_uri': 'https://trytaste.app/',
      'grant_type': 'authorization_code'
    };
    final response =
        await postJson('https://api.instagram.com/oauth/access_token', body);
    return (response['access_token'] ?? '') as String;
  }

  Future<$pb.InstagramToken> getLongTermAccessToken(String accessToken) async {
    try {
      final url =
          'https://graph.instagram.com/access_token?grant_type=ig_exchange_token&client_secret=$kInstagramClientSecret&access_token=$accessToken';
      final response = await http.get(Uri.parse(url));
      final body = json.decode(response.body) as Map<String, dynamic>;
      final token = (body['access_token'] ?? '') as String;
      if (token.isEmpty) {
        return null;
      }
      return $pb.InstagramToken()
        ..token = token
        ..expiresIn = body['expires_in'] as int;
    } catch (e) {
      print('Error getting long term access token: $e');
      return null;
    }
  }

  Future<$pb.InstagramToken> refreshAccessToken() async {
    try {
      final url =
          'https://graph.instagram.com/refresh_access_token?grant_type=ig_refresh_token&access_token=${proto.token}';
      final response = await http.get(Uri.parse(url));
      final body = json.decode(response.body) as Map<String, dynamic>;
      final token = (body['access_token'] ?? '') as String;
      if (token.isEmpty) {
        return null;
      }
      return $pb.InstagramToken()
        ..token = token
        ..expiresIn = body['expires_in'] as int;
    } catch (e) {
      print('Error refreshing access token: $e');
      return null;
    }
  }

  Future addUserInstagramInfo(ProfileInfo profile) async {
    final instagramInfo = $pb.InstagramInfo()
      ..username = profile.username
      ..userId = profile.id
      ..numPosts = 0
      ..settings = ($pb.InstagramSettings()
        ..autoImportSetting = $pb.InstagramSettings_AutoImportSetting.never);
    await userReference.updateData(
        UpdateData.fromMap({'instagram_info': instagramInfo.asMap}));
  }

  Future maybeRefresh() async {
    if (timeToExpiry < const Duration(days: 5)) {
      await refresh();
    }
  }

  Future refresh() async {
    final newToken = await refreshAccessToken();
    if (newToken == null) {
      return;
    }
    await updateSelf({
      'token': newToken.token,
      'time_acquired': DateTime.now().timestamp,
      'expires_in': newToken.expiresIn
    });
  }

  Duration get timeToExpiry => Duration(
      milliseconds: proto.timeAcquired
              .toDateTime()
              .add(Duration(seconds: proto.expiresIn))
              .millisecondsSinceEpoch -
          DateTime.now().millisecondsSinceEpoch);

  bool get isInvalid => timeToExpiry.isNegative;

  Future markInvalid() async => await proto.user.ref
      .updateData(UpdateData.fromMap({'instagram_info.token_invalid': true}));
}
