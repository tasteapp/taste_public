import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/screens/review/review.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';

import 'utils.dart';

class PostsListProvider extends StatelessWidget {
  const PostsListProvider({Key key, @required this.posts, @required this.child})
      : super(key: key);
  final List<Post> posts;
  final Widget child;

  static Future go(BuildContext context, Post post,
      {int postPhotoIndex = 0}) async {
    Future goToSingle() async {
      final input = post is DiscoverItem
          ? ReviewPageInput.discoverItem(post)
          : post is Review
              ? ReviewPageInput.review(post)
              : ReviewPageInput.reviewReference(post.postReference);
      await goToReviewPage(input);
    }

    try {
      final posts = Provider.of<_Wrap>(context, listen: false).list;
      final startingIndex = posts.indexOf(post);
      if (startingIndex < 0) {
        return goToSingle();
      }
      return quickPush(
          TAPage.posts,
          (context) => FutureBuilder<int>(
                future:
                    Future.delayed(const Duration(milliseconds: 700), () => 2),
                builder: (context, snapshot) => PreloadPageView.builder(
                  key: const PageStorageKey('ScrollableReviewPage'),
                  preloadPagesCount: snapshot.data ?? 0,
                  onPageChanged: (_) => TAEvent.swipe_multi_post(),
                  controller: PreloadPageController(initialPage: startingIndex),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, idx) {
                    return FutureBuilder<DiscoverItem>(
                      future: posts[idx].discoverItem,
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            color: Colors.black,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        }
                        return ReviewPage(
                          review: snapshot.data,
                          controller: PreloadPageController(
                            keepPage: true,
                            initialPage:
                                (startingIndex == idx ? postPhotoIndex : 0) ??
                                    0,
                          ),
                        );
                      },
                    );
                  },
                  itemCount: posts.length,
                ),
              ));
    } on ProviderNotFoundException catch (_) {
      return goToSingle();
    }
  }

  @override
  Widget build(BuildContext context) =>
      Provider.value(value: _Wrap(posts), child: child);
}

class _Wrap {
  _Wrap(this.list);
  final List<Post> list;
}
