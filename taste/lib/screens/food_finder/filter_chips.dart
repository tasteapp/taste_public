import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taste/components/icons.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/screens/food_finder/food_finder_manager.dart';
import 'package:taste/screens/restaurant/restaurant_page.dart';
import 'package:taste/screens/restaurant_lookup/restaurant_lookup.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/utils/fb_places_api.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' hide Size;
import 'package:taste/utils/analytics.dart';

const kFoodFinderFiltersHeight = 72.0;
const kFilterChipsHeight = 32.0;

class FoodFinderFilterChips extends StatelessWidget {
  const FoodFinderFilterChips(
      {Key key, this.bloc, this.state, this.panelController})
      : super(key: key);
  final FoodFinderManager bloc;
  final FoodFinderState state;
  final PanelController panelController;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        controller: ScrollController(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 14.0),
        child: Container(
          height: kFoodFinderFiltersHeight,
          child: Center(
            child: Row(
              children: <Widget>[
                SearchButton(),
                FilterButtonChip(
                    bloc: bloc, state: state, panelController: panelController),
                MapButtonChip(bloc: bloc, state: state),
                // DeliveryChip(bloc: bloc, state: state),
                // OpenNowChip(bloc: bloc, state: state),
                // ...createFilterChips(bloc, state),
              ].divide(const SizedBox(width: 12)),
            ),
          ),
        ),
      );
}

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FilterChoiceChip(
      label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.search,
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text('Search', style: getTextStyle(false)),
        ],
      ),
      padding: const EdgeInsets.only(left: 14.0, right: 16.0),
      isSelected: false,
      onSelected: () async {
        TAEvent.food_finder_search();
        final result = await quickPush<FacebookPlaceResult>(
          TAPage.search_place,
          (_) => RestaurantLookup(
            title: 'Search by name',
            searchLocation: LocationBuilder.of(context),
          ),
        );
        if (result != null) {
          await goToRestaurantPage(
              restaurant: await restaurantByFbPlace(result, create: true));
        }
      },
    );
  }
}

class FilterButtonChip extends StatelessWidget {
  const FilterButtonChip({Key key, this.bloc, this.state, this.panelController})
      : super(key: key);
  final FoodFinderManager bloc;
  final FoodFinderState state;
  final PanelController panelController;

  @override
  Widget build(BuildContext context) => FilterChoiceChip(
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FilterIcon.filter,
              size: 12,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text('Filters', style: getTextStyle(false)),
          ],
        ),
        padding: const EdgeInsets.only(left: 16.0, right: 15.0),
        isSelected: false,
        onSelected: state.isLoading
            ? null
            : () async {
                TAEvent.food_finder_expand_filters();
                if (panelController.isPanelClosed) {
                  await panelController.open();
                }
              },
      );
}

class MapButtonChip extends StatelessWidget {
  const MapButtonChip({Key key, this.bloc, this.state}) : super(key: key);
  final FoodFinderManager bloc;
  final FoodFinderState state;

  @override
  Widget build(BuildContext context) => FilterChoiceChip(
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              state.showMap ? Icons.photo_library : Feather.map,
              size: 14,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(state.showMap ? 'Recs' : 'Map', style: getTextStyle(false)),
          ],
        ),
        padding: const EdgeInsets.only(left: 16.0, right: 15.0),
        isSelected: false,
        onSelected: state.isLoading
            ? null
            : () {
                TAEvent.food_finder_toggle_map();
                bloc.add(const FoodFinderEvent.toggleShowMap());
              },
      );
}

TextStyle getTextStyle(bool isSelected) => TextStyle(
    fontFamily: "Montserrat",
    color: isSelected ? const Color(0xFF2F3542) : Colors.white,
    fontSize: 14.0,
    fontWeight: FontWeight.bold);

class DeliveryChip extends StatelessWidget {
  const DeliveryChip({Key key, this.bloc, this.state}) : super(key: key);
  final FoodFinderManager bloc;
  final FoodFinderState state;

  bool get isSelected => state?.filters?.onlyDelivery ?? false;

  @override
  Widget build(BuildContext context) => FilterChoiceChip(
      label: Text('Delivery', style: getTextStyle(isSelected)),
      isSelected: isSelected,
      onSelected: state.isLoading
          ? null
          : () async {
              TAEvent.tapped_filter_chip({'name': 'delivery'});
              final newFilters = state.filters
                  .copyWith(newOnlyDelivery: !state.filters.onlyDelivery);
              await setNewFilters(bloc, state, newFilters: newFilters);
            });
}

class OpenNowChip extends StatelessWidget {
  const OpenNowChip({Key key, this.bloc, this.state}) : super(key: key);
  final FoodFinderManager bloc;
  final FoodFinderState state;

  bool get isSelected => state?.filters?.openNow ?? false;

  @override
  Widget build(BuildContext context) => FilterChoiceChip(
      label: Text('Open Now', style: getTextStyle(isSelected)),
      isSelected: isSelected,
      onSelected: state.isLoading
          ? null
          : () async {
              TAEvent.tapped_filter_chip({'name': 'open_now'});
              final newFilters =
                  state.filters.copyWith(newOpenNow: !state.filters.openNow);
              await setNewFilters(bloc, state, newFilters: newFilters);
            });
}

List<Widget> createFilterChips(FoodFinderManager bloc, FoodFinderState state) {
  final categories = state?.filters?.placeCategories ?? {};
  return [
    PlaceCategory.restaurants,
    PlaceCategory.cafes,
    PlaceCategory.desserts,
    PlaceCategory.bars,
  ].map((c) {
    final isSelected = categories.contains(c);
    return FilterChoiceChip(
        label: Text(categoryToString(c), style: getTextStyle(isSelected)),
        isSelected: isSelected,
        onSelected: state.isLoading
            ? null
            : () async {
                TAEvent.tapped_filter_chip({'name': c.toString()});
                final newFilters = state.filters.copyWith(
                    newPlaceTypes: {},
                    newPlaceCategories: isSelected
                        ? <PlaceCategory>{...categories, c}
                        : <PlaceCategory>{...categories}
                      ..remove(c));
                await setNewFilters(bloc, state, newFilters: newFilters);
              });
  }).toList();
}

class FilterChoiceChip extends StatelessWidget {
  const FilterChoiceChip(
      {Key key, this.label, this.isSelected, this.onSelected, this.padding})
      : super(key: key);
  final Widget label;
  final bool isSelected;
  final Function() onSelected;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onSelected,
        child: Container(
          height: kFilterChipsHeight,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.black45,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 17.0),
            child: Center(child: label),
          ),
        ),
      );
}
