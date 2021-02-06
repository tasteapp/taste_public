import 'dart:math';

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:expire_cache/expire_cache.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/taste_backend_client/responses/restaurant.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/fb_places_api.dart';

import 'package:taste_protos/taste_protos.dart' as $pb;

class AlgoliaRestaurant with EquatableMixin {
  const AlgoliaRestaurant(this.reference, this.cache, this.restoWrapper);

  static AlgoliaRestaurant fromResult(AlgoliaObjectSnapshot result) =>
      AlgoliaRestaurant(
          Firestore.instance
              .document(result.data['reference'] as String ?? result.objectID),
          result.data.asProto($pb.RestaurantCache()),
          RestaurantWrapper());

  static AlgoliaRestaurant fromRestaurant(Restaurant resto) =>
      AlgoliaRestaurant(
          resto.reference,
          resto.algoliaRestaurantCache.asProto($pb.RestaurantCache()),
          RestaurantWrapper(restaurant: resto));

  final DocumentReference reference;
  final $pb.RestaurantCache cache;
  final RestaurantWrapper restoWrapper;

  LatLng get location => LatLng(cache.geoloc.lat, cache.geoloc.lng);
  String get name => cache.name;
  String get fbPlaceId => cache.fbPlaceId;
  List<$pb.PlaceType> get placeTypes => cache.placeTypes;
  List<double> get placeTypeScores => cache.placeTypeScores;
  List<$pb.FoodType> get foodTypes => cache.foodTypes;
  List<$pb.PlaceCategory> get placeCategories => cache.placeCategories;
  $pb.ScrapeInfo get yelpInfo => cache.yelpInfo;
  $pb.ScrapeInfo get googleInfo => cache.googleInfo;
  double get popularityScore => cache.popularityScore;
  int get numReviews => cache.numReviews;
  List<String> get serializedHours => cache.serializedHours;
  $pb.FirePhoto get profilePic => cache.profilePic;
  List<$pb.CoverPhotoData> get coverPhotoData => cache.coverPhotos;

  List<String> get deliveryProviders => cache.delivery;

  List<$pb.CoverPhoto> get coverPhotos =>
      coverPhotoData.map(deserializeCoverPhotoData).withoutNulls.toList();

  $pb.CoverPhoto deserializeCoverPhotoData($pb.CoverPhotoData data) {
    try {
      final coverPhoto = $pb.CoverPhoto();
      final firePhoto = $pb.FirePhoto();
      final discoverItemRef = "discover_items/${data.data[0]}".ref.proto;
      final photosRef = "photos/${data.data[1]}".ref.proto;
      final storagePath = "users/${data.data[2]}/uploads/${data.data[3]}";
      coverPhoto.reference = discoverItemRef;
      firePhoto
        ..photoReference = photosRef
        ..firebaseStorage = storagePath;
      if (data.data.length == 6) {
        final height = int.parse(data.data[4]);
        final width = int.parse(data.data[5]);
        firePhoto.photoSize = $pb.Size()
          ..height = height
          ..width = width;
      }
      coverPhoto.photo = firePhoto;
      return coverPhoto;
    } catch (e) {
      print("Error deserializing cover photo for: $path");
      return null;
    }
  }

  bool get hasDelivery => cache.delivery.isNotEmpty;

  bool get yelpMatch => cache.yelpInfo.match;
  bool get googleMatch => cache.googleInfo.match;

  $pb.FirePhoto get mapPic => coverPhotos.firstOrNull?.photo ?? profilePic;

  static final _picCache = ExpireCache<DocumentReference, Future<String>>(
      sizeLimit: 500, expireDuration: const Duration(days: 1));
  Future<String> get profilePicture =>
      _picCache.putIfAbsent(reference, () async {
        if (cache.hasProfilePic()) {
          return cache.profilePic.url(Resolution.full);
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

  $pb.Restaurant_Hours get restoHours {
    var hours = $pb.Restaurant_Hours.create()..hasHours = false;
    var days = Iterable<$pb.Restaurant_FacebookHours>.generate(
        7, (i) => $pb.Restaurant_FacebookHours()).toList();
    for (final window in serializedHours) {
      if (window.length != 7) {
        continue;
      }
      final open = decodeTime(window.substring(0, 2));
      final close = decodeTime(window.substring(2, 4));
      applicableWeekdays(window.substring(4))
        ..forEach((d) {
          hours..hasHours = true;
          days[d].hours.add($pb.Restaurant_OpenWindow()
            ..open = open
            ..close = close);
        });
    }
    if (!hours.hasHours) {
      return hours;
    }
    hours
      ..mon = getHours(days[0])
      ..tue = getHours(days[1])
      ..wed = getHours(days[2])
      ..thu = getHours(days[3])
      ..fri = getHours(days[4])
      ..sat = getHours(days[5])
      ..sun = getHours(days[6]);
    if (path == "restaurants/DdxZi0tPzzWQxGLY9XDe") {
      print("\n\n");
      print(name);
      print(path);
      print("Serialized hours: $serializedHours");
      print("Hours: $hours");
    }
    return hours;
  }

  $pb.Restaurant_HoursInfo getHours($pb.Restaurant_FacebookHours hours) {
    if (hours.hours.isEmpty) {
      return $pb.Restaurant_HoursInfo()..isOpen = false;
    }
    return $pb.Restaurant_HoursInfo()
      ..isOpen = true
      ..fbHours = hours;
  }

  String decodeTime(String serialized) {
    final windowInt = int.parse(serialized);
    final hours = (windowInt ~/ 4).toString().padLeft(2, '0');
    final minutes = (15 * (windowInt % 4)).toString().padLeft(2, '0');
    return "$hours:$minutes";
  }

  List<int> applicableWeekdays(String serialized) {
    final weekdaysInt = int.parse(serialized);
    if (weekdaysInt < 0 || weekdaysInt > 127) {
      return [];
    }
    return Iterable<int>.generate(7)
        .where((i) => weekdaysInt % pow(2, i + 1).toInt() >= pow(2, i))
        .toList();
  }

  bool get isOpen => isRestaurantOpen(restoHours);

  String get path => reference.path;

  @override
  List<Object> get props => [path];
}

class RestaurantWrapper {
  RestaurantWrapper({this.restaurant});
  Restaurant restaurant;
}
