import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expire_cache/expire_cache.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/screens/restaurant/restaurant_page.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/parent_user_index.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/fb_places_api.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/photo_regexp.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;
import 'package:taste_protos/taste_protos.dart' show Reaction, GrouperIterable;

import 'favorite.dart';
import 'responses.dart';

class Restaurant extends SnapshotHolder<$pb.Restaurant> {
  Restaurant(DocumentSnapshot e)
      : _favoriteable = favoriteable(e),
        super(e);
  final ParentUserIndex _favoriteable;
  Stream<List<Review>> get reviews => CollectionType.reviews.coll
      .visibleNoContext()
      .where('restaurant', isEqualTo: reference)
      .orderBy('score', descending: true)
      .stream();
  Stream<List<CoverPhotoData>> get reviewPhotos => restaurantPageData(this);
  Stream<List<TasteUser>> get favoritedUsers => CollectionType.favorites.coll
      .where('restaurant', isEqualTo: reference)
      .snapshots()
      .asyncMap((s) => Future.wait(
            s.documents.map((favorite) async => TasteUser.from(
                await (favorite.data['user'] as DocumentReference).get())),
          ));

  bool get acceptsReferrals => proto.hasMerchant();

  $pb.Restaurant_Attributes_Address get _address => proto.attributes.address;
  String get address => _address.simple;
  String get streetAddress => _address.detailed;

  bool get isOpen => isRestaurantOpen(proto.attributes.hours);

  bool get blackOwned => proto?.attributes?.blackOwned ?? false;

  Stream<List<TasteUser>> get favorites => CollectionType.favorites.coll
      .where('restaurant', isEqualTo: reference)
      .stream<Favorite>()
      .asyncMap((t) => t.futureMap((t) => t.user));

  static final _picCache = ExpireCache<DocumentReference, Future<String>>(
      sizeLimit: 500, expireDuration: const Duration(days: 1));
  Future<String> get profilePicture =>
      _picCache.putIfAbsent(reference, () async {
        if (proto.hasFireProfilePic()) {
          return proto.fireProfilePic.url(Resolution.full);
        }
        // TODO(team): Remove once cache is clear.
        if (proto.hasProfilePic()) {
          return (await proto.profilePic.ref.fetch<Photo>())
              .firePhoto
              .url(Resolution.full);
        }
        if (proto.profilePicExternalUrl?.isNotEmpty ?? false) {
          return proto.profilePicExternalUrl;
        }
        if (fbPlaceId == null) {
          return Future.value("");
        }
        final profilePicUrl =
            await FacebookPlacesManager.instance.getProfilePicture(fbPlaceId);
        if (profilePicUrl.item1.isNotEmpty &&
            profilePicUrl.item2 == ProfilePicSource.facebook) {
          unawaited(reference
              .updateData({'profile_pic_external_url': profilePicUrl.item1}));
        }
        return profilePicUrl.item1;
      });

  bool get hasAddress => proto.attributes.hasAddress();

  static Restaurant make(DocumentSnapshot snapshot) => Restaurant(snapshot);

  String get name => proto.attributes.name;
  GeoPoint get _geoPoint => proto.attributes.hasLocation()
      ? proto.attributes.location.geoPoint
      : proto.attributes.address.sourceLocation.geoPoint;
  LatLng get location => _geoPoint.latLng;
  Future<FacebookPlaceResult> get fbPlace => fbPlaceId?.isEmpty ?? true
      ? null
      : FacebookPlacesManager.instance.getPlaceById(fbPlaceId);
  String get fbPlaceId =>
      proto.attributes.hasFbPlaceId() ? proto.attributes.fbPlaceId : null;

  double get popularityScore => proto.popularityScore;

  List<String> get categories => proto.attributes.categories;

