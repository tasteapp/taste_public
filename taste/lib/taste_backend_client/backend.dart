import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_version/get_version.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taste/algolia/client.dart';
import 'package:taste/algolia/search_result.dart';
import 'package:taste/providers/firebase_user_provider.dart';
import 'package:taste/screens/restaurant/restaurant_page.dart';
import 'package:taste/taste_backend_client/responses/city.dart';
import 'package:taste/taste_backend_client/responses/conversation.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/responses/favorite.dart';
import 'package:taste/taste_backend_client/responses/insta_post.dart';
import 'package:taste/taste_backend_client/responses/instagram_location.dart';
import 'package:taste/taste_backend_client/responses/instagram_token.dart';
import 'package:taste/taste_backend_client/responses/recipe_request.dart';
import 'package:taste/taste_backend_client/responses/tag.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/fb_places_api.dart';
import 'package:taste/utils/logging.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;
import 'package:taste_protos/taste_protos.dart' show FirePhoto;

import '../utils/fire_photo.dart';
import 'responses/badge.dart';
import 'responses/responses.dart';

export 'responses/responses.dart';

Future<Map<String, String>> get metadata async => {
      'appID': await GetVersion.appID,
      'appName': await GetVersion.appName,
      'platformVersion': await GetVersion.platformVersion,
      'projectCode': await GetVersion.projectCode,
      'projectVersion': await GetVersion.projectVersion,
    };

Stream<Set<DocumentReference>> fetchFollowing([DocumentReference user]) =>
    CollectionType.followers.coll
        .where('follower', isEqualTo: user ?? currentUserReference)
        .stream<Follower>()
        .map((x) => x.map((x) => x.proto.following.ref).toSet());
Stream<Set<DocumentReference>> fetchFollowers([DocumentReference user]) =>
    CollectionType.followers.coll
        .where('following', isEqualTo: user ?? currentUserReference)
        .stream<Follower>()
        .map((x) => x.map((x) => x.proto.follower.ref).toSet());

TasteFirebaseUser get currentUser => tasteFirebaseUser.value;

Stream<bool> get hasUnseenMessagesStream => conversations()
    .map((convos) => convos.where((convo) => !convo.seen).isNotEmpty);

bool get isCurrentlyLoggedIn => _getCurrentUid?.isNotEmpty ?? false;

const masterCallFnName = 'tasteCall';

Future<Map<String, dynamic>> cloudCall(String fn, [dynamic data]) async {
  logger.d('CLOUD CALL $fn with data: \n $data');
  try {
    return Map.from((await CloudFunctions(region: "us-central1")
            .getHttpsCallable(functionName: masterCallFnName)
            .call({
      'fn': fn,
      'payload': data,
      'metadata': await metadata,
    }))
        .data as Map);
  } on CloudFunctionsException catch (e) {
    final reason = ["Unexpected CFE", e.code, e.details, e.message].join(', ');
    logger.e("CLOUD ERROR! $e $reason");
    return {'success': false, 'reason': reason};
  }
}

String get _getCurrentUid =>
    currentUser.maybeWhen(user: (user) => user.uid, orElse: () => '');

DocumentReference get currentUserReference =>
    CollectionType.users.coll.document(_getCurrentUid);
final _reportError = logger.e;

Future<Photo> _photoRecord({@required String path}) async {
  final completer = Completer<Photo>();
  final stream = CollectionType.photos.coll
      .where('firebase_storage_path', isEqualTo: path)
      .limit(1)
      .snapshots();
  StreamSubscription subscription;
  subscription = stream.listen((snapshot) async {
    if (snapshot.documents.isEmpty) {
      return;
    }
    completer.complete(Photo(snapshot.documents.first));
    await subscription.cancel();
  });
  return completer.future;
}

Future<FirePhoto> uploadPhoto(File file, [int identifier]) async {
  final imageType = file.path.split('.')?.lastOrNull ?? 'jpg';
  final uploadPath = FirebaseStorage.instance
      .ref()
      .child('users/$_getCurrentUid/uploads')
      .child([DateTime.now().microsecondsSinceEpoch, identifier, imageType]
          .withoutNulls
          .join('.'));
  final waitTypes = {
    StorageTaskEventType.failure,
    StorageTaskEventType.success
  };
  final event = await uploadPath
      .putFile(file, StorageMetadata(contentType: 'image/$imageType'))
      .events
      .firstWhere((e) {
    return waitTypes.contains(e.type);
  });

  if (event.type == StorageTaskEventType.failure) {
    _reportError("Could not upload file $event");
  }
  final photo = await _photoRecord(path: uploadPath.path);
  final firePhoto = photo.firePhoto;
  final thumb = firePhoto.url(Resolution.thumbnail);
  // Guard against race condition on fetching the thumbnail and having the thumbnail be public
  while (await DefaultCacheManager()
          .getFileStream(thumb)
          .map((a) => false)
          .onErrorReturnWith((e) => true)
          .first ??
      true) {
    await 1.seconds.wait;
  }
  return firePhoto;
}

