import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taste/components/icons.dart';
import 'package:taste/screens/profile/favorites_feed.dart';
import 'package:taste/screens/profile/posts_tab.dart';
import 'package:taste/screens/profile/profile_header.dart';
import 'package:taste/screens/profile/taste_drawer.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/quick_stateful_widget.dart';

import 'badges_list_widget.dart';
import 'bookmarks_tab.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key, @required this.tasteUser, this.heroTag})
      : super(key: key);
  static ProfilePageState of(BuildContext context) =>
      Provider.of<ProfilePageState>(context, listen: false);

  final TasteUser tasteUser;
  final Object heroTag;

  @override
  ProfilePageState createState() => ProfilePageState();
}

/// Use when the child of a SliverOverlapAbsorber is not a scroll view.
class SliverOverlapHandled extends StatelessWidget {
  const SliverOverlapHandled({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sliverOverlapExtent =
        NestedScrollView.sliverOverlapAbsorberHandleFor(context).layoutExtent;
    return Padding(
      padding: EdgeInsets.only(top: sliverOverlapExtent),
      child: child,
    );
  }
}

class ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController tabController(BuildContext context) =>
      DefaultTabController.of(context);

  ValueStream<int> postCount;
  ValueStream<Set<DocumentReference>> followers;
  ValueStream<Set<DocumentReference>> following;
  ValueStream<bool> amIFollowing;
  List<StreamSubscription> subscriptions;
  final showTop = ValueNotifier(true);
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    postCount = widget.tasteUser.allPosts.map((d) => d.length).shareValue();
    followers = widget.tasteUser.followers.shareValue();
    following = widget.tasteUser.following.shareValue();
    amIFollowing = widget.tasteUser.amIFollowing.shareValue();
    subscriptions = [postCount, followers, following, amIFollowing]
        .map((e) => e.listen((_) {}))
        .toList();
    _scrollController.addListener(() => showTop.value =
        _scrollController.offset <
            _scrollController.position.maxScrollExtent * .98);
  }

  @override
  void dispose() {
    subscriptions.forEach((s) => s.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      SliverOverlapHandled(
        child: PostsTab(
          user: widget.tasteUser,
        ),
      ),
      FavoritesFeedWidget(
        user: widget.tasteUser,
      ),
      SliverOverlapHandled(
        child: BookmarksTab(
          user: widget.tasteUser,
        ),
      ),
      BadgesListWidget(user: widget.tasteUser)
    ].enumerate.entryMap((i, w) => TabKeepAliveWidget(w, i)).toList();

    return MultiProvider(
      providers: [
        Provider.value(value: widget.tasteUser),
        Provider.value(value: this)
      ],
      child: Scaffold(
        drawer: TasteDrawer(),
        body: DefaultTabController(
          length: 4,
          child: Builder(
            builder: (context) => QuickStatefulWidget<TabController>(
              // Set screen-events for the different tabs.
              initState: (_) {
                final tabController = DefaultTabController.of(context);
                tabController.addListener(() {
                  final tab = tabController.index.round();
                  analytics.setCurrentScreen(
                    screenName: {
                      0: TATab.profile_posts.name,
                      1: TATab.profile_favorites.name,
                      2: TATab.profile_bookmarks.name,
                      3: TATab.profile_badges.name,
                    }[tab],
                  );
                });
                return tabController;
              },
              builder: (context, _) => NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return <Widget>[
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                          automaticallyImplyLeading: false,
                          flexibleSpace: FlexibleSpaceBar(
                            background: SafeArea(
                              child: ProfileHeader(tasteUser: widget.tasteUser),
                            ),
                            collapseMode: CollapseMode.pin,
                          ),
                          pinned: true,
                          expandedHeight: 274.0,
                          forceElevated: innerBoxIsScrolled,
                          bottom: TasteTabBar(
                            showTop: showTop,
                            tabBar: TabBar(
                              controller: tabController(context),
                              tabs: [
                                Tab(
                                    icon: Icon(PhotoLibraryIcons.photoLibrary,
                                        color: iconColor, size: 20.0)),
                                Tab(
                                    icon: Icon(TrophyOutlineIcons.trophy,
                                        color: iconColor, size: 20.0)),
                                Tab(
                                    icon: Icon(BookmarkIcons.bookmark,
                                        color: iconColor, size: 20.0)),
                                Tab(
                                    icon: Icon(GamificationIcons.gamification,
                                        color: iconColor, size: 20.0)),
                              ],
                              indicatorColor: kPrimaryButtonColor,
                              indicatorWeight: 3,
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: Container(
                    color: Colors.white,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController(context),
                      // Note that the children need to user SliverLists and also
                      // assign a handle for SliverOverlapInjector.
                      // See NestedScrollView doc for details:
                      // https://api.flutter.dev/flutter/widgets/NestedScrollView-class.html
                      children: pages,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Color get iconColor => Colors.black.withOpacity(0.5);

  static void goToBadges(BuildContext context) =>
      DefaultTabController.of(context).animateTo(3);
}

class TasteTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TasteTabBar({this.tabBar, @required this.showTop, this.visible = true});

  final TabBar tabBar;
  final ValueNotifier<bool> showTop;
  final bool visible;

  @override
  Size get preferredSize => const Size.fromHeight(0.0);

  @override
  Widget build(BuildContext context) => visible
      ? ValueListenableBuilder<bool>(
          valueListenable: showTop,
          builder: (context, showTop, child) => Container(
              decoration: BoxDecoration(
                  color: kPrimaryBackgroundColor,
                  border: Border(top: topBorder(showTop), bottom: border)),
              child: child),
          child: tabBar)
      : Container();

  BorderSide get border =>
      BorderSide(color: Colors.grey.withOpacity(0.8), width: 0.0);
  BorderSide topBorder(bool showTop) => showTop ? border : BorderSide.none;
}

class TabKeepAliveWidget extends StatefulWidget {
  TabKeepAliveWidget(this.child, [int i])
      : super(key: child.key ?? ValueKey(i));
  final Widget child;
  @override
  _TabKeepAliveWidgetState createState() => _TabKeepAliveWidgetState();
}

class _TabKeepAliveWidgetState extends State<TabKeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
