///
//  Generated code. Do not modify.
//  source: firestore.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const CollectionType$json = const {
  '1': 'CollectionType',
  '2': const [
    const {'1': 'COLLECTION_TYPE_UNDEFINED', '2': 0},
    const {'1': 'algolia_records', '2': 1},
    const {'1': 'bookmarks', '2': 2},
    const {'1': 'bug_reports', '2': 4},
    const {'1': 'comments', '2': 5},
    const {'1': 'favorites', '2': 9},
    const {'1': 'followers', '2': 10},
    const {'1': 'home_meals', '2': 11},
    const {'1': 'likes', '2': 12},
    const {'1': 'mail', '2': 13},
    const {'1': 'notifications', '2': 14},
    const {'1': 'operations', '2': 15},
    const {'1': 'photos', '2': 16},
    const {'1': 'private_documents', '2': 17},
    const {'1': 'reports', '2': 21},
    const {'1': 'restaurants', '2': 22},
    const {'1': 'reviews', '2': 23},
    const {'1': 'users', '2': 26},
    const {'1': 'view', '2': 27},
    const {'1': 'views', '2': 28},
    const {'1': 'instagram_username_requests', '2': 29},
    const {'1': 'badges', '2': 30},
    const {'1': 'index', '2': 31},
    const {'1': 'discover_items', '2': 32},
    const {'1': 'contests', '2': 33},
    const {'1': 'insta_posts', '2': 34},
    const {'1': 'daily_tasty_votes', '2': 35},
    const {'1': 'cities', '2': 36},
    const {'1': 'conversations', '2': 37},
    const {'1': 'tags', '2': 38},
    const {'1': 'movies', '2': 39},
    const {'1': 'inference_results', '2': 40},
    const {'1': 'instagram_tokens', '2': 41},
    const {'1': 'instagram_locations', '2': 42},
    const {'1': 'bad_crops', '2': 43},
    const {'1': 'taste_bud_groups', '2': 44},
    const {'1': 'recipe_requests', '2': 45},
    const {'1': 'mailchimp_user_settings', '2': 46},
    const {'1': 'instagram_scrape_requests', '2': 47},
    const {'1': 'user_posts_starting_locations', '2': 48},
    const {'1': 'instagram_posts', '2': 49},
    const {'1': 'instagram_network_scrape_requests', '2': 50},
    const {'1': 'google_places', '2': 51},
    const {'1': 'google_reviews', '2': 52},
    const {'1': 'yelp_places', '2': 53},
    const {'1': 'yelp_reviews', '2': 54},
    const {'1': 'food_finder_actions', '2': 55},
  ],
};

const NotificationType$json = const {
  '1': 'NotificationType',
  '2': const [
    const {'1': 'UNDEFINED', '2': 0},
    const {'1': 'like', '2': 1},
    const {'1': 'comment', '2': 2},
    const {'1': 'follow', '2': 3},
    const {'1': 'message', '2': 5},
    const {'1': 'bookmark', '2': 7},
    const {'1': 'meal_mate', '2': 8},
    const {'1': 'conversation', '2': 9},
    const {'1': 'daily_digest', '2': 10},
    const {'1': 'flagged_review_update', '2': 11},
    const {'1': 'won_daily_tasty', '2': 12},
    const {'1': 'recipe_request', '2': 13},
    const {'1': 'recipe_added', '2': 14},
  ],
};

const BlackCharity$json = const {
  '1': 'BlackCharity',
  '2': const [
    const {'1': 'CHARITY_UNDEFINED', '2': 0},
    const {'1': 'eji', '2': 1},
    const {'1': 'splc', '2': 2},
    const {'1': 'aclu', '2': 3},
  ],
};

const BugReportType$json = const {
  '1': 'BugReportType',
  '2': const [
    const {'1': 'bug_report', '2': 0},
    const {'1': 'feedback', '2': 1},
  ],
};

const RecipeRequest$json = const {
  '1': 'RecipeRequest',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'parent', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'parent'},
    const {'1': '_extras', '3': 3, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
  ],
  '7': const {},
};

const Comment$json = const {
  '1': 'Comment',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '8': const {}, '10': 'user'},
    const {'1': 'text', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'text'},
    const {'1': '_extras', '3': 5, '4': 1, '5': 11, '6': '.common.Extras', '8': const {}, '10': 'Extras'},
    const {'1': 'parent', '3': 7, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '8': const {}, '10': 'parent'},
    const {'1': 'tagged_users', '3': 8, '4': 3, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'taggedUsers'},
  ],
};

const Notification$json = const {
  '1': 'Notification',
  '2': const [
    const {'1': 'body', '3': 1, '4': 1, '5': 9, '10': 'body'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'document_link', '3': 3, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'documentLink'},
    const {'1': 'notification_type', '3': 4, '4': 1, '5': 14, '6': '.firestore.NotificationType', '10': 'notificationType'},
    const {'1': 'user', '3': 5, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'seen', '3': 6, '4': 1, '5': 8, '10': 'seen'},
    const {'1': 'fcm_settings', '3': 7, '4': 1, '5': 14, '6': '.firestore.Notification.FCMSettings', '10': 'fcmSettings'},
  ],
  '4': const [Notification_FCMSettings$json],
};

const Notification_FCMSettings$json = const {
  '1': 'FCMSettings',
  '2': const [
    const {'1': 'fcm_settings_undefined', '2': 0},
    const {'1': 'fcm_settings_on_create_only', '2': 1},
    const {'1': 'fcm_settings_on_all_events', '2': 2},
  ],
};

const Operation$json = const {
  '1': 'Operation',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'status', '3': 2, '4': 1, '5': 5, '10': 'status'},
    const {'1': '_extras', '3': 3, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
    const {'1': 'parent', '3': 4, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'parent'},
  ],
};

const InstagramSettings$json = const {
  '1': 'InstagramSettings',
  '2': const [
    const {'1': 'auto_import_setting', '3': 1, '4': 1, '5': 14, '6': '.firestore.InstagramSettings.AutoImportSetting', '10': 'autoImportSetting'},
  ],
  '4': const [InstagramSettings_AutoImportSetting$json],
};

const InstagramSettings_AutoImportSetting$json = const {
  '1': 'AutoImportSetting',
  '2': const [
    const {'1': 'AUTO_IMPORT_SETTING_UNDEFINED', '2': 0},
    const {'1': 'never', '2': 1},
    const {'1': 'daily', '2': 2},
  ],
};

