import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taste/components/icons.dart';
import 'package:taste/screens/restaurant/restaurant_page.dart';
import 'package:taste/screens/restaurant_lookup/restaurant_lookup.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/favorites_manager.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/responses/restaurant.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/buttons.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/fb_places_api.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/photo_regexp.dart';

import 'post_interface.dart';

const kFavoriteImageHeight = 112.0;
const kFavoriteImageWidth = 102.0;

class FavoritesFeedWidget extends StatefulWidget {
  const FavoritesFeedWidget({Key key, @required this.user}) : super(key: key);

  final TasteUser user;

  @override
  _FavoritesFeedWidgetState createState() => _FavoritesFeedWidgetState();
}

class _FavoritesFeedWidgetState extends State<FavoritesFeedWidget>
    with AutomaticKeepAliveClientMixin<FavoritesFeedWidget> {
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
  }

  static _FavoritesFeedWidgetState of(BuildContext context) =>
      Provider.of<_FavoritesFeedWidgetState>(context, listen: false);
  set editing(bool editing) => setState(() => isEditing = editing);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<Restaurant>>(
      stream: widget.user.favorites,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final restaurants = snapshot.data;
        final favoritesByCity = groupRestaurantsBySimpleAddress(restaurants);
        final cities = favoritesByCity.keys.where((x) => x.isNotEmpty).toList();
        return CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
              // This is the flip side of the SliverOverlapAbsorber above.
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    if (snapshot.data.isEmpty) {
                      return Provider.value(
                        value: this,
                        child: NoFavoritesWidget(user: widget.user),
                      );
                    }
                    if (!widget.user.isMe) {
                      return const SizedBox(height: 30.0);
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TasteButton(
                            text: "Edit Favorites",
                            iconData: EditFavoritesIcon.editFavorites,
                            onPressed: () {
                              TAEvent.clicked_edit_favorites();
                              setState(() => isEditing = !isEditing);
                            },
                            options: TasteButtonOptions(
                              color: isEditing
                                  ? kSecondaryButtonColor
                                  : Colors.white,
                              textColor: const Color(0xFF3A3B41),
                              borderSide: const BorderSide(
                                  color: Color(0xD8D8D8D8), width: 1.0),
                            ),
                          ),
                          Provider.value(
                            value: this,
                            child: AddRestaurantButton(user: widget.user),
                          ),
                        ],
                      ),
                    );
                  }
                  // (index - 1) to account for edit favorites button.
                  final city = cities[index - 1];
                  final restos = favoritesByCity[city];
                  return CityFavoritesWidget(
                    key: Key('CityFavoritesWidget_$city'),
                    city: city,
                    restos: restos,
                    user: widget.user,
                    isEditing: isEditing,
                  );
                },
                childCount: favoritesByCity.keys.length + 1,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CityFavoritesWidget extends StatelessWidget {
  const CityFavoritesWidget(
      {Key key,
      @required this.city,
      @required this.restos,
      @required this.user,
      this.isEditing})
      : super(key: key);

  final String city;
  final List<Restaurant> restos;
  final TasteUser user;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final cityTitle = Text(
      city,
      style: const TextStyle(
          fontFamily: "Quicksand",
          color: kPrimaryButtonColor,
          fontSize: 18.0,
          shadows: [
            Shadow(
              color: Color(0xFFE5E5E5),
              offset: Offset(0.0, 2.0),
              blurRadius: 6.0,
            )
          ],
          fontWeight: FontWeight.w700),
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(21.0, 0.0, 10.0, 0.0),
      child: Column(children: [
        Align(alignment: Alignment.centerLeft, child: cityTitle),
        const SizedBox(height: 12.0),
        Container(
          height: 210,
          child: ListView.builder(
            cacheExtent: MediaQuery.of(context).size.width * 3,
            primary: true,
            scrollDirection: Axis.horizontal,
            itemCount: restos.length,
            itemBuilder: (context, index) {
              return RestaurantFavoriteWidget(
                key: Key('RestaurantFavoriteWidget_${city}_$index'),
                restaurant: restos[index],
                user: user,
                isEditing: isEditing,
              );
            },
          ),
        ),
      ]),
    );
  }
}

class RestaurantFavoriteWidget extends StatelessWidget {
  const RestaurantFavoriteWidget(
      {Key key, @required this.restaurant, @required this.user, this.isEditing})
      : super(key: key);

