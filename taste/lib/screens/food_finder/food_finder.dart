import 'dart:async';
import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:quiver/iterables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/components/icons.dart';
import 'package:taste/components/taste_progress_indicator.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/screens/discover/components/expand_widget.dart';
import 'package:taste/screens/food_finder/filter_chips.dart';
import 'package:taste/screens/food_finder/filters_page.dart';
import 'package:taste/screens/food_finder/food_finder_manager.dart';
import 'package:taste/screens/food_finder/food_photo_gallery.dart';
import 'package:taste/screens/food_finder/maybe_list.dart';
import 'package:taste/screens/map/map_bloc.dart';
import 'package:taste/screens/map/map_page.dart';
import 'package:taste/screens/map/map_utils.dart';
import 'package:taste/screens/restaurant/restaurant_page.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/responses/restaurant.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/buttons.dart';
import 'package:taste/theme/style.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/ranking.dart';
import 'package:taste/utils/utils.dart';

const kSwipeEdge = 10.0;
const kFoodFinderBottomHeight = 95.0;
const kFoodFinderInfoHeight = 170.0;
const kProfilePicOverlap = 42.0;

class FoodFinderPage extends StatefulWidget {
  const FoodFinderPage();

  @override
  FoodFinderPageState createState() => FoodFinderPageState();
}

class FoodFinderPageState extends State<FoodFinderPage> {
  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child:
          FoodFinderWidget(bloc: BlocProvider.of<FoodFinderManager>(context)));
}

class FoodFinderWidget extends StatefulWidget {
  const FoodFinderWidget({this.bloc});
  final FoodFinderManager bloc;

  @override
  FoodFinderWidgetState createState() => FoodFinderWidgetState();
}