const InstagramInfo$json = const {
  '1': 'InstagramInfo',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'num_posts', '3': 3, '4': 1, '5': 5, '10': 'numPosts'},
    const {'1': 'settings', '3': 4, '4': 1, '5': 11, '6': '.firestore.InstagramSettings', '10': 'settings'},
    const {'1': 'profile_pic', '3': 5, '4': 1, '5': 11, '6': '.common.FirePhoto', '10': 'profilePic'},
    const {'1': 'display_name', '3': 6, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'num_followers', '3': 7, '4': 1, '5': 5, '10': 'numFollowers'},
    const {'1': 'num_following', '3': 8, '4': 1, '5': 5, '10': 'numFollowing'},
    const {'1': 'is_private', '3': 9, '4': 1, '5': 8, '10': 'isPrivate'},
    const {'1': 'token_invalid', '3': 10, '4': 1, '5': 8, '10': 'tokenInvalid'},
    const {'1': 'granted_permission', '3': 11, '4': 1, '5': 8, '10': 'grantedPermission'},
    const {'1': 'profile_pic_url', '3': 12, '4': 1, '5': 9, '10': 'profilePicUrl'},
    const {'1': 'email', '3': 13, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'biography', '3': 14, '4': 1, '5': 9, '10': 'biography'},
    const {'1': 'phone_number', '3': 15, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'scrape_finish_time', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'scrapeFinishTime'},
    const {'1': 'start_network_time', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startNetworkTime'},
    const {'1': 'end_network_time', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endNetworkTime'},
    const {'1': 'following', '3': 19, '4': 3, '5': 9, '10': 'following'},
  ],
};

