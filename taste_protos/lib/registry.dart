import 'taste_protos.dart';

final _collectionTypeRegistry = {
  CollectionType.reviews: Review,
  CollectionType.home_meals: Review,
  CollectionType.restaurants: Restaurant,
  CollectionType.favorites: Favorite,
  CollectionType.users: TasteUser,
  CollectionType.badges: Badge,
  CollectionType.discover_items: DiscoverItem,
  CollectionType.followers: Follower,
  CollectionType.likes: Like,
  CollectionType.bookmarks: Bookmark,
  CollectionType.daily_tasty_votes: DailyTastyVote,
  CollectionType.tags: Tag,
  CollectionType.taste_bud_groups: TasteBudGroup,
  CollectionType.photos: Photo,
  CollectionType.insta_posts: InstaPost,
  CollectionType.instagram_tokens: InstagramToken,
  CollectionType.conversations: Conversation,
  CollectionType.contests: Contest,
  CollectionType.cities: City,
  CollectionType.notifications: Notification,
  CollectionType.recipe_requests: RecipeRequest,
  CollectionType.comments: Comment,
  CollectionType.instagram_posts: InstagramPost,
  CollectionType.algolia_records: AlgoliaRecord,
  CollectionType.google_reviews: GoogleReviews,
  CollectionType.yelp_reviews: YelpReviews,
  CollectionType.food_finder_actions: FoodFinderAction,
};

final protoToTypes =
    _collectionTypeRegistry.invert.mapValue((_, v) => v.toSet());

final _constructors = {
  AlgoliaRecord: () => AlgoliaRecord(),
  Review: () => Review(),
  Restaurant: () => Restaurant(),
  Favorite: () => Favorite(),
  TasteUser: () => TasteUser(),
  Badge: () => Badge(),
  DiscoverItem: () => DiscoverItem(),
  Follower: () => Follower(),
  Like: () => Like(),
  Bookmark: () => Bookmark(),
  DailyTastyVote: () => DailyTastyVote(),
  FoodFinderAction: () => FoodFinderAction(),
  Tag: () => Tag(),
  TasteBudGroup: () => TasteBudGroup(),
  Photo: () => Photo(),
  InstagramToken: () => InstagramToken(),
  Conversation: () => Conversation(),
  Contest: () => Contest(),
  City: () => City(),
  Notification: () => Notification(),
  RecipeRequest: () => RecipeRequest(),
  Comment: () => Comment(),
  InstagramPost: () => InstagramPost(),
  InstaPost: () => InstaPost(),
  GoogleReviews: () => GoogleReviews(),
  YelpReviews: () => YelpReviews(),
};

extension CollectionTypeRegistryExtension on CollectionType {
  GeneratedMessage get proto {
    if (!_collectionTypeRegistry.containsKey(this)) {
      throw ('Corresponding proto message missing in _collectionTypeRegistry '
          'for $this');
    }
    final type = _collectionTypeRegistry[this];
    if (!_constructors.containsKey(type)) {
      throw ('Missing constructor for $type in _constructors.');
    }
    return _constructors[type]();
  }
}