class FoodFinderWidgetState extends State<FoodFinderWidget>
    with AutomaticKeepAliveClientMixin {
  FoodFinderState state;
  StateChanges changes;
  StreamSubscription<FoodFinderState> subscription;
  final PanelController panelController = PanelController();
  PreloadPageController pageController;
  final onboardingPageController = PageController();
  bool showOnboarding = false;

  @override
  void initState() {
    super.initState();
    checkOnboarding();
    state = widget.bloc.state;
    changes = StateChanges();
    pageController = PreloadPageController(initialPage: state.currentIndex);
    subscription = widget.bloc.listen((s) {
      if (const ListEquality()
              .equals(s.currentRestoIds, state.currentRestoIds) &&
          state.filters.equals(s.filters) &&
          state.isLoading == s.isLoading &&
          state.showMap == s.showMap) {
        return;
      }
      setState(() => state = s);
    });
    if (widget.bloc.state.currentRestos.isEmpty) {
      loadRestaurants(widget.bloc, widget.bloc.state);
    }
  }

  static const _onboardingKey = 'food-finder-onboarding-v0';
  Future<void> checkOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    showOnboarding = !(prefs.getBool(_onboardingKey) ?? false);
  }

  Future<void> onboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_onboardingKey, true);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  bool get hasChanges =>
      (changes.filters != null && !state.filters.equals(changes.filters)) ||
      (changes.location != null &&
          state.location.location != changes.location.location);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExpandableProvider(
      child: LocationBuilder(
        builder: (context, location, status) => Scaffold(
          endDrawer: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.black45,
              child: MaybeListPage(bloc: widget.bloc),
            ),
          ),
          body: status == Status.disabled ||
                  status == Status.permanentlyDisabled
              ? EnableLocationWidget()
              : state.allRestos.isEmpty
                  ? const TasteLargeCircularProgressIndicator()
                  : Stack(children: [
                      state.showMap
                          ? MapPage(
                              initialPosition: CameraPosition(
                                target: center(state.restoBounds),
                                zoom: calculateZoomToFit(
                                  state.restoBounds,
                                  Size(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height -
                                          kBottomNavigationBarHeight),
                                ),
                              ),
                              mapBlocBuilder: (context) => MapBloc(context,
                                  favorites: state.currentRestos,
                                  manager: widget.bloc),
                              isFoodFinder: true,
                            )
                          : PreloadPageView.builder(
                              preloadPagesCount: 2,
                              onPageChanged: (index) {
                                if (index > widget.bloc.state.currentIndex) {
                                  TAEvent.food_finder_swipe_right({
                                    'resto_ref': widget
                                        .bloc.state.currentResto.reference.path
                                  });
                                } else {
                                  TAEvent.food_finder_swipe_left({
                                    'resto_ref': widget
                                        .bloc.state.currentResto.reference.path
                                  });
                                }
                                widget.bloc.add(
                                    FoodFinderEvent.setCurrentIndex(index));
                              },
                              controller: pageController,
                              itemCount:
                                  math.max(state.currentRestos.length, 1),
                              itemBuilder: (context, i) => state
                                      .currentRestos.isEmpty
                                  ? state.isLoading
                                      ? Container()
                                      : LayoutBuilder(
                                          builder: (context, constraints) =>
                                              NoMoreRestosWidget(
                                            bloc: widget.bloc,
                                            state: state,
                                            maxHeight: constraints.maxHeight,
                                          ),
                                        )
                                  : LayoutBuilder(
                                      builder: (context, constraints) =>
                                          FoodFinderRestoWidget(
                                        key: Key(
                                            "RestoWidget_${state.currentRestos[i]}"),
                                        bloc: widget.bloc,
                                        state: widget.bloc.state,
                                        pageController: pageController,
                                        restaurant:
                                            widget.bloc.state.currentRestos[i],
                                        restoIndex: i,
                                        maxHeight: constraints.maxHeight,
                                      ),
                                    ),
                            ),
                      LayoutBuilder(
                        builder: (context, constraints) =>
                            Provider<FoodFinderWidgetState>.value(
                          value: this,
                          child: SlidingUpPanel(
                            isDraggable: false,
                            controller: panelController,
                            backdropEnabled: true,
                            backdropTapClosesPanel: true,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            minHeight: 0.0,
                            maxHeight: constraints.maxHeight -
                                kFoodFinderFiltersHeight,
                            panel: FoodFinderFiltersPanel(
                              filters: widget.bloc.state.filters,
                              location: widget.bloc.state.location,
                              changes: changes,
                              panelController: panelController,
                            ),
                            onPanelSlide: (fraction) {
                              if (fraction < 0.5 &&
                                  ExpandableProvider.of(context,
                                      listen: false)) {
                                ExpandableProvider.setExpanded(context, false);
                                return;
                              }
                              if (fraction > 0.5 &&
                                  !ExpandableProvider.of(context,
                                      listen: false)) {
                                ExpandableProvider.setExpanded(context, true);
                                return;
                              }
                            },
                            onPanelClosed: () {
                              if (!changes.apply || !hasChanges) {
                                setState(() => changes = StateChanges());
                                return;
                              }
                              if (!state.showMap) {
                                pageController.jumpToPage(0);
                              }
                              loadRestaurants(widget.bloc, widget.bloc.state,
                                  changes: changes);
                              setState(() => changes = StateChanges());
                            },
                          ),
                        ),
                      ),
                      ControlsOverlayWidget(
                        bloc: widget.bloc,
                        filtersSlidingPanelController: panelController,
                      ),
                      if (showOnboarding)
                        OnboardingWidget(
                          onDismiss: () {
                            onboardingDone();
                            setState(() => showOnboarding = false);
                          },
                        ),
                    ]),
        ),
      ),
    );
  }
}

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({Key key, @required this.onDismiss}) : super(key: key);
  final VoidCallback onDismiss;

  @override
  _OnboardingWidgetState createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  final controller = PreloadPageController();

  @override
  Widget build(BuildContext context) {
    const onboardingStyle = TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600);
    return Stack(
      children: [
        PreloadPageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              color: kDarkGrey.withOpacity(0.92),
              child: Stack(
                children: [
                  Align(
                    alignment: const Alignment(-0.7, 0.0),
                    child: Container(
                      width: 90,
                      child: const Text(
                        'Tap here to see the prior photo',
                        textAlign: TextAlign.center,
                        style: onboardingStyle,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.7, 0.0),
                    child: Container(
                      width: 90,
                      child: const Text(
                        'Tap here to see the next photo',
                        textAlign: TextAlign.center,
                        style: onboardingStyle,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.85),
                    child: TasteButton(
                      text: 'Next (1/2)',
                      onPressed: () => setState(
                        () {
                          controller.nextPage(
                            duration: 150.millis,
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                      options: kSimpleButtonOptions.copyWith(
                        fontSize: 16.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: kDarkGrey.withOpacity(0.92),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RawMaterialButton(
                              onPressed: () {},
                              fillColor: Colors.white,
                              padding:
                                  const EdgeInsets.fromLTRB(13, 16, 13, 10),
                              shape: CircleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  color: Colors.grey[300],
                                ),
                              ),
                              child: const Icon(
                                LikeButton.like,
                                color: kPrimaryButtonColor,
                                size: 26,
                              ),
                            ),
                            Container(
                              width: 250,
                              child: const Text(
                                'Tap this if you like what you see.'
                                "\nWe'll add it to your current list.",
                                style: onboardingStyle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RawMaterialButton(
                              onPressed: () {},
                              fillColor: Colors.white,
                              padding: const EdgeInsets.all(16.0),
                              shape: CircleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  color: Colors.grey[300],
                                ),
                              ),
                              child: const Icon(
                                DislikeButton.dislike,
                                color: kSecondaryButtonColor,
                                size: 20,
                              ),
                            ),
                            Container(
                              width: 250,
                              child: const Text(
                                'Tap this if you want to skip the rec.'
                                "\nWe'll show you less of those places.",
                                style: onboardingStyle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 80),
                        Container(
                          width: 250,
                          child: const Text(
                            'The more you use it the better our '
                            'recommendations get!',
                            style: onboardingStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.85),
                    child: TasteButton(
                      text: 'Get Started!',
                      onPressed: widget.onDismiss,
                      options: kSimpleButtonOptions.copyWith(
                        fontSize: 16.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ControlsOverlayWidget extends StatelessWidget {
  const ControlsOverlayWidget({
    Key key,
    this.bloc,
    this.filtersSlidingPanelController,
  }) : super(key: key);
  final FoodFinderManager bloc;
  final PanelController filtersSlidingPanelController;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: ExpandableProvider.of(context),
      child: AnimatedOpacity(
        duration: 150.millis,
        opacity: ExpandableProvider.of(context) ? 0.0 : 1.0,
        child: Stack(children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: kFoodFinderFiltersHeight,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FoodFinderFilterChips(
                    bloc: bloc,
                    state: bloc.state,
                    panelController: filtersSlidingPanelController,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.93, 0.0),
            child: InkWell(
              onTap: () {
                TAEvent.food_finder_maybe_list();
                Scaffold.of(context).openEndDrawer();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: const Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ),
          MaybeListNumber(bloc: bloc),
        ]),
      ),
    );
  }
}

class MaybeListNumber extends StatefulWidget {
  const MaybeListNumber({this.bloc});
  final FoodFinderManager bloc;

  @override
  MaybeListNumberState createState() => MaybeListNumberState();
}

class MaybeListNumberState extends State<MaybeListNumber> {
  StreamSubscription<FoodFinderState> subscription;
  int numMaybes = 0;

  @override
  void initState() {
    super.initState();
    numMaybes = widget.bloc.state.maybeList.length;
    subscription = widget.bloc.listen((s) {
      if (s.maybeList.length != numMaybes) {
        setState(() => numMaybes = s.maybeList.length);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => numMaybes <= 0
      ? Container()
      : Align(
          alignment: const Alignment(0.96, -0.05),
          child: InkWell(
            onTap: () {
              TAEvent.food_finder_maybe_list();
              Scaffold.of(context).openEndDrawer();
            },
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: kPrimaryButtonColor,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Center(
                child: Text(
                  numMaybes.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
}

class FoodFinderRestoWidget extends StatefulWidget {
  const FoodFinderRestoWidget({
    Key key,
    this.bloc,
    this.state,
    this.pageController,
    this.restaurant,
    this.restoIndex,
    this.maxHeight,
  }) : super(key: key);
  final FoodFinderManager bloc;
  final FoodFinderState state;
  final PreloadPageController pageController;
  final AlgoliaRestaurant restaurant;
  final int restoIndex;
  final double maxHeight;

  @override
  FoodFinderRestoWidgetState createState() => FoodFinderRestoWidgetState();
}

class FoodFinderRestoWidgetState extends State<FoodFinderRestoWidget> {
  final PanelController panelController = PanelController();
  final ScrollController scrollController = ScrollController();
  double fractionSlid = 0.0;
  double cumulativeDrag = 0;
  bool showDiscoverItems = false;

  double get panelPosition =>
      panelController.isAttached ? panelController.panelPosition : 0.0;

  @override
  Widget build(BuildContext context) {
    TextPainter nameWidget = TextPainter(
        text: TextSpan(
          text: widget.restaurant.name,
          style: const TextStyle(
              fontFamily: "Quicksand",
              color: Color(0xFF2F3542),
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout();
    bool longName = nameWidget.width > MediaQuery.of(context).size.width * 0.5;
    return SlidingUpPanel(
      controller: panelController,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      backdropEnabled: true,
      backdropTapClosesPanel: true,
      minHeight: widget.restaurant.hasDelivery
          ? longName ? 185 : 170
          : longName ? 160 : 145,
      maxHeight: widget.maxHeight - MediaQuery.of(context).padding.top - 10,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      collapsed: widget.state.isLoading || fractionSlid == 1.0
          ? Container(color: Colors.transparent)
          : Opacity(
              opacity: 1.0 - fractionSlid,
              child: CollapsedRestoPage(
                bloc: widget.bloc,
                state: widget.state,
                pageController: widget.pageController,
                panelController: panelController,
                restaurant: widget.restaurant,
                coverPhotos: widget.restaurant.coverPhotos,
              ),
            ),
      panel: Opacity(
        opacity: fractionSlid,
        child: Listener(
          onPointerMove: (opm) async {
            if (panelController.isPanelClosed ||
                panelController.isPanelAnimating ||
                scrollController.offset > 0) {
              return;
            }
            if (opm.delta.dy > 0) {
              if (cumulativeDrag > 50) {
                await panelController.close();
                setState(() => cumulativeDrag = 0);
                return;
              }
              setState(() => cumulativeDrag += opm.delta.dy);
            } else {
              setState(() => cumulativeDrag = 0);
            }
          },
          child: StreamBuilder<Restaurant>(
              stream: widget.bloc.getRestaurant(widget.restaurant.reference),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return const TasteLargeCircularProgressIndicator();
                }
                return RestaurantContent(
                  restaurant: snapshot.data,
                  scrollController: scrollController,
                  isFoodFinder: true,
                  showDiscoverItems: showDiscoverItems,
                );
              }),
        ),
      ),
      body: Stack(
        children: [
          FoodFinderContent(
            bloc: widget.bloc,
            state: widget.state,
            restaurant: widget.restaurant,
            pageController: widget.pageController,
            maxHeight: widget.maxHeight,
          ),
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.33),
                    Colors.transparent,
                  ],
                ),
              ),
              height: 120,
            ),
          ),
        ],
      ),
      onPanelSlide: (fraction) {
        if (fraction < 0.1) {
          if (fractionSlid != 0.0) {
            setState(() => fractionSlid = 0.0);
            ExpandableProvider.setExpanded(context, false);
          }
          return;
        }
        if (fraction > 0.9) {
          if (fractionSlid != 1.0) {
            setState(() => fractionSlid = 1.0);
            ExpandableProvider.setExpanded(context, true);
          }
          return;
        }
        if ((fraction - fractionSlid).abs() > 0.1) {
          setState(() => fractionSlid = fraction);
        }
      },
      onPanelOpened: () {
        TAEvent.food_finder_expand_resto({
          'resto_ref': widget.state.currentResto.reference.path,
        });
        setState(() => showDiscoverItems = true);
      },
      onPanelClosed: () {
        TAEvent.food_finder_collapse_resto({
          'resto_ref': widget.state.currentResto.reference.path,
        });
        setState(() => showDiscoverItems = false);
      },
    );
  }
}

class CollapsedRestoPage extends StatefulWidget {
  const CollapsedRestoPage(
      {Key key,
      this.bloc,
      this.state,
      this.pageController,
      this.panelController,
      this.restaurant,
      this.coverPhotos})
      : super(key: key);
  final FoodFinderManager bloc;
  final FoodFinderState state;
  final PreloadPageController pageController;
  final PanelController panelController;
  final AlgoliaRestaurant restaurant;
  final List<$pb.CoverPhoto> coverPhotos;

  @override
  CollapsedRestoPageState createState() => CollapsedRestoPageState();
}

class CollapsedRestoPageState extends State<CollapsedRestoPage> {
  @override
  Widget build(BuildContext context) => Stack(
        overflow: Overflow.visible,
        children: [
          InkWell(
            onTap: () async => widget.panelController.open(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.5,
                        ),
                        child: AutoSizeText(
                          widget.restaurant.name,
                          maxLines: 2,
                          style: const TextStyle(
                              fontFamily: "Quicksand",
                              color: Color(0xFF2F3542),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                          minFontSize: 13.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      CategoriesRowWidget(restaurant: widget.restaurant),
                      DeliveryRowWidget(restaurant: widget.restaurant),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: RestoDistanceWidget(
                          currentLocation: widget?.state?.location?.location,
                          restoLocation: widget.restaurant.location,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  RatingsWidget(restaurant: widget.restaurant),
                ],
              ),
            ),
          ),
          Positioned(
            top: -kProfilePicRadius * 1.3,
            left: MediaQuery.of(context).size.width / 2 -
                kProfilePicRadius * 1.25,
            child: FutureBuilder<String>(
              future: widget.restaurant?.profilePicture,
              builder: (context, snapshot) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      offset: Offset.fromDirection(math.pi / 4),
                    )
                  ],
                ),
                child: CircleAvatar(
                  radius: kProfilePicRadius,
                  backgroundImage: snapshot.hasData
                      ? CachedNetworkImageProvider(snapshot.data)
                      : null,
                  backgroundColor: Color.alphaBlend(
                    kPrimaryButtonColor.withOpacity(0.1),
                    Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 13,
            right: 0,
            child: FoodFinderActionsWidget(
              bloc: widget.bloc,
              pageController: widget.pageController,
              coverPhotos: widget.coverPhotos,
            ),
          ),
        ],
      );
}

List<DiscoverItem> visibleDiscoverItems(List<DiscoverItem> discoverItems) =>
    topNCoverPhotos(discoverItems)
        .map((p) => p.review as DiscoverItem)
        .toList();

class FoodFinderContent extends StatelessWidget {
  const FoodFinderContent(
      {this.bloc,
      this.state,
      this.restaurant,
      this.pageController,
      this.maxHeight});
  final FoodFinderManager bloc;
  final FoodFinderState state;
  final AlgoliaRestaurant restaurant;
  final PreloadPageController pageController;
  final double maxHeight;

  @override
  Widget build(BuildContext context) => state.isLoading
      ? const Align(
          alignment: Alignment.center,
          child: TasteLargeCircularProgressIndicator(),
        )
      : RestaurantPhotoCard(
          bloc: bloc, restaurant: restaurant, maxHeight: maxHeight);
}

class NoMoreRestosWidget extends StatelessWidget {
  const NoMoreRestosWidget({
    Key key,
    this.bloc,
    this.state,
    this.maxHeight,
  }) : super(key: key);

  final FoodFinderManager bloc;
  final FoodFinderState state;
  final double maxHeight;

  @override
  Widget build(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height - 8.0,
      width: MediaQuery.of(context).size.width - 8.0,
      child: Align(
        alignment: const Alignment(0.0, -0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 18,
              ),
              child: Text(
                state.hasFilters
                    ? 'No more matching restaurants in your area.\n\n'
                        'Try expanding the radius or changing the filters.'
                    : "Sorry, we don't have any restaurants in your area.\n\n"
                        "Try expanding the radius.",
                softWrap: true,
                style: TextStyle(
                  fontFamily: "Quickspan",
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TasteButton(
              text: 'Reset',
              options: kSimpleButtonOptions,
              onPressed: () async {
                final resetFilters = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return TasteDialog(
                          title: 'Reset all filters, likes, and dislikes?',
                          buttons: [
                            TasteDialogButton(
                                text: 'Cancel',
                                color: Colors.grey,
                                onPressed: () =>
                                    Navigator.of(context).pop(false)),
                            TasteDialogButton(
                                text: 'Reset',
                                color: const Color(0xFFe3593d),
                                onPressed: () =>
                                    Navigator.of(context).pop(true)),
                          ],
                        );
                      },
                    ) ??
                    false;
                if (resetFilters) {
                  bloc
                    ..add(const FoodFinderEvent.setCurrentIndex(0))
                    ..add(FoodFinderEvent.setMaybeList(
                        List<AlgoliaRestaurant>.empty(growable: true)))
                    ..add(FoodFinderEvent.setNoList(
                        List<AlgoliaRestaurant>.empty().toSet()));
                  loadRestaurants(bloc, state,
                      changes: StateChanges(
                          filters: FoodFilters(radius: state.filters.radius)));
                }
              },
            ),
          ],
        ),
      ));
}

class EnableLocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            height: constraints.maxHeight,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.4,
                  child: Align(
                    alignment: const Alignment(0.0, -1.05),
                    child: Container(
                      height: 400,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/us_map.jpg"),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.0, -1.05),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                    ),
                    child: Container(
                      height: 400,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/lost_travolta.gif"),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 410.0,
                  left: 0,
                  right: 0,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0.0,
                        left: 40.0,
                        right: 40.0,
                      ),
                      child: Text(
                        "In order to recommend restaurants near you, we need to know where you are.\n\n"
                        "Please enable location permissions for Taste in your settings 😊",
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: "Quickspan",
                          fontSize: 19,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: TasteButton(
                        text: 'Settings',
                        options:
                            kTastePrimaryButtonOptions.copyWith(fontSize: 16),
                        onPressed: () async {
                          await PermissionHandler().openAppSettings();
                          // Repeatedly queries to see if location has been granted.
                          for (var i = 0; i < 10; i++) {
                            await putLocation;
                            await 4.seconds.wait;
                          }
                        },
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      );
}

class FoodFinderActionsWidget extends StatelessWidget {
  const FoodFinderActionsWidget({
    Key key,
    this.bloc,
    this.pageController,
    this.coverPhotos,
    this.onDislikePressed,
    this.onLikePressed,
  }) : super(key: key);
  final FoodFinderManager bloc;
  final PreloadPageController pageController;
  final List<$pb.CoverPhoto> coverPhotos;
  final void Function() onDislikePressed;
  final void Function() onLikePressed;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RawMaterialButton(
            onPressed: onDislikePressed ??
                () {
                  bloc.add(FoodFinderEvent.addToNoList(coverPhotos));
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.ease);
                },
            elevation: 3.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(16.0),
            shape: CircleBorder(
              side: BorderSide(
                width: 2.0,
                color: Colors.grey[300],
              ),
            ),
            child: const Icon(
              DislikeButton.dislike,
              color: kSecondaryButtonColor,
              size: 20,
            ),
          ),
          RawMaterialButton(
            onPressed: onLikePressed ??
                () {
                  bloc.add(FoodFinderEvent.addToMaybeList(coverPhotos));
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.ease);
                },
            elevation: 3.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.fromLTRB(13, 16, 13, 10),
            shape: CircleBorder(
              side: BorderSide(
                width: 2.0,
                color: Colors.grey[300],
              ),
            ),
            child: const Icon(
              LikeButton.like,
              color: kPrimaryButtonColor,
              size: 26,
            ),
          ),
        ],
      );
}

class RestaurantPhotoCard extends StatefulWidget {
  const RestaurantPhotoCard({this.bloc, this.restaurant, this.maxHeight});
  final FoodFinderManager bloc;
  final AlgoliaRestaurant restaurant;
  final double maxHeight;

  @override
  RestaurantPhotoCardState createState() => RestaurantPhotoCardState();
}

class RestaurantPhotoCardState extends State<RestaurantPhotoCard> {
  @override
  Widget build(BuildContext context) {
    final coverPhotos = widget.restaurant.coverPhotos
        .map((p) => CoverPhotoData(firePhoto: p.photo))
        .toList();
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: widget.maxHeight,
      width: screenSize.width,
      child: FoodPhotoGallery(
        key: Key("FoodFinderGallery_${widget.restaurant.name}"),
        bloc: widget.bloc,
        restaurantRef: widget.restaurant.reference,
        coverPhotos: coverPhotos,
        photoHeight: widget.maxHeight,
        bottomPadding: 220,
      ),
    );
  }
}

class _CoverPhoto {
  const _CoverPhoto(
      this.indexInPost, this.numInstaLikes, this.photo, this.discoverItem);

  final int indexInPost;
  final int numInstaLikes;
  final FirePhoto photo;
  final DiscoverItem discoverItem;
}

List<CoverPhotoData> topNCoverPhotos(
  List<DiscoverItem> discoverItems, {
  int numPhotos = 20,
}) {
  final photos = discoverItems
      .map((d) => d.firePhotos.enumerate
          .map((f) => _CoverPhoto(f.key, d.proto.numInstaLikes, f.value, d)))
      .flatten;
  final maxLikes = max(photos.map((p) => p.numInstaLikes)) ?? 0 + 1;
  return photos
      // Sort by likes prioritizing earlier photos in multi-photo posts.
      .sorted((p) => p.indexInPost - p.numInstaLikes / maxLikes)
      .take(numPhotos)
      .map((p) => CoverPhotoData(review: p.discoverItem, firePhoto: p.photo))
      .toList();
}

class CategoriesRowWidget extends StatelessWidget {
  const CategoriesRowWidget({Key key, this.restaurant}) : super(key: key);

  final AlgoliaRestaurant restaurant;

  @override
  Widget build(BuildContext context) {
    if (restaurant == null) {
      return Container();
    }
    final filteredCategories = getRelevantTypes(restaurant)
        .keys
        .map((x) => x.displayString)
        .where((x) => x.isNotEmpty)
        .toList();
    if (filteredCategories.isEmpty) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: filteredCategories
            .take(2)
            .enumerate
            .map(
              (category) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.3,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kSecondaryCategoryBackgroundColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      child: AutoSizeText(
                        category.value,
                        maxLines: 1,
                        minFontSize: 11,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: kDarkGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class DeliveryRowWidget extends StatelessWidget {
  const DeliveryRowWidget({Key key, this.restaurant}) : super(key: key);

  final AlgoliaRestaurant restaurant;

  @override
  Widget build(BuildContext context) {
    if (restaurant == null) {
      return Container();
    }
    final hasDelivery = restaurant.hasDelivery;
    if (!hasDelivery) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.3,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryButtonColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              child: AutoSizeText(
                "Delivery",
                maxLines: 1,
                minFontSize: 11,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: kDarkGrey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RatingsWidget extends StatelessWidget {
  const RatingsWidget({this.restaurant});
  final AlgoliaRestaurant restaurant;

  @override
  Widget build(BuildContext context) => restaurant.googleMatch &&
          restaurant.yelpMatch
      ? Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoogleOrYelpRating(isGoogle: true, algoliaRestaurant: restaurant),
            GoogleOrYelpRating(isGoogle: false, algoliaRestaurant: restaurant),
          ],
        )
      : Container();
}

class RestoDistanceWidget extends StatelessWidget {
  const RestoDistanceWidget(
      {this.currentLocation, this.restoLocation, this.fontSize});
  final LatLng currentLocation;
  final LatLng restoLocation;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final loc = currentLocation ?? LocationBuilder.of(context);
    final distanceMiles =
        (loc?.distanceMeters(restoLocation) ?? 1e7) / kMetersPerMile;
    return Text(
      distanceMiles < 1
          ? '${distanceMiles.toStringAsFixed(1)} mi away'
          : '${distanceMiles.round()} mi away',
      style: TextStyle(
        fontFamily: "Quicksand",
        fontSize: fontSize ?? 15,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF75A563),
      ),
    );
  }
}





