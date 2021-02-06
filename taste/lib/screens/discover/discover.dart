import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deferrable/deferrable.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:taste/app_config.dart';
import 'package:taste/components/nav/nav.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/components/taste_brand.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/screens/contest/contest_page.dart';
import 'package:taste/screens/contest/daily_tasty_badge.dart';
import 'package:taste/screens/log_in/connect_account_screen.dart';
import 'package:taste/screens/profile/notifications/notifications_button.dart';
import 'package:taste/screens/profile/notifications/user_settings_button.dart';
import 'package:taste/screens/report_bug/report_bug.dart';
import 'package:taste/screens/report_bug/talk_to_us.dart';
import 'package:taste/taste_backend_client/responses/daily_tasty_vote.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/taste_backend_client/value_stream_builder.dart';
import 'package:taste/theme/buttons.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/debug.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste/utils/posts_list_provider.dart';
import 'package:taste/utils/taste_bottom_sheet.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' show BugReportType;

import '../../discover_feed_provider.dart';
import 'components/discover_item_widget.dart';

const _backgroundColor = Color(0xFFF2F2F2);
const _overlayColor = Color(0xFFFAFAFA);

class DiscoverPage extends StatelessWidget {
  const DiscoverPage();
  Widget pad(Widget w) =>
      Padding(padding: const EdgeInsets.only(top: 14), child: w);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: GestureDetector(
          onDoubleTap: isProd ? null : toggleTasteDebugMode,
          child: AppBar(
            elevation: 3,
            backgroundColor: _overlayColor,
            centerTitle: true,
            actions: [pad(NotificationsButton())],
            leading: pad(_DrawerButton()),
            title: pad(_AppBarTitle()),
          ),
        ),
      ),
      body: Theme(
          data: Theme.of(context).copyWith(
            scaffoldBackgroundColor: _backgroundColor,
            backgroundColor: _backgroundColor,
            canvasColor: _backgroundColor,
            primaryColor: _backgroundColor,
            primaryColorLight: _backgroundColor,
          ),
          child: Container(color: _backgroundColor, child: _DiscoverBody())),
      drawer: _Drawer());
}

class _Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MediaQuery.removePadding(
        context: context,
        // DrawerHeader consumes top MediaQuery padding.
        removeTop: true,
        child: Drawer(
          child: Container(
            color: _overlayColor,
            child: ListView(
                children: ListTile.divideTiles(
                        context: context,
                        tiles: [
                          _DrawerHeader(),
                          // InstagramImportTile(),
                          _DailyDigestTile(),
                          ListTile(
                              leading: const Icon(Icons.bug_report),
                              title: const Text('Report a bug'),
                              onTap: () {
                                Navigator.pop(context);
                                TAEvent.clicked_report_bug();
                                quickPush(
                                    TAPage.report_bug,
                                    (_) => const UserReportScreen(
                                        type: BugReportType.bug_report));
                              }),
                          ListTile(
                              leading: const Icon(Icons.feedback),
                              title: const Text('Talk with us!'),
                              onTap: () async {
                                Navigator.pop(context);
                                final user = await cachedLoggedInUser;
                                await quickPush(TAPage.talk_with_us,
                                    (_) => TalkToUsPage(user: user));
                              }),
                          ListTile(
                              leading: const Icon(Icons.people),
                              title: const Text('Invite Friends'),
                              onTap: () async {
                                Navigator.pop(context);
                                TAEvent.clicked_share_taste();
                                await Share.share(
                                    'Check out Taste @ https://trytaste.app!');
                              }),
                          const SignOutTile()
                        ].withoutNulls)
                    .toList()),
          ),
        ),
      );
}

class SwitchAccountTile extends StatelessWidget {
  const SwitchAccountTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<TasteUser>(
        stream: tasteUserStream,
        builder: (context, snapshot) => snapshot.data?.proto?.guestMode ?? false
            ? const ConnectAccountTile()
            : const SignOutTile(),
      );
}

class SignOutTile extends StatelessWidget {
  const SignOutTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
      leading: const Icon(FontAwesome.sign_out),
      title: const Text('Sign out'),
      onTap: FirebaseAuth.instance.signOut);
}

