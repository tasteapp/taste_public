///
//  Generated code. Do not modify.
//  source: instagram.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const ImageInfo$json = const {
  '1': 'ImageInfo',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 5, '10': 'height'},
    const {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
  ],
};

const ImageLabel$json = const {
  '1': 'ImageLabel',
  '2': const [
    const {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'confidence', '3': 2, '4': 1, '5': 1, '10': 'confidence'},
  ],
};

const ImageAnnotations$json = const {
  '1': 'ImageAnnotations',
  '2': const [
    const {'1': 'is_food', '3': 1, '4': 1, '5': 1, '10': 'isFood'},
    const {'1': 'is_drink', '3': 2, '4': 1, '5': 1, '10': 'isDrink'},
    const {'1': 'person_detections', '3': 3, '4': 3, '5': 11, '6': '.instagram.ImageAnnotations.PersonDetection', '10': 'personDetections'},
  ],
  '3': const [ImageAnnotations_PersonDetection$json],
};

const ImageAnnotations_PersonDetection$json = const {
  '1': 'PersonDetection',
  '2': const [
    const {'1': 'confidence', '3': 1, '4': 1, '5': 1, '10': 'confidence'},
    const {'1': 'bbox_area', '3': 2, '4': 1, '5': 1, '10': 'bboxArea'},
  ],
};

const InstagramImage$json = const {
  '1': 'InstagramImage',
  '2': const [
    const {'1': 'thumbnail', '3': 1, '4': 1, '5': 11, '6': '.instagram.ImageInfo', '10': 'thumbnail'},
    const {'1': 'low_res', '3': 2, '4': 1, '5': 11, '6': '.instagram.ImageInfo', '10': 'lowRes'},
    const {'1': 'standard_res', '3': 3, '4': 1, '5': 11, '6': '.instagram.ImageInfo', '10': 'standardRes'},
    const {'1': 'is_food_or_drink', '3': 4, '4': 1, '5': 8, '10': 'isFoodOrDrink'},
    const {'1': 'ml_labels', '3': 5, '4': 3, '5': 11, '6': '.instagram.ImageLabel', '10': 'mlLabels'},
    const {'1': 'photo', '3': 6, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'photo'},
    const {'1': 'image_annotations', '3': 7, '4': 1, '5': 11, '6': '.instagram.ImageAnnotations', '10': 'imageAnnotations'},
    const {'1': 'has_person', '3': 8, '4': 1, '5': 8, '10': 'hasPerson'},
  ],
};

const InstagramLocation$json = const {
  '1': 'InstagramLocation',
  '2': const [
    const {'1': 'location', '3': 1, '4': 1, '5': 11, '6': '.common.LatLng', '10': 'location'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'id', '3': 3, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'address', '3': 4, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'post_codes', '3': 5, '4': 3, '5': 9, '10': 'postCodes'},
    const {'1': 'fb_location', '3': 6, '4': 1, '5': 11, '6': '.instagram.FacebookLocation', '10': 'fbLocation'},
    const {'1': 'queried_location', '3': 7, '4': 1, '5': 8, '10': 'queriedLocation'},
    const {'1': 'num_requests', '3': 8, '4': 1, '5': 5, '10': 'numRequests'},
    const {'1': 'found_match', '3': 9, '4': 1, '5': 8, '10': 'foundMatch'},
  ],
};

