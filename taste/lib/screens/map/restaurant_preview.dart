import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/screens/food_finder/food_finder.dart';
import 'package:taste/screens/food_finder/food_finder_manager.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/ranking.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'map_bloc.dart';

const double kFractionScreenWidth = 1;
const double kRestaurantPreviewHeight = 140;

class RestaurantPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = MapBloc.of(context);
    Size screenSize = MediaQuery.of(context).size;
    return ValueListenableBuilder<int>(
      valueListenable: mapBloc.state.scrollerState.historyLengthNotifier,
      builder: (context, scrollerLength, _) => Container(
        height: kRestaurantPreviewHeight + 5,
        width: screenSize.width * kFractionScreenWidth,
        child: PageView.builder(
          onPageChanged: mapBloc.onPreviewPageChanged,
          controller: mapBloc.state.scrollerState.controller,
          itemCount: scrollerLength,
          itemBuilder: (context, i) {
            return FutureBuilder<AlgoliaRestaurant>(
              future: mapBloc.scrollerMarker(i).resto,
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final restaurant = snapshot.data;
                return Stack(
                  overflow: Overflow.visible,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: InkWell(
                        onTap: () async {
                          await mapBloc.tappedPreview(context, i);
                        },
                        child: Card(
                          elevation: 3,
                          color: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: RestaurantPreviewWidget(
                                  restaurant: restaurant,
                                  mapLocation: mapBloc
                                      ?.foodFinderState?.location?.location,
                                  index: i),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 10,
                      child: FoodFinderActionsWidget(
                        key: Key(
                            "FoodFinderActionsMap_${restaurant.name ?? ""}"),
                        bloc: mapBloc.manager,
                        onDislikePressed: () {
                          mapBloc.foodFinderState.createFoodFinderAction(
                              restaurant.coverPhotos,
                              $pb.FoodFinderAction_ActionType.pass);
                          mapBloc.manager.add(FoodFinderEvent.setNoList(
                              Set<AlgoliaRestaurant>.of(
                                  mapBloc.foodFinderState.noList)
                                ..add(restaurant)));
                          mapBloc.manager.add(FoodFinderEvent.setMaybeList(
                              List<AlgoliaRestaurant>.of(
                                  mapBloc.foodFinderState.maybeList)
                                ..remove(restaurant)));
                          mapBloc.state.scrollerState.controller.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.ease,
                          );
                        },
                        onLikePressed: () {
                          mapBloc.foodFinderState.createFoodFinderAction(
                            restaurant.coverPhotos,
                            $pb.FoodFinderAction_ActionType.add_to_list,
                          );
                          mapBloc.manager.add(FoodFinderEvent.setNoList(
                              Set<AlgoliaRestaurant>.of(
                                  mapBloc.foodFinderState.noList)
                                ..remove(restaurant)));
                          mapBloc.manager.add(FoodFinderEvent.setMaybeList(
                              List<AlgoliaRestaurant>.of(
                                  mapBloc.foodFinderState.maybeList)
                                ..add(restaurant)));
                          mapBloc.state.scrollerState.controller.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.ease,
                          );
                          unawaited(mapBloc.manager
                              .loadRestaurant(restaurant.reference));
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class RestaurantPreviewWidget extends StatelessWidget {
  const RestaurantPreviewWidget(
      {Key key, this.restaurant, this.mapLocation, this.index})
      : super(key: key);
  final AlgoliaRestaurant restaurant;
  final LatLng mapLocation;
  final int index;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 11,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12.0),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.5,
                  ),
                  child: AutoSizeText(
                    restaurant.name,
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
                getRelevantTypes(restaurant)
                        .keys
                        .map((x) => x.displayString)
                        .where((x) => x.isNotEmpty)
                        .isEmpty
                    ? Container()
                    : FittedBox(
                        child: CategoriesRowWidget(restaurant: restaurant)),
                const SizedBox(height: 8.0),
                if (mapLocation != null)
                  RestoDistanceWidget(
                    currentLocation: mapLocation,
                    restoLocation: restaurant.location,
                    fontSize: 14.0,
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: restaurant.googleMatch && restaurant.yelpMatch
                ? Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: FittedBox(
                      child: RatingsWidget(restaurant: restaurant),
                    ),
                  )
                : Container(),
          ),
        ],
      );
}