class ConnectAccountTile extends StatelessWidget {
  const ConnectAccountTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
      leading: const Icon(FontAwesome.link),
      title: const Text('Connect Account'),
      onTap: () =>
          TAPage.connect_account_page(widget: const ConnectAccountScreen()));
}

class _DailyDigestTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ValueStreamBuilder<TasteUser>(
        stream: tasteUserStream,
        builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: ListTile(
            onTap: () => snapshot.data.reference.updateData({
              'daily_digest.enabled':
                  !(snapshot.data?.proto?.dailyDigest?.enabled ?? false)
            }),
            title: const Text("Daily Digest"),
            subtitle: const Text(
                "Get notified on new posts from people you care about"),
            leading: snapshot.data?.proto?.dailyDigest?.enabled ?? false
                ? const Icon(Icons.check_box, color: Colors.blue)
                : const Icon(Icons.check_box_outline_blank),
          ),
        ),
      );
}

class _DrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.copyWith(
                bodyText1: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        child: ValueStreamBuilder<TasteUser>(
            stream: tasteUserStream,
            builder: (context, snapshot) {
              return InkWell(
                  onTap: goToUserSettings,
                  child: Container(
                    color: kPrimaryButtonColor,
                    padding: const EdgeInsets.only(top: 30),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(children: <Widget>[
                        Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              ProfilePhoto(
                                  radius: 50, user: snapshot.data.reference),
                              Card(
                                  color: Colors.white.withOpacity(0.8),
                                  elevation: 5,
                                  shape: const CircleBorder(),
                                  child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.edit, size: 14)))
                            ]),
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(snapshot.data?.name ?? '',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      (snapshot.data?.username ?? '').isEmpty
                                          ? ''
                                          : '@${snapshot.data.username}',
                                      style: const TextStyle(
                                          color: Colors.white))),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Edit Account",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              )
                            ]))
                      ]),
                    ),
                  ));
            }),
      );
}

class ProfilePictureHeroTag with EquatableMixin {
  ProfilePictureHeroTag(this.userReference);
  final DocumentReference userReference;

  @override
  List<Object> get props => [userReference];
}

class _AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      InkWell(onTap: () => _goToTop(_controller), child: _AppBarLogo());
}

class _AppBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const TasteBrand(showLogo: false, size: 25);
}

enum _Filter { following, home }

class _BlocState with EquatableMixin {
  _BlocState(this.filters, this.following, this.mode);

  final Set<_Filter> filters;
  final Set<DocumentReference> following;
  final DiscoverMode mode;
  bool get isHome => filters.contains(_Filter.home);
  bool get isFollowing => filters.contains(_Filter.following);

  bool keepPost(DiscoverItem item) =>
      item != null &&
      item.firePhotos.isNotEmpty &&
      (isHome || !item.isHomeCooked || mode == DiscoverMode.nearby) &&
      (!isFollowing || following.contains(item.userReference));

  @override
  List<Object> get props =>
      [mode, isHome, isFollowing, ...isFollowing ? following : {}];
}

final _controller = __controller();
ScrollController __controller() {
  final controller = ScrollController();
  onTabRetap((i) => i == 0 ? _goToTop(controller) : null);
  return controller;
}

void _goToTop(ScrollController controller) => controller.hasClients
    ? controller.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn)
    : null;

class _Bloc {
  factory _Bloc() {
    final filters = BehaviorSubject.seeded({_Filter.home});
    final mode = BehaviorSubject.seeded(DiscoverMode.most_recent);
    return _Bloc._(
      filters,
      mode,
      Rx.combineLatest3<Set<_Filter>, Set<DocumentReference>, DiscoverMode,
          _BlocState>(
        filters,
        fetchFollowing().startWith({}),
        mode,
        (a, b, c) => _BlocState(a, b, c),
      ).shareValueSeeded(
        _BlocState(filters.value, {}, DiscoverMode.most_recent),
      ),
    );
  }
  _Bloc._(this._filters, this._mode, this.state);
  final controller = RefreshController(initialRefresh: false);
  // Increases the fetch size by this much when friends toggle is on.
  static const friendsIncreaseFactor = 10;
  // Increments baseline fetch number this much each time a request is requested.
  static const _increment = 20;
  // Number to load, subject to value of "friends only" being false, otherwise
  // increase this number by friendsIncreaseFactor.
  static const _maxNumToLoad = _increment * 50;
  static const _initialLoad = 10;
  // Stream controller, sets the first fetch amount to be _increment, so we only
  // load _increment amount at first.
  //
  // While the amount may seem small, we preemptively fetch more as the user
  // near the bottom, making for a seamless scrolling experience.
  final numToLoad = BehaviorSubject.seeded(_initialLoad);

