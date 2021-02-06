import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/components/horizontal_scroll_wrapper.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/screens/profile/profile.dart';
import 'package:taste/screens/profile/simple_review_widget.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/posts_list_provider.dart';
import 'package:taste/utils/unfocusable.dart';

import 'post_interface.dart';

class PostsTab extends StatelessWidget {
  /// Either [emptyMessage] xor [emptyWidget] must be given.
  const PostsTab({
    Key key,
    @required this.user,
  }) : super(key: key);
  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return Unfocusable(
      child: StreamBuilder<List<Post>>(
        key: const Key('PostsTab#StreamBuilder'),
        stream: user.allPosts,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final reviews = snapshot.data;
          if (reviews.isEmpty) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(50, 92, 50, 0),
              child: Text(
                user.isMe
                    ? 'Posts you make will appear here, start sharing your taste!'
                    : "${user.name} hasn't shared anything yet.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Quicksand",
                  color: Color(0xFF6D7278),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
          return TabbedPostsPage(reviews: reviews);
        },
      ),
    );
  }
}

class TabbedPostsPage extends StatelessWidget {
  const TabbedPostsPage({Key key, this.reviews}) : super(key: key);

  final List<Post> reviews;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              PostsTabSelector(
                key: const Key('TabbedPostsSelector'),
                tabController: DefaultTabController.of(context),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  key: const Key('TabbedPostsPage'),
                  controller: DefaultTabController.of(context),
                  children: [
                    TabKeepAliveWidget(PostsGrid(
                      key: const PageStorageKey('PostsGridContainer'),
                      reviews: reviews,
                    )),
                    TabKeepAliveWidget(SmartSortedGrid(
                      key: const PageStorageKey('SmartSortedGridContainer'),
                      reviews: reviews,
                    )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PostsTabSelector extends StatefulWidget {
  const PostsTabSelector({Key key, this.tabController}) : super(key: key);

  final TabController tabController;

  @override
  _PostsTabSelectorState createState() => _PostsTabSelectorState();
}

class _PostsTabSelectorState extends State<PostsTabSelector> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      final tab = widget.tabController.index.round();
      analytics.setCurrentScreen(
        screenName: {
          0: TATab.profile_posts.name,
          1: TATab.profile_smart_sorted.name,
        }[tab],
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TasteChoiceChip(
            selected: widget.tabController.index == 0,
            text: 'All Posts',
            icon: const Icon(Icons.list, size: 17),
            onSelected: (_) {
              if (widget.tabController.index == 0) {
                return;
              }
              setState(() => widget.tabController.animateTo(0));
            },
          ),
          TasteChoiceChip(
            selected: widget.tabController.index == 1,
            text: 'Smart Sort',
            icon: const Icon(Icons.lightbulb_outline, size: 17),
            onSelected: (_) {
              if (widget.tabController.index == 1) {
                return;
              }
              setState(() => widget.tabController.animateTo(1));
            },
          ),
        ],
      ),
    );
  }
}

class PostsGrid extends StatelessWidget {
  const PostsGrid({Key key, this.reviews}) : super(key: key);

  final List<Post> reviews;

  @override
  Widget build(BuildContext context) => PostsListProvider(
      posts: reviews,
      child: GridView.builder(
        key: const Key("ProfilePostsGrid"),
        cacheExtent: MediaQuery.of(context).size.height * 3,
        primary: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio:
              MediaQuery.of(context).size.width < 400 ? 0.64 : 0.68,
        ),
        itemBuilder: (context, index) => SimpleReviewWidget(
            key: ValueKey(reviews[index].path), review: reviews[index]),
        itemCount: reviews.length,
      ));
}

class SmartSortedGrid extends StatelessWidget {
  const SmartSortedGrid({Key key, this.reviews, this.emptyWidget})
      : super(key: key);

  final List<Post> reviews;
  final Widget emptyWidget;

  @override
  Widget build(BuildContext context) => reviews == null
      ? const Center(child: CircularProgressIndicator())
      : reviews.isEmpty
          ? emptyWidget
          : LocationBuilder(
              waitDuration: const Duration(seconds: 2),
              builder: (context, location, status) {
                if (status.isWaiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final groupedReviewData = getGroupedReviewData(
                    context, reviews, location,
                    showHomeMeals: true);
                if (groupedReviewData.groupedData.isEmpty) {
                  return emptyWidget;
                }
                return CustomScrollView(
                  key: const Key('ProfileSmartedSortedGridScrollKey'),
                  cacheExtent: MediaQuery.of(context).size.height * 3,
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, i) {
                          if (i == groupedReviewData.groupedData.length) {
                            return const SizedBox(height: 20);
                          }
                          final group =
                              groupedReviewData.groupedData.entries.toList()[i];
                          return Column(
                            key: Key('SmartSortGrid_Column_$i'),
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: Text(
                                  group.key,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: kPrimaryButtonColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                height: 250,
                                color: Colors.white,
                                child: HorizontalScrollWrapper(
                                  child: PostsListProvider(
                                    posts: group.value,
                                    child: ListView.builder(
                                      key: Key('SmartSortGrid_ListView_$i'),
                                      cacheExtent:
                                          MediaQuery.of(context).size.width * 3,
                                      controller: ScrollController(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_, index) {
                                        if (index == 0) {
                                          return const SizedBox(width: 13);
                                        }
                                        final review = group.value[index - 1];
                                        return Padding(
                                          key: ValueKey(review.path),
                                          padding: const EdgeInsets.only(
                                            left: 7,
                                            right: 7,
                                            top: 18,
                                          ),
                                          child: SimpleReviewWidget(
                                              review: review),
                                        );
                                      },
                                      itemCount: group.value.length + 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        childCount: groupedReviewData.groupedData.length + 1,
                      ),
                    ),
                  ],
                );
              },
            );
}

class GroupedReviewData {
  GroupedReviewData({this.groupedData, this.userLocation});

  final Map<String, List<Post>> groupedData;
  final LatLng userLocation;
}

const kHomeMealGroupKey = 'Home Cooked';

GroupedReviewData getGroupedReviewData(
    BuildContext context, List<Post> reviews, LatLng latLng,
    {bool showHomeMeals = false}) {
  final reviewTypes = reviews.groupBy((r) => r.isHomeCooked);
  const maxDistance = 33000;
  const filterDistance = maxDistance + 1;
  return GroupedReviewData(
    userLocation: latLng,
    groupedData: {
      'Nearby': (reviewTypes[false] ?? [])
          .zipWith((r) => r.distanceMeters(latLng) ?? filterDistance)
          .where((r) => r.b < maxDistance)
          .sorted((r) => r.b)
          .a
          .toList(),
      kHomeMealGroupKey: showHomeMeals ? reviewTypes[true] : null,
      ...(reviewTypes[false] ?? [])
          .groupBy((input) => input.simpleAddress)
          .withoutEmpties
          .sortBy((r) => latLng == null
              ? r.simpleAddress
              : r.distanceMeters(latLng) as Comparable),
    }.withoutEmpties,
  );
}
