import 'dart:typed_data';

import 'package:taste_cloud_functions/instagram_util.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_cloud_functions/types/instagram_location.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'insta_post.g.dart';

@RegisterType()
mixin InstaPost on FirestoreProto<$pb.InstaPost>, UserOwned {
  static final triggers = trigger<InstaPost>(
    delete: (r) => r.deleteReview(),
    create: (r) => r.proto.hidden
        ? r.proto.photosLabeled
            ? r.createScrapedReview()
            : r.processScrapedPost()
        : r.createReview(),
    update: (r, c) => r.updateReview(c),
  );

  Future<Review> get review async {
    final review = await CollectionType.reviews.coll
        .where('insta_post', isEqualTo: ref)
        .where('user', isEqualTo: proto.user.ref)
        .limit(1)
        .get();
    final homecooked = await CollectionType.home_meals.coll
        .where('insta_post', isEqualTo: ref)
        .where('user', isEqualTo: proto.user.ref)
        .limit(1)
        .get();
    assert(review.isEmpty || homecooked.isEmpty);
    final result = review.isEmpty ? homecooked : review;
    return result.isEmpty
        ? null
        : reviewOrHomeMeal(result.documents.first, transaction);
  }

  Future deleteReview({Review post, bool deletePhotos = true}) async {
    final instaReview = post ?? await review;
    if (instaReview == null) {
      return;
    }
    await instaReview.deleteSelf();
    if (deletePhotos) {
      final photos = proto.images.map((i) => i.photo.ref).toList();
      await deleteDynamic(photos.toSet());
    }
  }

  Future<String> get userUID =>
      memoize(() async => (await user).uid, 'userUID');

  Future<Map<String, List<int>>> createImageBytesMap() => proto.images
      .futureMap((e) async => MapEntry(
          e.standardRes.url, await tasteStorage.urlBytes(e.standardRes.url)))
      .then((m) => Map.fromEntries(m));

  Future createReview() async {
    final imageBytesMap = await createImageBytesMap();
    final post = await populatedInstaPost(imageBytesMap);
    final photos = await createPhotos(post, imageBytesMap);
    await updateSelf(post.asMap);
    if (photos.isEmpty) {
      await updateSelf({
        'has_review': false,
        '_extras.created_at': tasteServerTimestamp(),
      });
      return;
    }
    await createInstaReview(post, photos.map((p) => p.ref).toList());
    await updateSelf({
      'has_review': true,
      '_extras.created_at': tasteServerTimestamp(),
    });
  }

  Future processScrapedPost() async {
    print('InstaPost trigger without labeling for ${proto.link}');
    final imageBytesMap = await createImageBytesMap();
    var post = proto.clone();
    post.reaction = getReaction(post);
    final photos = await createPhotos(post, imageBytesMap, allPhotos: true);
    await updateSelf(post.asMap);
    if (photos.isEmpty) {
      await updateSelf({
        'has_review': false,
        'do_not_update': true,
        '_extras.created_at': tasteServerTimestamp(),
      });
      return;
    }
    await getScrapedFacebookLocation(post);
    await updateSelf(post.asMap);
    await updateSelf({
      'has_review': false,
      '_extras.created_at': tasteServerTimestamp(),
    });
  }

  Future updateExistingScrapedReview(Review review) async {
    print('InstaPost labeled and now possibly updating review ${proto.link}');
    final post = populateImageAnnotations();
    final photos = post.images
        .where((i) => i.isFoodOrDrink && !i.hasPerson)
        .map((i) => i.photo.ref)
        .toList();
    if (photos.isEmpty) {
      print('Deleting review for ${proto.link}');
      await updateSelf(post.asMap);
      await updateSelf({
        'do_not_update': true,
        'has_review': false,
        'image_annotations': Firestore.fieldValues.delete()
      });
      await deleteReview(post: review, deletePhotos: false);
      return;
    }
    await updateSelf(post.asMap);
    await updateSelf({'image_annotations': Firestore.fieldValues.delete()});
    if (review.proto.firePhotos.length == photos.length) {
      print('Review remains unchanged, no photos removed for ${proto.link}');
      return;
    }
    print('Updating photos for ${proto.link}');
    await review.updateSelf({
      'photo': photos.firstOrNull,
      'more_photos': photos.skip(1).toList(),
    });
  }

  Future createLabeledScrapedReview() async {
    print('InstaPost labeled and now creating review ${proto.link}');
    final post = populateImageAnnotations();
    final photos = post.images
        .where((i) => i.isFoodOrDrink && !i.hasPerson)
        .map((i) => i.photo.ref)
        .toList();
    if (photos.isEmpty) {
      await updateSelf(post.asMap);
      await updateSelf({
        'do_not_update': true,
        'image_annotations': Firestore.fieldValues.delete()
      });
      return;
    }
    final shouldCreateReview =
        await getScrapedFacebookLocation(post, incrementRequests: false);
    await updateSelf(post.asMap);
    await updateSelf({'image_annotations': Firestore.fieldValues.delete()});
    print('Maybe creating review for ${proto.link}: $shouldCreateReview');
    if (shouldCreateReview && !post.isHomecooked) {
      final createdReview =
          await createInstaReview(post, photos, createNew: true);
      print('Created review for ${proto.link} is $createdReview');
      await updateSelf({'has_review': createdReview});
    }
  }

  Future createScrapedReview() async {
    print('InstaPost create trigger for ${proto.link}');
    final imageBytesMap = await createImageBytesMap();
    final post = await populatedInstaPost(imageBytesMap, addHomecooked: false);
    final photos = await createPhotos(post, imageBytesMap);
    await updateSelf(post.asMap);
    if (photos.isEmpty) {
      await updateSelf({
        'has_review': false,
        'do_not_update': true,
        '_extras.created_at': tasteServerTimestamp(),
      });
      return;
    }
    final shouldCreateReview = await getScrapedFacebookLocation(post);
    await updateSelf(post.asMap);
    if (shouldCreateReview) {
      final createdReview =
          await createInstaReview(post, photos.map((p) => p.ref).toList());
      await updateSelf({
        'has_review': createdReview,
        '_extras.created_at': tasteServerTimestamp(),
      });
      return;
    }
    await updateSelf({
      'has_review': false,
      '_extras.created_at': tasteServerTimestamp(),
    });
  }

  Future updateReview(Change<InstaPost> change) async {
    print('InstaPost update trigger for ${proto.link}');
    final instaReview = await review;
    if (instaReview == null) {
      if (change.fieldChanged('photos_labeled') &&
          proto.photosLabeled &&
          proto.imageAnnotations.length == proto.images.length) {
        await createLabeledScrapedReview();
        return;
      }
      if (change.fieldChanged('fb_location') &&
          !proto.hasReview &&
          !proto.doNotUpdate &&
          proto.images
              .where((i) =>
                  i.hasIsFoodOrDrink() &&
                  i.isFoodOrDrink &&
                  i.hasHasPerson() &&
                  !i.hasPerson)
              .map((i) => i.photo.ref)
              .isNotEmpty &&
          !proto.isHomecooked &&
          proto.hasFbLocation() &&
          proto.hidden &&
          proto.photosLabeled) {
        await createReviewWithLocation();
      }
      return;
    }
    if (change.fieldChanged('photos_labeled') &&
        proto.photosLabeled &&
        proto.imageAnnotations.length == proto.images.length) {
      await updateExistingScrapedReview(instaReview);
      return;
    }
    if (change.fieldChanged('fb_location') &&
        !proto.hasFbLocation() &&
        change.before.proto.fbLocation.hasFbPlaceId()) {
      if (!instaReview.proto.hasRestaurant()) {
        return;
      }
      await updateSelf(
          {'is_homecooked': true, 'instagram_location.found_match': false});
      await deleteReviewRestaurant(instaReview);
      return;
    }
    if (change.fieldChanged('instagram_location') &&
        proto.hasInstagramLocation()) {
      await updateLocation(instaReview);
    }
    final foodTypesLists = getFoodTypesLists(proto.images);
    await instaReview.updateSelf({
      if (change.fieldChanged('hidden')) 'hidden': proto.hidden,
      if (change.fieldChanged('dish')) 'dish': proto.dish,
      if (change.fieldChanged('text')) 'text': proto.caption,
      if (change.fieldChanged('likes')) 'num_insta_likes': proto.likes,
      if (change.fieldChanged('num_followers'))
        'num_insta_followers': proto.numFollowers,
      // Always update food_types.
      'food_types': foodTypesLists.foodTypes,
      'food_types_photo_indices': foodTypesLists.foodTypesPhotoIndices
    }.ensureAs($pb.Review()));
  }

  Future createReviewWithLocation() async {
    final createdReview = await createInstaReview(
        proto, proto.images.map((e) => e.photo.ref).toList());
    await updateSelf({'has_review': createdReview});
  }

  Future<List<Photo>> createPhotos(
          $pb.InstaPost post, Map<String, List<int>> imageBytesMap,
          {bool allPhotos = false}) async =>
      (await post.images.enumerate.futureMap((k, v) async => Tuple2(
              v.isFoodOrDrink || allPhotos,
              await uploadInstagramImage(
                  v, imageBytesMap[v.standardRes.url], k))))
          .where((e) => e.item1)
          .map((e) => e.item2)
          .withoutNulls
          .toList();

  Future<Photo> uploadInstagramImage(
      $pb.InstagramImage image, List<int> imageBytes, int index) async {
    // The cloud time doesn't have anything past milliseconds so unfortunately this
    // can lead to collisions if there are multiple simultaneous imports. Adds a semi-random
    // noise to the microseconds based on the url's hashCode.
    final timestampNoise = image.standardRes.url.hashCode % 1000;
    final timestamp = DateTime.now().microsecondsSinceEpoch + timestampNoise;
    final path = 'users/${await userUID}/uploads/$timestamp.$index.jpg';
    final instagramImage = await tasteStorage.uploadToStorage(
        path, Uint8List.fromList(imageBytes));
    if (instagramImage != null) {
      image.photo = instagramImage.ref.proto;
    }
    return instagramImage;
  }

  Future<bool> createInstaReview(
      $pb.InstaPost post, List<DocumentReference> photoRefs,
      {bool createNew}) async {
    final reference =
        (post.isHomecooked ? CollectionType.home_meals : CollectionType.reviews)
            .coll
            .document();
    final existingRestaurant = post.isHomecooked
        ? null
        : await restaurantByFbPlace(post.fbLocation, proto.hidden,
            createNew: createNew ?? !post.hidden);
    if (!post.isHomecooked && existingRestaurant == null) {
      return false;
    }
    final foodTypesLists = getFoodTypesLists(post.images);
    await reference.setData(
      DocumentData.fromMap(
        {
          'user': post.user.ref,
          'photo': photoRefs.firstOrNull,
          'more_photos': photoRefs.skip(1).toList(),
          'dish': post.dish,
          'restaurant': existingRestaurant,
          'restaurant_name': post.isHomecooked ? null : post.fbLocation.name,
          'restaurant_location': post.isHomecooked
              ? null
              : {
                  'latitude': post.fbLocation.location.latitude,
                  'longitude': post.fbLocation.location.longitude,
                },
          'meal_type':
              post.isHomecooked ? $pb.Review_MealType.meal_type_home : null,
          'location': post.isHomecooked
              ? null
              : {
                  'latitude': post.fbLocation.location.latitude,
                  'longitude': post.fbLocation.location.longitude,
                },
          'address': post.isHomecooked ? null : post.fbLocation.address,
          'text': post.caption,
          'reaction': post.reaction,
          'insta_post': ref,
          'imported_at': tasteServerTimestamp(),
          'num_insta_likes': post.likes,
          'num_insta_followers': post.numFollowers,
          'hidden': post.hidden,
          '_extras': {
            'created_at': Timestamp(post.createdTime.seconds.toInt(), 0),
            'updated_at': tasteServerTimestamp(),
          },
          'food_types': foodTypesLists.foodTypes,
          'food_types_photo_indices': foodTypesLists.foodTypesPhotoIndices,
        }.ensureAs($pb.Review()),
      ),
    );
    return true;
  }

  Future updateLocation(Review post) async {
    final fbLocation = await getFacebookLocation();
    if (fbLocation == null) {
      await updateSelf({'instagram_location.found_match': false});
      return;
    }
    final resto = await restaurantByFbPlace(fbLocation, proto.hidden);
    await updateSelf({
      'fb_location': fbLocation.asMap,
      'is_homecooked': false,
      'instagram_location.found_match': true,
    });
    await updateReviewRestaurant(post, resto);
  }

  Future deleteReviewRestaurant(Review post) async => post.updateSelf({
        'restaurant': Firestore.fieldValues.delete(),
        'restaurant_name': Firestore.fieldValues.delete(),
        'address': Firestore.fieldValues.delete(),
        'restaurant_location': Firestore.fieldValues.delete(),
      });

  Future updateReviewRestaurant(Review post, DocumentReference resto) async {
    final discoverItem = (await post.allDiscoverItems()).firstOrNull;
    final restaurant = Restaurants.make(await resto.get(), transaction);
    await post.updateSelf({
      'restaurant': restaurant.ref,
      'restaurant_name': restaurant.name,
      'address': restaurant.proto.attributes.address.asMap,
      'restaurant_location': restaurant.proto.attributes.location.geoPoint
    });
    if (discoverItem != null) {
      await discoverItem.updateSelf({
        'restaurant': {
          'reference': restaurant.ref,
          'name': restaurant.name,
          'address': restaurant.proto.attributes.address.asMap,
        }
      });
    }
  }

  Future addIsFoodOrDrink(
          $pb.InstaPost post, Map<String, List<int>> imageBytesMap) =>
      post.images.futureMap((e) async {
        e.mlLabels
            .addAll(await getImageLabels(imageBytesMap[e.standardRes.url]));
        e.isFoodOrDrink = isFoodOrDrink(e.mlLabels);
      });

  Future<$pb.InstaPost> populatedInstaPost(Map<String, List<int>> imageBytesMap,
      {bool addHomecooked = true}) async {
    var post = proto.clone();
    await addIsFoodOrDrink(post, imageBytesMap);
    post..reaction = getReaction(post);
    if (addHomecooked) {
      post..isHomecooked = true;
    }
    return post;
  }

  bool hasFoodOrDrink($pb.ImageAnnotations annotations) =>
      annotations.isFood > 0.6 || annotations.isDrink > 0.5;

  bool hasPerson($pb.ImageAnnotations annotations) =>
      annotations.personDetections.isNotEmpty &&
      annotations.personDetections
          .any((p) => p.confidence > 0.95 && p.bboxArea > 0.02);

  $pb.InstaPost populateImageAnnotations() {
    var post = proto.clone();
    post.images.enumerate.forEach((element) {
      final image = element.value;
      final annotation = post.imageAnnotations[element.key];
      image.imageAnnotations = annotation;
      if (!image.hasIsFoodOrDrink()) {
        image.isFoodOrDrink = hasFoodOrDrink(annotation);
      }
      image.hasPerson = hasPerson(annotation);
    });
    post.imageAnnotations.clear();
    return post;
  }

  $pb.Reaction getReaction($pb.InstaPost post) {
    if (post.caption.toLowerCase().contains(' love ') ||
        post.caption.toLowerCase().contains(' favorite ')) {
      return $pb.Reaction.love;
    }
    return $pb.Reaction.up;
  }

  Future<$pb.FacebookLocation> getFacebookLocation() async {
    if (!proto.hasInstagramLocation() ||
        proto.instagramLocation.name.isEmpty ||
        locationIsCity(proto.instagramLocation.name) ||
        !proto.instagramLocation.location.hasLatitude() ||
        !proto.instagramLocation.location.hasLongitude() ||
        proto.hidden) {
      return null;
    }
    final location = proto.instagramLocation;
    final result = await fbPlaces.nearbyPlaces(
        lat: location.location.latitude,
        lng: location.location.longitude,
        term: location.name,
        maxDistanceMeters: 300.0);
    if (result.limitReached) {
      print('Error: FB Graph API Limit Reached');
    }
    if (result?.result?.isEmpty ?? true) {
      return null;
    }
    return createFacebookLocation(result.result.first);
  }

  Future<bool> getScrapedFacebookLocation($pb.InstaPost post,
      {bool incrementRequests = true}) async {
    if (post.hasFbLocation()) {
      post.isHomecooked = false;
      return true;
    }
    if (!post.instagramLocation.hasLocation() ||
        post.instagramLocation.id.isEmpty ||
        post.instagramLocation.name.isEmpty ||
        locationIsCity(post.instagramLocation.name)) {
      post
        ..doNotUpdate = true
        ..isHomecooked = true;
      return true;
    }
    var location = (await wrapQuery(
                CollectionType.instagram_locations.coll
                    .where('id', isEqualTo: post.instagramLocation.id)
                    .limit(1),
                InstagramLocations.make))
            .firstOrNull ??
        await InstagramLocations.createNew(transaction,
            data: post.instagramLocation.documentData);
    if (location.proto.hasFbLocation()) {
      post
        ..isHomecooked = false
        ..fbLocation = location.proto.fbLocation;
      return true;
    }
    if (location.proto.queriedLocation) {
      post.isHomecooked = true;
      return true;
    }
    await location.updateSelf({
      'queried_location': false,
      if (incrementRequests) 'num_requests': Firestore.fieldValues.increment(1),
    });
    return false;
  }
}
