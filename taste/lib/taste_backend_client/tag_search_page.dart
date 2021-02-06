import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/screens/create_review/review/legal_taste_tags.dart';
import 'package:taste/screens/discover/components/discover_item_widget.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/utils/posts_list_provider.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' show Review_DeliveryApp;

import 'backend.dart';

class TagSearchPage extends StatelessWidget {
  const TagSearchPage({Key key, @required this.tag, this.deliveryApp})
      : super(key: key);
  final String tag;
  final Review_DeliveryApp deliveryApp;

  static Future goTo(BuildContext context, String tag,
      {Review_DeliveryApp deliveryApp}) async {
    tag = tag?.tagify;
    if (tag?.isEmpty ?? true) {
      return;
    }
    TAEvent.clicked_tag({'tag': tag});
    await quickPush(
      TAPage.tag_search,
      (context) => TagSearchPage(tag: tag, deliveryApp: deliveryApp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LocationBuilder(builder: (context, latLng, status) {
      if (status == Status.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            kCountryTasteTagsMap.containsKey(tag)
                ? [tag, kCountryTasteTagsMap[tag] ?? ''].join(' ')
                : '#$tag',
            style: const TextStyle(color: Colors.blue),
            maxLines: 1,
            maxFontSize: 24,
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<List<DiscoverItem>>(
          stream: deliveryApp == null
              ? tagSearch(tag)
                  .map((e) => e.distinctOn((t) => t.proto.reference).toList())
              : deliveryAppSearch(deliveryApp)
                  .map((e) => e.distinctOn((t) => t.proto.reference).toList()),
          builder: (context, snapshot) => !snapshot.hasData
              ? const Center(child: CircularProgressIndicator())
              : snapshot.data.isEmpty
                  ? const Center(child: Text("No hits!"))
                  : PostsListProvider(
                      posts: snapshot.data,
                      child: ListView.separated(
                        separatorBuilder: (_, i) => const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(
                            thickness: 2,
                            color: Color(0x88E0E0E0),
                          ),
                        ),
                        cacheExtent: 1000,
                        itemBuilder: (c, i) => Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                          child: DiscoverItemWidget(
                              discoverItem: snapshot.data[i]),
                        ),
                        itemCount: snapshot.data?.length ?? 0,
                      ),
                    ),
        ),
      );
    });
  }
}
