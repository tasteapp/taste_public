import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/responses/parent_user_index.dart';
import 'package:taste/taste_backend_client/responses/restaurant.dart';
import 'package:taste/taste_backend_client/responses/snapshot_holder.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/fire_photo.dart';
import 'package:taste/utils/proto_transforms.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

mixin Post<T extends GeneratedMessage> on SnapshotHolder<T>, UserOwned {
  String get dish;
  DocumentReference get postReference;
  DocumentReference get instaPost;
  Future<DiscoverItem> get discoverItem;
  bool get isFrozen;

  int get score => byName('score') as int;
  List<String> get categories => List.from(byName('categories') as List);

  bool get hasInstaPost => instaPost?.path?.isNotEmpty ?? false;
  bool get shouldShowAddDish => isEmptyInstagramDish && isMine;
  bool get shouldShowEditRestaurant => hasInstaPost && isMine && !isFrozen;
  bool get isEmptyInstagramDish => hasInstaPost && dish.isEmpty;
  String get displayDish => isEmptyInstagramDish ? "" : dish;
  DateTime get dailyTasty;
  bool get hasDailyTasty => dailyTasty?.isAfter(DateTime(1980)) ?? false;
  DocumentReference get restaurantRef;
  bool get isHomeCooked;
  bool get isRestaurant => !isHomeCooked;

  List<FirePhoto> get firePhotos {
    final photos = List<FirePhoto>.from(byName('firePhotos') as List);
    if (photos.isNotEmpty) {
      return photos;
    }
    if (this is Review) {
      return List<$pb.DocumentReferenceProto>.from(
              [byName('photo'), ...byName('morePhotos') ?? []])
          .listMap(referenceOnlyFirePhoto);
    }
    return List<String>.from([byName('photo'), ...byName('morePhotos') ?? []])
        .listMap(fixedFirePhoto);
  }

  bool get isMultiPhoto => firePhotos.length > 1;
  FirePhoto get firePhoto => firePhotos.firstOrNull ?? emptyFirePhoto;
  String get recipe;
  bool get hasRecipe => recipe?.isNotEmpty ?? false;
  ParentUserIndex get _recipeRequester =>
      ParentUserIndex(postReference, CollectionType.recipe_requests);

  Stream<Post> get asStream;
  Future requestRecipe() => _recipeRequester.update(enable: true);
  Future removeRecipeRequest() {
    TAEvent.unrequested_recipe();
    return _recipeRequester.update(enable: false);
  }

  Stream<bool> requestedRecipe() => _recipeRequester.exists;
  Stream<Restaurant> get restaurant =>
      isHomeCooked ? Stream.value(null) : restaurantRef.stream();

  @protected
  ParentUserIndex get bookmarkable =>
      ParentUserIndex(postReference, CollectionType.bookmarks);
  @protected
  ParentUserIndex get likeable =>
      ParentUserIndex(postReference, CollectionType.likes);
  @protected
  ParentUserIndex get voteable => ParentUserIndex(
        postReference,
        CollectionType.daily_tasty_votes,
        parentField: 'post',
      );

  String get restaurantName;

  LatLng get latLng => geoPoint?.latLng;

  GeoPoint get geoPoint;

  Set<String> get emojis;

  ValueStream<int> get nComments => CollectionType.comments.coll
      .where('parent', isEqualTo: postReference)
      .byCreated
      .count
      .shareValue();

  Stream<int> get views => CollectionType.views.coll
      .where('parent', isEqualTo: postReference)
      .snapshots()
      .map((x) => x.documents.length);

  String get simpleAddress => address?.simple;
  $pb.Restaurant_Attributes_Address get address;

  Stream<bool> get isFavorited => isFavoritedStream(restaurantRef);
  bool get isPublished => firePhotos.isNotEmpty;
  $pb.Reaction get reaction;
  String get displayText;
  bool get isUploading => false;

  List<DocumentReference> get mealMates;

  bool get isDelivery => emojis.contains('#delivery') || deliveryApp != null;

  @override
  Future delete() async {
    if (isNotMine) {
      return false;
    }
    await postReference.delete();
  }

  Future markViewed() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    bool viewedToday = sharedPrefs.getBool(getViewedKey());
    if (viewedToday ?? false) {
      return;
    }
    await sharedPrefs.setBool(getViewedKey(), true);
    await CollectionType.views.coll.add({
      'parent': postReference,
      'user': currentUserReference,
      '_extras': {
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      }
    });
  }

  String getViewedKey() {
    final now = DateTime.now();
    return 'viewed_${postReference.path}_${now.year}${now.month}${now.day}';
  }

  Future bookmark(bool enable) async =>
      (enable ^ await bookmarkable.exists.first)
          ? bookmarkable.toggle(enable)
          : null;
  Future like(bool enable) async =>
      (enable ^ await likeable.exists.first) ? likeable.toggle(enable) : null;

  $pb.Review_DeliveryApp get deliveryApp;

  Future vote(double score) => voteable
      .update(enable: true, payload: {'score': score, 'date': DateTime.now()});

  double distanceMeters(LatLng latLng) =>
      latLng == null ? null : geoPoint?.distanceMeters(latLng?.geoPoint);
}
