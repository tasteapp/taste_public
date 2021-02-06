import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/mapbox_api.dart';
import 'package:taste/utils/utils.dart';

class LocationLookup extends StatelessWidget {
  const LocationLookup(
      {Key key, this.title, this.includeCurrentLocation = false})
      : super(key: key);
  final String title;
  final bool includeCurrentLocation;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: AutoSizeText(
          title ?? 'Location Search',
          style: kAppBarTitleStyle,
          overflow: TextOverflow.ellipsis,
          maxFontSize: 24,
          minFontSize: 12,
          maxLines: 1,
        ),
        elevation: 0,
        actions: includeCurrentLocation
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: InkWell(
                    onTap: () => Navigator.pop(
                        context, const MapboxAutocompleteResult()),
                    child: const Icon(Icons.gps_fixed, color: Colors.blue),
                  ),
                )
              ]
            : null,
      ),
      body: LocationBuilder(
        builder: (context, latLng, status) =>
            TypeAheadField<MapboxAutocompleteResult>(
          // get results quicker. default is 300ms.
          debounceDuration: const Duration(milliseconds: 200),
          textFieldConfiguration: TextFieldConfiguration(
            textCapitalization: TextCapitalization.words,
            autofocus: true,
            controller: textController,
            keyboardType: TextInputType.multiline,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontStyle: FontStyle.italic),
            decoration: const InputDecoration(
              hintText: "Search for address, city or location...",
              border: OutlineInputBorder(),
            ),
          ),
          suggestionsCallback: (pattern) async {
            latLng ??= status.done ? null : await myLocation(1.seconds);
            return MapBoxApi.autocomplete(pattern, latLng);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              key: Key(suggestion.name),
              leading: Icon({
                    MapboxDataType.poi: Icons.store,
                    MapboxDataType.address: Icons.place,
                    MapboxDataType.place: Icons.location_city,
                    MapboxDataType.region: Icons.outlined_flag,
                  }[suggestion.type] ??
                  Icons.place),
              title: Text(
                suggestion.type == MapboxDataType.poi
                    ? suggestion.name
                    : suggestion.fullName,
              ),
              // Make the subtitle address only. We need to remove the name
              // from the fullName to get the address. Weird Mapbox API.
              subtitle: suggestion.type == MapboxDataType.poi
                  ? Text(suggestion.fullName
                      .replaceAll('${suggestion.name}, ', ''))
                  : null,
            );
          },
          onSuggestionSelected: (suggestion) {
            TAEvent.selected_loc_lookup_suggestion({
              'search_term': textController.text,
              'letters': textController.text.length,
              'name': suggestion.name,
            });
            Navigator.pop(context, suggestion);
          },
        ),
      ),
    );
  }
}
