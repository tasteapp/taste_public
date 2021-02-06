import 'package:taste_cloud_functions/taste_functions.dart';

typedef Maker<T extends GeneratedMessage> = FirestoreProto<T> Function(
    DocumentSnapshot s, BatchedTransaction t);

final _types = {
  Reviews: Review,
  HomeMeals: HomeMeal,
  Likes: Like,
  Bookmarks: Bookmark,
  Comments: Comment,
  Followers: Follower,
  Restaurants: Restaurant,
  TasteUsers: TasteUser,
  Favorites: Favorite,
  TasteBudGroups: TasteBudGroup,
  Photos: Photo,
  DiscoverItems: DiscoverItem,
};

final constructors = <CollectionType, Maker>{
  Reviews.collectionType: Reviews.make,
  HomeMeals.collectionType: HomeMeals.make,
  Likes.collectionType: Likes.make,
  Bookmarks.collectionType: Bookmarks.make,
  Comments.collectionType: Comments.make,
  Followers.collectionType: Followers.make,
  Restaurants.collectionType: Restaurants.make,
  TasteUsers.collectionType: TasteUsers.make,
  Favorites.collectionType: Favorites.make,
  TasteBudGroups.collectionType: TasteBudGroups.make,
  Photos.collectionType: Photos.make,
  DiscoverItems.collectionType: DiscoverItems.make,
};

class BatchDump with Memoizer {
  BatchDump._(this.snapshots, this.collections);
  final Set<CollectionType> collections;
  final Map<DocumentReference, FirestoreProto> snapshots;
  T get<T extends FirestoreProto>(DocumentReference ref) =>
      snapshots[ref] == null ? null : (snapshots[ref] as T);
  @visibleForTesting
  Map<Type, Iterable<FirestoreProto>> get byType => memoize(
      () => snapshots.values.groupBy((a) => _types[a.runtimeType]), '_byType');
  Iterable<Review> get reviews => memoize(
      () => Iterable.castFrom(typed<Review>().followedBy(typed<HomeMeal>())),
      'reviews');
  Iterable<T> typed<T extends FirestoreProto>() =>
      memoize(() => Iterable.castFrom(byType[T] ?? <T>[]), 'typed-$T');
  Map<DocumentReference, TasteUser> get users =>
      memoize(() => typed<TasteUser>().keyOn((t) => t.ref), 'users');
  TasteUser user(DocumentReference r) => users[r];
  TasteUser owner(UserOwned r) => user(r?.userReference);

  Map<TasteUser, BatchDumpUserRecord> get userRecords => memoize(() {
        final comments = typed<Comment>().groupBy(owner);
        final likes = typed<Like>().groupBy(owner);
        final bookmarks = typed<Bookmark>().groupBy(owner);
        final reviews = this.reviews.groupBy(owner);
        final favorites = typed<Favorite>().groupBy(owner);
        final followers = typed<Follower>()
            .groupBy((f) => user(f.followingRef))
            .deepMap((v) => user(v.followerRef));
        final following = followers.invert;
        List<T> nullHandled<T>(Iterable<T> t) => t?.toList() ?? [];
        return typed<TasteUser>().toMap((user) => BatchDumpUserRecord._(
            dump: this,
            user: user,
            reviews:
                nullHandled(reviews[user]).sorted((a) => a.createdAt.seconds),
            favoriteRestaurants: nullHandled(favorites[user])
                .map((e) => get<Restaurant>(e.restaurantRef))
                .withoutNulls
                .toList(),
            comments: nullHandled(comments[user]),
            favorites: nullHandled(favorites[user]),
            followers: nullHandled(followers[user]),
            following: nullHandled(following[user]),
            likes: nullHandled(likes[user]),
            bookmarks: nullHandled(bookmarks[user])));
      }, 'userRecords');

  static Future<BatchDump> fetch(
          BatchedTransaction transaction, Set<CollectionType> collections,
          {bool Function(FirestoreProto s) filter,
          Map<CollectionType, DocumentQuery Function(DocumentQuery q)> queries =
              const {}}) async =>
      BatchDump._(
          (await collections.futureMap((t) {
            final queryFn = queries[t] ?? identity;
            final query = queryFn(t.coll);
            return query.get();
          }))
              .expand((e) => e.documents)
              .map((e) =>
                  constructors[e.reference.collectionType](e, transaction))
              .where((e) => (filter ?? (_) => true)(e))
              .keyOn((t) => t.ref),
          collections);
}

class BatchDumpUserRecord {
  final BatchDump dump;
  final TasteUser user;
  final List<Review> reviews;
  final List<Restaurant> favoriteRestaurants;
  final List<Comment> comments;
  final List<Favorite> favorites;
  final List<TasteUser> followers;
  final List<TasteUser> following;
  final List<Like> likes;
  final List<Bookmark> bookmarks;

  BatchDumpUserRecord._({
    @required this.dump,
    @required this.user,
    @required this.reviews,
    @required this.favoriteRestaurants,
    @required this.comments,
    @required this.favorites,
    @required this.followers,
    @required this.following,
    @required this.likes,
    @required this.bookmarks,
  });
}
