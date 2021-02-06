import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as google;
import 'package:pedantic/pedantic.dart';
import 'package:photo_view/photo_view.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:quiver/collection.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/components/icons.dart';
import 'package:taste/components/taste_progress_indicator.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/screens/discover/components/discover_item_widget.dart';
import 'package:taste/screens/discover/components/expand_widget.dart';
import 'package:taste/screens/food_finder/food_photo_gallery.dart';
import 'package:taste/screens/map/map_page.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/screens/restaurant/google_places.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/responses/restaurant.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/fb_places_api.dart';
import 'package:taste/utils/fire_photo.dart';
import 'package:taste/utils/mapbox_api.dart';
import 'package:taste/utils/posts_list_provider.dart';
import 'package:taste/utils/ranking.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/photo_regexp.dart';
import 'package:taste_protos/extensions.dart';
import 'package:taste_protos/taste_protos.dart'
    show
        FirePhoto,
        Restaurant_DeliveryInfo,
        Restaurant_DeliveryUrl,
        Restaurant_DeliveryAppInfo,
        Restaurant_Hours,
        Restaurant_HoursInfo;
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class CoverPhotoData {
  const CoverPhotoData({this.review, this.firePhoto});
  final Post review;
  final FirePhoto firePhoto;
}

double coverPhotoHeight(BuildContext context) =>
    min(MediaQuery.of(context).size.height * 0.7, 500.0);

