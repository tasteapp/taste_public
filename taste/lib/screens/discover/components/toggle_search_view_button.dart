import 'package:flutter/material.dart';
import 'package:taste/screens/logged_in/map_promotion.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ToggleSearchViewButton extends StatelessWidget {
  const ToggleSearchViewButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.share),
        onPressed: () async {
          TAEvent.web_map();
          final username = (await cachedLoggedInUser).username;
          final shortLink = 'trytaste.app/@$username';
          final longLink = 'https://$shortLink';
          if (await mapPromotionActiveStream.first) {
            TAEvent.map_promotion();
            await completeMapPromotion();
            await showOkayMessageDialog(
                context: context,
                message:
                    "Redirecting to your brand new TasteMap at $shortLink: a web-link of all your posts you can share with anyone!");
          }
          await launch(longLink);
        });
  }
}
