import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taste/screens/food_finder/food_finder.dart';
import 'package:taste/screens/food_finder/food_finder_manager.dart';
import 'package:taste/screens/location_lookup.dart';
import 'package:taste/screens/restaurant/restaurant_page.dart' show kAppLogo;
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/mapbox_api.dart';
import 'package:taste/utils/unfocusable.dart';
import 'package:taste_protos/taste_protos.dart' hide LatLng;
import 'package:taste/taste_backend_client/geocoding_manager.dart';

TextStyle filterPageStyle(
        {FontWeight weight,
        Color color = const Color(0xFF2F3542),
        double opacity = 1.0,
        double size = 18.0}) =>
    TextStyle(
        fontFamily: "SF Compact Text",
        fontWeight: weight,
        color: color.withOpacity(opacity),
        fontSize: size);

class FoodFinderFiltersPanel extends StatefulWidget {
  const FoodFinderFiltersPanel({
    Key key,
    this.filters,
    this.location,
    this.changes,
    this.panelController,
  }) : super(key: key);
  final FoodFilters filters;
  final LocationInfo location;
  final StateChanges changes;
  final PanelController panelController;

  @override
  FoodFinderFiltersPanelState createState() => FoodFinderFiltersPanelState();
}

class FoodFinderFiltersPanelState extends State<FoodFinderFiltersPanel> {
  FoodFilters get filters => widget.changes?.filters ?? widget.filters;
  String cuisineSearchText = '';

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Stack(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: InkWell(
                    onTap: () async {
                      TAEvent.food_finder_filters_cancel();
                      keyboardUnfocus(context);
                      await widget.panelController.close();
                    },
                    child: Text(
                      "Cancel",
                      style: filterPageStyle(opacity: 0.5),
                    ),
                  ),
                ),
              ),
              Center(
                child: InkWell(
                  child: Text(
                    "Settings",
                    style: filterPageStyle(weight: FontWeight.w600),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: InkWell(
                    onTap: () {
                      TAEvent.food_finder_filters_apply();
                      keyboardUnfocus(context);
                      setState(() => Provider.of<FoodFinderWidgetState>(context,
                              listen: false)
                          .changes
                          .apply = true);
                      widget.panelController.close();
                    },
                    child: Text(
                      "Done",
                      style: filterPageStyle(color: Colors.blue),
                    ),
                  ),
                ),
              )
            ]),
            const SizedBox(height: 20.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  LocationDisplayWidget(
                    changes: widget.changes,
                    location: widget.location,
                  ),
                  const SettingsSeparatorWidget(height: 22.0),
                  const SizedBox(height: 14.0),
                  SetRadiusWidget(
                      changes: widget.changes, filters: widget.filters),
                  const SettingsSeparatorWidget(height: 26.0),
                  const SizedBox(height: 12.0),
                  Center(
                    child: Text(
                      "Popular",
                      style: filterPageStyle(
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  CheckboxListWidget(filters: [
                    CheckboxFilter(
                      displayText: "Delivery",
                      isChecked: filters.onlyDelivery,
                      onChanged: (checked) => setState(() =>
                          widget.changes.filters =
                              filters.copyWith(newOnlyDelivery: checked)),
                    ),
                    CheckboxFilter(
                      displayText: "Open Now",
                      isChecked: filters.openNow,
                      onChanged: (checked) => setState(() => widget.changes
                          .filters = filters.copyWith(newOpenNow: checked)),
                    ),
                    ...[
                      PlaceCategory.restaurants,
                      PlaceCategory.cafes,
                      PlaceCategory.desserts,
                      PlaceCategory.bars,
                    ].map(
                      (c) => CheckboxFilter(
                        displayText: categoryToString(c),
                        isChecked: filters.placeCategories.contains(c),
                        onChanged: (checked) => categoryOnChanged(
                          filters.placeCategories.contains(c)
                              ? filters.placeCategories.difference({c})
                              : filters.placeCategories.union({c}),
                        ),
                      ),
                    ),
                  ]),
                  const SettingsSeparatorWidget(height: 50.0),
                  if (filters.onlyDelivery)
                    DeliveryProvidersWidget(
                      changes: widget.changes,
                      filters: widget.filters,
                      location: widget.location,
                    ),
                  if (filters.onlyDelivery)
                    const SettingsSeparatorWidget(height: 50.0),
                  Center(
                      child: Text("Cuisines",
                          style: filterPageStyle(weight: FontWeight.w600))),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        contentPadding: EdgeInsets.zero,
                        suffixIcon: cuisineSearchText.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                      autofocus: false,
                      autocorrect: false,
                      onChanged: (value) =>
                          setState(() => cuisineSearchText = value),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  CheckboxListWidget(
                    filters: (cuisineSearchText.isEmpty
                            ? PlaceType.values.skip(1).take(20)
                            : placeTypeSearch
                                .search(cuisineSearchText)
                                .map((result) => result.object))
                        .map(
                          (p) => CheckboxFilter(
                            displayText: p.displayString,
                            isChecked: filters.placeTypes.contains(p),
                            onChanged: (checked) => setState(
                              () => widget.changes.filters = filters.copyWith(
                                  newPlaceTypes: filters.placeTypes.contains(p)
                                      ? filters.placeTypes.difference({p})
                                      : filters.placeTypes.union({p}),
                                  newPlaceCategories: {},
                                  newDeliveryProviders: {}),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16.0),
                ]),
              ),
            )
          ],
        ),
      );

  void categoryOnChanged(Set<PlaceCategory> newCategories) {
    setState(() => widget.changes.filters = filters.copyWith(
        newPlaceTypes: {},
        newPlaceCategories: newCategories,
        newDeliveryProviders: {}));
  }
}