  Future onRefresh() async {
    // We change the mode as a hack to force a refresh due to how refresh is
    // tied to a new state being pushed (which requires filter or mode change).
    // See _Bloc constructor.
    final currentMode = _mode.value;
    _mode.add(currentMode == DiscoverMode.nearby
        ? DiscoverMode.most_recent
        : DiscoverMode.nearby);
    await 50.millis.wait;
    _mode.add(currentMode);
    await 3.seconds.wait;
    // Safeguard against network failures or lack of new data by always
    // completing within 3 seconds.
    controller.loadComplete();
    TAEvent.discover_refreshed();
  }

  Future onLoading() async {
    if (numToLoad.value >= _maxNumToLoad) {
      // Don't load anymore, just exit immediately.
      controller.loadComplete();
      TAEvent.discover_loaded({'max': true, 'count': numToLoad.value});
      return;
    }
    // Increase the total number of items to fetch
    numToLoad.add(numToLoad.value + _increment);
    await Future.delayed(const Duration(seconds: 3));
    // Safeguard against network failures or lack of new data by always
    // completing within 3 seconds.
    controller.loadComplete();
    TAEvent.discover_loaded({'max': false, 'count': numToLoad.value});
  }

  static _Bloc of(BuildContext context) => Provider.of(context, listen: false);

  final ValueStream<_BlocState> state;
  final BehaviorSubject<Set<_Filter>> _filters;
  final BehaviorSubject<DiscoverMode> _mode;

  void setFilter(BuildContext context, _Filter filter, bool addFilter) {
    final values = Set.of(_filters.value);
    _filters.add(addFilter ? (values..add(filter)) : (values..remove(filter)));
    numToLoad.add(_initialLoad);
  }

  void setMode(DiscoverMode mode) {
    _mode.add(mode);
    numToLoad.add(_initialLoad);
  }

  void dispose() {
    _filters.close();
    _mode.close();
    numToLoad.close();
  }

  void finished() {
    controller
      ..loadComplete()
      ..refreshCompleted();
  }
}

class NoPostsFromFriendsMessage extends StatelessWidget {
  const NoPostsFromFriendsMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'No posts from people you follow.\nInvite your friends or browse '
            'the public feed.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class NoNearbyPostsMessage extends StatelessWidget {
  const NoNearbyPostsMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              // TODO(team): badge for pioneers.
              'There are currently no posts in your area.\n'
              'Be the first to post!',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 15),
          TasteButton(
            text: 'Create Post',
            onPressed: () {
              TAEvent.discover_tap_first_to_post();
              goToTab(2);
            },
            options: kTastePrimaryButtonOptions,
          ),
        ],
      ),
    );
  }
}

class _DiscoverBody extends StatefulWidget {
  @override
  __DiscoverBodyState createState() => __DiscoverBodyState();
}

class __DiscoverBodyState extends State<_DiscoverBody> with Deferrable {
  _Bloc bloc;

  Stream<List<DiscoverItem>> stream;

