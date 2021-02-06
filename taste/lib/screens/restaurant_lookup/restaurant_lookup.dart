import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/fb_places_api.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart'
    show Restaurant_Attributes_Address;

part 'restaurant_lookup.freezed.dart';

@freezed
abstract class RestaurantChoice with _$RestaurantChoice {
  const factory RestaurantChoice.homeCooked() = _HomeCooked;
  const factory RestaurantChoice.empty() = _Empty;
  const factory RestaurantChoice.place(FacebookPlaceResult fbPlace) = _Place;
}

class RestaurantLookup extends StatelessWidget {
  const RestaurantLookup({
    Key key,
    this.title,
    this.homeCookedOption,
    this.searchLocation,
  }) : super(key: key);
  final String title;
  final bool homeCookedOption;
  bool get showHomeCooked => homeCookedOption ?? false;
  final LatLng searchLocation;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          title ?? 'Place Search',
          style: kAppBarTitleStyle,
          overflow: TextOverflow.ellipsis,
          maxFontSize: 24,
          minFontSize: 12,
          maxLines: 1,
        ),
        actions: [
          showHomeCooked
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlineButton(
                      visualDensity: const VisualDensity(
                        vertical: VisualDensity.minimumDensity,
                        horizontal: VisualDensity.minimumDensity,
                      ),
                      onPressed: () => Navigator.pop(
                          context, const RestaurantChoice.homeCooked()),
                      child: const AutoSizeText("Home\ncooked",
                          minFontSize: 10, maxFontSize: 14, maxLines: 2)),
                )
              : null
        ].withoutNulls,
      ),
      body: LocationBuilder(
        builder: (context, latLng, status) =>
            TypeAheadField<FacebookPlaceResult>(
          // get results quicker. default is 300ms.
          debounceDuration: const Duration(milliseconds: 100),
          textFieldConfiguration: TextFieldConfiguration(
              textCapitalization: TextCapitalization.words,
              autofocus: true,
              controller: textController,
              keyboardType: TextInputType.multiline,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: const InputDecoration(
                  hintText:
                      "Search for restaurants & bars, by name / location...",
                  border: OutlineInputBorder())),
          suggestionsCallback: (pattern) async {
            latLng ??= status.done
                ? null
                : await myLocation(const Duration(seconds: 1));
            print('Search location: $searchLocation');
            final results = await FacebookPlacesManager.instance.nearbyPlaces(
                location: searchLocation ?? latLng, term: pattern);
            if (results.isEmpty) {
              TAEvent.empty_place_lookup({'pattern': pattern});
            }
            return results;
          },
          itemBuilder: (context, suggestion) {
            final Widget address = FutureBuilder<Restaurant_Attributes_Address>(
                future: findAddress(suggestion, suggestion.location),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return AutoSizeText(snapshot.data.detailed, maxLines: 1);
                });
            return ListTile(
              key: Key(suggestion.id),
              leading: const Icon(Icons.restaurant),
              title: Text(suggestion.name),
              subtitle: address,
            );
          },
          onSuggestionSelected: (suggestion) {
            TAEvent.selected_place_lookup_suggestion({
              'search_term': textController.text,
              'letters': textController.text.length,
              'fb_name': suggestion.name,
              'fb_id': suggestion.id
            });
            Navigator.pop(context, suggestion);
          },
        ),
      ),
    );
  }
}

Future<RestaurantChoice> searchForRestaurantPush(
    {String title, bool homeCookedOption}) async {
  final value = await quickPush(
      TAPage.search_place,
      (_) =>
          RestaurantLookup(title: title, homeCookedOption: homeCookedOption));
  return value == null
      ? const RestaurantChoice.empty()
      : value is RestaurantChoice
          ? value
          : RestaurantChoice.place(value as FacebookPlaceResult);
}