const TasteUser$json = const {
  '1': 'TasteUser',
  '2': const [
    const {'1': 'display_name', '3': 1, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'photo_url', '3': 3, '4': 1, '5': 9, '10': 'photoUrl'},
    const {'1': 'vanity', '3': 2, '4': 1, '5': 11, '6': '.firestore.TasteUser.Vanity', '10': 'vanity'},
    const {'1': '_extras', '3': 5, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
    const {'1': 'score', '3': 8, '4': 1, '5': 5, '10': 'score'},
    const {'1': 'email', '3': 9, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'daily_digest', '3': 10, '4': 1, '5': 11, '6': '.firestore.TasteUser.DailyDigest', '10': 'dailyDigest'},
    const {'1': 'fb_id', '3': 11, '4': 1, '5': 9, '10': 'fbId'},
    const {'1': 'instagram_info', '3': 12, '4': 1, '5': 11, '6': '.firestore.InstagramInfo', '10': 'instagramInfo'},
    const {'1': 'guest_mode', '3': 13, '4': 1, '5': 8, '10': 'guestMode'},
    const {'1': 'uid', '3': 14, '4': 1, '5': 9, '10': 'uid'},
    const {'1': 'setup_liked_restos', '3': 15, '4': 3, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'setupLikedRestos'},
  ],
  '3': const [TasteUser_Vanity$json, TasteUser_DailyDigest$json],
};

const TasteUser_Vanity$json = const {
  '1': 'Vanity',
  '2': const [
    const {'1': 'display_name', '3': 1, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    const {
      '1': 'photo',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.common.DocumentReferenceProto',
      '8': const {'3': true},
      '10': 'photo',
    },
    const {'1': 'fire_photo', '3': 6, '4': 1, '5': 11, '6': '.common.FirePhoto', '10': 'firePhoto'},
    const {'1': 'has_set_up_account', '3': 4, '4': 1, '5': 8, '10': 'hasSetUpAccount'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
  ],
};

const TasteUser_DailyDigest$json = const {
  '1': 'DailyDigest',
  '2': const [
    const {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
  ],
};

const FoodFinderAction$json = const {
  '1': 'FoodFinderAction',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'restaurant', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'restaurant'},
    const {'1': 'discover_items', '3': 3, '4': 3, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'discoverItems'},
    const {'1': 'active_discover_item_index', '3': 4, '4': 1, '5': 5, '10': 'activeDiscoverItemIndex'},
    const {'1': 'action', '3': 5, '4': 1, '5': 14, '6': '.firestore.FoodFinderAction.ActionType', '10': 'action'},
    const {'1': 'session_id', '3': 6, '4': 1, '5': 9, '10': 'sessionId'},
    const {'1': 'time', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'time'},
  ],
  '4': const [FoodFinderAction_ActionType$json],
};

const FoodFinderAction_ActionType$json = const {
  '1': 'ActionType',
  '2': const [
    const {'1': 'ACTION_TYPE_UNDEFINED', '2': 0},
    const {'1': 'add_to_list', '2': 1},
    const {'1': 'pass', '2': 2},
    const {'1': 'never_show_again', '2': 3},
    const {'1': 'open_resto_page', '2': 4},
    const {'1': 'remove_from_list', '2': 5},
  ],
};

const Review$json = const {
  '1': 'Review',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {
      '1': 'photo',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.common.DocumentReferenceProto',
      '8': const {'3': true},
      '10': 'photo',
    },
    const {'1': 'reaction', '3': 5, '4': 1, '5': 14, '6': '.review.Reaction', '10': 'reaction'},
    const {'1': 'meal_type', '3': 6, '4': 1, '5': 14, '6': '.firestore.Review.MealType', '10': 'mealType'},
    const {'1': 'published', '3': 8, '4': 1, '5': 8, '10': 'published'},
    const {'1': 'score', '3': 9, '4': 1, '5': 5, '10': 'score'},
    const {'1': '_extras', '3': 13, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
    const {'1': 'emojis', '3': 15, '4': 3, '5': 9, '10': 'emojis'},
    const {'1': 'location', '3': 16, '4': 1, '5': 11, '6': '.common.LatLng', '10': 'location'},
    const {'1': 'dish', '3': 17, '4': 1, '5': 9, '10': 'dish'},
    const {'1': 'restaurant', '3': 10, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'restaurant'},
    const {'1': 'restaurant_location', '3': 11, '4': 1, '5': 11, '6': '.common.LatLng', '10': 'restaurantLocation'},
    const {'1': 'address', '3': 12, '4': 1, '5': 11, '6': '.firestore.Restaurant.Attributes.Address', '10': 'address'},
    const {'1': 'restaurant_name', '3': 18, '4': 1, '5': 9, '10': 'restaurantName'},
    const {'1': 'attributes', '3': 19, '4': 3, '5': 9, '10': 'attributes'},
    const {'1': 'meal_mates', '3': 20, '4': 3, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'mealMates'},
    const {'1': 'contest', '3': 21, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'contest'},
    const {'1': 'delivery_app', '3': 22, '4': 1, '5': 14, '6': '.firestore.Review.DeliveryApp', '10': 'deliveryApp'},
    const {
      '1': 'more_photos',
      '3': 23,
      '4': 3,
      '5': 11,
      '6': '.common.DocumentReferenceProto',
      '8': const {'3': true},
      '10': 'morePhotos',
    },
    const {'1': 'fire_photos', '3': 30, '4': 3, '5': 11, '6': '.common.FirePhoto', '10': 'firePhotos'},
    const {'1': 'user_tags_in_text', '3': 24, '4': 3, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'userTagsInText'},
    const {'1': 'insta_post', '3': 25, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'instaPost'},
    const {'1': 'imported_at', '3': 26, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'importedAt'},
    const {'1': 'awards', '3': 27, '4': 1, '5': 11, '6': '.firestore.Awards', '10': 'awards'},
    const {'1': 'freeze_place', '3': 28, '4': 1, '5': 8, '10': 'freezePlace'},
    const {'1': 'categories', '3': 29, '4': 3, '5': 9, '10': 'categories'},
    const {'1': 'recipe', '3': 31, '4': 1, '5': 9, '10': 'recipe'},
    const {'1': 'black_owned', '3': 32, '4': 1, '5': 14, '6': '.firestore.Review.BlackOwnedStatus', '10': 'blackOwned'},
    const {'1': 'black_charity', '3': 33, '4': 1, '5': 14, '6': '.firestore.BlackCharity', '10': 'blackCharity'},
    const {'1': 'num_insta_likes', '3': 34, '4': 1, '5': 5, '10': 'numInstaLikes'},
    const {'1': 'num_insta_followers', '3': 35, '4': 1, '5': 5, '10': 'numInstaFollowers'},
    const {'1': 'hidden', '3': 36, '4': 1, '5': 8, '10': 'hidden'},
    const {'1': 'food_types', '3': 37, '4': 3, '5': 14, '6': '.common.FoodType', '10': 'foodTypes'},
    const {'1': 'food_types_photo_indices', '3': 38, '4': 3, '5': 5, '10': 'foodTypesPhotoIndices'},
  ],
  '4': const [Review_MealType$json, Review_DeliveryApp$json, Review_BlackOwnedStatus$json],
};

const Review_MealType$json = const {
  '1': 'MealType',
  '2': const [
    const {'1': 'MEAL_TYPE_UNDEFINED', '2': 0},
    const {'1': 'meal_type_restaurant', '2': 1},
    const {'1': 'meal_type_home', '2': 2},
  ],
};

const Review_DeliveryApp$json = const {
  '1': 'DeliveryApp',
  '2': const [
    const {'1': 'UNDEFINED', '2': 0},
    const {'1': 'postmates', '2': 1},
    const {'1': 'grub_hub', '2': 2},
    const {'1': 'uber_eats', '2': 3},
    const {'1': 'seamless', '2': 4},
    const {'1': 'door_dash', '2': 5},
    const {'1': 'eat_24', '2': 6},
  ],
};

const Review_BlackOwnedStatus$json = const {
  '1': 'BlackOwnedStatus',
  '2': const [
    const {'1': 'BLACK_OWNED_UNDEFINED', '2': 0},
    const {'1': 'restaurant_black_owned', '2': 1},
    const {'1': 'restaurant_not_black_owned', '2': 2},
    const {'1': 'user_selected_black_owned', '2': 3},
  ],
};

const Restaurant$json = const {
  '1': 'Restaurant',
  '2': const [
    const {'1': '_extras', '3': 1, '4': 1, '5': 11, '6': '.common.Extras', '8': const {}, '10': 'Extras'},
    const {'1': 'attributes', '3': 2, '4': 1, '5': 11, '6': '.firestore.Restaurant.Attributes', '8': const {}, '10': 'attributes'},
    const {'1': 'merchant', '3': 3, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'merchant'},
    const {'1': 'yelp', '3': 4, '4': 1, '5': 11, '6': '.common.ScraperResults', '10': 'yelp'},
    const {'1': 'google', '3': 5, '4': 1, '5': 11, '6': '.common.ScraperResults', '10': 'google'},
    const {'1': 'popularity_score', '3': 6, '4': 1, '5': 1, '10': 'popularityScore'},
    const {
      '1': 'profile_pic',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.common.DocumentReferenceProto',
      '8': const {'3': true},
      '10': 'profilePic',
    },
    const {'1': 'profile_pic_external_url', '3': 8, '4': 1, '5': 9, '8': const {}, '10': 'profilePicExternalUrl'},
    const {'1': 'fire_profile_pic', '3': 9, '4': 1, '5': 11, '6': '.common.FirePhoto', '10': 'fireProfilePic'},
    const {'1': 'yelp_scraped', '3': 10, '4': 1, '5': 8, '10': 'yelpScraped'},
    const {'1': 'yelp_match', '3': 11, '4': 1, '5': 8, '10': 'yelpMatch'},
    const {'1': 'google_scraped', '3': 12, '4': 1, '5': 8, '10': 'googleScraped'},
    const {'1': 'google_match', '3': 13, '4': 1, '5': 8, '10': 'googleMatch'},
    const {'1': 'from_hidden_review', '3': 14, '4': 1, '5': 8, '10': 'fromHiddenReview'},
    const {'1': 'gm_yelp_score', '3': 15, '4': 1, '5': 1, '10': 'gmYelpScore'},
    const {'1': 'instagram_score', '3': 16, '4': 1, '5': 1, '10': 'instagramScore'},
    const {'1': 'spatial_index', '3': 17, '4': 1, '5': 11, '6': '.firestore.SpatialIndex', '10': 'spatialIndex'},
    const {'1': 'geohash', '3': 18, '4': 1, '5': 9, '10': 'geohash'},
    const {'1': 'num_reviews', '3': 19, '4': 1, '5': 5, '10': 'numReviews'},
    const {'1': 'num_visible_reviews', '3': 20, '4': 1, '5': 5, '10': 'numVisibleReviews'},
    const {'1': 'delivery_scraped', '3': 21, '4': 1, '5': 8, '10': 'deliveryScraped'},
    const {'1': 'delivery_url', '3': 22, '4': 1, '5': 11, '6': '.firestore.Restaurant.DeliveryUrl', '10': 'deliveryUrl'},
    const {'1': 'delivery_info', '3': 23, '4': 1, '5': 11, '6': '.firestore.Restaurant.DeliveryInfo', '10': 'deliveryInfo'},
    const {'1': 'delivery_scraper_error', '3': 24, '4': 1, '5': 8, '10': 'deliveryScraperError'},
    const {'1': 'total_ig_likes', '3': 25, '4': 1, '5': 5, '10': 'totalIgLikes'},
    const {'1': 'total_ig_followers', '3': 26, '4': 1, '5': 5, '10': 'totalIgFollowers'},
    const {'1': 'num_ig_posts', '3': 27, '4': 1, '5': 5, '10': 'numIgPosts'},
    const {'1': 'scores_up_to_date', '3': 28, '4': 1, '5': 8, '10': 'scoresUpToDate'},
    const {'1': 'top_review_pic', '3': 29, '4': 1, '5': 11, '6': '.common.FirePhoto', '10': 'topReviewPic'},
  ],
  '3': const [Restaurant_Attributes$json, Restaurant_DeliveryAppInfo$json, Restaurant_HoursInfo$json, Restaurant_HoursWindows$json, Restaurant_OpenWindow$json, Restaurant_FacebookHours$json, Restaurant_Hours$json, Restaurant_DeliveryInfo$json, Restaurant_DeliveryUrl$json],
};

const Restaurant_Attributes$json = const {
  '1': 'Attributes',
  '2': const [
    const {'1': 'location', '3': 1, '4': 1, '5': 11, '6': '.common.LatLng', '8': const {}, '10': 'location'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'name'},
    const {'1': 'google_place_id', '3': 3, '4': 1, '5': 9, '8': const {}, '10': 'googlePlaceId'},
    const {'1': 'all_fb_place_ids', '3': 4, '4': 3, '5': 9, '10': 'allFbPlaceIds'},
    const {'1': 'fb_place_id', '3': 5, '4': 1, '5': 9, '8': const {}, '10': 'fbPlaceId'},
    const {'1': 'address', '3': 6, '4': 1, '5': 11, '6': '.firestore.Restaurant.Attributes.Address', '8': const {}, '10': 'address'},
    const {'1': 'categories', '3': 7, '4': 3, '5': 9, '10': 'categories'},
    const {'1': 'black_owned', '3': 8, '4': 1, '5': 8, '10': 'blackOwned'},
    const {'1': 'phone', '3': 9, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'website', '3': 10, '4': 1, '5': 9, '10': 'website'},
    const {'1': 'food_types', '3': 11, '4': 3, '5': 14, '6': '.common.FoodType', '10': 'foodTypes'},
    const {'1': 'place_types', '3': 12, '4': 3, '5': 14, '6': '.common.PlaceType', '10': 'placeTypes'},
    const {'1': 'place_type_scores', '3': 13, '4': 3, '5': 1, '10': 'placeTypeScores'},
    const {'1': 'place_types_set', '3': 14, '4': 1, '5': 8, '10': 'placeTypesSet'},
    const {'1': 'hours', '3': 15, '4': 1, '5': 11, '6': '.firestore.Restaurant.Hours', '10': 'hours'},
    const {'1': 'queried_hours', '3': 16, '4': 1, '5': 8, '10': 'queriedHours'},
  ],
  '3': const [Restaurant_Attributes_Address$json],
};

const Restaurant_Attributes_Address$json = const {
  '1': 'Address',
  '2': const [
    const {'1': 'street', '3': 1, '4': 1, '5': 9, '10': 'street'},
    const {'1': 'city', '3': 2, '4': 1, '5': 9, '8': const {}, '10': 'city'},
    const {'1': 'state', '3': 3, '4': 1, '5': 9, '10': 'state'},
    const {'1': 'country', '3': 4, '4': 1, '5': 9, '8': const {}, '10': 'country'},
    const {'1': 'source', '3': 5, '4': 1, '5': 14, '6': '.firestore.Restaurant.Attributes.Address.Source', '8': const {}, '10': 'source'},
    const {'1': 'source_location', '3': 6, '4': 1, '5': 11, '6': '.common.LatLng', '8': const {}, '10': 'sourceLocation'},
  ],
  '4': const [Restaurant_Attributes_Address_Source$json],
};

const Restaurant_Attributes_Address_Source$json = const {
  '1': 'Source',
  '2': const [
    const {'1': 'SOURCE_UNDEFINED', '2': 0},
    const {'1': 'facebook', '2': 1},
    const {'1': 'google_geocoder', '2': 2},
  ],
};

const Restaurant_DeliveryAppInfo$json = const {
  '1': 'DeliveryAppInfo',
  '2': const [
    const {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'subscription_discount', '3': 2, '4': 1, '5': 8, '10': 'subscriptionDiscount'},
    const {'1': 'taking_orders', '3': 3, '4': 1, '5': 8, '10': 'takingOrders'},
    const {'1': 'delivery_fee', '3': 4, '4': 1, '5': 9, '10': 'deliveryFee'},
    const {'1': 'hours', '3': 5, '4': 1, '5': 11, '6': '.firestore.Restaurant.Hours', '10': 'hours'},
    const {'1': 'extra', '3': 6, '4': 1, '5': 9, '10': 'extra'},
    const {'1': 'has_delivery', '3': 7, '4': 1, '5': 8, '10': 'hasDelivery'},
    const {'1': 'has_pickup', '3': 8, '4': 1, '5': 8, '10': 'hasPickup'},
  ],
};

const Restaurant_HoursInfo$json = const {
  '1': 'HoursInfo',
  '2': const [
    const {'1': 'is_open', '3': 1, '4': 1, '5': 8, '10': 'isOpen'},
    const {'1': 'delivery', '3': 2, '4': 1, '5': 11, '6': '.firestore.Restaurant.HoursWindows', '10': 'delivery'},
    const {'1': 'pickup', '3': 3, '4': 1, '5': 11, '6': '.firestore.Restaurant.HoursWindows', '10': 'pickup'},
    const {'1': 'fb_hours', '3': 4, '4': 1, '5': 11, '6': '.firestore.Restaurant.FacebookHours', '10': 'fbHours'},
  ],
};

const Restaurant_HoursWindows$json = const {
  '1': 'HoursWindows',
  '2': const [
    const {'1': 'begin', '3': 1, '4': 3, '5': 9, '10': 'begin'},
    const {'1': 'end', '3': 2, '4': 3, '5': 9, '10': 'end'},
  ],
};

const Restaurant_OpenWindow$json = const {
  '1': 'OpenWindow',
  '2': const [
    const {'1': 'open', '3': 1, '4': 1, '5': 9, '10': 'open'},
    const {'1': 'close', '3': 2, '4': 1, '5': 9, '10': 'close'},
  ],
};

const Restaurant_FacebookHours$json = const {
  '1': 'FacebookHours',
  '2': const [
    const {'1': 'hours', '3': 1, '4': 3, '5': 11, '6': '.firestore.Restaurant.OpenWindow', '10': 'hours'},
  ],
};

const Restaurant_Hours$json = const {
  '1': 'Hours',
  '2': const [
    const {'1': 'Mon', '3': 1, '4': 1, '5': 11, '6': '.firestore.Restaurant.HoursInfo', '10': 'Mon'},
    const {'1': 'Tue', '3': 2, '4': 1, '5': 11, '6': '.firestore.Restaurant.HoursInfo', '10': 'Tue'},
    const {'1': 'Wed', '3': 3, '4': 1, '5': 11, '6': '.firestore.Restaurant.HoursInfo', '10': 'Wed'},
    const {'1': 'Thu', '3': 4, '4': 1, '5': 11, '6': '.firestore.Restaurant.HoursInfo', '10': 'Thu'},
    const {'1': 'Fri', '3': 5, '4': 1, '5': 11, '6': '.firestore.Restaurant.HoursInfo', '10': 'Fri'},
    const {'1': 'Sat', '3': 6, '4': 1, '5': 11, '6': '.firestore.Restaurant.HoursInfo', '10': 'Sat'},
    const {'1': 'Sun', '3': 7, '4': 1, '5': 11, '6': '.firestore.Restaurant.HoursInfo', '10': 'Sun'},
    const {'1': 'has_hours', '3': 8, '4': 1, '5': 8, '10': 'hasHours'},
  ],
};

const Restaurant_DeliveryInfo$json = const {
  '1': 'DeliveryInfo',
  '2': const [
    const {'1': 'ubereats', '3': 1, '4': 1, '5': 11, '6': '.firestore.Restaurant.DeliveryAppInfo', '10': 'ubereats'},
    const {'1': 'postmates', '3': 2, '4': 1, '5': 11, '6': '.firestore.Restaurant.DeliveryAppInfo', '10': 'postmates'},
    const {'1': 'grubhub', '3': 3, '4': 1, '5': 11, '6': '.firestore.Restaurant.DeliveryAppInfo', '10': 'grubhub'},
    const {'1': 'doordash', '3': 4, '4': 1, '5': 11, '6': '.firestore.Restaurant.DeliveryAppInfo', '10': 'doordash'},
    const {'1': 'favor', '3': 5, '4': 1, '5': 11, '6': '.firestore.Restaurant.DeliveryAppInfo', '10': 'favor'},
  ],
};

const Restaurant_DeliveryUrl$json = const {
  '1': 'DeliveryUrl',
  '2': const [
    const {'1': 'ubereats', '3': 1, '4': 1, '5': 9, '10': 'ubereats'},
    const {'1': 'postmates', '3': 2, '4': 1, '5': 9, '10': 'postmates'},
    const {'1': 'grubhub', '3': 3, '4': 1, '5': 9, '10': 'grubhub'},
    const {'1': 'seamless', '3': 4, '4': 1, '5': 9, '10': 'seamless'},
    const {'1': 'doordash', '3': 5, '4': 1, '5': 9, '10': 'doordash'},
    const {'1': 'caviar', '3': 6, '4': 1, '5': 9, '10': 'caviar'},
    const {'1': 'favor', '3': 7, '4': 1, '5': 9, '10': 'favor'},
  ],
};

const View$json = const {
  '1': 'View',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'parent', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'parent'},
  ],
};

