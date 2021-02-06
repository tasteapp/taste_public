import 'utilities.dart';

void main() {
  group('discover', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);

    test('convert-type', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      var review = await fixture.createReview();
      final photo = await fixture.createPhoto(photoUser: user);
      await review.updateSelf({
        'more_photos': [photo]
      }.ensureAs(Reviews.emptyInstance));
      review = await review.refetch;
      final photos = await review.photos;
      expect(photos, hasLength(2));
      final comment = await fixture.comment(user, review: review);
      final reviewLike = await fixture.like(user, review);
      final commentLike = await fixture.like(user, comment);
      final bookmark = await fixture.bookmark(user, review: review);
      final view = await fixture.viewReview(user, review);
      final vote = await fixture.vote(review, 3);
      await review.updateSelf({'restaurant': null});
      await eventually(() async => (await review.ref.get()).exists, isFalse,
          message: (_) => 'review should be deleted',
          duration: const Duration(minutes: 2));
      final converted = (await HomeMeals.get()).first;
      expect(converted.type, CollectionType.home_meals);
      expect(converted.isHome, isTrue);
      expect(converted.mealType, Review_MealType.meal_type_home);

      expect((await converted.refetch).exists, isTrue);
      expect(
          (await (await converted.refetch).photos)
              .listMap((t) => t.firebaseStoragePath),
          photos.listMap((t) => t.firebaseStoragePath));
      expect((await comment.refetch).parent, converted.ref);
      expect((await reviewLike.refetch).parent, converted.ref);
      expect((await commentLike.refetch).parent, comment.ref);
      expect((await bookmark.refetch).parent, converted.ref);
      expect((await view.refetch).parent, converted.ref);
      expect((await vote.refetch).parent, converted.ref);
      await eventually(
          () async =>
              (await photos.futureMap((t) => t.ref.get())).map((e) => e.exists),
          everyElement(isFalse),
          duration: const Duration(minutes: 5));
    }, timeout: const Timeout(Duration(minutes: 20)));
    test('other-way', () async {
      final fixture = Fixture();
      final home = await fixture.createReview(home: true);
      await home.updateSelf({'restaurant': (await fixture.restaurant).ref});
      await eventually(() async => (await home.ref.get()).exists, isFalse);
      final converted = (await Reviews.get()).first;
      expect(converted.type, CollectionType.reviews);
      expect(converted.isHome, isFalse);
      expect(converted.mealType, Review_MealType.meal_type_restaurant);
      expect(await converted.restaurant, await fixture.restaurant);
    });
    test('switch-resto', () async {
      final fixture = Fixture();
      final review = await fixture.review;
      final resto = await fixture.createRestaurant(restoName: 'newest-resto');
      await review.updateSelf({'restaurant': resto.ref});
      await eventually(() async => (await review.refetch).proto.restaurantName,
          'newest-resto');
    });
  });
}
