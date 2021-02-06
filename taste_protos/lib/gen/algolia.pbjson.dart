///
//  Generated code. Do not modify.
//  source: algolia.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const AlgoliaIndex$json = const {
  '1': 'AlgoliaIndex',
  '2': const [
    const {'1': 'ALGOLIA_INDEX_UNDEFINED', '2': 0},
    const {'1': 'discover', '2': 1},
    const {'1': 'referrals', '2': 2},
    const {'1': 'reviews', '2': 3},
    const {'1': 'restaurants', '2': 4},
  ],
};

const AlgoliaRecordType$json = const {
  '1': 'AlgoliaRecordType',
  '2': const [
    const {'1': 'ALGOLIA_RECORD_TYPE_UNDEFINED', '2': 0},
    const {'1': 'restaurant', '2': 1},
    const {'1': 'restaurant_marker', '2': 2},
    const {'1': 'dish', '2': 3},
    const {'1': 'user', '2': 4},
    const {'1': 'referral_link', '2': 5},
    const {'1': 'review_marker', '2': 6},
    const {'1': 'review_discover', '2': 7},
    const {'1': 'city', '2': 8},
  ],
};

const GeoLoc$json = const {
  '1': 'GeoLoc',
  '2': const [
    const {'1': 'lat', '3': 1, '4': 1, '5': 1, '10': 'lat'},
    const {'1': 'lng', '3': 2, '4': 1, '5': 1, '10': 'lng'},
  ],
};

const DiscoverCache$json = const {
  '1': 'DiscoverCache',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 9, '10': 'reference'},
    const {'1': '_geoloc', '3': 4, '4': 1, '5': 11, '6': '.algolia.GeoLoc', '10': 'Geoloc'},
    const {'1': '_tags', '3': 5, '4': 3, '5': 9, '10': 'Tags'},
    const {'1': 'objectID', '3': 6, '4': 1, '5': 9, '10': 'objectID'},
    const {'1': 'record_type', '3': 7, '4': 1, '5': 9, '10': 'recordType'},
    const {'1': 'username', '3': 8, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'restaurant_name', '3': 9, '4': 1, '5': 9, '10': 'restaurantName'},
  ],
};

const RestaurantMarkerCache$json = const {
  '1': 'RestaurantMarkerCache',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'reviewers', '3': 5, '4': 3, '5': 9, '10': 'reviewers'},
    const {'1': 'reviews', '3': 6, '4': 3, '5': 11, '6': '.algolia.ReviewInfoCache', '10': 'reviews'},
    const {'1': 'num_favorites', '3': 3, '4': 1, '5': 5, '10': 'numFavorites'},
    const {'1': 'top_review', '3': 4, '4': 1, '5': 11, '6': '.algolia.RestaurantMarkerCache.TopReview', '10': 'topReview'},
    const {'1': '_geoloc', '3': 7, '4': 1, '5': 11, '6': '.algolia.GeoLoc', '10': 'Geoloc'},
    const {'1': '_tags', '3': 8, '4': 3, '5': 9, '10': 'Tags'},
    const {'1': 'objectID', '3': 9, '4': 1, '5': 9, '10': 'objectID'},
    const {'1': 'reference', '3': 10, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'record_type', '3': 11, '4': 1, '5': 9, '10': 'recordType'},
    const {'1': 'fb_place_id', '3': 12, '4': 1, '5': 9, '10': 'fbPlaceId'},
  ],
  '3': const [RestaurantMarkerCache_TopReview$json],
};

const RestaurantMarkerCache_TopReview$json = const {
  '1': 'TopReview',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.algolia.RestaurantMarkerCache.TopReview.User', '10': 'user'},
    const {'1': 'photo', '3': 2, '4': 1, '5': 9, '10': 'photo'},
    const {'1': 'score', '3': 3, '4': 1, '5': 5, '10': 'score'},
  ],
  '3': const [RestaurantMarkerCache_TopReview_User$json],
};

const RestaurantMarkerCache_TopReview_User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'thumbnail', '3': 1, '4': 1, '5': 9, '10': 'thumbnail'},
  ],
};

