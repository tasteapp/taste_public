import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/taste_backend_client/responses/badge.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste_protos/taste_protos.dart'
    show Badge_CityChampion_City, Badge_BadgeType;

class CityChampion {
  const CityChampion._(
      this.badge, this.city, this.searchTerms, this.label, this.user);
  factory CityChampion.create(Badge badge, Badge_CityChampion_City city) {
    final searchTerms = [
      city.city,
      city.country,
      city.state,
      stateAbbreviations[city.state],
      stateAbbreviations.inverse[city.state],
    ].withoutEmpties.join(' ').toLowerCase().split(' ').toSet();
    return CityChampion._(
        badge, city, searchTerms, city.summary, badge.userReference);
  }
  final Badge badge;
  final Badge_CityChampion_City city;
  final Set<String> searchTerms;
  final String label;
  final DocumentReference user;
  int matches(Set<String> queryTerms) => queryTerms
      .where((t) => searchTerms.any((s) => s.contains(t)))
      .toSet()
      .length;
}

class SearchCityChampionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = SuggestionsBoxController();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search City Guv'nah", style: kAppBarTitleStyle),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<CityChampion>>(
              future: CollectionType.badges.coll
                  .where('count_data.count', isGreaterThan: 0)
                  .where('type', isEqualTo: Badge_BadgeType.city_champion.name)
                  .fetch<Badge>()
                  .then((badges) => badges
                      .expand((badge) => badge.proto.cityChampionData.cities
                          .map((e) => CityChampion.create(badge, e)))
                      .sorted((a) => a.city.city)
                      .toList()),
              builder: (context, snapshot) {
                final cities = snapshot.data;
                return TypeAheadField<CityChampion>(
                  hideSuggestionsOnKeyboardHide: false,
                  animationDuration: const Duration(),
                  textFieldConfiguration: TextFieldConfiguration(
                      textCapitalization: TextCapitalization.words,
                      onSubmitted: (_) => Future.microtask(controller.open),
                      autofocus: true,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          hintText: "Search by city, state, or country")),
                  suggestionsCallback: (t) {
                    if (t.trim().isEmpty || cities == null) {
                      return [];
                    }
                    final queryTerms =
                        t.toLowerCase().split(' ').withoutEmpties.toSet();
                    return cities
                        .zipWith((city) => city.matches(queryTerms))
                        // Prioritize country/state-wide badges by sorting by
                        // 1. # of (city,state) entries that are not empty ASC
                        // 2. Token matches DESC
                        .tupleSort((s) => [
                              s.a.searchTerms.where((e) => e.isNotEmpty).length,
                              -s.b
                            ])
                        .where((s) => s.b > 0)
                        .a
                        .toList();
                  },
                  getImmediateSuggestions: true,
                  hideOnEmpty: true,
                  keepSuggestionsOnLoading: true,
                  suggestionsBoxController: controller,
                  itemBuilder: (context, city) => ListTile(
                      title: Text(city.label),
                      subtitle: StreamBuilder<TasteUser>(
                          stream: city.user.stream(),
                          builder: (context, snapshot) =>
                              Text(snapshot.data?.name ?? '')),
                      leading: ProfilePhoto(
                        user: city.user,
                        radius: 20,
                      )),
                  onSuggestionSelected: (city) => city.badge.goTo(),
                );
              }),
        ));
  }
}
