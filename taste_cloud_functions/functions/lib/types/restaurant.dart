import 'dart:math';

import 'package:geohash/geohash.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'restaurant.g.dart';

@RegisterType()
mixin Restaurant
    on FirestoreProto<$pb.Restaurant>, AlgoliaBacked, SpatialIndexed {
  static final triggers = trigger<Restaurant>(
    delete: (r) => [r.deleteLinkedNotifications(), r.deleteAlgoliaCache()],
    create: (r) => [
      r.updateAlgoliaRecords(),
      r.updatePopularityScore(),
      r.setRequiredFields()
    ],
    update: (r, c) {
      print('Update trigger called on ${r.path}');
      if (c.fieldChanged('attributes.queried_hours')) {
        return [];
      }
      return [
        r.setRequiredFields(),
        r.updatePopularityScore(),
        r.updateBlackOwnedPhoto(),
        r.updateAlgoliaRecords(),
        r.maybeUpdateChildCaches(c),
        r.recachePhoto(),
        r.updatePhoto(c.before),
      ];
    },
  );

  @override
  GeoPoint get indexLocation => geoPoint;

  Future updateBlackOwnedPhoto() async {
    print('updateBlackOwned');
    if (!blackOwned) {
      return;
    }
    if (thumbnail?.isNotEmpty ?? false) {
      return;
    }
    if (fbPlaceId?.isEmpty ?? true) {
      return;
    }
    try {
      await updateSelf(
          {'profile_pic_external_url': await fbCoverPhoto(fbPlaceId)});
    } catch (e, s) {
      print('failed to update photo from FB for $path $fbPlaceId $e $s');
      return;
    }
  }

  Future recachePhoto() async {
    print('recachePhoto');
    if (proto.profilePic.exists &&
        proto.profilePic != proto.fireProfilePic.photoReference) {
      await updateSelf({
        'fire_profile_pic': Photos.make(
                await proto.profilePic.ref.tGet(transaction), transaction)
            .firePhoto
      }.ensureAs(prototype));
    }
  }

  DocumentQuery get reviewsQuery =>
      CollectionType.reviews.coll.where('restaurant', isEqualTo: ref);
  DocumentQuery get favoritesQuery =>
      CollectionType.favorites.coll.where('restaurant', isEqualTo: ref);

  Future<List<Favorite>> get favoriteRecords =>
      wrapQuery(favoritesQuery, Favorites.make);
  Future<List<TasteUser>> get favorites async =>
      (await favoriteRecords).futureMap((f) => f.user);

  Future<List<Review>> get reviews => wrapQuery(reviewsQuery, Reviews.make);

  String get name => proto.attributes.name;
  String get fbPlaceId => proto.attributes.fbPlaceId;

  Future<int> get numFavorites async => (await favorites).length;
  GeoPoint get geoPoint => proto.attributes.hasLocation()
      ? proto.attributes.location.geoPoint
      : proto.attributes.address.sourceLocation.geoPoint;
  String get googlePlaceId => proto.attributes.googlePlaceId;
  String get thumbnail =>
      proto.fireProfilePic.firebaseStorage ?? proto.profilePicExternalUrl;

  DocumentReference get merchantReference =>
      proto.hasMerchant() ? proto.merchant.ref : null;

  @override
  Future<GeoPoint> get algoliaGeoPoint async => geoPoint;
  Future<int> reactionCount(Reaction reaction) async => (await Reviews.get(
          trans: transaction,
          queryFn: (q) => q
              .where('restaurant', isEqualTo: ref)
              .where('reaction', isEqualTo: reaction.name)
              .select([])))
      .length;
  Future<int> get numUps => reactionCount(Reaction.up);
  Future<int> get numDown => reactionCount(Reaction.down);
  Future<int> get numLoves => reactionCount(Reaction.love);
  Future<$pb.ReviewMarker_RestaurantCounts> get counts async => {
        'up': await numUps,
        'love': await numLoves,
        'down': await numDown,
        'favorite': await numFavorites,
      }.asProto($pb.ReviewMarker_RestaurantCounts());
  Future get updateRestaurantRecord async => await updateAlgoliaRecord(
        payload: await algoliaPayload,
        recordID: AlgoliaRecordID(ref, $pb.AlgoliaRecordType.restaurant),
        extraTags: tags,
      );

  Future<Map<String, dynamic>> get algoliaPayload async {
    final covers = await coverPhotos;
    return {
      'name': name,
      'fb_place_id': fbPlaceId,
      'location': proto.attributes.location.geoPoint,
      'popularity_score': popularityScore,
      'num_reviews': covers.isNotEmpty ? proto.numReviews : 0,
      'place_types': validPlaceTypes.map((e) => e.name).toList(),
      'place_type_scores': validPlaceTypeScores,
      // 'food_types': proto.attributes.foodTypes.map((e) => e.name).toList(),
      'place_categories': placeCategories.map((e) => e.name).toList(),
      'yelp_info': scrapeInfo(proto.yelpMatch, proto.yelp)..asJson,
      'google_info': scrapeInfo(proto.googleMatch, proto.google).asJson,
      'serialized_hours': serializedHours,
      'delivery': deliveryInfo,
      'pickup': pickupInfo,
      if (proto.hasFireProfilePic()) 'profile_pic': proto.fireProfilePic.asJson,
      'cover_photos': covers,
    }.ensureAs($pb.RestaurantCache());
  }

  List<String> get deliveryInfo => proto.deliveryScraped
      ? [
          if (proto.deliveryUrl.ubereats != '0' &&
              proto.deliveryInfo.ubereats.hasDelivery)
            'ubereats',
          if (proto.deliveryUrl.postmates != '0' &&
              proto.deliveryInfo.postmates.hasDelivery)
            'postmates',
          if (proto.deliveryUrl.grubhub != '0' &&
              proto.deliveryInfo.grubhub.hasDelivery)
            'grubhub',
          if (proto.deliveryUrl.doordash != '0' &&
              proto.deliveryInfo.doordash.hasDelivery)
            'doordash',
          if (proto.deliveryUrl.favor != '0' &&
              proto.deliveryInfo.favor.hasDelivery)
            'favor',
          if (proto.deliveryUrl.seamless != '0' &&
              proto.deliveryInfo.grubhub.hasDelivery)
            'seamless',
          if (proto.deliveryUrl.caviar != '0' &&
              proto.deliveryInfo.doordash.hasDelivery)
            'caviar',
        ]
      : [];

  List<String> get pickupInfo => proto.deliveryScraped
      ? [
          if (proto.deliveryUrl.ubereats != '0' &&
              proto.deliveryInfo.ubereats.hasPickup)
            'ubereats',
          if (proto.deliveryUrl.postmates != '0' &&
              proto.deliveryInfo.postmates.hasPickup)
            'postmates',
          if (proto.deliveryUrl.grubhub != '0' &&
              proto.deliveryInfo.grubhub.hasPickup)
            'grubhub',
          if (proto.deliveryUrl.doordash != '0' &&
              proto.deliveryInfo.doordash.hasPickup)
            'doordash',
          if (proto.deliveryUrl.favor != '0' &&
              proto.deliveryInfo.favor.hasPickup)
            'favor',
          if (proto.deliveryUrl.seamless != '0' &&
              proto.deliveryInfo.grubhub.hasPickup)
            'seamless',
          if (proto.deliveryUrl.caviar != '0' &&
              proto.deliveryInfo.doordash.hasPickup)
            'caviar',
        ]
      : [];

  $pb.ScrapeInfo scrapeInfo(bool match, $pb.ScraperResults results) =>
      $pb.ScrapeInfo()
        ..match = match
        ..scraperResult = ($pb.ScraperResults()
          ..avgRating = results.avgRating
          ..numReviews = results.numReviews);

  Future<List<$pb.CoverPhotoData>> get coverPhotos async {
    final discoverItems = await CollectionType.discover_items.coll
        .where('restaurant.reference', isEqualTo: ref)
        .get()
        .then((s) => s.documents
            .map((d) => DiscoverItems.make(d, transaction))
            .where((d) => d.proto.firePhotos.isNotEmpty)
            .sorted((d) => d.proto.numInstaLikes, desc: true)
            .take(10)
            .toList());
    return discoverItems.map(coverPhoto).withoutNulls.toList();
  }

  $pb.CoverPhotoData coverPhoto(DiscoverItem discoverItem) {
    final photo = discoverItem.proto.firePhotos.first;
    final ref = discoverItem.ref.path;
    if (ref.split('/').length != 2 ||
        photo.photoReference.path.split('/').length != 2 ||
        photo.firebaseStorage.split('/').length != 4) {
      return null;
    }
    final coverPhoto = $pb.CoverPhotoData();
    coverPhoto.data.addAll([
      ref.split('/')[1],
      photo.photoReference.path.split('/')[1],
      photo.firebaseStorage.split('/')[1],
      photo.firebaseStorage.split('/')[3],
      if (photo.hasPhotoSize()) photo.photoSize.height.toString(),
      if (photo.hasPhotoSize()) photo.photoSize.width.toString(),
    ]);
    return coverPhoto;
  }

  List<$pb.PlaceCategory> get placeCategories => [
        if (restaurantPlaceTypes
            .intersection(validPlaceTypes.toSet())
            .isNotEmpty)
          $pb.PlaceCategory.restaurants,
        if (kCafePlaceTypes.intersection(validPlaceTypes.toSet()).isNotEmpty)
          $pb.PlaceCategory.cafes,
        if (kDessertBakeryPlaceTypes
            .intersection(validPlaceTypes.toSet())
            .isNotEmpty)
          $pb.PlaceCategory.desserts,
        if (kBarPlaceTypes.intersection(validPlaceTypes.toSet()).isNotEmpty)
          $pb.PlaceCategory.bars,
      ];

  List<$pb.PlaceType> get validPlaceTypes =>
      validPlaceTypePairs.map((e) => e.key).toList();

  List<double> get validPlaceTypeScores =>
      validPlaceTypePairs.map((e) => e.value).toList();

  List<MapEntry<$pb.PlaceType, double>> get validPlaceTypePairs =>
      proto.attributes.placeTypeScores.length !=
              proto.attributes.placeTypes.length
          ? []
          : proto.attributes.placeTypeScores.enumerate
              .where((s) => s.value > 0.2)
              .map((s) => MapEntry(proto.attributes.placeTypes[s.key], s.value))
              .toList();

  List<String> get serializedHours {
    if (!proto.attributes.hours.hasHours) {
      return [];
    }
    final serializedHours = <String>[];
    final ranges = <Tuple2<int, int>, Set<int>>{};
    final hours = proto.attributes.hours;
    for (final day in [
      hours.mon,
      hours.tue,
      hours.wed,
      hours.thu,
      hours.fri,
      hours.sat,
      hours.sun
    ].enumerate) {
      if (!day.value.isOpen || !day.value.hasFbHours()) {
        continue;
      }
      for (final window in day.value.fbHours.hours) {
        final serializedWindow =
            Tuple2(serializeHour(window.open), serializeHour(window.close));
        if (!ranges.containsKey(serializedWindow)) {
          ranges[serializedWindow] = {};
        }
        ranges[serializedWindow].add(day.key);
      }
    }
    for (final range in ranges.entries) {
      final openWindow = range.key.item1.toString().padLeft(2, '0');
      final closeWindow = range.key.item2.toString().padLeft(2, '0');
      final days = serializeDays(range.value).toString().padLeft(3, '0');
      serializedHours.add('$openWindow$closeWindow$days');
    }
    return serializedHours;
  }

  int serializeHour(String hour) {
    final hourPart = int.parse(hour.split(':')[0]);
    final minutePart = int.parse(hour.split(':')[1]);
    return 4 * hourPart + minutePart ~/ 15;
  }

  int serializeDays(Set<int> days) =>
      days.map((d) => pow(2, d)).reduce((a, b) => a + b).toInt();

  Set<String> get tags => blackOwned ? {'black_owned'} : {};

  bool get blackOwned => proto.attributes.blackOwned;

  bool get hasMerchant => merchantReference != null;

  double get popularityScore =>
      0.5 * proto.gmYelpScore.zScore(kGmYelpMean, kGmYelpStdDev) +
      0.5 * proto.instagramScore.zScore(kIgMean, kIgStdDev);

  Future setRequiredFields() async {
    print('setRequiredFields');
    final updateData = {
      if (!proto.hasYelpScraped()) 'yelp_scraped': false,
      if (!proto.hasGoogleScraped()) 'google_scraped': false,
      if (!proto.hasDeliveryScraped()) 'delivery_scraped': false,
      if (!proto.attributes.hasPlaceTypesSet())
        'attributes.place_types_set': false,
      if (!proto.hasScoresUpToDate()) 'scores_up_to_date': false,
      if (!proto.attributes.hasQueriedHours())
        'attributes.queried_hours': false,
      'spatial_index': spatialIndex.asJson,
      'from_hidden_review': proto.fromHiddenReview,
      'geohash': Geohash.encode(geoPoint.latitude, geoPoint.longitude),
    };
    if (updateData.isEmpty) {
      return;
    }
    await updateSelf(updateData);
  }

  Future updatePopularityScore() async {
    print('updating popularity score');
    await updateSelf({'popularity_score': popularityScore});
  }

  double get yelpScore =>
      ratingScore(proto.yelp.avgRating, proto.yelp.numReviews);

  double get googScore =>
      // Yelp reviews are typically higher quality. Ouch. Burn!
      0.8 * ratingScore(proto.google.avgRating, proto.google.numReviews);

  Future updateAlgoliaRecords() async {
    print('updateAlgoliaRecords()');
    if (buildType != BuildType.prod || proto.numReviews <= 0) {
      return;
    }
    return updateRestaurantRecord;
  }

  Future setGooglePlaceId() async {
    if (googlePlaceId != null) {
      return;
    }
    await updateSelf(
        {'attributes.google_place_id': await getGooglePlaceId(name, geoPoint)},
        changeUpdatedAt: false);
  }

  @override
  List<AlgoliaRecordID> get algoliaRecordIDs =>
      [AlgoliaRecordID(ref, $pb.AlgoliaRecordType.restaurant)];

  Future<Favorite> createFavorites(TasteUser user) =>
      Favorite.createForRestaurantUser(this, user);

  Future<bool> removeFromFavorites(TasteUser user) async {
    return await Favorite.removeFavoriteForUser(this, user);
  }

  Future<bool> hasFavorite(TasteUser user) =>
      queryExists(favoritesQuery.where('user', isEqualTo: user.ref));

  Future<List<Bookmark>> get bookmarks async =>
      (await (await reviews).futureMap((r) => r.bookmarks)).flatten.toList();

  Future maybeUpdateChildCaches(Change<Restaurant> change) async {
    print('maybeUpdateChildCaches');
    if (!change.fieldsChanged({'attributes.location', 'attributes.address'})) {
      return;
    }
    await (await reviews)
        .futureMap((review) => review.restaurantWasUpdated(this));
  }

  Future updatePhoto(Restaurant old) async {
    print('updatePhoto');
    final externalUrl = proto.profilePicExternalUrl;
    if ((externalUrl?.isEmpty ?? true) ||
        (old.proto.profilePicExternalUrl == externalUrl)) {
      return;
    }
    final path =
        'restaurants/${ref.documentID}/uploads/${DateTime.now().microsecondsSinceEpoch}.jpg';
    final photo = await tasteStorage.uploadUrlPhoto(
      externalUrl,
      path,
    );
    await updateSelf({
      'profile_pic': photo,
      'fire_profile_pic': photo?.firePhoto,
    }.ensureAs(Restaurants.emptyInstance));
  }

  Future setMerchant(TasteUser merchant) =>
      updateSelf({'merchant': merchant.ref},
          changeUpdatedAt: true, validate: true);
}

/// Trying to balance between avg rating and # reviews. See "Yelp-Maps ratings
/// scoring analysis" notebook.
double ratingScore(double avgRating, int numReviews) {
  if (avgRating == 0 || numReviews == 0) {
    return 0;
  }
  return pow(3, avgRating).toDouble() * log(numReviews);
}

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