const FacebookLocation$json = const {
  '1': 'FacebookLocation',
  '2': const [
    const {'1': 'fb_place_id', '3': 1, '4': 1, '5': 9, '10': 'fbPlaceId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'location', '3': 3, '4': 1, '5': 11, '6': '.common.LatLng', '10': 'location'},
    const {'1': 'address', '3': 4, '4': 1, '5': 11, '6': '.firestore.Restaurant.Attributes.Address', '10': 'address'},
    const {'1': 'categories', '3': 5, '4': 3, '5': 9, '10': 'categories'},
    const {'1': 'phone', '3': 6, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'website', '3': 7, '4': 1, '5': 9, '10': 'website'},
    const {'1': 'hours', '3': 8, '4': 1, '5': 11, '6': '.firestore.Restaurant.Hours', '10': 'hours'},
  ],
};

const InstaPost$json = const {
  '1': 'InstaPost',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'post_id', '3': 2, '4': 1, '5': 9, '10': 'postId'},
    const {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'images', '3': 4, '4': 3, '5': 11, '6': '.instagram.InstagramImage', '10': 'images'},
    const {'1': 'caption', '3': 5, '4': 1, '5': 9, '10': 'caption'},
    const {'1': 'dish', '3': 17, '4': 1, '5': 9, '10': 'dish'},
    const {'1': 'instagram_location', '3': 6, '4': 1, '5': 11, '6': '.instagram.InstagramLocation', '10': 'instagramLocation'},
    const {'1': 'fb_location', '3': 7, '4': 1, '5': 11, '6': '.instagram.FacebookLocation', '10': 'fbLocation'},
    const {'1': 'is_homecooked', '3': 8, '4': 1, '5': 8, '10': 'isHomecooked'},
    const {'1': 'created_time', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdTime'},
    const {'1': 'user_id', '3': 10, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'likes', '3': 11, '4': 1, '5': 5, '10': 'likes'},
    const {'1': 'tags', '3': 12, '4': 3, '5': 9, '10': 'tags'},
    const {'1': 'is_manual', '3': 13, '4': 1, '5': 8, '10': 'isManual'},
    const {'1': 'link', '3': 14, '4': 1, '5': 9, '10': 'link'},
    const {'1': 'reaction', '3': 15, '4': 1, '5': 14, '6': '.review.Reaction', '10': 'reaction'},
    const {'1': 'has_review', '3': 16, '4': 1, '5': 8, '10': 'hasReview'},
    const {'1': 'tried_extra_info', '3': 18, '4': 1, '5': 8, '10': 'triedExtraInfo'},
    const {'1': 'num_update_attempts', '3': 19, '4': 1, '5': 5, '10': 'numUpdateAttempts'},
    const {'1': 'num_followers', '3': 20, '4': 1, '5': 5, '10': 'numFollowers'},
    const {'1': 'hidden', '3': 21, '4': 1, '5': 8, '10': 'hidden'},
    const {'1': 'do_not_update', '3': 22, '4': 1, '5': 8, '10': 'doNotUpdate'},
    const {'1': '_extras', '3': 23, '4': 1, '5': 11, '6': '.common.Extras', '10': 'Extras'},
    const {'1': 'photos_labeled', '3': 24, '4': 1, '5': 8, '10': 'photosLabeled'},
    const {'1': 'image_annotations', '3': 25, '4': 3, '5': 11, '6': '.instagram.ImageAnnotations', '10': 'imageAnnotations'},
  ],
};

const InstagramScrapeRequest$json = const {
  '1': 'InstagramScrapeRequest',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.common.DocumentReferenceProto', '10': 'user'},
    const {'1': 'index', '3': 3, '4': 1, '5': 5, '10': 'index'},
    const {'1': 'priority', '3': 4, '4': 1, '5': 5, '10': 'priority'},
    const {'1': 'ignore_most_recent', '3': 5, '4': 1, '5': 8, '10': 'ignoreMostRecent'},
    const {'1': 'failed', '3': 6, '4': 1, '5': 8, '10': 'failed'},
    const {'1': 'failure_stack', '3': 7, '4': 1, '5': 9, '10': 'failureStack'},
  ],
};

const InstagramNetworkScrapeRequest$json = const {
  '1': 'InstagramNetworkScrapeRequest',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'index', '3': 2, '4': 1, '5': 5, '10': 'index'},
    const {'1': 'priority', '3': 3, '4': 1, '5': 5, '10': 'priority'},
    const {'1': 'num_followers', '3': 4, '4': 1, '5': 5, '10': 'numFollowers'},
    const {'1': 'num_posts', '3': 5, '4': 1, '5': 5, '10': 'numPosts'},
    const {'1': 'failed', '3': 6, '4': 1, '5': 8, '10': 'failed'},
  ],
};

const RejectedInstagramUsers$json = const {
  '1': 'RejectedInstagramUsers',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'full_name', '3': 2, '4': 1, '5': 9, '10': 'fullName'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 14, '6': '.instagram.RejectedInstagramUsers.RejectionReason', '10': 'reason'},
    const {'1': 'num_followers', '3': 4, '4': 1, '5': 5, '10': 'numFollowers'},
    const {'1': 'num_posts', '3': 5, '4': 1, '5': 5, '10': 'numPosts'},
  ],
  '4': const [RejectedInstagramUsers_RejectionReason$json],
};

const RejectedInstagramUsers_RejectionReason$json = const {
  '1': 'RejectionReason',
  '2': const [
    const {'1': 'rejection_reason_undefined', '2': 0},
    const {'1': 'no_email', '2': 1},
    const {'1': 'posts_not_food', '2': 2},
    const {'1': 'posts_not_tagged', '2': 3},
    const {'1': 'posts_not_usa', '2': 4},
    const {'1': 'too_many_followers', '2': 5},
    const {'1': 'too_few_posts', '2': 6},
    const {'1': 'is_food_call_failed', '2': 7},
    const {'1': 'likely_restaurant', '2': 8},
  ],
};