const Photo$json = const {
  '1': 'Photo',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'firebase_storage_path', '3': 2, '4': 1, '5': 9, '10': 'firebaseStoragePath'},
    const {'1': 'inference_data', '3': 4, '4': 1, '5': 11, '6': '.firestore.Photo.InferenceData', '10': 'inferenceData'},
    const {'1': 'references', '3': 5, '4': 3, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'references'},
    const {'1': 'photo_size', '3': 6, '4': 1, '5': 11, '6': '.common.Size', '10': 'photoSize'},
  ],
  '3': const [Photo_InferenceData$json],
};

const Photo_InferenceData$json = const {
  '1': 'InferenceData',
  '2': const [
    const {'1': 'source_ref', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'sourceRef'},
    const {'1': 'detection_center', '3': 2, '4': 1, '5': 11, '6': '.common.Point', '10': 'detectionCenter'},
  ],
};

const Follower$json = const {
  '1': 'Follower',
  '2': const [
    const {'1': 'following', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'following'},
    const {'1': 'follower', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'follower'},
    const {'1': '_extras', '3': 3, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
  ],
};

const Favorite$json = const {
  '1': 'Favorite',
  '2': const [
    const {'1': 'restaurant', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'restaurant'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': '_extras', '3': 3, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
  ],
};

const Like$json = const {
  '1': 'Like',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'parent'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': '_extras', '3': 3, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
  ],
};

const Bookmark$json = const {
  '1': 'Bookmark',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'parent'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': '_extras', '3': 3, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
  ],
};