const RestaurantCache$json = const {
  '1': 'RestaurantCache',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'fb_place_id', '3': 2, '4': 1, '5': 9, '10': 'fbPlaceId'},
    const {'1': 'location', '3': 3, '4': 1, '5': 11, '6': '.common.LatLng', '10': 'location'},
    const {'1': 'popularity_score', '3': 4, '4': 1, '5': 1, '10': 'popularityScore'},
    const {'1': 'num_reviews', '3': 5, '4': 1, '5': 5, '10': 'numReviews'},
    const {'1': 'place_types', '3': 6, '4': 3, '5': 14, '6': '.common.PlaceType', '10': 'placeTypes'},
    const {'1': 'place_type_scores', '3': 7, '4': 3, '5': 1, '10': 'placeTypeScores'},
    const {'1': 'food_types', '3': 8, '4': 3, '5': 14, '6': '.common.FoodType', '10': 'foodTypes'},
    const {'1': 'place_categories', '3': 9, '4': 3, '5': 14, '6': '.common.PlaceCategory', '10': 'placeCategories'},
    const {'1': 'yelp_info', '3': 10, '4': 1, '5': 11, '6': '.algolia.ScrapeInfo', '10': 'yelpInfo'},
    const {'1': 'google_info', '3': 11, '4': 1, '5': 11, '6': '.algolia.ScrapeInfo', '10': 'googleInfo'},
    const {'1': 'serialized_hours', '3': 12, '4': 3, '5': 9, '10': 'serializedHours'},
    const {'1': 'delivery', '3': 13, '4': 3, '5': 9, '10': 'delivery'},
    const {'1': 'profile_pic', '3': 14, '4': 1, '5': 11, '6': '.common.FirePhoto', '10': 'profilePic'},
    const {'1': 'cover_photos', '3': 15, '4': 3, '5': 11, '6': '.algolia.CoverPhotoData', '10': 'coverPhotos'},
    const {'1': '_geoloc', '3': 16, '4': 1, '5': 11, '6': '.algolia.GeoLoc', '10': 'Geoloc'},
    const {'1': '_tags', '3': 17, '4': 3, '5': 9, '10': 'Tags'},
    const {'1': 'objectID', '3': 18, '4': 1, '5': 9, '10': 'objectID'},
    const {'1': 'reference', '3': 19, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'record_type', '3': 20, '4': 1, '5': 9, '10': 'recordType'},
    const {'1': 'pickup', '3': 21, '4': 3, '5': 9, '10': 'pickup'},
  ],
};

const ScrapeInfo$json = const {
  '1': 'ScrapeInfo',
  '2': const [
    const {'1': 'match', '3': 1, '4': 1, '5': 8, '10': 'match'},
    const {'1': 'scraper_result', '3': 2, '4': 1, '5': 11, '6': '.common.ScraperResults', '10': 'scraperResult'},
  ],
};

const CoverPhotoData$json = const {
  '1': 'CoverPhotoData',
  '2': const [
    const {'1': 'data', '3': 1, '4': 3, '5': 9, '10': 'data'},
  ],
};

const CoverPhoto$json = const {
  '1': 'CoverPhoto',
  '2': const [
    const {'1': 'photo', '3': 1, '4': 1, '5': 11, '6': '.common.FirePhoto', '10': 'photo'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'reference'},
  ],
};

const ReviewInfoCache$json = const {
  '1': 'ReviewInfoCache',
  '2': const [
    const {'1': 'reference', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'reference'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'photo', '3': 3, '4': 1, '5': 9, '10': 'photo'},
    const {'1': 'user_photo', '3': 4, '4': 1, '5': 9, '10': 'userPhoto'},
    const {'1': 'score', '3': 5, '4': 1, '5': 5, '10': 'score'},
    const {'1': 'more_photos', '3': 6, '4': 3, '5': 9, '10': 'morePhotos'},
  ],
};

const AlgoliaJSON$json = const {
  '1': 'AlgoliaJSON',
  '2': const [
    const {'1': '_geoloc', '3': 1, '4': 1, '5': 11, '6': '.algolia.GeoLoc', '10': 'Geoloc'},
    const {'1': '_tags', '3': 2, '4': 3, '5': 9, '10': 'Tags'},
    const {'1': 'objectID', '3': 3, '4': 1, '5': 9, '10': 'objectID'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'record_type', '3': 5, '4': 1, '5': 9, '10': 'recordType'},
  ],
};