  @override
  void initState() {
    super.initState();
    bloc = _Bloc();
    defer(bloc.dispose);
    defer(Rx.combineLatest2<_BlocState, int, int>(
            bloc.state.distinct(),
            bloc.numToLoad.distinct(),
            (state, numToLoad) =>
                numToLoad *
                (state.isFollowing ? _Bloc.friendsIncreaseFactor : 1))
        .listen(setDiscoverCount)
        .cancel);
    stream = bloc.state.distinct().switchMap((state) =>
        getDiscoverStream(state.mode)
            .startWith(null)
            .listWhere(state.keepPost)
            .sideEffect((_) {
          bloc.finished();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return LocationBuilder(locationUpdateCallback: (status) {
      if (status != Status.enabled) {
        setState(() => bloc.setMode(DiscoverMode.most_recent));
      }
    }, builder: (context, latLng, status) {
      if (status == Status.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      final locationEnabled = status == Status.enabled;
      return Provider<_Bloc>.value(
        value: bloc,
        child: StreamBuilder<List<DiscoverItem>>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('error encoutered: ${snapshot.error}');
              if (isDev) {
                return Center(child: Text(snapshot.error.toString()));
              }
              Crashlytics.instance.recordError(
                'Error loading Discover feed: ${snapshot.error}\n'
                'Filters: ${bloc._filters.value}\n'
                'Mode: ${bloc._mode.value}',
                null,
              );
              return const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Oh no! We had trouble loading the posts. Please reopen Taste and try again.",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: DeferringSpinner());
            }
            final mode = bloc.state.value.mode;
            return PostsListProvider(
              posts: snapshot.data ?? [],
              child: RefreshConfiguration(
                footerTriggerDistance: 500,
                child: SmartRefresher(
                  header: const MaterialClassicHeader(
                    offset: 50,
                    distance: 10,
                    backgroundColor: kPrimaryButtonColor,
                  ),
                  footer: const ClassicFooter(loadingText: ''),
                  enablePullUp: true,
                  enablePullDown: true,
                  controller: bloc.controller,
                  onRefresh: bloc.onRefresh,
                  onLoading: bloc.onLoading,
                  child: ListView.separated(
                    cacheExtent: 1000,
                    controller: _controller,
                    separatorBuilder: (_, i) => i == 0
                        ? Container()
                        : const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 2,
                              color: Color(0x88E0E0E0),
                            ),
                          ),
                    itemCount: 1 +
                        (snapshot.data.isEmpty ? 1 : 0) +
                        snapshot.data.length,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (context, i) {
                      if (i == 0) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: _FiltersWidget(
                            key: const Key('mode'),
                            locationEnabled: locationEnabled,
                          ),
                        );
                      }
                      if (snapshot.data.isEmpty) {
                        if (mode == DiscoverMode.nearby) {
                          return const NoNearbyPostsMessage();
                        }
                        return const NoPostsFromFriendsMessage();
                      }
                      final item = snapshot.data[i - 1];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                        child: DiscoverItemWidget(
                          onViewed: () => TAEvent.discover_scrolled_to_item({
                            'index': i,
                            'item_path': item.reference.path,
                            'mode': mode.toString()
                          }),
                          discoverItem: item,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class _FiltersWidget extends StatefulWidget {
  const _FiltersWidget({Key key, this.locationEnabled}) : super(key: key);

  final bool locationEnabled;

  @override
  __FiltersWidgetState createState() => __FiltersWidgetState();
}

class __FiltersWidgetState extends State<_FiltersWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = _Bloc.of(context);
    return StreamBuilder<_BlocState>(
        stream: bloc.state,
        initialData: bloc.state.value,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => showTasteBottomSheetWithItems(
                    context,
                    [
                      TasteBottomSheetItem(
                        title: 'Following',
                        callback: () => setState(() =>
                            bloc.setFilter(context, _Filter.following, true)),
                      ),
                      TasteBottomSheetItem(
                        title: 'Public',
                        callback: () => setState(() =>
                            bloc.setFilter(context, _Filter.following, false)),
                      ),
                    ],
                  ),
                  child: Text(
                    snapshot.data.isFollowing ? 'Following' : 'Public',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0x992F3542)),
                  ),
                ),
                InkWell(
                  onTap: () => showTasteBottomSheetWithItems(
                    context,
                    [
                      TasteBottomSheetItem(
                        title: 'Nearby',
                        callback: () =>
                            setState(() => bloc.setMode(DiscoverMode.nearby)),
                      ),
                      TasteBottomSheetItem(
                        title: 'Recent',
                        callback: () => setState(
                            () => bloc.setMode(DiscoverMode.most_recent)),
                      ),
                    ],
                  ),
                  child: Text(
                    'Sort: ${snapshot.data.mode == DiscoverMode.nearby ? "Nearby" : "Recent"}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0x992F3542)),
                  ),
                ),
              ],
            ),
            // ),
          );
        });
  }
}

class _Selector extends StatelessWidget {
  const _Selector({
    this.enabled,
    this.onSelected,
    this.text,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    this.fontSize = 15.0,
  });

