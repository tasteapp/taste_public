import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_cloud_functions/types/conversation.dart';

import 'calls/generate_auth_token.dart' as generate_auth_token;
import 'calls/master_call.dart' as master_call;
import 'triggers/add_restaurant_hours.dart' as add_restaurant_hours;
import 'triggers/batch_update_restaurants.dart' as batch_update_restaurants;
import 'triggers/fb_search_instagram_locations.dart'
    as fb_search_instagram_locations;
import 'triggers/get_is_food_status.dart' as get_is_food_status;
import 'triggers/populate_cities.dart' as populate_cities;
import 'triggers/user_photos.dart' as user_photos;
import 'triggers/users.dart' as users;

void registerTasteFunctions() {
  // DO NOT DELETE ME! This is static-initializing.
  if (firestore == null) {
    throw Error();
  }
  enableAllFeatureFlags = buildType.isNotProd;
  // registerDailyDigest();
  // final batchDedupeRestaurants = tasteFunctions.pubsub
  //     .schedule('every 6 hours')
  //     .onRun((message, context) => autoBatch(batchDedupeRestos));
  // registerFunction(
  //     'batchDedupeRestaurants', batchDedupeRestaurants, batchDedupeRestaurants);
  generate_auth_token.register();
  master_call.register();
  add_restaurant_hours.register();
  batch_update_restaurants.register();
  fb_search_instagram_locations.register();
  get_is_food_status.register();
  populate_cities.register();
  user_photos.register();
  users.register();
  AlgoliaRecords.register();
  Badges.register();
  Bookmarks.register();
  BugReports.register();
  Comments.register();
  Conversations.register();
  DailyTastyVotes.register();
  Favorites.register();
  Followers.register();
  HomeMeals.register();
  InstaPosts.register();
  InstagramLocations.register();
  InstagramPosts.register();
  InstagramScrapeRequests.register();
  InstagramTokens.register();
  UserPostsStartingLocations.register();
  Likes.register();
  MailchimpUserSettings.register();
  Movies.register();
  Photos.register();
  RecipeRequests.register();
  Reports.register();
  Restaurants.register();
  Reviews.register();
  TasteNotifications.register();
  TasteUsers.register();
  registerCallFn((_) async => true, 'log');
  // ignore: unnecessary_statements
  registerRateLimiter;
  // ignore: unnecessary_statements
  registerCheckBrokenPosts;
}