Future<void> goToRestaurantPage(
    {Restaurant restaurant, FacebookPlaceResult fbPlaceResult}) async {
  return quickPush(
    TAPage.restaurant_page,
    (context) =>
        RestaurantPage(restaurant: restaurant, fbPlaceResult: fbPlaceResult),
  );
}

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key key, this.restaurant, this.fbPlaceResult})
      : super(key: key);
  final Restaurant restaurant;
  final FacebookPlaceResult fbPlaceResult;

  @override
  Widget build(BuildContext context) {
    if (restaurant != null && !restaurant.proto.googleMatch ||
        !restaurant.proto.yelpMatch) {
      TAEvent.resto_missing_ratings({'resto_ref': restaurant.reference.path});
    }
    Future<Restaurant> restoFuture;
    if (restaurant == null) {
      restoFuture = restaurantByFbPlace(fbPlaceResult, create: true);
    } else {
      restoFuture = Future.value(restaurant);
    }
    return LocationBuilder(
      builder: (context, latLng, status) {
        return Scaffold(
          body: FutureBuilder<Restaurant>(
            future: restoFuture,
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final restaurant = snapshot.data;
              return Stack(
                children: [
                  RestaurantContent(
                      restaurant: restaurant, fbPlaceResult: fbPlaceResult),
                  IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.33),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      height: 120,
                    ),
                  ),
                  RestaurantAppBar(
                    restaurant: restaurant,
                    fbPlaceResult: fbPlaceResult,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class RestaurantAppBar extends StatelessWidget {
  const RestaurantAppBar({this.restaurant, this.fbPlaceResult});
  final Restaurant restaurant;
  final FacebookPlaceResult fbPlaceResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          brightness: Brightness.dark,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            // AddFavoriteButton(restaurant: restaurant.reference),
            // GoToRestaurantOnMapButton(restaurant: restaurant),
          ]),
    );
  }
}

const kProfilePicRadius = 36.0;

class RestaurantContent extends StatelessWidget {
  const RestaurantContent(
      {this.restaurant,
      this.fbPlaceResult,
      this.scrollController,
      this.isFoodFinder = false,
      this.showDiscoverItems = false});
  final Restaurant restaurant;
  final FacebookPlaceResult fbPlaceResult;
  final ScrollController scrollController;
  final bool isFoodFinder;
  final bool showDiscoverItems;

  @override
  Widget build(BuildContext context) {
    Widget coverPhotos;
    if (restaurant == null) {
      coverPhotos = GoogleMapsPhotos(restaurant, fbPlaceResult);
    } else {
      coverPhotos = StreamBuilder<List<CoverPhotoData>>(
          stream: restaurant.reviewPhotos,
          builder: (_, snapshot) => (snapshot.data?.isEmpty ?? false)
              ? GoogleMapsPhotos(restaurant, fbPlaceResult)
              : CoverPhotosWidget(snapshot.data));
    }
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.zero,
      primary: scrollController == null ? true : null,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      children: [
        LayoutBuilder(
          builder: (context, constraints) => Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                height: isFoodFinder ? 100.0 : coverPhotoHeight(context),
                child: coverPhotos,
              ),
              Positioned(
                top: (isFoodFinder ? 100.0 : coverPhotoHeight(context)) -
                    kProfilePicRadius * 1.2,
                left: constraints.maxWidth / 2 - kProfilePicRadius,
                child: FutureBuilder<String>(
                  future: restaurant?.profilePicture,
                  builder: (context, snapshot) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          offset: Offset.fromDirection(pi / 4),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      radius: kProfilePicRadius,
                      backgroundImage: snapshot.hasData
                          ? CachedNetworkImageProvider(snapshot.data)
                          : null,
                      backgroundColor: Color.alphaBlend(
                        kPrimaryButtonColor.withOpacity(0.1),
                        Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        RestaurantInfoWrapper(
          restaurant: restaurant,
          fbPlaceResult: fbPlaceResult,
          isFoodFinder: isFoodFinder,
          showDiscoverItems: showDiscoverItems,
        )
      ],
    );
  }
}

class GoogleMapsPhotos extends StatelessWidget {
  const GoogleMapsPhotos(this.restaurant, this.fbPlaceResult);
  final Restaurant restaurant;
  final FacebookPlaceResult fbPlaceResult;

  @override
  Widget build(BuildContext context) => FutureBuilder<List<CoverPhotoData>>(
      future: getGoogleCoverPhotos(
          restaurant, fbPlaceResult, MediaQuery.of(context).size),
      builder: (_, snapshot) => CoverPhotosWidget(snapshot.data));
}

final _placeIdCache =
    LruMap<DocumentReference, Future<String>>(maximumSize: 500);

Future<List<CoverPhotoData>> getGoogleCoverPhotos(Restaurant restaurant,
    FacebookPlaceResult fbPlaceResult, Size screenSize) async {
  final googlePlaces = GooglePlacesManager.instance;

  String placeId = restaurant?.proto?.attributes?.hasGooglePlaceId() ?? false
      ? restaurant.proto.attributes.googlePlaceId
      : await getGooglePlaceId(restaurant, fbPlaceResult);
  if (placeId == null) {
    return [];
  }
  List<String> placePhotos = await googlePlaces.getPlacePhotos(
      placeId, screenSize.height, screenSize.width);
  return placePhotos
      .listMap((p) => CoverPhotoData(firePhoto: fixedFirePhoto(p)));
}

Future<String> getGooglePlaceId(Restaurant restaurant,
    [FacebookPlaceResult fbPlaceResult]) async {
  assert(restaurant != null || fbPlaceResult != null);
  if (restaurant?.proto?.attributes?.hasGooglePlaceId() ?? false) {
    return restaurant.proto.attributes.googlePlaceId;
  }
  return _placeIdCache.putIfAbsent(restaurant.reference, () async {
    final location = restaurant?.location ?? fbPlaceResult?.location;
    if (location == null) {
      return null;
    }
    String name = restaurant?.name ?? fbPlaceResult.name;
    final googlePlaces = GooglePlacesManager.instance;
    List<google.PlacesSearchResult> places =
        await googlePlaces.search(location, name);
    if (places.isEmpty) {
      return null;
    }
    final id = places.first.placeId;
    unawaited(
        restaurant.reference.updateData({'attributes.google_place_id': id}));
    return id;
  });
}

class CoverPhotosWidget extends StatelessWidget {
  const CoverPhotosWidget(this.coverPhotos);
  final List<CoverPhotoData> coverPhotos;

  @override
  Widget build(BuildContext context) => FoodPhotoGallery(
        coverPhotos: coverPhotos,
        photoHeight: coverPhotoHeight(context),
        bottomPadding: kProfilePicRadius / 2 + 36,
      );
}

class CoverPhoto extends StatelessWidget {
  const CoverPhoto(this.coverPhoto,
      {this.controller, this.onTap, this.numPhotos});
  final CoverPhotoData coverPhoto;
  final PreloadPageController controller;
  final int numPhotos;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final image = PhotoView.customChild(
      minScale: 1.0,
      maxScale: 1.0,
      child: coverPhoto.firePhoto.progressive(
        Resolution.medium,
        Resolution.thumbnail,
        BoxFit.cover,
        height: coverPhotoHeight(context),
        width: MediaQuery.of(context).size.width,
      ),
    );
    return InkWell(
      onTap: onTap ??
          (coverPhoto.review == null
              ? () {
                  TAEvent.tapped_post_on_restaurant(
                      {'post': coverPhoto.review?.path});
                  if (controller != null) {
                    controller.animateToPage(
                        (controller.page.round() + 1) % numPhotos,
                        duration: 150.millis,
                        curve: Curves.easeInOut);
                  }
                }
              : null),
      child: image,
    );
  }
}

class RestaurantInfoWrapper extends StatelessWidget {
  const RestaurantInfoWrapper(
      {this.restaurant,
      this.fbPlaceResult,
      this.isFoodFinder,
      this.showDiscoverItems});
  final Restaurant restaurant;
  final FacebookPlaceResult fbPlaceResult;
  final bool isFoodFinder;
  final bool showDiscoverItems;

  @override
  Widget build(BuildContext context) {
    if (fbPlaceResult != null) {
      return RestaurantInfo(
          restaurant, fbPlaceResult, isFoodFinder, showDiscoverItems);
    }
    return FutureBuilder<FacebookPlaceResult>(
      future: FacebookPlacesManager.instance.getPlaceById(restaurant.fbPlaceId),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(50),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return RestaurantInfo(
            restaurant, snapshot.data, isFoodFinder, showDiscoverItems);
      },
    );
  }
}

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo(this.restaurant, this.fbPlaceResult, this.isFoodFinder,
      this.showDiscoverItems);
  final Restaurant restaurant;
  final FacebookPlaceResult fbPlaceResult;
  final bool isFoodFinder;
  final bool showDiscoverItems;

  @override
  Widget build(BuildContext context) {
    final latLng = LocationBuilder.of(context);
    final distanceMiles =
        (latLng?.distanceMeters(restaurant.location) ?? 1e7) / kMetersPerMile;
    final headerContent = [
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 30, 5, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              fbPlaceResult.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kDarkGrey,
              ),
              maxLines: 2,
              minFontSize: 7,
              maxFontSize: 22,
            ),
            if (distanceMiles < 100)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  distanceMiles < 1
                      ? '${distanceMiles.toStringAsFixed(1)} mi'
                      : '${distanceMiles.round()} mi',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF75A563),
                  ),
                ),
              ),
            if (distanceMiles > 100)
              AutoSizeText(
                fbPlaceResult.address.simple,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                maxLines: 2,
                minFontSize: 7,
              ),
            const SizedBox(height: 10.0),
            CategoriesWidget(restaurant: restaurant),
            restaurant != null && restaurant.proto.attributes.blackOwned
                ? const BlackOwnedMarker()
                : null,
            const SizedBox(height: 5.0),
            HoursWidget(fbPlaceResult),
          ].withoutNulls,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: RestaurantActionRow(
            restaurant: restaurant, fbPlaceResult: fbPlaceResult),
      ),
      Container(
        color: kScaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: RatingsWidget(restaurant: restaurant),
        ),
      ),
      if (restaurant.proto.deliveryScraped &&
          restaurant.proto.hasDeliveryUrl() &&
          !restaurant.proto.deliveryScraperError)
        Container(
          color: kScaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: DeliveryWidget(restaurant: restaurant),
          ),
        ),
      Container(
        color: kScaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: DirectionsWidget(
            restaurant: restaurant,
            fbPlaceResult: fbPlaceResult,
          ),
        ),
      ),
      if (isFoodFinder)
        Container(
          color: kScaffoldBackgroundColor,
          height: 10,
        )
    ].withoutNulls;
    final restaurantPosts = CollectionType.discover_items.coll
        .visible(context)
        .where('restaurant.reference', isEqualTo: restaurant.reference)
        .orderBy('score', descending: true)
        .limit(10)
        .getDocuments()
        .then((snapshots) =>
            snapshots.documents.listMap((snapshot) => DiscoverItem(snapshot)));
    return FutureBuilder<List<DiscoverItem>>(
        future: isFoodFinder && !showDiscoverItems ? null : restaurantPosts,
        builder: (context, snapshot) {
          final posts = snapshot.data ?? [];
          final preFeedContent = [
            ...headerContent,
            if (snapshot.hasData && posts.isNotEmpty)
              Container(
                color: kScaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                  child: AutoSizeText(
                    'Posts at ${restaurant.name}',
                    maxLines: 1,
                    minFontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: primaryStyle.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
          ];
          return PostsListProvider(
            posts: posts.withoutNulls,
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 8.0),
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              separatorBuilder: (context, i) {
                return Container(
                  color: kScaffoldBackgroundColor,
                  height: i < 1 ? 0 : 20,
                );
              },
              itemBuilder: (context, i) {
                if (i < preFeedContent.length) {
                  return preFeedContent[i];
                }
                if (!snapshot.hasData) {
                  return Container(
                    height: 200,
                    color: kScaffoldBackgroundColor,
                    child: const Center(
                      child: TasteLargeCircularProgressIndicator(),
                    ),
                  );
                }
                final post = posts[i - preFeedContent.length];
                final postIdx = i - preFeedContent.length;
                return Container(
                  color: kScaffoldBackgroundColor,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        25, 15, 25, postIdx == (posts.length - 1) ? 25 : 10),
                    child: DiscoverItemWidget(
                      onViewed: () => TAEvent.discover_scrolled_to_item({
                        'index': postIdx,
                        'item_path': post.reference.path,
                      }),
                      discoverItem: post,
                    ),
                  ),
                );
              },
              itemCount: preFeedContent.length +
                  (!snapshot.hasData ? 1 : posts.length),
            ),
          );
        });
  }
}

