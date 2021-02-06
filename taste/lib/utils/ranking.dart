import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/taste_backend_client/responses/responses.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;
import 'package:tuple/tuple.dart';

const _placeTypePenalty = {
  $pb.PlaceType.grocery_store: 8,
  $pb.PlaceType.farmers_market: 6,
  $pb.PlaceType.caterer: 6,
  $pb.PlaceType.deli: 5,
  $pb.PlaceType.bakery: 4,
  $pb.PlaceType.dessert_shop: 4,
  $pb.PlaceType.coffee_shop: 4,
  $pb.PlaceType.cafe: 4,
  $pb.PlaceType.donut_shop: 4,
  $pb.PlaceType.bubble_tea_shop: 4,
  $pb.PlaceType.ice_cream_shop: 3,
  $pb.PlaceType.bar: 3,
  $pb.PlaceType.pub: 3,
};

Set<$pb.PlaceType> get restaurantPlaceTypes =>
    $pb.PlaceType.values.toSet().difference(kCafePlaceTypes
        .union(kDessertBakeryPlaceTypes)
        .union(kBarPlaceTypes)
        .union(kIgnorePlaceTypes));

const kCafePlaceTypes = {
  $pb.PlaceType.coffee_shop,
  $pb.PlaceType.bagel_shop,
  $pb.PlaceType.cafe
};

const kDessertBakeryPlaceTypes = {
  $pb.PlaceType.smoothie_and_juice_bar,
  $pb.PlaceType.bubble_tea_shop,
  $pb.PlaceType.cupcake_shop,
  $pb.PlaceType.bakery,
  $pb.PlaceType.dessert_shop,
  $pb.PlaceType.frozen_yogurt_shop,
  $pb.PlaceType.candy_store,
  $pb.PlaceType.gelato_shop,
  $pb.PlaceType.chocolate_shop,
  $pb.PlaceType.shaved_ice_shop,
  $pb.PlaceType.ice_cream_shop
};

const kBarPlaceTypes = {
  $pb.PlaceType.bar,
  $pb.PlaceType.pub,
  $pb.PlaceType.cocktail_bar,
  $pb.PlaceType.wine_bar,
  $pb.PlaceType.brewery,
  $pb.PlaceType.sports_bar,
  $pb.PlaceType.beer_bar,
  $pb.PlaceType.beer_garden,
  $pb.PlaceType.winery_or_vineyard,
  $pb.PlaceType.wine_or_spirits,
  $pb.PlaceType.dive_bar,
  $pb.PlaceType.irish_pub,
  $pb.PlaceType.whisky_bar,
  $pb.PlaceType.sake_bar,
  $pb.PlaceType.speakeasy,
  $pb.PlaceType.tiki_bar
};

const kIgnorePlaceTypes = {
  $pb.PlaceType.PLACE_TYPE_UNDEFINED,
  $pb.PlaceType.fast_food_restaurant,
  $pb.PlaceType.grocery_store,
  $pb.PlaceType.farmers_market,
};

/// Distance penalties, tuple<distance in miles, penalty>
const _distancePenaltyCutoffsMiles = [
  Tuple2(10.0, 6),
  Tuple2(6.0, 4),
  Tuple2(3.0, 3),
  Tuple2(1.0, 2),
  Tuple2(0.2, 1)
];

const _placeTypeThreshold = 0.2;
const _missingReviewsPenalty = 4;

Map<$pb.PlaceType, double> getRelevantTypes(AlgoliaRestaurant resto) {
  final restoPlaceTypes = resto.placeTypes;
  final restoPlaceTypeScores = resto.placeTypeScores;
  return Map.fromEntries(restoPlaceTypes.enumerate
      .where((entry) => restoPlaceTypeScores[entry.key] > _placeTypeThreshold)
      .map((entry) => MapEntry(entry.value, restoPlaceTypeScores[entry.key])));
}

class RestoRanking {
  static List<AlgoliaRestaurant> sort({
    List<AlgoliaRestaurant> restos,
    Set<$pb.PlaceType> placeTypes,
    TasteUser user,
    LatLng location,
  }) {
    placeTypes ??= _placeTypePenalty.keys.toSet();
    // ignore: avoid_types_on_closure_parameters
    final getRankingScore = (AlgoliaRestaurant resto) {
      final relevantTypes = getRelevantTypes(resto);
      final placeTypePenalty = relevantTypes.keys
              .map(
                  (t) => placeTypes.contains(t) ? 0 : _placeTypePenalty[t] ?? 0)
              .max((t) => t) ??
          0;
      var placeTypeFactor = placeTypes.isEmpty
          ? 1.0
          : relevantTypes.entries
                  .map((t) => placeTypes.contains(t.key) ? t.value : 1e-6)
                  .max((t) => t) ??
              1e-6;
      var locationPenalty = 0;
      if (location != null) {
        final distanceMiles =
            resto.location.distanceMeters(location) / kMetersPerMile;
        // Find the first cutoff from distance penalty and set the penalty as
        // one more than the index.
        for (final cutoffs in _distancePenaltyCutoffsMiles) {
          if (distanceMiles > cutoffs.item1) {
            locationPenalty = cutoffs.item2;
            break;
          }
        }
      }
      final missingReviewsPenalty =
          (!resto.yelpMatch ? _missingReviewsPenalty : 0) +
              (!resto.googleMatch ? _missingReviewsPenalty : 0);
      final popularityScore = -resto.popularityScore +
          placeTypePenalty +
          locationPenalty +
          missingReviewsPenalty;
      placeTypeFactor =
          popularityScore < 0 ? placeTypeFactor : 1 / placeTypeFactor;
      return popularityScore * placeTypeFactor;
    };
    return restos.toList()
      ..sort((a, b) => getRankingScore(a).compareTo(getRankingScore(b)));
  }
}
