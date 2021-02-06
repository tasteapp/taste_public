import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/components/taste_progress_indicator.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/screens/food_finder/filter_chips.dart';
import 'package:taste/screens/food_finder/food_finder_manager.dart';
import 'package:taste/screens/restaurant/restaurant_page.dart';
import 'package:taste/taste_backend_client/responses/restaurant.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/utils.dart';

const kLeftPadding = 14.0;
const kRightPadding = 16.0;

class MaybeListPage extends StatefulWidget {
  const MaybeListPage({Key key, this.bloc}) : super(key: key);

  final FoodFinderManager bloc;

  @override
  MaybeListPageState createState() => MaybeListPageState();
}

class MaybeListPageState extends State<MaybeListPage> {
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  double dismissExtent = 0.0;
  StreamSubscription<FoodFinderState> subscription;
  List<AlgoliaRestaurant> maybeList;
  LocationInfo location;

  @override
  void initState() {
    super.initState();
    maybeList = widget.bloc.state.maybeList;
    location = widget.bloc.state.location;
    subscription = widget.bloc.listen((s) {
      if (maybeList.length != s.maybeList.length || location != s.location) {
        setState(() {
          maybeList = s.maybeList;
          location = s.location;
        });
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
            top: kFoodFinderFiltersHeight + 30,
            left: 35,
            right: 35,
            bottom: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Match Tracker",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: maybeList.isEmpty
                      ? null
                      : () async {
                          final clearMaybes = await showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return TasteDialog(
                                    title: 'Clear your list of likes?',
                                    buttons: [
                                      TasteDialogButton(
                                          text: 'Cancel',
                                          color: Colors.grey,
                                          onPressed: () =>
                                              Navigator.of(context).pop(false)),
                                      TasteDialogButton(
                                          text: 'Clear',
                                          color: const Color(0xFFe3593d),
                                          onPressed: () =>
                                              Navigator.of(context).pop(true)),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (clearMaybes) {
                            widget.bloc
                                .add(const FoodFinderEvent.clearMaybeList());
                            Navigator.pop(context);
                          }
                        },
                  child: Opacity(
                    opacity: maybeList.isEmpty ? 0.0 : 1.0,
                    child: const Text(
                      "Clear",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFe3593d),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Keep track of the places you've liked here!",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(height: 15.0),
            Expanded(
              child: FadingEdgeScrollView.fromScrollView(
                gradientFractionOnEnd: 0.03,
                gradientFractionOnStart: 0.03,
                child: ListView.separated(
                  controller: ScrollController(),
                  padding: EdgeInsets.zero,
                  itemCount: maybeList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20.0),
                  itemBuilder: (context, index) => Slidable(
                    actionPane: const SlidableBehindActionPane(),
                    secondaryActions: [
                      Container(
                        height: 96,
                        child: IconSlideAction(
                          onTap: () => widget.bloc.add(
                            FoodFinderEvent.removeFromMaybeList(
                              maybeList[index],
                            ),
                          ),
                          caption: 'Delete',
                          color: const Color(0xFFe3593d),
                          icon: Icons.delete,
                        ),
                      ),
                    ],
                    actionExtentRatio: 0.3,
                    child: MaybeListRestoWidget(
                        bloc: widget.bloc,
                        location: location,
                        algoliaRestaurant: maybeList[index],
                        restoIndex: index),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class MaybeListRestoWidget extends StatelessWidget {
  const MaybeListRestoWidget(
      {Key key,
      this.bloc,
      this.location,
      this.algoliaRestaurant,
      this.restoIndex})
      : super(key: key);

  final FoodFinderManager bloc;
  final LocationInfo location;
  final AlgoliaRestaurant algoliaRestaurant;
  final int restoIndex;

  @override
  Widget build(BuildContext context) => StreamBuilder<Restaurant>(
        stream: bloc.getRestaurant(algoliaRestaurant.reference),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const TasteLargeCircularProgressIndicator();
          }
          final restaurant = snapshot.data;
          final loc = location?.location ?? LocationBuilder.of(context);
          final distanceMiles =
              (loc?.distanceMeters(restaurant.location) ?? 1e7) /
                  kMetersPerMile;
          final coverPhoto = algoliaRestaurant.coverPhotos
              .map((p) => CoverPhotoData(firePhoto: p.photo))
              .toList()
              .firstOrNull;
          return InkWell(
            onTap: () {
              TAEvent.food_finder_maybe_list_item({
                'resto_ref': restaurant.reference.path,
              });
              return goToRestaurantPage(restaurant: restaurant);
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Expanded(
                  flex: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          restaurant.name,
                          minFontSize: 13.0,
                          maxFontSize: 16.0,
                          maxLines: 3,
                          style: const TextStyle(
                              fontFamily: "Quicksand",
                              fontSize: 16.0,
                              color: Color(0xFF2F3542),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          distanceMiles < 1
                              ? '${distanceMiles.toStringAsFixed(1)} mi away'
                              : '${distanceMiles.round()} mi away',
                          style: const TextStyle(
                            fontFamily: "Quicksand",
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF2F3542),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 17,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, right: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: coverPhoto == null
                          ? Container()
                          : CoverPhoto(
                              coverPhoto,
                              onTap: () =>
                                  goToRestaurantPage(restaurant: restaurant),
                            ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        },
      );
}