class RatingsWidget extends StatelessWidget {
  const RatingsWidget({
    Key key,
    this.restaurant,
    this.fbPlaceResult,
  }) : super(key: key);

  final Restaurant restaurant;
  final FacebookPlaceResult fbPlaceResult;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Ratings',
              style: primaryStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 10),
            (restaurant.proto.googleMatch && restaurant.proto.yelpMatch)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GoogleOrYelpRating(
                        isGoogle: true,
                        restaurant: restaurant,
                        fbPlaceResult: fbPlaceResult,
                      ),
                      GoogleOrYelpRating(
                        isGoogle: false,
                        restaurant: restaurant,
                        fbPlaceResult: fbPlaceResult,
                      ),
                    ],
                  )
                : Text(
                    'No rating info yet',
                    style: primaryStyle.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class GoogleOrYelpRating extends StatelessWidget {
  const GoogleOrYelpRating({
    Key key,
    this.isGoogle,
    this.restaurant,
    this.algoliaRestaurant,
    this.fbPlaceResult,
    this.aBitBigger = false,
  }) : super(key: key);

  final bool isGoogle;
  final Restaurant restaurant;
  final AlgoliaRestaurant algoliaRestaurant;
  final FacebookPlaceResult fbPlaceResult;
  final bool aBitBigger;

  bool get isAlgolia => algoliaRestaurant != null;

  @override
  Widget build(BuildContext context) {
    final scraperResult = isAlgolia
        ? isGoogle
            ? algoliaRestaurant.googleInfo.scraperResult
            : algoliaRestaurant.yelpInfo.scraperResult
        : isGoogle ? restaurant.proto.google : restaurant.proto.yelp;
    return InkWell(
      onTap: isAlgolia
          ? null
          : () async {
              if (isGoogle) {
                TAEvent.resto_tapped_gmaps_rating();
              } else {
                TAEvent.resto_tapped_yelp_rating();
              }
              final uri = isGoogle
                  ? Uri(
                      scheme: 'https',
                      host: 'www.google.com',
                      path: 'maps/search/',
                      queryParameters: {
                        'api': '1',
                        'query_place_id':
                            await getGooglePlaceId(restaurant, fbPlaceResult) ??
                                '',
                        'query': restaurant?.name ?? fbPlaceResult?.name,
                      },
                    )
                  : Uri(
                      scheme: 'https',
                      host: 'www.yelp.com',
                      path: 'biz/${restaurant.proto.yelp.placeId}',
                    );
              await url_launcher.launch(uri.toString());
            },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Image.asset(
              isGoogle
                  ? 'assets/ui/google_maps_icon.png'
                  : 'assets/ui/yelp_icon.png',
              height: aBitBigger ? 26 : 20,
              width: aBitBigger ? 26 : 20,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 35,
            child: AutoSizeText(
              '${scraperResult.avgRating.toStringAsFixed(2)}',
              style: secondaryStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: aBitBigger ? 15 : 13,
              ),
              maxLines: 1,
            ),
          ),
          AutoSizeText(
            '(${scraperResult.numReviews})',
            style: secondaryStyle.copyWith(
              color: Colors.grey,
              fontSize: aBitBigger ? 15 : 13,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class DeliveryWidget extends StatelessWidget {
  const DeliveryWidget({
    Key key,
    this.restaurant,
    this.fbPlaceResult,
  }) : super(key: key);

  final Restaurant restaurant;
  final FacebookPlaceResult fbPlaceResult;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Delivery Options',
              style: primaryStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 5),
            DeliveryList(
              restaurant: restaurant,
              fbPlaceResult: fbPlaceResult,
            )
          ],
        ),
      ),
    );
  }
}

