import 'package:taste_cloud_functions/taste_functions.dart' hide InstagramPost;
import 'package:taste_protos/taste_protos.dart' as $pb;
import 'package:taste_protos/taste_protos.dart' show Review_MealType;

part 'review.g.dart';

@RegisterType()
mixin Review
    on
        ParentUpdater,
        FirestoreProto<$pb.Review>,
        Likeable,
        Viewable,
        UserOwned,
        AlgoliaBacked,
        SpatialIndexed {
  @override
  GeoPoint get indexLocation =>
      isHome ? null : (restaurantLocation ?? proto.location.geoPoint);
  Review_MealType get mealType => proto.hasRestaurant()
      ? Review_MealType.meal_type_restaurant
      : Review_MealType.meal_type_home;
  bool get isHome => mealType == Review_MealType.meal_type_home;
  bool get isRestaurant => mealType == Review_MealType.meal_type_restaurant;
  bool get hasPhoto => proto.firePhotos.isNotEmpty || proto.hasPhoto();

  bool get isInstagramImport => proto.instaPost?.path?.isNotEmpty ?? false;

  bool get hasDailyTasty => proto.awards.hasDailyTasty();
  Future<List<Photo>> get photos async =>
      proto.firePhotos.futureMap((p) => p.photo(transaction));
  String get dish => proto.dish;
  DocumentReference get restaurantRef =>
      isRestaurant ? proto.restaurant.ref : null;
  Future<Restaurant> get restaurant async => isRestaurant
      ? Restaurants.make(await getRef(restaurantRef), transaction)
      : null;

  GeoPoint get restaurantLocation => proto.restaurantLocation.geoPoint;

  @override
  List<AlgoliaRecordID> get algoliaRecordIDs => [
        AlgoliaRecordID(ref, $pb.AlgoliaRecordType.review_marker),
        AlgoliaRecordID(ref, $pb.AlgoliaRecordType.review_discover)
      ];

  @override
  FutureOr<GeoPoint> get algoliaGeoPoint => restaurantLocation;

  Future updateAlgoliaRecords() async => [
        if (isRestaurant)
          updateAlgoliaRecord(
            recordID: AlgoliaRecordID(ref, $pb.AlgoliaRecordType.review_marker),
            payload: (await algoliaReviewMarker).asJson,
            extraTags: (await restaurant).tags,
          ),
        updateAlgoliaRecord(
          recordID: AlgoliaRecordID(ref, $pb.AlgoliaRecordType.review_discover),
          payload: (await discoverRecord).asJson,
          extraTags: isHome ? {} : (await restaurant).tags,
        ),
      ].wait;

  Future<$pb.DiscoverReviewRecord> get discoverRecord async {
    final user = await this.user;
    return {
      'dish': dish,
      'restaurant_name': (await restaurant)?.name ?? '',
      'review': ref,
      'display_text': displayText,
      'user': user.name,
      'user_photo': user.thumbnail,
      'search_text': searchText,
      'photo': proto.firePhotos.firstOrNull?.firebaseStorage,
      'more_photos': proto.firePhotos.skip(1).listMap((s) => s.firebaseStorage),
      'score': await computeScore,
    }.asProto($pb.DiscoverReviewRecord());
  }

  static final _regexp = RegExp(kTasteTagsMap.keys.join('|'));
  String get displayText => proto.displayText;

  String get searchText => _regexp
      .allMatches(displayText)
      .map((e) => kTasteTagsMap[e.group(0)]?.toLowerCase())
      .withoutNulls
      .toSet()
      .join(' ');

  Future<$pb.ReviewMarker> get algoliaReviewMarker async {
    final user = await this.user;
    final resto = await restaurant;
    return {
      'dish': dish,
      'restaurant_name': resto.name,
      'restaurant_ref': resto.ref,
      'restaurant_counts': await resto.counts,
      'user': userReference,
      'photo': proto.firePhotos.firstOrNull?.firebaseStorage,
      'more_photos': proto.firePhotos.skip(1).listMap((s) => s.firebaseStorage),
      'user_photo': user.thumbnail,
      'text': text,
      'reaction': reaction,
      'emojis': emojis.toList(),
      'score': score,
      'username': user.username,
      'user_display_name': user.name,
      'fb_place_id': resto.fbPlaceId,
    }.asProto($pb.ReviewMarker());
  }

  Future<List<Comment>> get comments => wrapQuery(commentsQuery, Comments.make);
  Future<List<DailyTastyVote>> get votes => DailyTastyVotes.get(
      trans: transaction, queryFn: (q) => q.where('post', isEqualTo: ref));
  Future<List<Report>> get reports => Reports.get(
      trans: transaction, queryFn: (q) => q.where('parent', isEqualTo: ref));
  Future<List<Badge>> get badgesReferencing => Badges.get(
      trans: transaction,
      queryFn: (q) => q.where('matching_references', arrayContains: ref));
  Future<List<Bookmark>> get bookmarks async => wrapQuery(
      CollectionType.bookmarks.coll.where('parent', isEqualTo: ref),
      Bookmarks.make);

  DocumentQuery get commentsQuery =>
      CollectionType.comments.coll.where('parent', isEqualTo: ref);

  Future<Set<TasteUser>> get participants async =>
      (await (await comments).futureMap((comment) => comment.participants))
          .flatten
          .toSet()
            ..add(await user)
            ..addAll(await mealMates)
            ..addAll(await userTagsInText);
  Future<List<TasteUser>> get mealMates async => proto.mealMates.futureMap(
      (m) async => TasteUsers.make(await getRef(m.ref), transaction));
  Future<List<TasteUser>> get userTagsInText async =>
      proto.userTagsInText.futureMap(
          (m) async => TasteUsers.make(await getRef(m.ref), transaction));

  int get score => proto.score;
  Set<String> get emojis => proto.emojis.toSet();

  Future<ReviewInfoCache> get asCache async {
    final user = await this.user;
    return {
      'reference': ref,
      'user': user.ref,
      'user_photo': user.thumbnail,
      'score': score,
      'photo': proto.firePhotos.firstOrNull?.firebaseStorage,
      'more_photos': proto.firePhotos.skip(1).listMap((s) => s.firebaseStorage),
    }.asProto(ReviewInfoCache());
  }

  Future restaurantWasUpdated(Restaurant restaurant) async {
    await updateSelf({
      'restaurant_location': restaurant.geoPoint,
      'address': restaurant.proto.attributes.address.asMap,
      'restaurant_name': restaurant.name,
    }, changeUpdatedAt: false);
  }

  String get text => proto.text;
  Reaction get reaction => proto.reaction;

  static final triggers = reviewTriggers<Review>();

  Future deleteOldPhotos(Review before) async => deleteDynamic(
      (await before?.photos ?? []).toSet().difference((await photos).toSet()));

  Future onPhotosChanged([Review before]) => [
        recacheFirePhotos(),
        // deleteOldPhotos(before),
        updateParents(),
        updateScore(),
        notifyPostLevelParticipants(before),
        updateDiscover(),
        RateLimiter.user_badge(userReference),
        isRestaurant ? updateRestaurantHiddenStatus() : null,
        if (!proto.hidden) runCenterDetection(),
      ].withoutNulls.wait;

  Future<void> runCenterDetection() async =>
      (await photos).futureMap((t) => t.runObjectDetection());

  Future recacheFirePhotos() async {
    // For now, photo+more_photos is the source of truth.
    // Once all clients are fire-photo aware, then we can nuke the photo/more_photos
    // field and pull truth from fire_photos.
    final photos = await [proto.photo, ...proto.morePhotos].futureMap(
        (t) async => Photos.make(await t.ref.tGet(transaction), transaction));
    await [
      updateSelf({
        'fire_photos': photos.listMap((t) => t.firePhoto),
      }.ensureAs(prototype)),
      photos.futureMap((t) => t.setOwner(this)),
    ].wait;
  }

  Future<Comment> createComment(
      {DocumentReference user,
      String text,
      List<TasteUser> taggedUsers = const []}) async {
    return await Comments.createNew(transaction,
        data: {
          'user': user,
          'text': text,
          'parent': ref,
          'tagged_users': taggedUsers?.map((e) => e.ref)?.toList(),
        }.ensureAs(Comments.emptyInstance).documentData.withExtras);
  }

  Future updateScore() async {
    await updateSelf({'score': await computeScore}, changeUpdatedAt: false);
  }

  Future updateRestaurantHiddenStatus() async {
    final resto = await restaurant;
    final fromHiddenReview = (resto.proto.hasFromHiddenReview()
            ? resto.proto.fromHiddenReview
            : true) &&
        proto.hidden;
    await resto.updateSelf({'from_hidden_review': fromHiddenReview});
  }

  Future resetRestoScoresUpToDateFlag() async {
    if (proto.hasInstaPost()) {
      await (await restaurant).updateSelf({'scores_up_to_date': false});
    }
  }

  Future<int> get computeScore async {
    return <int>[
      createScore,
      _Scoring.reactionScores[reaction],
      await bookmarkScore,
      await likeScore,
      await commentScore,
      await viewScore,
      isHome ? 0 : ((await restaurant).proto.popularityScore * 0.5).round(),
      hasDailyTasty ? _Scoring.dailyTastyValue : 0,
      !isHome
          ? 0
          : proto.recipe.isEmpty
              // No recipe penalty.
              ? (-0.5 * _Scoring.recipeValue).round()
              : _Scoring.recipeValue,
      // brerington@ boost
      userReference.path == '/users/GAqUyNz3CMPiLLyrMYXSD2WOjaN2' ? 50 : 0,
    ].sum;
  }

  int get createScore => _Scoring.createValue;

  Future<int> get numViews async => withoutMine(await views).length;

  Future<int> get bookmarkScore async =>
      withoutMine(await bookmarks).length * _Scoring.bookmarkValue;
  Future<int> get commentScore async =>
      withoutMine(await comments).length * _Scoring.commentValue;
  Future<int> get likeScore async =>
      withoutMine(await likes).length * _Scoring.likeValue;
  Future<int> get viewScore async => (await numViews) * _Scoring.viewValue;

  Iterable<UserOwned> withoutMine(Iterable<UserOwned> input) =>
      input.where((i) => i.userReference != userReference);

  @override
  Future<List<DocumentReference>> get referencesToUpdate async =>
      [if (isRestaurant) restaurantRef];

  Future notifyPostLevelParticipants(Review before) async {
    final isFirstNotification = !(before?.hasPhoto ?? false);
    final reviewer = await user;
    final mealMates = (await this.mealMates).toSet().difference({reviewer}
        .union(isFirstNotification ? {} : (await before.mealMates).toSet()));
    final taggedUsers = (await userTagsInText)
        .toSet()
        .difference({reviewer}.union(
            isFirstNotification ? {} : (await before.userTagsInText).toSet()))
        .difference(mealMates);
    await [
      mealMates.futureMap((user) => user.sendNotification(
            title: isHome
                ? 'New Meal Mate!'
                : 'New Meal Mate at ${proto.restaurantName}',
            body: isHome
                ? '${reviewer.name} added you as a meal-mate for "$dish".'
                : '${reviewer.name} added you as a meal-mate at ${proto.restaurantName}',
            documentLink: ref,
            notificationType: NotificationType.meal_mate,
          )),
      taggedUsers.futureMap((user) => user.sendNotification(
            title: '${reviewer.name} tagged you in their post',
            body: '${reviewer.name} said: $text',
            documentLink: ref,
            notificationType: NotificationType.meal_mate,
          ))
    ].wait;
  }

  /// Updates restaurant of review.
  /// If [restaurant] is not null, returned reference will be [CollectionType.reviews].
  /// If [restaurant] is null, returned reference will be [CollectionType.home_meals].
  /// If [restaurant] is not null and existing review has restaurant, then modifies restaurant fields and returns same reference.
  /// If [restaurant] is not null and existing review is home-cooked, then a new reference is created and old reference deleted.
  /// If [restaurant] is null and existing review is restaurant, then a new reference is created and old reference deleted.
  /// If [restaurant] is null and existing review is home-cooked, nothing happens.
  Future<Review> migrateBetweenMealTypes() async {
    final wasRestaurant = type == CollectionType.reviews;
    final restaurant = await this.restaurant;
    final basePayload = {
      'freeze_place': true,
      'restaurant': restaurant?.ref,
      'restaurant_name': restaurant?.name,
      'restaurant_location': restaurant?.geoPoint,
      'address': restaurant?.proto?.attributes?.address,
      'black_owned': restaurant != null
          ? restaurant.blackOwned
              ? $pb.Review_BlackOwnedStatus.restaurant_black_owned
              : $pb.Review_BlackOwnedStatus.restaurant_not_black_owned
          : null,
    }.ensureAs(Reviews.emptyInstance,
        explicitEmpties: true, explicitNulls: true);
    if (isRestaurant && wasRestaurant) {
      await updateSelf(basePayload);
      return this;
    }
    if (!(isRestaurant ^ wasRestaurant)) {
      return this;
    }
    final converted = await transaction.inner((t) async {
      // Photo fields are deleted from review, so we just make a copy for simplicity.
      final photoCopies =
          await (await photos).futureMap((p) => Photos.createNew(t,
              data: {
                ...p.data.toMap(),
                'references': [],
              }.documentData));
      return (isHome ? HomeMeals.createNew : Reviews.createNew)(t,
          data: (data.toMap()
                ..addAll({
                  'photo': photoCopies.first,
                  'more_photos': photoCopies.skip(1).toList(),
                  'fire_photos': photoCopies.listMap((p) => p.firePhoto),
                  'meal_type': (isHome
                          ? Review_MealType.meal_type_home
                          : Review_MealType.meal_type_restaurant)
                      .name,
                  ...basePayload
                }))
              .ensureAs(Reviews.emptyInstance,
                  explicitEmpties: true, explicitNulls: true)
              .documentData);
    });
    await transaction.inner((t) async => [
          (() async => (await <Future<List<ParentHolder>>>[
                comments,
                likes,
                bookmarks,
                views,
                reports,
                votes
              ].futureMap((a) => a))
                  .flatten
                  .futureMap((t) => t.updateParent(converted.ref)))(),
          (() async => (await badgesReferencing).futureMap((t) => t.updateSelf({
                'matching_references': t.proto.matchingReferences
                    .map((e) => e.ref)
                    .toSet()
                    .union({converted.ref}).difference({ref})
              }.ensureAs(Badges.emptyInstance))))(),
          (await photos).futureMap((t) => t.setOwner(converted))
        ].wait);
    await deleteSelf();
    return converted;
  }

  Future<List<DiscoverItem>> allDiscoverItems(
          [BatchedTransaction transaction]) =>
      DiscoverItems.get(
          trans: transaction ?? this.transaction,
          queryFn: (q) => q.where('reference', isEqualTo: ref));

  Future<DiscoverItem> updateDiscover() => withTransaction((t) async {
        final ref = (await allDiscoverItems(t))?.firstOrNull?.ref ??
            DiscoverItems.collection.document();
        final data = (await discoverProto).documentData;
        await t.set(ref, data);
        // Don't pass back `t` as transaction since it will expired.
        return DiscoverItems.makeSimple(data, ref, transaction);
      });

  Future<$pb.DiscoverItem> get discoverProto async {
    return {
      'reference': ref,
      'restaurant': isHome
          ? null
          : {
              'name': proto.restaurantName,
              'address': proto.address,
              'reference': proto.restaurant,
            },
      'review': {
        'text': displayText,
        'reaction': reaction,
        'meal_mates': {
          'meal_mates': proto.mealMates.map((m) => {'reference': m}).toList(),
        },
        'raw_text': text,
        'emojis': emojis,
        'attributes': proto.attributes,
        'delivery_app': proto.deliveryApp,
        'recipe': proto.recipe,
        'food_types': proto.foodTypes,
        'food_types_photo_indices': proto.foodTypesPhotoIndices,
      },
      'user': await (await user).asDiscover,
      'comments': await (await comments).futureMap((comment) async => {
            'reference': comment.ref,
            'user': await (await comment.user).asDiscover,
            'text': comment.text,
            'date': comment.createdAt
          }),
      'date': createdAt,
      'meal_type': mealType,
      'location': restaurantLocation,
      'dish': dish,
      'photo': proto.firePhotos.firstOrNull?.firebaseStorage,
      'more_photos': proto.firePhotos.skip(1).listMap((s) => s.firebaseStorage),
      'fire_photos': proto.firePhotos,
      'tags': tags,
      'insta_post': isInstagramImport ? proto.instaPost : null,
      'awards': proto.awards,
      'freeze_place': proto.freezePlace,
      'imported_at': importedAt,
      'is_instagram_post': isInstagramImport,
      'black_owned': isHome ? false : (await restaurant).blackOwned,
      'bookmarks': await (await bookmarks)
          .futureMap((l) async => (await l.user).asDiscover),
      'likes':
          await (await likes).futureMap((l) async => (await l.user).asDiscover),
      // enums default to 0 so no need to check for isHomeMeal.
      'black_charity': proto.blackCharity == $pb.BlackCharity.CHARITY_UNDEFINED
          ? null
          : proto.blackCharity,
      'score': proto.score,
      'categories': proto.categories,
      'spatial_index': spatialIndex,
      'hidden': proto.hidden,
      'num_insta_likes': proto.hasNumInstaLikes() ? proto.numInstaLikes : null,
      'num_insta_followers':
          proto.hasNumInstaFollowers() ? proto.numInstaFollowers : null,
      'show_on_discover_feed': !isInstagramImport || !isHome || dish.isNotEmpty,
    }.withoutNulls.asProto(DiscoverItems.emptyInstance);
  }

  DateTime get importedAt => isInstagramImport &&
          proto.importedAt.toDateTime().millisecondsSinceEpoch > 0
      ? proto.importedAt.toDateTime()
      : null;

  Set<String> get tags => proto.attributes
      .followedBy(_tagRegexp.allMatches(text).map((e) => e.group(1)))
      .followedBy(emojis)
      .map((e) => e.tagify)
      .toSet();

  Future sendDailyTastyNotification() async => (await user).sendNotification(
      notificationType: NotificationType.won_daily_tasty,
      documentLink: ref,
      title: 'You won the Daily Tasty!',
      body: '"$dish" won the Daily Tasty!');

  Future handleRecipeChange(Change<Review> change) async {
    if (!(proto.recipe.isNotEmpty && change.before.proto.recipe.isEmpty)) {
      return;
    }
    final owner = await user;
    final ownerName = owner.usernameOrName;
    final requests = await RecipeRequests.get(
        trans: transaction, queryFn: (q) => q.where('parent', isEqualTo: ref));
    final requesters = await requests.futureMap((r) => r.user);
    final title = 'Recipe Added!';
    final body = '$ownerName added a recipe for $dish';
    await requesters.futureMap(
      (requester) => requester.sendNotification(
        documentLink: ref,
        title: title,
        body: body,
        notificationType: NotificationType.recipe_added,
      ),
    );
  }

  Future maybeMarkRestoBlackOwned() => withTransaction((t) async {
        if (isHome) {
          return;
        }
        if (proto.blackOwned !=
            $pb.Review_BlackOwnedStatus.user_selected_black_owned) {
          return;
        }
        if ((await restaurant).blackOwned) {
          return;
        }
        await sendSlack('User added black-owned tag to: ${restaurantRef.path}');
        await t.update(
          restaurantRef,
          {
            'attributes': {'black_owned': true}
          }.ensureAs($pb.Restaurant()).updateData,
        );
      });
}