  final bool enabled;
  final void Function(bool value) onSelected;
  final String text;
  final EdgeInsets padding;
  final double fontSize;

  Color get color => enabled ? kPrimaryButtonColor : Colors.white;
  Color get textColor => enabled ? kChipTextColor : const Color(0xFF979A9F);
  TextStyle get labelStyle => TextStyle(
        color: textColor,
        fontWeight: FontWeight.w600,
        fontSize: 15,
      );

  @override
  Widget build(BuildContext context) => ChoiceChip(
      padding: padding,
      selected: enabled,
      onSelected: onSelected,
      selectedColor: color,
      labelStyle: labelStyle,
      shape: StadiumBorder(
          side: BorderSide(color: enabled ? color : textColor, width: 1.5)),
      backgroundColor: color,
      label: Text(
        text,
        style: TextStyle(fontFamily: 'Quicksand', fontSize: fontSize),
      ));
}

class _DrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
      icon: Icon(Icons.menu, color: Colors.black.withOpacity(0.75)),
      onPressed: () => Scaffold.of(context).openDrawer());
}

class PlayDailyTastyHeader extends StatelessWidget {
  const PlayDailyTastyHeader({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: ListTile(
          onTap: () => quickPush(
            TAPage.daily_tasty,
            (_) => const ContestPage(),
          ),
          trailing: const Icon(Icons.chevron_right),
          title: Row(
            children: const [
              Text("Play ", style: TextStyle(fontSize: 20)),
              DailyTastyBadgeInner(size: 20),
              Padding(
                padding: EdgeInsets.only(left: 2),
                child: Text("!",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: NewDailyTasties(),
              ),
            ],
          ),
        ),
      );
}

class NewDailyTasties extends StatefulWidget {
  const NewDailyTasties();

  @override
  _NewDailyTastiesState createState() => _NewDailyTastiesState();
}

class _NewDailyTastiesState extends State<NewDailyTasties>
    with AutomaticKeepAliveClientMixin {
  Stream<int> stream;
  @override
  void initState() {
    super.initState();

    stream = Rx.combineLatest2<List<DailyTastyVote>, Set<DiscoverItem>, int>(
        CollectionType.daily_tasty_votes.coll
            .forUser(currentUserReference)
            .orderBy('date', descending: true)
            .limit(200)
            .stream(),
        CollectionType.discover_items.coll
            .visible()
            .orderBy('awards.daily_tasty', descending: true)
            .limit(2)
            .stream<DiscoverItem>()
            .map((x) => x.lastOrNull)
            .map((d) => d.dailyTasty)
            .switchMap((date) => [
                  CollectionType.discover_items.coll
                      .visible()
                      .where('date', isGreaterThanOrEqualTo: date)
                      .stream<DiscoverItem>(),
                  CollectionType.discover_items.coll
                      .visible()
                      .where('imported_at', isGreaterThanOrEqualTo: date)
                      .where('is_instagram_post', isEqualTo: true)
                      .stream<DiscoverItem>()
                      .map((posts) => posts
                          .groupBy((input) => input.userReference)
                          .values
                          .expand((posts) => posts
                              .sorted((post) => post.createTime, desc: true)
                              .take(5)))
                ].combineLatestFlat.map((s) => s.toSet())),
        (a, b) => b
            .map((b) => b.postReference)
            .toSet()
            .difference(a.map((a) => a.post).toSet())
            .length);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<int>(
        stream: stream,
        builder: (context, snapshot) => Visibility(
              visible: (snapshot.data ?? 0) > 0,
              child: Chip(
                  backgroundColor: kSecondaryButtonColor,
                  visualDensity: squeezeDensity,
                  label: Text(
                    '${snapshot.data ?? ''} new',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
            ));
  }

  @override
  bool get wantKeepAlive => true;
}

const squeezeDensity = VisualDensity(
    horizontal: VisualDensity.minimumDensity,
    vertical: VisualDensity.minimumDensity);