class DeliveryList extends StatelessWidget {
  const DeliveryList({
    Key key,
    this.restaurant,
    this.fbPlaceResult,
    this.aBitBigger = false,
    this.disableTap = false,
  }) : super(key: key);

  final Restaurant restaurant;
  final FacebookPlaceResult fbPlaceResult;
  final bool aBitBigger;
  final bool disableTap;

  @override
  Widget build(BuildContext context) {
    List<Widget> showApps = [];
    final Restaurant_DeliveryUrl urlsAll = restaurant.proto.deliveryUrl;
    final Restaurant_DeliveryInfo infoAll = restaurant.proto.deliveryInfo;
    final Map remapApps = {
      'seamless': 'grubhub',
      'caviar': 'doordash',
    };
    final Map<String, String> urlsAllMap = {
      'postmates': urlsAll.postmates,
      'ubereats': urlsAll.ubereats,
      'grubhub': urlsAll.grubhub,
      'doordash': urlsAll.doordash,
      'favor': urlsAll.favor,
      'seamless': urlsAll.seamless,
      'caviar': urlsAll.caviar,
    };
    final Map<String, Restaurant_DeliveryAppInfo> infoAllMap = {
      'postmates': infoAll.postmates,
      'ubereats': infoAll.ubereats,
      'grubhub': infoAll.grubhub,
      'doordash': infoAll.doordash,
      'favor': infoAll.favor,
    };
    for (final key in urlsAllMap.keys) {
      if (urlsAllMap[key] != "0") {
        showApps.add(DeliveryRow(
            app: key.toString(),
            url: urlsAllMap[key],
            info: infoAllMap[remapApps[key] ?? key],
            fbPlaceResult: fbPlaceResult,
            weekday: DateTime.now().weekday));
      }
    }
    return Column(
        children: showApps.isEmpty
            ? [
                Text(
                  'No delivery info found',
                  style: primaryStyle.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )
              ]
            : showApps);
  }
}

const Map<String, String> kAppLogo = {
  'postmates': 'assets/images/postmates.png',
  'grubhub': 'assets/images/grubhub.png',
  'seamless': 'assets/images/seamless.png',
  'ubereats': 'assets/images/uber_eats.png',
  'doordash': 'assets/images/door_dash.png',
  'favor': 'assets/images/favor.png',
  'caviar': 'assets/images/caviar.png'
};

const Map<String, String> _kSubscriptionLogo = {
  'grubhub': 'assets/images/grubhubplus.png',
  'seamless': 'assets/images/seamlessplus.png',
  'doordash': 'assets/images/dashpass.png',
  'caviar': 'assets/images/dashpass.png'
};

const Map<String, TAEvent> _kUrlEvent = {
  'postmates': TAEvent.resto_tapped_postmates_url,
  'grubhub': TAEvent.resto_tapped_grubhub_url,
  'seamless': TAEvent.resto_tapped_seamless_url,
  'ubereats': TAEvent.resto_tapped_ubereats_url,
  'doordash': TAEvent.resto_tapped_doordash_url,
  'favor': TAEvent.resto_tapped_favor_url,
  'caviar': TAEvent.resto_tapped_caviar_url
};

