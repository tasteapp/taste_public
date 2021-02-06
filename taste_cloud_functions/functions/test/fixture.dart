import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'utilities.dart';

class Fixture with Memoizer {
  Future<TasteUser> get newUser => createUser();
  Future<TasteUser> get user => memoize(() => newUser, 'user');
  Future<TasteUser> get otherUser => memoize(() => newUser, 'otherUser');
  Future<Restaurant> get restaurant =>
      memoize(() async => createRestaurant(), 'restaurant');

  Future<Restaurant> getRestaurant(DocumentReference ref) async {
    return Restaurants.make(await ref.get(), quickTrans);
  }

  Future<Restaurant> createRestaurant({
    String restoName = 'resto',
    String fbPlaceId,
    $pb.Restaurant_Attributes_Address address,
    GeoPoint location,
    bool blackOwned,
  }) async =>
      Restaurants.make(
          await (await Restaurants.collection.add({
            'attributes': {
              'name': restoName,
              'fb_place_id': fbPlaceId ?? restoName,
              'location': location ?? GeoPoint(2, 3),
              'address': {
                'city': address?.city ?? 'Cool City',
                'state': address?.state ?? 'Cool State',
                'country': address?.country ?? 'United States',
              },
              'blackOwned': blackOwned ?? false,
            }
          }.ensureAs(Restaurants.emptyInstance).documentData.withExtras))
              .get(),
          quickTrans);
  Future<Photo> _photo;
  Future<Photo> get photo => _photo ?? resetPhoto();
  Future<Photo> resetPhoto() {
    _photo = createPhoto();
    return _photo;
  }

  Future<Photo> createPhoto(
          {TasteUser photoUser, String path = 'fakepath'}) async =>
      Photos.createNew(quickTrans,
          data: {
            'firebase_storage_path': path,
            'user': (photoUser ?? await user).ref,
          }.ensureAs(Photos.emptyInstance).documentData);
  Future<Review> get review =>
      memoize(() async => await createReview(), 'review');
  Future<Comment> get reviewComment =>
      memoize(() async => await comment(await user), 'reviewComment');
  Future<Like> get commentLike => memoize(
      () async => await like(await user, await reviewComment), 'commentLike');
  Future<Comment> comment(TasteUser user,
          {Review review, TasteUser tag}) async =>
      (review ?? await this.review).createComment(
          user: user.ref,
          text: 'great',
          taggedUsers: [tag].withoutNulls.toList());

  Future<View> viewReview(TasteUser user, [Viewable viewable]) async =>
      Views.make(
          await (await (viewable ?? (await review)).createView(user)).get(),
          quickTrans);

  Future<Like> like(TasteUser user, [Likeable likeable]) async =>
      (likeable ?? await review).like(user, true);

  Future<Bookmark> bookmark(TasteUser user, {Review review}) async =>
      await user.bookmark(review ?? await this.review, true);

  Future<Follower> follow(TasteUser requester, TasteUser user,
          {bool unfollow = false}) =>
      requester.follow(user, !unfollow);

  Future<Favorite> favorite(TasteUser user, Restaurant restaurant) async =>
      user.favorite(restaurant, true);