const BugReport$json = const {
  '1': 'BugReport',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'bug_photos', '3': 3, '4': 3, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'bugPhotos'},
    const {'1': 'report_type', '3': 4, '4': 1, '5': 14, '6': '.firestore.BugReportType', '10': 'reportType'},
    const {'1': 'metadata', '3': 5, '4': 1, '5': 11, '6': '.common.AppMetadata', '10': 'metadata'},
    const {'1': '_extras', '3': 6, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
  ],
};

const Report$json = const {
  '1': 'Report',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'parent', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'parent'},
    const {'1': 'resolved', '3': 3, '4': 1, '5': 8, '10': 'resolved'},
    const {'1': 'text', '3': 4, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'resolution_text', '3': 5, '4': 1, '5': 9, '10': 'resolutionText'},
    const {'1': 'send_notification', '3': 6, '4': 1, '5': 8, '10': 'sendNotification'},
  ],
};

const AlgoliaRecord$json = const {
  '1': 'AlgoliaRecord',
  '2': const [
    const {'1': 'index', '3': 1, '4': 1, '5': 14, '6': '.algolia.AlgoliaIndex', '10': 'index'},
    const {'1': 'record_type', '3': 2, '4': 1, '5': 14, '6': '.algolia.AlgoliaRecordType', '10': 'recordType'},
    const {'1': 'tags', '3': 3, '4': 3, '5': 9, '10': 'tags'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'reference'},
    const {'1': 'object_id', '3': 5, '4': 1, '5': 9, '10': 'objectId'},
    const {'1': 'payload', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Struct', '10': 'payload'},
    const {'1': 'location', '3': 7, '4': 1, '5': 11, '6': '.common.LatLng', '10': 'location'},
  ],
};

const InstagramUsernameRequest$json = const {
  '1': 'InstagramUsernameRequest',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'most_recent_post_date', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'mostRecentPostDate'},
    const {'1': 'set_location_request', '3': 3, '4': 1, '5': 8, '10': 'setLocationRequest'},
  ],
};

const InstagramPost$json = const {
  '1': 'InstagramPost',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'likes', '3': 3, '4': 1, '5': 5, '10': 'likes'},
    const {'1': 'full_name', '3': 4, '4': 1, '5': 9, '10': 'fullName'},
    const {'1': 'profile_pic_url', '3': 5, '4': 1, '5': 9, '10': 'profilePicUrl'},
    const {'1': 'text', '3': 6, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'code', '3': 7, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'location_name', '3': 8, '4': 1, '5': 9, '10': 'locationName'},
    const {'1': 'location', '3': 9, '4': 1, '5': 11, '6': '.common.LatLng', '10': 'location'},
    const {'1': 'date_processed', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'dateProcessed'},
    const {'1': 'date_posted', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'datePosted'},
    const {'1': 'spatial_index', '3': 12, '4': 1, '5': 11, '6': '.firestore.SpatialIndex', '10': 'spatialIndex'},
    const {'1': 'post_type', '3': 13, '4': 1, '5': 14, '6': '.firestore.InstagramPost.PostType', '10': 'postType'},
    const {'1': 'pk', '3': 14, '4': 1, '5': 9, '10': 'pk'},
    const {'1': 'classifications', '3': 15, '4': 3, '5': 14, '6': '.firestore.InstagramPost.PhotoClassification', '10': 'classifications'},
    const {'1': 's3_photo_url', '3': 16, '4': 1, '5': 9, '10': 's3PhotoUrl'},
    const {'1': 'source', '3': 17, '4': 1, '5': 14, '6': '.firestore.InstagramPost.InstagramPostSource', '10': 'source'},
    const {'1': 'reference', '3': 19, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'reference'},
    const {'1': 'photo_urls', '3': 20, '4': 3, '5': 9, '10': 'photoUrls'},
  ],
  '4': const [InstagramPost_PostType$json, InstagramPost_PhotoClassification$json, InstagramPost_InstagramPostSource$json],
};