class DeliveryRow extends StatelessWidget {
  const DeliveryRow(
      {Key key,
      this.weekday,
      this.fbPlaceResult,
      this.app,
      this.url,
      this.info})
      : super(key: key);

  final FacebookPlaceResult fbPlaceResult;
  final int weekday;
  final String app;
  final String url;
  final Restaurant_DeliveryAppInfo info;

  static const subscriptionLogoWidth = 20.0;
  static const subscriptionLogoHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    final bool subscriptionDiscount = info.subscriptionDiscount;
    final bool takingOrders = info.takingOrders;
    final Restaurant_Hours hours = info.hours;

    return InkWell(
      onTap: () => url_launcher.launch(url),
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  kAppLogo[app],
                  width: 100,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: (_kSubscriptionLogo[app] == null)
                        ? const SizedBox(
                            height: subscriptionLogoHeight,
                            width: subscriptionLogoWidth)
                        : subscriptionDiscount
                            ? Image.asset(
                                _kSubscriptionLogo[app],
                                height: subscriptionLogoHeight,
                                width: subscriptionLogoWidth,
                              )
                            : const SizedBox(
                                height: subscriptionLogoHeight,
                                width: subscriptionLogoWidth)),
                const SizedBox(width: 5),
                Flexible(
                    child:
                        Column(children: deliveryPickup(hours, takingOrders))),
                const SizedBox(width: 5),
                IconButton(
                  icon: const Icon(Icons.launch),
                  onPressed: () async {
                    _kUrlEvent[app]();
                    await url_launcher.launch(url);
                  },
                  iconSize: 18,
                )
              ],
            ),
            const Divider()
          ])),
    );
  }

  List<Widget> deliveryPickup(Restaurant_Hours restoHours, bool takingOrders) {
    final daysString = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];
    final Map<String, Restaurant_HoursInfo> hours = {
      'Mon': restoHours.mon,
      'Tue': restoHours.tue,
      'Wed': restoHours.wed,
      'Thu': restoHours.thu,
      'Fri': restoHours.fri,
      'Sat': restoHours.sat,
      'Sun': restoHours.sun
    };
    List<Widget> deliveryPickup = [];
    if (!takingOrders) {
      deliveryPickup.add(const Text(
        'Currently Unavailable',
        textAlign: TextAlign.center,
      ));
      return deliveryPickup;
    }
    final DateTime now = DateTime.now();
    final String today = daysString[now.weekday];
    final String yesterday = daysString[now.weekday - 1];
    final bool isOpen = hours[today].isOpen;
    if (!isOpen) {
      deliveryPickup.add(
          const Text('Closed for Delivery Today', textAlign: TextAlign.center));
      return deliveryPickup;
    }
    String timePartDelivery;
    String timePartPickup;
    if (hours[today].hasDelivery()) {
      final List<String> openDel = hours[today].delivery.begin;
      final List<String> closeDel = hours[today].delivery.end;
      if (hours[yesterday].isOpen && hours[yesterday].hasDelivery()) {
        final List<String> yesterOpenDel = hours[yesterday].delivery.begin;
        final List<String> yesterCloseDel = hours[yesterday].delivery.end;
        for (var i = 0; i < yesterOpenDel.length; i++) {
          if (int.parse(yesterCloseDel[i].split(":")[0]) <
              int.parse(yesterOpenDel[i].split(":")[0])) {
            openDel.add('0:00');
            closeDel.add(yesterCloseDel[i]);
          }
        }
      }
      final List<bool> timeline = getTimeline(openDel, closeDel);
      final DateTime now = DateTime.now();
      final int currentInd = now.hour * 60 + now.minute;
      final bool isOpenDel = timeline[currentInd];
      String currentClose;
      String nextOpen;
      final toEOD = timeline.sublist(currentInd);
      if (isOpenDel) {
        final currentCloseInd = currentInd + toEOD.indexOf(false);
        currentClose = timelineIndToTime(currentCloseInd);
      } else {
        final opensToday = toEOD.indexOf(true);
        final nextOpenInd =
            opensToday == -1 ? timeline.indexOf(true) : currentInd + opensToday;
        nextOpen = timelineIndToTime(nextOpenInd);
      }

      final String deliveryHoursString = isOpenDel
          ? 'Delivery until ${militaryToStandard(currentClose)}'
          : 'Delivery opens at ${militaryToStandard(nextOpen)}';
      deliveryPickup
          .add(Text(deliveryHoursString, textAlign: TextAlign.center));
      timePartDelivery = deliveryHoursString.split('Delivery')[1];
    }
    if (hours[today].hasPickup()) {
      final List<String> openPup = hours[today].pickup.begin;
      final List<String> closePup = hours[today].pickup.end;
      if (hours[yesterday].isOpen && hours[yesterday].hasPickup()) {
        final List<String> yesterOpenPup = hours[yesterday].pickup.begin;
        final List<String> yesterClosePup = hours[yesterday].pickup.end;
        for (var i = 0; i < yesterOpenPup.length; i++) {
          if (int.parse(yesterClosePup[i].split(":")[0]) <
              int.parse(yesterOpenPup[i].split(":")[0])) {
            openPup.add('0:00');
            closePup.add(yesterClosePup[i]);
          }
        }
      }
      final List<bool> timeline = getTimeline(openPup, closePup);
      final DateTime now = DateTime.now();
      final int currentInd = now.hour * 60 + now.minute;
      final bool isOpenPup = timeline[currentInd];
      String currentClose;
      String nextOpen;
      final toEOD = timeline.sublist(currentInd);
      if (isOpenPup) {
        final currentCloseInd = toEOD.indexOf(false) + currentInd;
        currentClose = timelineIndToTime(currentCloseInd);
      } else {
        final opensToday = toEOD.indexOf(true);
        final nextOpenInd =
            opensToday == -1 ? timeline.indexOf(true) : opensToday + currentInd;
        nextOpen = timelineIndToTime(nextOpenInd);
      }
      final String pickupHoursString = isOpenPup
          ? 'Pickup until ${militaryToStandard(currentClose)}'
          : 'Pickup opens at ${militaryToStandard(nextOpen)}';
      deliveryPickup.add(Text(pickupHoursString, textAlign: TextAlign.center));
      timePartPickup = pickupHoursString.split('Pickup')[1];
    }
    if (timePartDelivery == timePartPickup) {
      final hoursString = 'Delivery/Pickup$timePartDelivery';
      deliveryPickup = [Text(hoursString, textAlign: TextAlign.center)];
    }
    return deliveryPickup;
  }

  bool isWithinHours(DateTime now, String open, String close) {
    double openHour =
        int.parse(open.split(":")[0]) + int.parse(open.split(":")[1]) / 60;
    double closeHour =
        int.parse(close.split(":")[0]) + int.parse(close.split(":")[1]) / 60;
    closeHour = closeHour < openHour ? closeHour + 24 : closeHour;
    double nowDouble = now.hour + now.minute / 60;
    return nowDouble >= openHour && nowDouble < closeHour;
  }

  String militaryToStandard(String militaryTime) {
    final hour = int.parse(militaryTime.split(":")[0]);
    final minutes = militaryTime.split(":")[1];
    final shift = hour < 12 ? "am" : "pm";
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    final standardTime = "$displayHour:$minutes$shift";
    return standardTime;
  }

  Map<String, List<String>> consolidateWindows(
      List<String> open, List<String> close) {
    List<List<String>> listOfLists = [];
    for (var i = 0; i < open.length; i++) {
      listOfLists.add([open[i], close[i]]);
    }
    List<List<String>> setOfLists = listOfLists.toSet().toList();
    if (setOfLists.length > 2) {
      Map<String, List<String>> consolidated = {'open': [], 'close': []};
      for (var i = 0; i < setOfLists.length; i++) {
        List<String> current = setOfLists[i];
        var test = setOfLists.removeAt(i).map((e) =>
            (int.parse(current[0]) >= int.parse(e[0])) &&
            (int.parse(current[1]) <= int.parse(e[1])));

        bool isNotContained =
            test.toList().every((element) => element == false);
        if (isNotContained) {
          consolidated['open'].add(current[0]);
          consolidated['close'].add(current[1]);
        }
      }
      return consolidated;
    }
    return {
      'open': [setOfLists[0][0]],
      'close': [setOfLists[0][1]]
    };
  }

  List<bool> getTimeline(List<String> open, List<String> close) {
    List<bool> timeline = List.filled(1800, false);
    for (var i = 0; i < open.length; i++) {
      int openHour = int.parse(open[i].split(':')[0]);
      int openMin = int.parse(open[i].split(':')[1]);
      int closeHour = int.parse(close[i].split(':')[0]);
      closeHour = closeHour < openHour ? closeHour + 24 : closeHour;
      int closeMin = int.parse(close[i].split(':')[1]);
      int openInd = 60 * openHour + openMin;
      int closeInd = 60 * closeHour + closeMin;
      timeline.fillRange(openInd, closeInd, true);
    }
    return timeline;
  }

  String timelineIndToTime(int ind) {
    final min = ind.remainder(60);
    final hour = (ind - min) ~/ 60;
    final minString = min < 10 ? '0$min' : min.toString();
    return '$hour:$minString';
  }

  String getNextOpen(List<String> consolidatedOpen) {
    List<double> sorted = consolidatedOpen
        .map(
            (e) => int.parse(e.split(":")[0]) + int.parse(e.split(":")[1]) / 60)
        .toList()
          ..sort();
    double nextOpenDouble = sorted.firstWhere((element) =>
            element < DateTime.now().hour + DateTime.now().minute / 60) ??
        sorted[0];
    return '${nextOpenDouble.floor()}:${(nextOpenDouble - nextOpenDouble.floor()) * 60}';
  }
}