const ReviewMarker$json = const {
  '1': 'ReviewMarker',
  '2': const [
    const {'1': 'dish', '3': 1, '4': 1, '5': 9, '10': 'dish'},
    const {'1': 'restaurant_name', '3': 2, '4': 1, '5': 9, '10': 'restaurantName'},
    const {'1': 'user', '3': 3, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'photo', '3': 4, '4': 1, '5': 9, '10': 'photo'},
    const {'1': 'user_photo', '3': 5, '4': 1, '5': 9, '10': 'userPhoto'},
    const {'1': 'text', '3': 6, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'reaction', '3': 7, '4': 1, '5': 14, '6': '.review.Reaction', '10': 'reaction'},
    const {'1': 'emojis', '3': 8, '4': 3, '5': 9, '10': 'emojis'},
    const {'1': '_geoloc', '3': 9, '4': 1, '5': 11, '6': '.algolia.GeoLoc', '10': 'Geoloc'},
    const {'1': 'objectID', '3': 10, '4': 1, '5': 9, '10': 'objectID'},
    const {'1': '_tags', '3': 11, '4': 3, '5': 9, '10': 'Tags'},
    const {'1': 'score', '3': 12, '4': 1, '5': 5, '10': 'score'},
    const {'1': 'username', '3': 13, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'user_display_name', '3': 14, '4': 1, '5': 9, '10': 'userDisplayName'},
    const {'1': 'restaurant_ref', '3': 15, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'restaurantRef'},
    const {'1': 'restaurant_counts', '3': 16, '4': 1, '5': 11, '6': '.algolia.ReviewMarker.RestaurantCounts', '10': 'restaurantCounts'},
    const {'1': 'fb_place_id', '3': 17, '4': 1, '5': 9, '10': 'fbPlaceId'},
    const {'1': 'more_photos', '3': 18, '4': 3, '5': 9, '10': 'morePhotos'},
  ],
  '3': const [ReviewMarker_RestaurantCounts$json],
};

const ReviewMarker_RestaurantCounts$json = const {
  '1': 'RestaurantCounts',
  '2': const [
    const {'1': 'down', '3': 1, '4': 1, '5': 5, '10': 'down'},
    const {'1': 'love', '3': 2, '4': 1, '5': 5, '10': 'love'},
    const {'1': 'favorite', '3': 3, '4': 1, '5': 5, '10': 'favorite'},
    const {'1': 'up', '3': 4, '4': 1, '5': 5, '10': 'up'},
  ],
};

const DiscoverReviewRecord$json = const {
  '1': 'DiscoverReviewRecord',
  '2': const [
    const {'1': 'display_text', '3': 1, '4': 1, '5': 9, '10': 'displayText'},
    const {'1': 'review', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'review'},
    const {'1': 'user', '3': 3, '4': 1, '5': 9, '10': 'user'},
    const {'1': 'user_photo', '3': 4, '4': 1, '5': 9, '10': 'userPhoto'},
    const {'1': 'dish', '3': 5, '4': 1, '5': 9, '10': 'dish'},
    const {'1': 'restaurant_name', '3': 6, '4': 1, '5': 9, '10': 'restaurantName'},
    const {'1': 'photo', '3': 7, '4': 1, '5': 9, '10': 'photo'},
    const {'1': 'search_text', '3': 8, '4': 1, '5': 9, '10': 'searchText'},
    const {'1': 'more_photos', '3': 9, '4': 3, '5': 9, '10': 'morePhotos'},
    const {'1': 'score', '3': 10, '4': 1, '5': 5, '10': 'score'},
  ],
};

const AlgoliaUserRecord$json = const {
  '1': 'AlgoliaUserRecord',
  '2': const [
    const {'1': '_geoloc', '3': 1, '4': 1, '5': 11, '6': '.algolia.GeoLoc', '10': 'Geoloc'},
    const {'1': '_tags', '3': 2, '4': 3, '5': 9, '10': 'Tags'},
    const {'1': 'objectID', '3': 3, '4': 1, '5': 9, '10': 'objectID'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'record_type', '3': 5, '4': 1, '5': 9, '10': 'recordType'},
    const {'1': 'name', '3': 6, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'username', '3': 7, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'profile_pic_url', '3': 8, '4': 1, '5': 9, '10': 'profilePicUrl'},
  ],
};

