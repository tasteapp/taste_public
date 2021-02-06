import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:taste/providers/account_provider.dart';
import 'package:taste/screens/user_list/user_list.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/collection_type.dart';

const kFBFriendsPermission = 'user_friends';

// TODO(abelsm): handle non FB users.
class FacebookFriends extends StatefulWidget {
  const FacebookFriends({Key key}) : super(key: key);

  @override
  _FacebookFriendsState createState() => _FacebookFriendsState();
}

// TODO(abelsm): replace with user_id from user snapshot.
Future<String> getUserId() async {
  final accessToken = await facebookLogin.currentAccessToken;
  final response = await http.get('https://graph.facebook.com/v6.0/me?'
      'access_token=${accessToken.token}');
  return jsonDecode(response.body)["id"] as String;
}

Future<dynamic> getFacebookFriends() async {
  final accessToken = await facebookLogin.currentAccessToken;
  final userId = await getUserId();
  final response = await http.get('https://graph.facebook.com/v6.0/$userId/'
      'friends?access_token=${accessToken.token}');
  if (response.statusCode != 200) {
    return Crashlytics.instance.recordError('Failed: $response', null);
  }
  return jsonDecode(response.body);
}

class _FacebookFriendsState extends State<FacebookFriends> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FacebookAccessToken>(
      future: facebookLogin.currentAccessToken,
      builder: (c, s) {
        if (!s.hasData) {
          return const Text('Loading...');
        }
        final currentAccessToken = s.data;
        if (!currentAccessToken.permissions.contains(kFBFriendsPermission)) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'We need your permission to get your list of FB friends.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                OutlineButton(
                  onPressed: () async {
                    await facebookLogin.logIn(
                      kDefaultFBPermissions + [kFBFriendsPermission],
                    );
                    setState(() {});
                  },
                  child: const Text(
                    "Grant Permission",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'We do not store this data, and we only use it '
                            'to show you the list of your friends that are '
                            'already on ',
                      ),
                      TextSpan(
                        text: 'Taste',
                        style: TextStyle(
                          fontFamily: 'Hurley',
                          color: kTasteBrandColor,
                          fontSize: 25,
                        ),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        const progressIndicator = Center(child: CircularProgressIndicator());
        return FutureBuilder(
          future: getFacebookFriends(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return progressIndicator;
            }
            final data = snapshot.data;
            final friends = data['data'] as List;
            if (friends.isEmpty) {
              return const Center(
                child: Text('Facebook friends already on Taste appear here.'),
              );
            }
            final friendIds =
                friends.map((friend) => friend['id'] as String).toList();
            return FutureBuilder<List<TasteUser>>(
                future: CollectionType.users.coll.fetch(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return progressIndicator;
                  }
                  return UserListBody(
                    users: snapshot.data
                        .where((user) => friendIds.contains(user.proto.fbId))
                        .toList(),
                  );
                });
          },
        );
      },
    );
  }
}