class DirectionsWidget extends StatelessWidget {
  const DirectionsWidget({
    Key key,
    this.restaurant,
    this.fbPlaceResult,
  }) : super(key: key);

  final Restaurant restaurant;
  final FacebookPlaceResult fbPlaceResult;

  @override
  Widget build(BuildContext context) {
    final latLng = LocationBuilder.of(context);
    final distanceMiles =
        (latLng?.distanceMeters(restaurant.location) ?? 1e7) / kMetersPerMile;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: () async {
            TAEvent.resto_tapped_navigate_btn();
            final Uri googMapsUri = Uri(
              scheme: 'https',
              host: 'www.google.com',
              path: 'maps/dir/',
              queryParameters: {
                'api': '1',
                'destination_place_id':
                    await getGooglePlaceId(restaurant, fbPlaceResult) ?? '',
                'destination': restaurant?.name ?? fbPlaceResult?.name,
              },
            );
            if (await url_launcher.canLaunch(googMapsUri.toString())) {
              await url_launcher.launch(googMapsUri.toString());
            } else {
              final Uri appleMapsUri = Uri(
                scheme: 'https',
                host: 'maps.apple.com',
                path: 'maps',
                queryParameters: {
                  'saddr': 'Current Location',
                  'daddr':
                      '${restaurant.name} ${fbPlaceResult?.detailedAddress ?? restaurant?.streetAddress ?? (restaurant?.location ?? fbPlaceResult?.location)?.csv ?? ''}',
                },
              );
              await url_launcher.launch(appleMapsUri.toString());
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      'Directions',
                      style: primaryStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    if (distanceMiles < 100)
                      Text(
                        distanceMiles < 1
                            ? '${distanceMiles.toStringAsFixed(1)} mi away'
                            : '${distanceMiles.round()} mi away',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF75A563),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CachedNetworkImage(
                  imageUrl:
                      MapBoxApi.getMapBoxStaticTileUrl(restaurant.location)),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: AutoSizeText(
                  fbPlaceResult.detailedAddress,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kDarkGrey,
                  ),
                  maxLines: 1,
                  minFontSize: 7,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantActionRow extends StatelessWidget {
  const RestaurantActionRow({
    Key key,
    this.restaurant,
    this.fbPlaceResult,
  }) : super(key: key);

  final Restaurant restaurant;
  final FacebookPlaceResult fbPlaceResult;

  @override
  Widget build(BuildContext context) {
    final phone =
        restaurant.proto.attributes.phone.isEmpty ? fbPlaceResult.phone : '';
    final website = restaurant.proto.attributes.website.isEmpty
        ? fbPlaceResult.website
        : '';
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 25, 30, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RestaurantActionButton(
            label: 'Call',
            icon: const Icon(TasteIcons.call),
            onPressed: phone.isNotEmpty
                ? () async {
                    final sanitizedPhone = phone.startsWith('+')
                        ? phone
                        : "+1${phone.replaceAll(RegExp(r'[^\d]'), '')}";
                    TAEvent.resto_tapped_call_btn();
                    await url_launcher.launch('tel://$sanitizedPhone');
                  }
                : null,
          ),
          RestaurantActionButton(
            label: 'Navigate',
            icon: const Icon(TasteIcons.navigate),
            onPressed: () async {
              TAEvent.resto_tapped_navigate_btn();
              final Uri googMapsUri = Uri(
                scheme: 'https',
                host: 'www.google.com',
                path: 'maps/dir/',
                queryParameters: {
                  'api': '1',
                  'destination_place_id':
                      await getGooglePlaceId(restaurant, fbPlaceResult) ?? '',
                  'destination': restaurant?.name ?? fbPlaceResult?.name,
                },
              );
              if (await url_launcher.canLaunch(googMapsUri.toString())) {
                await url_launcher.launch(googMapsUri.toString());
              } else {
                final Uri appleMapsUri = Uri(
                  scheme: 'https',
                  host: 'maps.apple.com',
                  path: 'maps',
                  queryParameters: {
                    'saddr': 'Current Location',
                    'daddr':
                        '${restaurant.name} ${fbPlaceResult?.detailedAddress ?? restaurant?.streetAddress ?? (restaurant?.location ?? fbPlaceResult?.location)?.csv ?? ''}',
                  },
                );
                await url_launcher.launch(appleMapsUri.toString());
              }
            },
          ),
          RestaurantActionButton(
            label: 'Website',
            icon: const Icon(TasteIcons.website),
            onPressed: website.isNotEmpty
                ? () async {
                    TAEvent.resto_tapped_webpage_btn();
                    final sanitizedUrl = website.startsWith('http')
                        ? website
                        : 'https://$website';
                    await url_launcher
                        .launch(sanitizedUrl.replaceAll(' ', '%20'));
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class RestaurantActionButton extends StatelessWidget {
  const RestaurantActionButton({
    Key key,
    this.icon,
    this.label,
    this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: onPressed == null
                ? Colors.grey.withOpacity(0.33)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: icon,
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: primaryStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: onPressed == null ? Colors.grey : kDarkGrey,
          ),
        ),
      ],
    );
  }
}

class BlackOwnedMarker extends StatelessWidget {
  const BlackOwnedMarker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 27,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Image.asset('assets/ui/black_power.png'),
            ),
            const SizedBox(width: 7),
            const Text(
              'Black Owned',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const kCategoryBackgroundColor = Color(0xFF987CFF);
const kSecondaryCategoryBackgroundColor = Color(0xFFFFBB68);

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key key, this.restaurant, this.category})
      : super(key: key);

  final Restaurant restaurant;
  final String category;

  @override
  Widget build(BuildContext context) {
    if (restaurant == null) {
      return Container();
    }
    var filteredCategories = <String>[];
    if (category != null) {
      if (category.isEmpty) {
        return Container();
      }
      filteredCategories = [category];
    } else {
      filteredCategories =
          getRelevantTypes(AlgoliaRestaurant.fromRestaurant(restaurant))
              .keys
              .map((x) => x.displayString)
              .where((x) => x.isNotEmpty)
              .toList();
    }
    if (filteredCategories.isEmpty) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Wrap(
        alignment: WrapAlignment.start,
        direction: Axis.horizontal,
        spacing: 6,
        runSpacing: 8,
        children: filteredCategories
            .map((category) => Container(
                  decoration: BoxDecoration(
                    color: kSecondaryCategoryBackgroundColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: kDarkGrey,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

const _daysString = [
  null,
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

class HoursWidgetRow extends StatelessWidget {
  const HoursWidgetRow({
    Key key,
    this.weekday,
    this.fbPlaceResult,
  }) : super(key: key);

  final FacebookPlaceResult fbPlaceResult;
  final int weekday;

  @override
  Widget build(BuildContext context) {
    Tuple2<List<String>, bool> hours =
        hoursToString(fbPlaceResult?.hours, weekday);
    final isToday = DateTime.now().weekday == weekday;
    Color color = isToday
        ? hours.item2 ? kTasteBrandColorLeft.withOpacity(0.8) : Colors.red[800]
        : Colors.grey;
    final delimeter = hours.item1.length > 1 ? "\n" : " ";
    final hoursString =
        hours.item1.isEmpty ? " Closed" : hours.item1.join(delimeter);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 50,
        vertical:
            (hours.item1.length > 1 && ExpandableProvider.of(context)) ? 3 : 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _daysString[weekday],
            style: primaryStyle.copyWith(color: Colors.grey, fontSize: 15),
          ),
          Text(
            "$hoursString",
            style: primaryStyle.copyWith(
              color: color,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Tuple2<List<String>, bool> hoursToString(
    Map<String, dynamic> hours,
    int weekday,
  ) {
    if (hours == null || hours.isEmpty) {
      return null;
    }
    List<String> hoursKeys = getHoursKeys(hours, weekday);
    final List<String> hoursStrings = [];
    bool isOpen = false;
    for (final hoursKey in hoursKeys) {
      final openKey = "${hoursKey}_open";
      final closeKey = "${hoursKey}_close";
      if (!hours.containsKey(openKey) || !hours.containsKey(closeKey)) {
        continue;
      }
      final open = hours[openKey] as String;
      final close = hours[closeKey] as String;
      isOpen = isOpen || isWithinWindow(DateTime.now(), open, close);
      hoursStrings
          .add("${militaryToStandard(open)} - ${militaryToStandard(close)}");
    }

    return Tuple2(hoursStrings, isOpen);
  }

  List<String> getHoursKeys(Map<String, dynamic> hours, int weekday) {
    final prefixes = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];
    String prefix = prefixes[weekday - 1];
    int index = 1;
    List<String> hoursKeys = [];
    while (true) {
      if (hours.containsKey("${prefix}_${index}_open")) {
        hoursKeys.add("${prefix}_$index");
        index += 1;
      } else {
        break;
      }
    }
    return hoursKeys;
  }

  String militaryToStandard(String militaryTime) {
    final hour = int.parse(militaryTime.split(":")[0]);
    final minutes = militaryTime.split(":")[1];
    final shift = hour < 12 ? "am" : "pm";
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    final standardTime =
        "${displayHour < 10 ? ' ' : ''}$displayHour:$minutes $shift";
    return standardTime;
  }
}

class HoursWidget extends StatelessWidget {
  const HoursWidget(this.fbPlaceResult);
  final FacebookPlaceResult fbPlaceResult;

  @override
  Widget build(BuildContext context) {
    if (fbPlaceResult?.hours == null || fbPlaceResult.hours.isEmpty) {
      return Container();
    }
    final fullView = Column(
      mainAxisSize: MainAxisSize.min,
      children: [1, 2, 3, 4, 5, 6, 7]
          .map((weekday) =>
              HoursWidgetRow(fbPlaceResult: fbPlaceResult, weekday: weekday))
          .toList(),
    );
    final todayView = HoursWidgetRow(
        fbPlaceResult: fbPlaceResult, weekday: DateTime.now().weekday);
    return ExpandableProvider(
      child: Builder(
        builder: (context) => InkWell(
          onTap: () => ExpandableProvider.toggle(context),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  'Hours',
                  style: primaryStyle.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ExpandableProvider.of(context) ? fullView : todayView,
            ],
          ),
        ),
      ),
    );
  }
}

const primaryStyle = TextStyle(
  fontFamily: 'Quicksand',
  color: kDarkGrey,
  fontSize: 16.0,
);

const secondaryStyle = TextStyle(
  fontFamily: 'Montserrat',
  color: kDarkGrey,
  fontSize: 15.0,
);

class GoToRestaurantOnMapButton extends StatelessWidget {
  const GoToRestaurantOnMapButton({Key key, this.restaurant}) : super(key: key);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) => IconButton(
      icon: const Icon(Feather.map),
      onPressed: () => goToRestaurantOnMap(context, restaurant));
}

Future goToRestaurantOnMap(BuildContext context, Restaurant restaurant) {
  TAEvent.tapped_restaurant_map_button({'restaurant': restaurant.path});
  return quickPush(
      TAPage.map_root, (_) => MapPage(initialRestaurant: restaurant));
}

extension on LatLng {
  String get csv => '$latitude,$longitude';
}
