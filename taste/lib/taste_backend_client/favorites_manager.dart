/// Simply a wrapper around a StreamProvider so that disposing is taken care of.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/utils/analytics.dart';

import 'backend.dart';
import 'responses/restaurant.dart';

enum FavoriteStatus {
  ok,
  limit,
  dupe,
}

extension FSExt on FavoriteStatus {
  bool get isOk => this == FavoriteStatus.ok;
  bool get isError => !isOk;
  String get _message => {
        FavoriteStatus.limit:
            'Favorites limit reached for city: You need to remove a favorite before adding another to this city.',
        FavoriteStatus.dupe: 'Restaurant already favorited.',
        FavoriteStatus.ok: 'ok',
      }[this];
  void maybeSnackbar() => isError ? snackBarString(_message) : null;
}

class _Favorites {
  _Favorites(this.favorites);
  final List<Restaurant> favorites;
}

final favoritesProvider = StreamProvider(
    lazy: false, create: (c) => favoritesStream().map((s) => _Favorites(s)));

Future<FavoriteStatus> addFavorite(
    BuildContext context, Restaurant restaurant) async {
  final favorites =
      (Provider.of<_Favorites>(context, listen: false).favorites ?? []).toSet();

  final limit =
      ((await restaurantPostsStream.firstNonNull)?.length ?? 0) >= 20 ? 5 : 3;
  if (favorites.contains(restaurant)) {
    TAEvent.favorites_duplicate_place();

    return FavoriteStatus.dupe;
  }
  if (favorites.where((e) => e.address == restaurant.address).length >= limit) {
    TAEvent.favorites_city_limits_reached();
    return FavoriteStatus.limit;
  }
  TAEvent.favorites_added();
  await restaurant.favorite();
  return FavoriteStatus.ok;
}