  Map<String, dynamic> get algoliaRestaurantCache => {
        'name': name,
        'fb_place_id': fbPlaceId,
        'location': proto.attributes.location.geoPoint,
        'popularity_score': popularityScore,
        'num_reviews': proto.numReviews,
        'place_types': validPlaceTypes.map((e) => e.key.name).toList(),
        'place_type_scores': validPlaceTypes.map((e) => e.value).toList(),
        'food_types': proto.attributes.foodTypes.map((e) => e.name).toList(),
        'yelp_info': scrapeInfo(proto.yelpMatch, proto.yelp),
        'google_info': scrapeInfo(proto.googleMatch, proto.google),
        if (proto.hasFireProfilePic())
          'profile_pic': proto.fireProfilePic.asJson,
        '_geoloc': ($pb.GeoLoc()
              ..lat = proto.attributes.location.latitude
              ..lng = proto.attributes.location.longitude)
            .asJson,
      }.ensureAs($pb.RestaurantCache());

  $pb.ScrapeInfo scrapeInfo(bool match, $pb.ScraperResults results) =>
      $pb.ScrapeInfo()
        ..match = match
        ..scraperResult = ($pb.ScraperResults()
          ..avgRating = results.avgRating
          ..numReviews = results.numReviews);

  List<MapEntry<$pb.PlaceType, double>> get validPlaceTypes =>
      proto.attributes.placeTypeScores.length !=
              proto.attributes.placeTypes.length
          ? []
          : proto.attributes.placeTypeScores.enumerate
              .where((s) => s.value > 0.2)
              .map((s) => MapEntry(proto.attributes.placeTypes[s.key], s.value))
              .toList();

  @override
  String toString() => name;

  // Compares two restaurants by popularity then avg. Google/Yelp
  // review score. Note: Sorting by this leads to ascending scores.
  int comparison(Restaurant other) {
    int cmp = popularityScore.compareTo(other.popularityScore);
    return cmp != 0
        ? cmp
        : externalReviewScore.compareTo(other.externalReviewScore);
  }

  int get numExternalReviews => proto.yelp.numReviews + proto.google.numReviews;

  double get externalReviewScore => numExternalReviews > 0
      ? (proto.google.avgRating * proto.google.numReviews +
              proto.yelp.avgRating * proto.yelp.numReviews) /
          numExternalReviews
      : 0.0;

  Future favorite({bool enable = true}) async {
    if (!enable) {
      TAEvent.remove_favorite();
    }
    await _favoriteable.toggle(enable);
  }

  Stream<Map<Reaction, int>> get reactions =>
      reviews.map((reviews) => reviews.counts((r) => r.reaction));
  Stream<int> get ups => reactions.map((r) => r[Reaction.up]);
  Stream<int> get downs => reactions.map((r) => r[Reaction.down]);
  Stream<int> get loves => reactions.map((r) => r[Reaction.love]);

  Future goTo() => goToRestaurantPage(restaurant: this);
}

bool isRestaurantOpen($pb.Restaurant_Hours hours) {
  if (!hours.hasHours) {
    return false;
  }
  final now = DateTime.now();
  final todayHours = [
    hours.mon,
    hours.tue,
    hours.wed,
    hours.thu,
    hours.fri,
    hours.sat,
    hours.sun
  ][now.weekday - 1];
  return todayHours.fbHours.hours
      .any((w) => isWithinWindow(now, w.open, w.close));
}

bool isWithinWindow(DateTime now, String open, String close) {
  int openHour = int.parse(open.split(":")[0]);
  int closeHour = int.parse(close.split(":")[0]);
  closeHour = closeHour == 0 ? 24 : closeHour;
  if (now.hour > openHour && now.hour < closeHour) {
    return true;
  }
  if (now.hour < openHour || now.hour > closeHour) {
    return false;
  }
  int openMinutes = int.parse(open.split(":")[1]);
  int closeMinutes = int.parse(close.split(":")[1]);
  return now.minute >= openMinutes && now.minute < closeMinutes;
}

Future<$pb.Restaurant_Attributes_Address> findAddress(
    FacebookPlaceResult fbPlace, LatLng location) async {
  if (fbPlace == null) {
    return geocoded(location);
  }
  if (fbPlace.street?.isEmpty ?? false) {
    return geocoded(fbPlace.location);
  }
  return fbPlace.address;
}
