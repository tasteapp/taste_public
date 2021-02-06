import 'package:flutter/material.dart';
import 'package:taste/taste_backend_client/responses/restaurant.dart';
import 'package:taste/utils/utils.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList(
      {Key key,
      @required this.restaurants,
      this.showRemoveIcon = false,
      this.removeCallback})
      : super(key: key);
  final Iterable<Restaurant> restaurants;
  final bool showRemoveIcon;
  final void Function(Restaurant) removeCallback;

  @override
  Widget build(BuildContext context) {
    if (restaurants == null || restaurants.isEmpty) {
      return Center(
        child: Container(
          width: 300,
          child: const Text(
            'Start adding your favorite places.\nYou can add as many as 3 '
            'places per city. After your 20th post, you get 5 picks per city!',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    final favoritesByCity = groupRestaurantsBySimpleAddress(restaurants);
    return ListView(
      cacheExtent: MediaQuery.of(context).size.height * 3,
      children: favoritesByCity
          .map((city, restos) {
            var cityItems = [
              // City header.
              ListTile(
                key: Key('$city-header'),
                contentPadding: const EdgeInsets.only(top: 10),
                title: Text(
                  city,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Lato',
                    color: Colors.grey[800],
                  ),
                ),
              ),
              ...restos.map((restaurant) {
                return ListTile(
                  key: Key(restaurant.reference.path),
                  title: Text(restaurant.name),
                  leading: const Icon(Icons.restaurant),
                  trailing: showRemoveIcon
                      ? IconButton(
                          icon: const Icon(Icons.remove_circle),
                          color: Colors.red,
                          onPressed: () {
                            if (removeCallback != null) {
                              removeCallback(restaurant);
                            }
                          },
                        )
                      : null,
                );
              }).toList()
            ];

            return MapEntry(
              city,
              ListTile(
                key: Key(city),
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: cityItems,
                ),
              ),
            );
          })
          .values
          .toList(),
    );
  }
}
