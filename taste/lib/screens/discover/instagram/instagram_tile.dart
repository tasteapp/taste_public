import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/discover/instagram/instagram_actions.dart';
import 'package:taste/screens/discover/instagram/instagram_settings.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/taste_backend_client/value_stream_builder.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

class InstagramImportTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ValueStreamBuilder<TasteUser>(
        stream: tasteUserStream,
        builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: ListTile(
            onTap: () async {
              if (snapshot.data == null) {
                return;
              }
              final user = snapshot.data;
              if (!user.proto.hasInstagramInfo()) {
                final instagramToken = await login(context, user);
                if (instagramToken == null) {
                  return;
                }
                unawaited(instagramTokenStream(instagramToken.reference)
                    .firstWhere((t) => t.proto.hasTokenStatus())
                    .then((t) async {
                  if (t.proto.tokenStatus ==
                      $pb.InstagramToken_TokenStatus.token_failed) {
                    return;
                  }
                  await updateInstagramInfo(user: user, token: t);
                  await t.reference.updateData({'import_status': 'start'});
                }));
                await showDialog<bool>(
                  context: context,
                  builder: (context) => InstagramImportDialog(
                    token: instagramToken,
                  ),
                );
                return;
              }
              await showDialog<$pb.InstagramSettings>(
                  context: context,
                  builder: (c) => InstagramSettingsDialog(
                        user: user,
                      ));
            },
            title: snapshot.hasData ? InstagramTitle(snapshot.data) : null,
            subtitle: InstagramSubtitle(user: snapshot.data),
            leading: Image.asset("assets/ui/instagram_logo.png", height: 24.0),
          ),
        ),
      );
}

class InstagramTitle extends StatelessWidget {
  const InstagramTitle(this.user);

  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return user.proto.hasInstagramInfo()
        ? const Text("Linked Instagram Account")
        : const Text("Instagram Auto-Import");
  }
}

class InstagramSubtitle extends StatelessWidget {
  const InstagramSubtitle({this.user});

  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!user.proto.hasInstagramInfo()) {
      return const Text(
          "Add all your food and drink photos from Instagram with one magic click");
    }
    return InstagramInfoTileWidget(user: user);
  }
}

class InstagramInfoTileWidget extends StatelessWidget {
  const InstagramInfoTileWidget({Key key, this.user}) : super(key: key);

  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    final profileImage = user.instagramProfileImage() ?? "";
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 10.0),
          Padding(
            padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: profileImage.isNotEmpty
                  ? CachedNetworkImageProvider(profileImage)
                  : null,
              backgroundColor: Color.alphaBlend(
                kPrimaryButtonColor.withOpacity(0.1),
                Colors.white,
              ),
              child: profileImage.isEmpty
                  ? Icon(
                      Icons.person_outline,
                      size: 25 * 4.0 / 3,
                      color: Color.alphaBlend(
                        kPrimaryButtonColor.withOpacity(0.66),
                        Colors.white,
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 11.0),
          Column(
            children: [
              Text("@${user.proto.instagramInfo.username}",
                  style: const TextStyle(
                      color: kTasteBrandColor, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4.0),
              StreamBuilder<int>(
                stream: user.numInstaPosts,
                builder: (context, snapshot) {
                  final displayNum = snapshot.data?.toString() ?? '?';
                  return Text("$displayNum posts on Taste");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