  Future<Review> createReview(
      {Restaurant restaurant,
      String dish = 'dishy',
      Photo photo,
      bool noPhoto = false,
      String emoji,
      TasteUser user,
      Reaction reaction = Reaction.up,
      LatLng location,
      TasteUser mealMate,
      Set<String> attributes = const {},
      num daysAgo = 0,
      Set<String> emojis = const {},
      bool home = false,
      DateTime date,
      int score,
      String text,
      TasteUser taggedUser,
      DocumentReference instaPost,
      bool dailyTasty,
      DateTime importedAt,
      List<Photo> morePhotos,
      BatchedTransaction transaction}) async {
    home ??= false;
    restaurant ??= await this.restaurant;
    user ??= await this.user;
    photo ??= (noPhoto ? null : await photoForUser(user));
    final geopoint = location == null
        ? restaurant.geoPoint
        : GeoPoint(location.lat, location.lng);
    final time = date != null
        ? Timestamp.fromDateTime(date)
        : Timestamp.fromDateTime(DateTime.now()
            .subtract(Duration(hours: ((daysAgo ?? 0) * 24).toInt())));
    return reviewOrHomeMeal(
        await (await (home ? HomeMeals.collection : Reviews.collection).add({
          'meal_type': home ? Review_MealType.meal_type_home : null,
          '_extras': {
            'created_at': time,
            'updated_at': time,
          },
          'user': user.ref,
          'dish': dish,
          'restaurant': home ? null : restaurant.ref,
          'restaurant_name': home ? null : restaurant.name,
          'restaurant_location': home ? null : restaurant.geoPoint,
          'location': home ? null : geopoint,
          'address': home ? null : restaurant.proto.attributes.address,
          'text': text ?? 'great',
          'photo': photo,
          'reaction': reaction,
          'emojis': {emoji ?? '🥪'}.union(emojis ?? {}),
          'meal_mates': mealMate == null ? [] : [mealMate.ref],
          'attributes': attributes,
          'score': score ?? (noPhoto ? 0 : 200),
          'user_tags_in_text': [taggedUser?.ref].withoutNulls.toList(),
          'insta_post': instaPost,
          'awards': dailyTasty ?? false
              ? {'daily_tasty': DateTime.now().timestamp}
              : {},
          'imported_at': importedAt,
          'more_photos': morePhotos,
          'fire_photos': [photo, ...(morePhotos ?? [])]
              .withoutNulls
              .listMap((p) => p.firePhoto),
        }
                .ensureAs(
                    home ? HomeMeals.emptyInstance : Reviews.emptyInstance)
                .documentData))
            .get(),
        transaction ?? quickTrans);
  }

  Future<InstaPost> createInstaPost(
          {String caption = 'my love caption',
          double lat = 37.7600495,
          double lng = -122.42804,
          String postId = 'post_id',
          String url,
          DateTime createdTime,
          TasteUser user}) async =>
      InstaPosts.createNew(quickTrans,
          data: {
            'user': user ?? await this.user,
            'user_id': (user ?? await this.user)?.username,
            'username': (user ?? await this.user)?.username,
            'caption': caption,
            'post_id': postId,
            'created_time': createdTime ?? DateTime.now(),
            'images': [
              {
                'low_res': {'url': url},
                'standard_res': {'url': url},
              }
            ],
            'instagram_location': {
              'location': {
                'latitude': lat,
                'longitude': lng,
              },
              'name': 'El Farolito',
            }
          }.ensureAs(InstaPosts.emptyInstance).documentData);

  Future<Review> updateReview(
      {@required Review review,
      String dishName,
      String reaction,
      String text,
      TasteUser user,
      Set<String> emojis}) async {
    await review.updateSelf({
      'dish': dishName,
      'reaction': reaction,
      'text': text,
      'emojis': emojis,
    });
    return review;
  }

  Future<Photo> photoForUser(TasteUser tasteUser) async {
    if (tasteUser == await user) {
      return await photo;
    }
    return await createPhoto(photoUser: tasteUser);
  }

  Future<TasteUser> createUser(
      {String name = 'Test User',
      String username = 'fakeusername',
      String photo = 'http://test-user-photo',
      Photo vanityPhoto,
      String email = 'a@a.com'}) async {
    final user = await TasteUsers.createNew(quickTrans,
        data: {
          'photo_url': photo,
          'display_name': name,
          'email': email,
          'vanity': {
            'username': username,
            'photo': vanityPhoto,
          }
        }.ensureAs(TasteUsers.emptyInstance).documentData.withExtras);
    await userPrivateDocument(user.ref).setData({
      'fcm_tokens': ['${user.ref.documentID}-token']
    }.documentData);
    return user;
  }

  Future<DailyTastyVote> vote(Review post, double score) async =>
      DailyTastyVotes.createNew(quickTrans,
          data: {
            'user': (await createUser()).ref,
            'post': post.ref,
            'score': score,
            'date': DateTime.now(),
          }.documentData);

  Future<Conversation> get conversation async =>
      Conversations.createNew(quickTrans,
          data: {
            'members': [await otherUser, await user]
          }.ensureAs(Conversations.emptyInstance).documentData);
}