final _tagRegexp = RegExp(r'#([^\s]+)');

class _Scoring {
  static const bookmarkValue = 80;
  static const createValue = 100;
  static const likeValue = 20;
  static const commentValue = 10;
  static const viewValue = 2;
  static const dailyTastyValue = 160;
  static const recipeValue = 60;
  static const reactionScores = {
    Reaction.UNDEFINED: 0,
    Reaction.down: -100,
    Reaction.up: 20,
    Reaction.love: 100,
  };
}

Triggerable<T> reviewTriggers<T extends Review>() => trigger(
    update: (r, change) => change.fieldChanged('restaurant')
        ? r.migrateBetweenMealTypes()
        : change.fieldsChanged({'photo', 'more_photos', 'fire_photos'})
            ? r.onPhotosChanged(change.before)
            : [
                r.handleRecipeChange(change),
                change.fieldChanged('awards.daily_tasty') &&
                        r.hasDailyTasty &&
                        FeatureFlag.daily_tasty.isEnabled
                    ? r.sendDailyTastyNotification()
                    : null,
                r.updateParents(),
                r.updateDiscover(),
                r.updateScore(),
                r.notifyPostLevelParticipants(change.before),
                r.maybeMarkRestoBlackOwned(),
                change.fieldChanged('hidden') && r.isRestaurant
                    ? r.updateRestaurantHiddenStatus()
                    : null,
              ].withoutNulls,
    create: (r) => r.hasPhoto
        ? [r.onPhotosChanged(), r.resetRestoScoresUpToDateFlag()]
        : null,
    delete: (r) => [
          r.deleteLinkedNotifications(),
          r.updateParents(),
          r.resetRestoScoresUpToDateFlag(),
          r.deleteDynamic([
            r.allDiscoverItems(),
            r.views,
            r.comments,
            r.bookmarks,
            r.likes,
            // Commented out to prevent deletion of photos when InstaPosts
            // are updated to not have people in them. Same as onPhotosChanged
            //
            // r.photos,
            r.deleteAlgoliaCache(),
          ])
        ]);

extension on TasteUser {
  Future<$pb.DiscoverItem_User> get asDiscover async => {
        'reference': ref,
        'name': username?.isNotEmpty ?? false ? username : name,
        'photo': thumbnail,
      }.asProto($pb.DiscoverItem_User());
}