class CheckboxFilter extends StatelessWidget {
  const CheckboxFilter(
      {this.displayText, this.fontWeight, this.isChecked, this.onChanged});
  final String displayText;
  final FontWeight fontWeight;
  final bool isChecked;
  final Function(bool checked) onChanged;

  @override
  Widget build(BuildContext context) {
    Widget display;
    if (displayText.contains('.png')) {
      display = Image.asset(
        displayText,
        width: 100,
      );
    } else {
      display = AutoSizeText(
        displayText,
        style: filterPageStyle(weight: fontWeight),
        maxLines: 2,
        minFontSize: 12,
        overflow: TextOverflow.ellipsis,
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 25,
      child: CheckboxListTile(
        title: display,
        value: isChecked,
        onChanged: onChanged,
        dense: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

class CheckboxListWidget extends StatefulWidget {
  const CheckboxListWidget({Key key, this.filters}) : super(key: key);
  final List<Widget> filters;

  @override
  CheckboxListWidgetState createState() => CheckboxListWidgetState();
}

class CheckboxListWidgetState extends State<CheckboxListWidget> {
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: checkboxRows(widget.filters).divide(
            const SizedBox(height: 8.0),
          )));

  List<Widget> checkboxRows(List<Widget> filters) =>
      Iterable<int>.generate((filters.length / 2).ceil())
          .map((i) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    filters.sublist(2 * i, min(2 * i + 2, filters.length)),
              ))
          .toList();
}

class DeliveryProvidersWidget extends StatefulWidget {
  const DeliveryProvidersWidget(
      {Key key, this.filters, this.changes, this.location})
      : super(key: key);
  final FoodFilters filters;
  final StateChanges changes;
  final LocationInfo location;

  @override
  DeliveryProvidersWidgetState createState() => DeliveryProvidersWidgetState();
}

class DeliveryProvidersWidgetState extends State<DeliveryProvidersWidget> {
  bool inTX;

  FoodFilters get filters => widget.changes?.filters ?? widget.filters;

  @override
  Widget build(BuildContext context) {
    getAddress(widget.location.setLocation ?? widget.location.currentLocation)
        .then((value) {
      setState(() {
        inTX = value.adminAreaShort == "TX";
      });
    });
    return (inTX == null)
        ? Container()
        : Column(children: [
            Center(
              child: Text(
                "Delivery Providers",
                style: filterPageStyle(
                  weight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            CheckboxListWidget(
                filters: [
              'ubereats',
              'postmates',
              'doordash',
              'caviar',
              'grubhub',
              'seamless',
              if (inTX) 'favor',
            ]
                    .map(
                      (c) => CheckboxFilter(
                        displayText: kAppLogo[c],
                        isChecked: filters.deliveryProviders.contains(c),
                        onChanged: (checked) => deliveryOnChanged(
                          filters.deliveryProviders.contains(c)
                              ? filters.deliveryProviders.difference({c})
                              : filters.deliveryProviders.union({c}),
                        ),
                      ),
                    )
                    .toList())
          ]);
  }

  void deliveryOnChanged(Set<String> newDelivery) {
    setState(() => widget.changes.filters = filters.copyWith(
        newPlaceTypes: {},
        newPlaceCategories: {},
        newDeliveryProviders: newDelivery));
  }
}

class SettingsSeparatorWidget extends StatelessWidget {
  const SettingsSeparatorWidget(
      {Key key, this.color = Colors.grey, this.height = 40.0})
      : super(key: key);
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) => Divider(
        color: color,
        height: height,
        thickness: 0.0,
        indent: 20,
        endIndent: 20,
      );
}

class LocationDisplayWidget extends StatefulWidget {
  const LocationDisplayWidget({Key key, this.changes, this.location})
      : super(key: key);
  final StateChanges changes;
  final LocationInfo location;

  @override
  LocationDisplayWidgetState createState() => LocationDisplayWidgetState();
}

class LocationDisplayWidgetState extends State<LocationDisplayWidget> {
  LocationInfo get location => widget.changes?.location ?? widget.location;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () async {
          final result = await Navigator.push<MapboxAutocompleteResult>(
            context,
            MaterialPageRoute(
                builder: (context) => const LocationLookup(
                      title: "Set Location",
                      includeCurrentLocation: true,
                    )),
          );
          if (result == null) {
            TAEvent.empty_result_from_loc_lookup();
            return;
          }
          TAEvent.selected_loc_lookup_suggestion();
          print('setting location to ${result.name}');
          widget.changes.location = result.name == null
              ? location.withoutSetLocation()
              : location.withSetLocation(result.name, result.location);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Location", style: filterPageStyle()),
              Row(children: [
                Text(
                  location.setLocation == null
                      ? "Your Location"
                      : location.name,
                  style: filterPageStyle(),
                ),
                const SizedBox(width: 8.0),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ]),
            ],
          ),
        ),
      );
}

class SetRadiusWidget extends StatefulWidget {
  const SetRadiusWidget({Key key, this.filters, this.changes})
      : super(key: key);
  final FoodFilters filters;
  final StateChanges changes;

  @override
  SetRadiusWidgetState createState() => SetRadiusWidgetState();
}

class SetRadiusWidgetState extends State<SetRadiusWidget> {
  double currentRadius;

  @override
  void initState() {
    super.initState();
    currentRadius = filters.radius;
  }

  FoodFilters get filters => widget.changes?.filters ?? widget.filters;

  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            "Distance",
            style: filterPageStyle(
              weight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 9.0),
        Wrap(
          children: [
            radioButton(0.5),
            radioButton(2.0),
            radioButton(4.0),
            radioButton(8.0),
            radioButton(12.0),
            radioButton(20.0),
          ],
        ),
      ]);

  Widget radioButton(double radius) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 120),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: '$radius mi',
            groupValue: '$currentRadius mi',
            onChanged: (value) {
              setState(() {
                currentRadius = double.parse(value.split(' mi')[0]);
                widget.changes.filters =
                    filters.copyWith(newRadius: currentRadius);
              });
            },
          ),
          Text('$radius mi', style: filterPageStyle()),
        ],
      ),
    );
  }
}