  final Restaurant restaurant;
  final TasteUser user;
  final bool isEditing;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            Container(
              width: kFavoriteImageWidth + 10,
              height: kFavoriteImageHeight + 10,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () async =>
                          goToRestaurantPage(restaurant: restaurant),
                      child: Container(
                        width: kFavoriteImageWidth,
                        height: kFavoriteImageHeight,
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            side: BorderSide(
                              width: 1,
                              color: Color(0xFFE5E5E5),
                            ),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: RestaurantCoverPhoto(restaurant: restaurant),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Visibility(
                      visible: isEditing,
                      child: InkWell(
                        onTap: () => restaurant.favorite(enable: false),
                        child:
                            Image.asset("assets/ui/delete_favorite_icon.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7.0),
            Container(
              width: kFavoriteImageWidth,
              child: Text(
                restaurant.name,
                style: const TextStyle(
                    fontFamily: "Quicksand",
                    color: Color(0xFF6D7278),
                    fontSize: 16.0,
                    shadows: [
                      Shadow(
                        color: Color(0xFFE5E5E5),
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      )
                    ],
                    fontWeight: FontWeight.w700),
                maxLines: 3,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      );
}

class RestaurantCoverPhoto extends StatelessWidget {
  const RestaurantCoverPhoto(
      {Key key, @required this.restaurant, this.reviews = const []})
      : super(key: key);

  final Restaurant restaurant;
  final List<DiscoverItem> reviews;

  @override
  Widget build(BuildContext context) => reviews.isNotEmpty
      ? ReviewPicture(review: reviews.first)
      : FutureBuilder<String>(
          future: restaurant.profilePicture,
          builder: (_, snapshot) {
            if (snapshot.data?.isEmpty ?? false) {
              return TastePicture(restaurant: restaurant);
            }
            return fixedFirePhoto(snapshot.data ?? '')
                .progressive(Resolution.medium, null, BoxFit.cover);
          },
        );
}

class ReviewPicture extends StatelessWidget {
  const ReviewPicture({Key key, @required this.review}) : super(key: key);

  final Post review;

  @override
  Widget build(BuildContext context) =>
      review.firePhoto.thumbnail(BoxFit.cover);
}

class TastePicture extends StatelessWidget {
  const TastePicture({Key key, @required this.restaurant}) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<CoverPhotoData>>(
        stream: restaurant.reviewPhotos,
        builder: (context, snapshot) {
          if (snapshot.data?.isEmpty ?? false) {
            return GoogleMapsCoverPhoto(restaurant: restaurant);
          }
          return (snapshot.data?.first?.firePhoto ?? emptyFirePhoto)
              .thumbnail(BoxFit.cover);
        });
  }
}

class GoogleMapsCoverPhoto extends StatelessWidget {
  const GoogleMapsCoverPhoto({Key key, @required this.restaurant})
      : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return FutureBuilder<String>(
        future: getProfileCoverPhoto(screenSize),
        builder: (_, snapshot) =>
            fixedFirePhoto(snapshot.data ?? '').thumbnail(BoxFit.cover));
  }

  Future<String> getProfileCoverPhoto(Size screenSize) async {
    List<CoverPhotoData> coverPhotos =
        await getGoogleCoverPhotos(restaurant, null, screenSize);
    if (coverPhotos.isEmpty) {
      return null;
    }
    return coverPhotos.first.firePhoto.url(Resolution.medium);
  }
}

class NoFavoritesWidget extends StatefulWidget {
  const NoFavoritesWidget({Key key, @required this.user}) : super(key: key);

  final TasteUser user;

  @override
  NoFavoritesWidgetState createState() => NoFavoritesWidgetState();
}

class NoFavoritesWidgetState extends State<NoFavoritesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 45),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 72.0),
            Text(
              widget.user.isMe
                  ? 'Show off your top 3 spots in different cities!'
                  : "${widget.user.name} hasn't added any favorites.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Quicksand",
                color: Color(0xFF6D7278),
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (widget.user.isMe)
              Padding(
                  padding: const EdgeInsets.only(top: 42.0),
                  child: AddRestaurantButton(user: widget.user, isFirst: true))
            else
              Container(),
          ],
        ),
      ),
    );
  }
}

class AddRestaurantButton extends StatelessWidget {
  const AddRestaurantButton({Key key, this.user, this.isFirst = false})
      : super(key: key);

  final TasteUser user;
  final bool isFirst;

  @override
  Widget build(BuildContext context) => StreamBuilder<int>(
      stream: null,
      builder: (context, snapshot) {
        final state = _FavoritesFeedWidgetState.of(context);
        return TasteButton(
          text: isFirst ? "Add Favorite" : "Add",
          iconData: Icons.add,
          onPressed: () async {
            final result = await quickPush<FacebookPlaceResult>(
                TAPage.add_favorite,
                (context) => const RestaurantLookup(title: "Add Favorite"));
            (await addFavorite(
                    context, await restaurantByFbPlace(result, create: true)))
                .maybeSnackbar();
            state.editing = false;
          },
          options: kDefaultButtonOptions.copyWith(
            color: Colors.white,
            textColor:
                isFirst ? kPrimaryButtonColor : kDarkGrey.withOpacity(0.7),
            borderSide: const BorderSide(color: Color(0xD8D8D8D8), width: 1.0),
          ),
        );
      });
}