final restaurantPostsStream = CollectionType.discover_items.coll
    .visibleNoContext()
    .where('user.reference', isEqualTo: currentUserReference)
    .stream<DiscoverItem>()
    .listWhere((x) => x.isRestaurant)
    .shareValue()
      ..subscribe;

Stream<List<Restaurant>> restaurantsByCity(City city,
    {bool onlyBlackOwned = false}) {
  var restos = CollectionType.restaurants.coll
      .where('attributes.address.city', isEqualTo: city.city)
      .where('attributes.address.country', isEqualTo: city.country);
  if (city.state.isNotEmpty) {
    restos = restos.where('attributes.address.state', isEqualTo: city.state);
  }
  if (onlyBlackOwned) {
    restos = restos.where('attributes.black_owned', isEqualTo: true);
  }
  return restos
      .limit(50)
      .snapshots()
      .map((snapshot) => snapshot.documents.map(Restaurant.make).toList())
      .map((l) {
    l.sort((a, b) => a.comparison(b));
    return l.reversed.toList();
  });
}

Future<DocumentReference> reportContentCall(DocumentReference reference,
        {String text}) =>
    CollectionType.reports.coll.add({
      'parent': reference,
      'text': text,
      'user': currentUserReference
    }.ensureAs($pb.Report()).withExtras);

Stream<List<Restaurant>> favoritesStream({DocumentReference user}) =>
    CollectionType.favorites.coll
        .forUser(user ?? currentUserReference)
        .stream<Favorite>()
        .deepMap((v) => v.restaurantRef.stream());

Future<List<SearchResult>> searchEverything(
        {LatLng location,
        String term,
        LatLngBounds bounds,
        Set<String> tags,
        Set<DocumentReference> following}) =>
    algoliaClient.search(
        index: 'discover',
        bounds: bounds,
        tags: tags,
        location: location,
        term: term,
        following: following);

Future updateVanity(Map<String, dynamic> data) => currentUserReference
    .setData({'vanity': data}.ensureAs($pb.TasteUser()), merge: true);

Stream<List<CoverPhotoData>> restaurantPageData(Restaurant restaurant) =>
    CollectionType.discover_items.coll
        .visible()
        .where('restaurant.reference', isEqualTo: restaurant.reference)
        .stream<DiscoverItem>()
        .map((rs) => rs
            .sorted((r) => r.score, desc: true)
            .expand((r) => r.firePhotos
                .map((photo) => CoverPhotoData(review: r, firePhoto: photo)))
            .toList());

Stream<bool> isFavoritedStream(DocumentReference restaurantRef) =>
    CollectionType.favorites.coll
        .forUser(currentUserReference)
        .where('restaurant', isEqualTo: restaurantRef)
        .existsStream;

Stream<List<Badge>> badgeLeaderboard(Badge badge) => CollectionType.badges.coll
    .where('type', isEqualTo: badge.type.name)
    .where('count_data.count', isGreaterThan: 0)
    .orderBy('count_data.count', descending: true)
    .stream<Badge>()
    .map((bs) => bs.where((b) => b.unlocked).toList());

Future<Restaurant> restaurantByFbPlace(FacebookPlaceResult place,
        {bool create = false}) async =>
    await CollectionType.restaurants.coll
        .where('attributes.fb_place_id', isEqualTo: place.id)
        .stream<Restaurant>()
        .map((event) => event?.firstOrNull)
        .first ??
    (!create
        ? null
        : Restaurant.make(await (await CollectionType.restaurants.coll.add({
            'attributes': {
              'location': {
                'latitude': place.location?.latitude,
                'longitude': place.location?.longitude,
              },
              'name': place.name,
              'address': await findAddress(place, place.location),
              'fb_place_id': place.id,
              'categories': place.restaurantCategories,
            }
          }.ensureAs($pb.Restaurant()).withExtras))
            .get()));

Future<TasteUser> userByUsername(String username) => CollectionType.users.coll
    .where('vanity.username', isEqualTo: username)
    .limit(1)
    .stream<TasteUser>()
    .map((event) => event.firstOrNull)
    .first;