const InstagramPost_PostType$json = const {
  '1': 'PostType',
  '2': const [
    const {'1': 'POST_TYPE_UNDEFINED', '2': 0},
    const {'1': 'instagram', '2': 1},
    const {'1': 'taste', '2': 2},
  ],
};

const InstagramPost_PhotoClassification$json = const {
  '1': 'PhotoClassification',
  '2': const [
    const {'1': 'PHOTO_CLASSIFICATION_UNDEFINED', '2': 0},
    const {'1': 'food', '2': 1},
  ],
};

const InstagramPost_InstagramPostSource$json = const {
  '1': 'InstagramPostSource',
  '2': const [
    const {'1': 'InstagramPostSource_UNDEFINED', '2': 0},
    const {'1': 'queue_processor', '2': 1},
    const {'1': 'cloud_function_trigger', '2': 2},
  ],
};

const Badge$json = const {
  '1': 'Badge',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.firestore.Badge.BadgeType', '10': 'type'},
    const {'1': 'count_data', '3': 3, '4': 1, '5': 11, '6': '.firestore.Badge.CountData', '10': 'countData'},
    const {'1': 'city_champion_data', '3': 4, '4': 1, '5': 11, '6': '.firestore.Badge.CityChampion', '10': 'cityChampionData'},
    const {'1': 'emoji_flags', '3': 5, '4': 1, '5': 11, '6': '.firestore.Badge.EmojiFlags', '10': 'emojiFlags'},
    const {'1': 'matching_references', '3': 6, '4': 3, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'matchingReferences'},
    const {'1': 'brainiac_info', '3': 7, '4': 1, '5': 11, '6': '.firestore.Badge.Brainiac', '10': 'brainiacInfo'},
  ],
  '3': const [Badge_CountData$json, Badge_CityChampion$json, Badge_EmojiFlags$json, Badge_Brainiac$json],
  '4': const [Badge_BadgeType$json],
};

const Badge_CountData$json = const {
  '1': 'CountData',
  '2': const [
    const {'1': 'count', '3': 1, '4': 1, '5': 5, '10': 'count'},
  ],
};

const Badge_CityChampion$json = const {
  '1': 'CityChampion',
  '2': const [
    const {'1': 'cities', '3': 1, '4': 3, '5': 11, '6': '.firestore.Badge.CityChampion.City', '10': 'cities'},
  ],
  '3': const [Badge_CityChampion_City$json],
};

const Badge_CityChampion_City$json = const {
  '1': 'City',
  '2': const [
    const {'1': 'city', '3': 1, '4': 1, '5': 9, '10': 'city'},
    const {'1': 'country', '3': 2, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'state', '3': 3, '4': 1, '5': 9, '10': 'state'},
  ],
};

const Badge_EmojiFlags$json = const {
  '1': 'EmojiFlags',
  '2': const [
    const {'1': 'flags', '3': 1, '4': 3, '5': 9, '10': 'flags'},
  ],
};

const Badge_Brainiac$json = const {
  '1': 'Brainiac',
  '2': const [
    const {'1': 'attributes', '3': 1, '4': 3, '5': 9, '10': 'attributes'},
  ],
};

const Badge_BadgeType$json = const {
  '1': 'BadgeType',
  '2': const [
    const {'1': 'BADGE_TYPE_UNDEFINED', '2': 0},
    const {'1': 'streak_longest', '2': 1},
    const {'1': 'streak_active', '2': 2},
    const {'1': 'post_cities_total', '2': 3},
    const {'1': 'post_countries_total', '2': 4},
    const {'1': 'favorites_cities_total', '2': 5},
    const {'1': 'favorites_countries_total', '2': 6},
    const {'1': 'commenter_level_1', '2': 7},
    const {'1': 'emoji_flags_level_1', '2': 8},
    const {'1': 'brainiac', '2': 9},
    const {'1': 'burgermeister', '2': 10},
    const {'1': 'sushinista', '2': 11},
    const {'1': 'regular', '2': 12},
    const {'1': 'herbivore', '2': 13},
    const {'1': 'socialite', '2': 14},
    const {'1': 'ramsay', '2': 15},
    const {'1': 'character', '2': 16},
    const {'1': 'city_champion', '2': 17},
    const {'1': 'quarantine', '2': 18},
    const {'1': 'daily_tasty', '2': 19},
    const {'1': 'black_owned_restaurant_post', '2': 20},
  ],
};

const SpatialIndex$json = const {
  '1': 'SpatialIndex',
  '2': const [
    const {'1': 'cell_id', '3': 1, '4': 1, '5': 9, '10': 'cellId'},
    const {'1': 'levels', '3': 2, '4': 3, '5': 9, '10': 'levels'},
  ],
};

const UniqueUserIndex$json = const {
  '1': 'UniqueUserIndex',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'reference'},
  ],
};

const DiscoverItem$json = const {
  '1': 'DiscoverItem',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'reference'},
    const {'1': 'restaurant', '3': 2, '4': 1, '5': 11, '6': '.firestore.DiscoverItem.DiscoverRestaurant', '10': 'restaurant'},
    const {'1': 'review', '3': 3, '4': 1, '5': 11, '6': '.firestore.DiscoverItem.DiscoverReview', '10': 'review'},
    const {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.firestore.DiscoverItem.User', '10': 'user'},
    const {'1': 'date', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    const {'1': 'comments', '3': 6, '4': 3, '5': 11, '6': '.firestore.DiscoverItem.Comment', '10': 'comments'},
    const {'1': 'meal_type', '3': 7, '4': 1, '5': 14, '6': '.firestore.Review.MealType', '10': 'mealType'},
    const {'1': 'location', '3': 8, '4': 1, '5': 11, '6': '.common.LatLng', '10': 'location'},
    const {'1': 'dish', '3': 9, '4': 1, '5': 9, '10': 'dish'},
    const {
      '1': 'photo',
      '3': 10,
      '4': 1,
      '5': 9,
      '8': const {'3': true},
      '10': 'photo',
    },
    const {'1': 'tags', '3': 11, '4': 3, '5': 9, '10': 'tags'},
    const {
      '1': 'more_photos',
      '3': 12,
      '4': 3,
      '5': 9,
      '8': const {'3': true},
      '10': 'morePhotos',
    },
    const {'1': 'insta_post', '3': 13, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'instaPost'},
    const {'1': 'awards', '3': 14, '4': 1, '5': 11, '6': '.firestore.Awards', '10': 'awards'},
    const {'1': 'freeze_place', '3': 15, '4': 1, '5': 8, '10': 'freezePlace'},
    const {'1': 'imported_at', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'importedAt'},
    const {'1': 'is_instagram_post', '3': 17, '4': 1, '5': 8, '10': 'isInstagramPost'},
    const {'1': 'fire_photos', '3': 18, '4': 3, '5': 11, '6': '.common.FirePhoto', '10': 'firePhotos'},
    const {'1': '_extras', '3': 20, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
    const {'1': 'black_owned', '3': 21, '4': 1, '5': 8, '10': 'blackOwned'},
    const {'1': 'likes', '3': 22, '4': 3, '5': 11, '6': '.firestore.DiscoverItem.User', '10': 'likes'},
    const {'1': 'bookmarks', '3': 23, '4': 3, '5': 11, '6': '.firestore.DiscoverItem.User', '10': 'bookmarks'},
    const {'1': 'black_charity', '3': 24, '4': 1, '5': 14, '6': '.firestore.BlackCharity', '10': 'blackCharity'},
    const {'1': 'score', '3': 25, '4': 1, '5': 5, '10': 'score'},
    const {'1': 'categories', '3': 26, '4': 3, '5': 9, '10': 'categories'},
    const {'1': 'spatial_index', '3': 27, '4': 1, '5': 11, '6': '.firestore.SpatialIndex', '10': 'spatialIndex'},
    const {'1': 'hidden', '3': 28, '4': 1, '5': 8, '10': 'hidden'},
    const {'1': 'num_insta_likes', '3': 29, '4': 1, '5': 5, '10': 'numInstaLikes'},
    const {'1': 'num_insta_followers', '3': 30, '4': 1, '5': 5, '10': 'numInstaFollowers'},
    const {'1': 'show_on_discover_feed', '3': 31, '4': 1, '5': 8, '10': 'showOnDiscoverFeed'},
  ],
  '3': const [DiscoverItem_DiscoverRestaurant$json, DiscoverItem_DiscoverReview$json, DiscoverItem_User$json, DiscoverItem_Comment$json],
};

const DiscoverItem_DiscoverRestaurant$json = const {
  '1': 'DiscoverRestaurant',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'reference'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'address', '3': 3, '4': 1, '5': 11, '6': '.firestore.Restaurant.Attributes.Address', '10': 'address'},
  ],
};

