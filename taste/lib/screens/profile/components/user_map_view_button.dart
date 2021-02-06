import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/screens/map/map_bloc.dart';
import 'package:taste/screens/map/map_page.dart';
import 'package:taste/screens/map/map_utils.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/utils/utils.dart';

Future goToUserMapView(BuildContext context, TasteUser user) async {
  final favoritesFuture = user.favorites.first;
  final reviews = (await user.restaurantPosts.first)
      .where((review) => review.latLng != null)
      .toList();
  final favorites = await favoritesFuture;
  if (reviews.isEmpty && favorites.isEmpty) {
    await showDialog(
        context: context,
        builder: (context) => SimpleDialog(
                title: const Text("No Posts to Display"),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(user.isMe
                        ? "Post your next 🍽️ or add your favorite restaurant 🏆 using Taste and it'll show up here on the Taste Map 🌍!"
                        : "${user.name} does not have any posts 😔. Tell them to post their next 🍽️ on Taste so you can 👀 it out!"),
                  )
                ]));
    return;
  }
  final screenSize = MediaQuery.of(context).size;
  final mapSize =
      Size(screenSize.width, screenSize.height - kBottomNavigationBarHeight);
  TAEvent.clicked_user_map({'map_user': user.path});
  LatLngBounds userBounds =
      pointsBounds(reviews.map((review) => review.latLng));
  await quickPush(
      TAPage.user_map,
      (_) => MapPage(
          initialPosition: CameraPosition(
              target: center(userBounds),
              zoom: calculateZoomToFit(userBounds, mapSize)),
          mapBlocBuilder: (context) => MapBloc(context,
              reviews: reviews,
              favorites:
                  favorites.map(AlgoliaRestaurant.fromRestaurant).toList(),
              user: user)));
}