Stream<List<DiscoverItem>> tagSearch(String tag) =>
    CollectionType.discover_items.coll
        .visible()
        .orderBy('date', descending: true)
        .where('tags', arrayContains: tag)
        .stream();

Stream<List<DiscoverItem>> deliveryAppSearch(
        $pb.Review_DeliveryApp deliveryApp) =>
    CollectionType.discover_items.coll
        .visible()
        .orderBy('date', descending: true)
        .where('review.delivery_app', isEqualTo: deliveryApp.toString())
        .stream();

Stream<DiscoverItem> discoverItem(DocumentReference review) =>
    CollectionType.discover_items.coll
        .visible()
        .where('reference', isEqualTo: review)
        .limit(1)
        .stream<DiscoverItem>()
        .map((ds) => ds.firstOrNull);

Stream<List<City>> citiesStream() => CollectionType.cities.coll
    .where('popularity_score', isGreaterThan: 200)
    .orderBy('popularity_score', descending: true)
    .stream();

Stream<List<Tag>> tags() => CollectionType.tags.coll
    .orderBy('trending_score', descending: true)
    .stream();

Future<List<InstaPost>> instaPosts(DocumentReference user, String userId) =>
    CollectionType.insta_posts.coll
        .forUser(currentUserReference)
        .where('user', isEqualTo: user)
        .where('user_id', isEqualTo: userId)
        .orderBy('created_time', descending: true)
        .fetch();

Future<InstagramLocation> getExistingInstagramLocation(String id) =>
    CollectionType.instagram_locations.coll
        .where('id', isEqualTo: id)
        .limit(1)
        .getDocuments()
        .then((querySnapshot) => querySnapshot.documents
            .map((p) => InstagramLocation(p))
            .toList()
            .firstOrNull);

// TODO(alex): figure out why location.asMap converts some ids
// (such as San Francisco's) to timestamp.
Future backendCreateInstagramLocation($pb.InstagramLocation location) =>
    CollectionType.instagram_locations.coll.add({
      'location': location.location.geoPoint,
      'name': location.name,
      'id': location.id,
      'address': location.address,
      'post_ids': location.postCodes,
    }.withoutNulls);

Stream<List<Conversation>> conversations() => CollectionType.conversations.coll
    .where('members', arrayContains: currentUserReference)
    .stream();

// Reuse any existing conversation with another user.
// Ensures only 1 other user.
Future<Conversation> conversationWith(DocumentReference otherUser,
    {bool create = true}) async {
  final results = (await CollectionType.conversations.coll
          .where('members', arrayContains: currentUserReference)
          .getDocuments())
      .documents
      .map((s) => Conversation(s))
      .where((convo) =>
          convo.otherUsers.length == 1 && convo.otherUsers.first == otherUser);
  if (results.isNotEmpty) {
    return results.first;
  }
  final ref = await CollectionType.conversations.coll.add({
    'members': [
      currentUserReference,
      otherUser,
    ]
  }.ensureAs($pb.Conversation()).withExtras);
  return Conversation(await ref.get());
}

Stream<InstagramToken> instagramTokenStream(DocumentReference reference) =>
    reference.snapshots().map((t) => InstagramToken(t));

Future<InstagramToken> getInstagramToken() async =>
    (await CollectionType.instagram_tokens.coll
            .forUser(currentUserReference)
            .limit(1)
            .getDocuments())
        .documents
        .map((snapshot) => InstagramToken(snapshot))
        .firstOrNull;

Future<InstagramToken> createOrUpdateInstagramToken(String code) async {
  final token = await getInstagramToken() ??
      InstagramToken(await (await CollectionType.instagram_tokens.coll.add({
        'user': currentUserReference,
        'code': code,
      }.ensureAs($pb.InstagramToken()).withExtras))
          .get());
  if (token.proto.code != code) {
    await token.reference
        .updateData({'code': code, 'token_status': FieldValue.delete()});
  }
  return token;
}

void cloudLog(dynamic payload) => cloudCall('log', payload);

Stream<Set<DocumentReference>> recipeRequesters(DocumentReference post) =>
    CollectionType.recipe_requests.coll
        .forParent(post)
        .stream<RecipeRequest>()
        .map((r) => r.map((r) => r.userReference).toSet());

final tasteUserStream = tasteFirebaseUser
    .switchMap((value) => value.maybeWhen(
          user: (user) => CollectionType.users.coll
              .where('uid', isEqualTo: user.uid)
              .stream<TasteUser>()
              .map((s) => s.firstOrNull),
          orElse: () => Stream.value(null),
        ))
    .withoutNulls
    .subscribe;
Future<TasteUser> get cachedLoggedInUser => tasteUserStream.firstNonNull;