const DiscoverItem_DiscoverReview$json = const {
  '1': 'DiscoverReview',
  '2': const [
    const {
      '1': 'text',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': const {'3': true},
      '10': 'text',
    },
    const {'1': 'reaction', '3': 2, '4': 1, '5': 14, '6': '.review.Reaction', '10': 'reaction'},
    const {'1': 'meal_mates', '3': 3, '4': 1, '5': 11, '6': '.firestore.DiscoverItem.DiscoverReview.DiscoverMealMates', '10': 'mealMates'},
    const {'1': 'raw_text', '3': 4, '4': 1, '5': 9, '10': 'rawText'},
    const {'1': 'emojis', '3': 5, '4': 3, '5': 9, '10': 'emojis'},
    const {'1': 'attributes', '3': 6, '4': 3, '5': 9, '10': 'attributes'},
    const {'1': 'delivery_app', '3': 7, '4': 1, '5': 14, '6': '.firestore.Review.DeliveryApp', '10': 'deliveryApp'},
    const {'1': 'recipe', '3': 8, '4': 1, '5': 9, '10': 'recipe'},
    const {'1': 'food_types', '3': 9, '4': 3, '5': 14, '6': '.common.FoodType', '10': 'foodTypes'},
    const {'1': 'food_types_photo_indices', '3': 10, '4': 3, '5': 5, '10': 'foodTypesPhotoIndices'},
  ],
  '3': const [DiscoverItem_DiscoverReview_DiscoverMealMates$json],
};

const DiscoverItem_DiscoverReview_DiscoverMealMates$json = const {
  '1': 'DiscoverMealMates',
  '2': const [
    const {'1': 'meal_mates', '3': 1, '4': 3, '5': 11, '6': '.firestore.DiscoverItem.DiscoverReview.DiscoverMealMates.DiscoverMealMate', '10': 'mealMates'},
  ],
  '3': const [DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate$json],
};

const DiscoverItem_DiscoverReview_DiscoverMealMates_DiscoverMealMate$json = const {
  '1': 'DiscoverMealMate',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'reference'},
  ],
};

const DiscoverItem_User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'reference'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'photo', '3': 3, '4': 1, '5': 9, '10': 'photo'},
  ],
};

const DiscoverItem_Comment$json = const {
  '1': 'Comment',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'reference'},
    const {'1': 'text', '3': 2, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    const {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.firestore.DiscoverItem.User', '10': 'user'},
  ],
};

const City$json = const {
  '1': 'City',
  '2': const [
    const {'1': 'city', '3': 1, '4': 1, '5': 9, '10': 'city'},
    const {'1': 'state', '3': 2, '4': 1, '5': 9, '10': 'state'},
    const {'1': 'country', '3': 3, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'popularity_score', '3': 4, '4': 1, '5': 1, '10': 'popularityScore'},
    const {'1': 'location', '3': 5, '4': 1, '5': 11, '6': '.common.LatLng', '10': 'location'},
  ],
};

const Tag$json = const {
  '1': 'Tag',
  '2': const [
    const {'1': 'tag', '3': 1, '4': 1, '5': 9, '10': 'tag'},
    const {'1': 'trending_score', '3': 2, '4': 1, '5': 1, '10': 'trendingScore'},
    const {'1': 'last_updated', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdated'},
  ],
};

const Contest$json = const {
  '1': 'Contest',
  '2': const [
    const {'1': 'start', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'start'},
    const {'1': 'end', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'end'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'contest_type', '3': 4, '4': 1, '5': 14, '6': '.firestore.Contest.ContestType', '10': 'contestType'},
  ],
  '4': const [Contest_ContestType$json],
};

const Contest_ContestType$json = const {
  '1': 'ContestType',
  '2': const [
    const {'1': 'contest_type_undefined', '2': 0},
    const {'1': 'contest_type_home_cooking', '2': 1},
    const {'1': 'contest_type_local_restaurants', '2': 2},
  ],
};

const DailyTastyVote$json = const {
  '1': 'DailyTastyVote',
  '2': const [
    const {'1': 'score', '3': 1, '4': 1, '5': 1, '8': const {}, '10': 'score'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '8': const {}, '10': 'user'},
    const {'1': 'post', '3': 3, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'post'},
    const {'1': 'date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    const {'1': '_extras', '3': 5, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
  ],
  '7': const {},
};

const Awards$json = const {
  '1': 'Awards',
  '2': const [
    const {'1': 'daily_tasty', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'dailyTasty'},
  ],
};

const Conversation$json = const {
  '1': 'Conversation',
  '2': const [
    const {'1': '_extras', '3': 5, '4': 1, '5': 11, '6': '.common.Extras', '8': const {}, '10': 'Extras'},
    const {'1': 'members', '3': 1, '4': 3, '5': 11, '6': '.common.DocumentReferenceProto', '8': const {}, '10': 'members'},
    const {'1': 'messages', '3': 2, '4': 3, '5': 11, '6': '.firestore.Conversation.Message', '10': 'messages'},
    const {'1': 'seen_by', '3': 4, '4': 3, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'seenBy'},
    const {'1': 'last_seen', '3': 6, '4': 3, '5': 11, '6': '.firestore.Conversation.LastSeenEntry', '10': 'lastSeen'},
  ],
  '3': const [Conversation_Message$json, Conversation_LastSeenEntry$json],
};

const Conversation_Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'text', '3': 2, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'sent_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'sentAt'},
  ],
};

const Conversation_LastSeenEntry$json = const {
  '1': 'LastSeenEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'value'},
  ],
  '7': const {'7': true},
};

const Movie$json = const {
  '1': 'Movie',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'movie', '3': 2, '4': 1, '5': 9, '10': 'movie'},
    const {'1': 'date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
  ],
};

const InferenceResult$json = const {
  '1': 'InferenceResult',
  '2': const [
    const {'1': '_extras', '3': 1, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
    const {'1': 'photo_ref', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'photoRef'},
    const {'1': 'objects', '3': 3, '4': 3, '5': 11, '6': '.firestore.InferenceResult.LocalizedObjectAnnotation', '10': 'objects'},
  ],
  '3': const [InferenceResult_LocalizedObjectAnnotation$json],
};

const InferenceResult_LocalizedObjectAnnotation$json = const {
  '1': 'LocalizedObjectAnnotation',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'locale', '3': 2, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'score', '3': 3, '4': 1, '5': 1, '10': 'score'},
    const {'1': 'bounding_poly', '3': 5, '4': 1, '5': 11, '6': '.common.Polygon', '10': 'boundingPoly'},
  ],
};

const InstagramToken$json = const {
  '1': 'InstagramToken',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'time_acquired', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timeAcquired'},
    const {'1': 'expires_in', '3': 5, '4': 1, '5': 5, '10': 'expiresIn'},
    const {'1': 'username', '3': 6, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'user_id', '3': 7, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'import_status', '3': 8, '4': 1, '5': 14, '6': '.firestore.InstagramToken.ImportStatus', '10': 'importStatus'},
    const {'1': 'last_update', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastUpdate'},
    const {'1': 'token_status', '3': 10, '4': 1, '5': 14, '6': '.firestore.InstagramToken.TokenStatus', '10': 'tokenStatus'},
  ],
  '4': const [InstagramToken_ImportStatus$json, InstagramToken_TokenStatus$json],
};

const InstagramToken_ImportStatus$json = const {
  '1': 'ImportStatus',
  '2': const [
    const {'1': 'import_status_undefined', '2': 0},
    const {'1': 'start', '2': 1},
    const {'1': 'running', '2': 2},
    const {'1': 'complete', '2': 3},
    const {'1': 'added_locations', '2': 4},
  ],
};

const InstagramToken_TokenStatus$json = const {
  '1': 'TokenStatus',
  '2': const [
    const {'1': 'token_status_undefined', '2': 0},
    const {'1': 'token_failed', '2': 1},
    const {'1': 'short_term_token', '2': 2},
    const {'1': 'long_term_token', '2': 3},
  ],
};

const TasteBudGroup$json = const {
  '1': 'TasteBudGroup',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'taste_buds', '3': 2, '4': 3, '5': 11, '6': '.firestore.TasteBudGroup.TasteBud', '10': 'tasteBuds'},
  ],
  '3': const [TasteBudGroup_TasteBud$json],
};

const TasteBudGroup_TasteBud$json = const {
  '1': 'TasteBud',
  '2': const [
    const {'1': 'bud', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'bud'},
    const {'1': 'score', '3': 2, '4': 1, '5': 1, '10': 'score'},
  ],
};

const PrivateUserDocument$json = const {
  '1': 'PrivateUserDocument',
  '2': const [
    const {'1': 'fcm_tokens', '3': 1, '4': 3, '5': 9, '10': 'fcmTokens'},
    const {'1': 'timezone', '3': 2, '4': 1, '5': 9, '10': 'timezone'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
  ],
};

const MailchimpUserSetting$json = const {
  '1': 'MailchimpUserSetting',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'tags', '3': 2, '4': 3, '5': 9, '10': 'tags'},
  ],
};

const UserPostsStartingLocation$json = const {
  '1': 'UserPostsStartingLocation',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'location', '3': 2, '4': 1, '5': 11, '6': '.common.LatLng', '10': 'location'},
  ],
};

const GooglePlaces$json = const {
  '1': 'GooglePlaces',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'last_execute', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastExecute'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'num_reviews', '3': 5, '4': 1, '5': 5, '10': 'numReviews'},
    const {'1': 'scraped_reviews', '3': 6, '4': 1, '5': 5, '10': 'scrapedReviews'},
    const {'1': 'match_found', '3': 7, '4': 1, '5': 8, '10': 'matchFound'},
    const {'1': 'url', '3': 8, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'website', '3': 9, '4': 1, '5': 9, '10': 'website'},
  ],
};

const YelpPlaces$json = const {
  '1': 'YelpPlaces',
  '2': const [
    const {'1': 'place_id', '3': 1, '4': 1, '5': 9, '10': 'placeId'},
    const {'1': 'address', '3': 2, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'center', '3': 3, '4': 1, '5': 11, '6': '.common.LatLng', '10': 'center'},
    const {'1': 'has_center', '3': 4, '4': 1, '5': 8, '10': 'hasCenter'},
    const {'1': 'last_execute', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastExecute'},
    const {'1': 'name', '3': 6, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'num_reviews', '3': 8, '4': 1, '5': 5, '10': 'numReviews'},
    const {'1': 'scraped_reviews', '3': 9, '4': 1, '5': 5, '10': 'scrapedReviews'},
    const {'1': 'success', '3': 10, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'url', '3': 11, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'website', '3': 12, '4': 1, '5': 9, '10': 'website'},
  ],
};

const GoogleReviews$json = const {
  '1': 'GoogleReviews',
  '2': const [
    const {'1': 'place', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'place'},
    const {'1': 'text', '3': 2, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'photo_urls', '3': 3, '4': 3, '5': 9, '10': 'photoUrls'},
    const {'1': 'photos_saved', '3': 4, '4': 1, '5': 8, '10': 'photosSaved'},
    const {'1': 'approximate_timestamp', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'approximateTimestamp'},
    const {'1': 'rating', '3': 6, '4': 1, '5': 5, '10': 'rating'},
    const {'1': 'random', '3': 7, '4': 1, '5': 1, '10': 'random'},
  ],
};

const YelpReviews$json = const {
  '1': 'YelpReviews',
  '2': const [
    const {'1': 'place', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'place'},
    const {'1': 'text', '3': 2, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'photo_urls', '3': 3, '4': 3, '5': 9, '10': 'photoUrls'},
    const {'1': 'photos_saved', '3': 4, '4': 1, '5': 8, '10': 'photosSaved'},
    const {'1': 'date', '3': 5, '4': 1, '5': 9, '10': 'date'},
    const {'1': 'rating', '3': 6, '4': 1, '5': 5, '10': 'rating'},
    const {'1': 'random', '3': 7, '4': 1, '5': 1, '10': 'random'},
  ],
};

