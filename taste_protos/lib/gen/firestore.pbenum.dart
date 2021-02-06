///
//  Generated code. Do not modify.
//  source: firestore.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CollectionType extends $pb.ProtobufEnum {
  static const CollectionType COLLECTION_TYPE_UNDEFINED = CollectionType._(0, 'COLLECTION_TYPE_UNDEFINED');
  static const CollectionType algolia_records = CollectionType._(1, 'algolia_records');
  static const CollectionType bookmarks = CollectionType._(2, 'bookmarks');
  static const CollectionType bug_reports = CollectionType._(4, 'bug_reports');
  static const CollectionType comments = CollectionType._(5, 'comments');
  static const CollectionType favorites = CollectionType._(9, 'favorites');
  static const CollectionType followers = CollectionType._(10, 'followers');
  static const CollectionType home_meals = CollectionType._(11, 'home_meals');
  static const CollectionType likes = CollectionType._(12, 'likes');
  static const CollectionType mail = CollectionType._(13, 'mail');
  static const CollectionType notifications = CollectionType._(14, 'notifications');
  static const CollectionType operations = CollectionType._(15, 'operations');
  static const CollectionType photos = CollectionType._(16, 'photos');
  static const CollectionType private_documents = CollectionType._(17, 'private_documents');
  static const CollectionType reports = CollectionType._(21, 'reports');
  static const CollectionType restaurants = CollectionType._(22, 'restaurants');
  static const CollectionType reviews = CollectionType._(23, 'reviews');
  static const CollectionType users = CollectionType._(26, 'users');
  static const CollectionType view = CollectionType._(27, 'view');
  static const CollectionType views = CollectionType._(28, 'views');
  static const CollectionType instagram_username_requests = CollectionType._(29, 'instagram_username_requests');
  static const CollectionType badges = CollectionType._(30, 'badges');
  static const CollectionType index = CollectionType._(31, 'index');
  static const CollectionType discover_items = CollectionType._(32, 'discover_items');
  static const CollectionType contests = CollectionType._(33, 'contests');
  static const CollectionType insta_posts = CollectionType._(34, 'insta_posts');
  static const CollectionType daily_tasty_votes = CollectionType._(35, 'daily_tasty_votes');
  static const CollectionType cities = CollectionType._(36, 'cities');
  static const CollectionType conversations = CollectionType._(37, 'conversations');
  static const CollectionType tags = CollectionType._(38, 'tags');
  static const CollectionType movies = CollectionType._(39, 'movies');
  static const CollectionType inference_results = CollectionType._(40, 'inference_results');
  static const CollectionType instagram_tokens = CollectionType._(41, 'instagram_tokens');
  static const CollectionType instagram_locations = CollectionType._(42, 'instagram_locations');
  static const CollectionType bad_crops = CollectionType._(43, 'bad_crops');
  static const CollectionType taste_bud_groups = CollectionType._(44, 'taste_bud_groups');
  static const CollectionType recipe_requests = CollectionType._(45, 'recipe_requests');
  static const CollectionType mailchimp_user_settings = CollectionType._(46, 'mailchimp_user_settings');
  static const CollectionType instagram_scrape_requests = CollectionType._(47, 'instagram_scrape_requests');
  static const CollectionType user_posts_starting_locations = CollectionType._(48, 'user_posts_starting_locations');
  static const CollectionType instagram_posts = CollectionType._(49, 'instagram_posts');
  static const CollectionType instagram_network_scrape_requests = CollectionType._(50, 'instagram_network_scrape_requests');
  static const CollectionType google_places = CollectionType._(51, 'google_places');
  static const CollectionType google_reviews = CollectionType._(52, 'google_reviews');
  static const CollectionType yelp_places = CollectionType._(53, 'yelp_places');
  static const CollectionType yelp_reviews = CollectionType._(54, 'yelp_reviews');
  static const CollectionType food_finder_actions = CollectionType._(55, 'food_finder_actions');

  static const $core.List<CollectionType> values = <CollectionType> [
    COLLECTION_TYPE_UNDEFINED,
    algolia_records,
    bookmarks,
    bug_reports,
    comments,
    favorites,
    followers,
    home_meals,
    likes,
    mail,
    notifications,
    operations,
    photos,
    private_documents,
    reports,
    restaurants,
    reviews,
    users,
    view,
    views,
    instagram_username_requests,
    badges,
    index,
    discover_items,
    contests,
    insta_posts,
    daily_tasty_votes,
    cities,
    conversations,
    tags,
    movies,
    inference_results,
    instagram_tokens,
    instagram_locations,
    bad_crops,
    taste_bud_groups,
    recipe_requests,
    mailchimp_user_settings,
    instagram_scrape_requests,
    user_posts_starting_locations,
    instagram_posts,
    instagram_network_scrape_requests,
    google_places,
    google_reviews,
    yelp_places,
    yelp_reviews,
    food_finder_actions,
  ];

  static final $core.Map<$core.int, CollectionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CollectionType valueOf($core.int value) => _byValue[value];

  const CollectionType._($core.int v, $core.String n) : super(v, n);
}

class NotificationType extends $pb.ProtobufEnum {
  static const NotificationType UNDEFINED = NotificationType._(0, 'UNDEFINED');
  static const NotificationType like = NotificationType._(1, 'like');
  static const NotificationType comment = NotificationType._(2, 'comment');
  static const NotificationType follow = NotificationType._(3, 'follow');
  static const NotificationType message = NotificationType._(5, 'message');
  static const NotificationType bookmark = NotificationType._(7, 'bookmark');
  static const NotificationType meal_mate = NotificationType._(8, 'meal_mate');
  static const NotificationType conversation = NotificationType._(9, 'conversation');
  static const NotificationType daily_digest = NotificationType._(10, 'daily_digest');
  static const NotificationType flagged_review_update = NotificationType._(11, 'flagged_review_update');
  static const NotificationType won_daily_tasty = NotificationType._(12, 'won_daily_tasty');
  static const NotificationType recipe_request = NotificationType._(13, 'recipe_request');
  static const NotificationType recipe_added = NotificationType._(14, 'recipe_added');

  static const $core.List<NotificationType> values = <NotificationType> [
    UNDEFINED,
    like,
    comment,
    follow,
    message,
    bookmark,
    meal_mate,
    conversation,
    daily_digest,
    flagged_review_update,
    won_daily_tasty,
    recipe_request,
    recipe_added,
  ];

  static final $core.Map<$core.int, NotificationType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NotificationType valueOf($core.int value) => _byValue[value];

  const NotificationType._($core.int v, $core.String n) : super(v, n);
}

class BlackCharity extends $pb.ProtobufEnum {
  static const BlackCharity CHARITY_UNDEFINED = BlackCharity._(0, 'CHARITY_UNDEFINED');
  static const BlackCharity eji = BlackCharity._(1, 'eji');
  static const BlackCharity splc = BlackCharity._(2, 'splc');
  static const BlackCharity aclu = BlackCharity._(3, 'aclu');

  static const $core.List<BlackCharity> values = <BlackCharity> [
    CHARITY_UNDEFINED,
    eji,
    splc,
    aclu,
  ];

  static final $core.Map<$core.int, BlackCharity> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BlackCharity valueOf($core.int value) => _byValue[value];

  const BlackCharity._($core.int v, $core.String n) : super(v, n);
}

class BugReportType extends $pb.ProtobufEnum {
  static const BugReportType bug_report = BugReportType._(0, 'bug_report');
  static const BugReportType feedback = BugReportType._(1, 'feedback');

  static const $core.List<BugReportType> values = <BugReportType> [
    bug_report,
    feedback,
  ];

  static final $core.Map<$core.int, BugReportType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BugReportType valueOf($core.int value) => _byValue[value];

  const BugReportType._($core.int v, $core.String n) : super(v, n);
}

class Notification_FCMSettings extends $pb.ProtobufEnum {
  static const Notification_FCMSettings fcm_settings_undefined = Notification_FCMSettings._(0, 'fcm_settings_undefined');
  static const Notification_FCMSettings fcm_settings_on_create_only = Notification_FCMSettings._(1, 'fcm_settings_on_create_only');
  static const Notification_FCMSettings fcm_settings_on_all_events = Notification_FCMSettings._(2, 'fcm_settings_on_all_events');

  static const $core.List<Notification_FCMSettings> values = <Notification_FCMSettings> [
    fcm_settings_undefined,
    fcm_settings_on_create_only,
    fcm_settings_on_all_events,
  ];

  static final $core.Map<$core.int, Notification_FCMSettings> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Notification_FCMSettings valueOf($core.int value) => _byValue[value];

  const Notification_FCMSettings._($core.int v, $core.String n) : super(v, n);
}

class InstagramSettings_AutoImportSetting extends $pb.ProtobufEnum {
  static const InstagramSettings_AutoImportSetting AUTO_IMPORT_SETTING_UNDEFINED = InstagramSettings_AutoImportSetting._(0, 'AUTO_IMPORT_SETTING_UNDEFINED');
  static const InstagramSettings_AutoImportSetting never = InstagramSettings_AutoImportSetting._(1, 'never');
  static const InstagramSettings_AutoImportSetting daily = InstagramSettings_AutoImportSetting._(2, 'daily');

  static const $core.List<InstagramSettings_AutoImportSetting> values = <InstagramSettings_AutoImportSetting> [
    AUTO_IMPORT_SETTING_UNDEFINED,
    never,
    daily,
  ];

  static final $core.Map<$core.int, InstagramSettings_AutoImportSetting> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InstagramSettings_AutoImportSetting valueOf($core.int value) => _byValue[value];

  const InstagramSettings_AutoImportSetting._($core.int v, $core.String n) : super(v, n);
}

class FoodFinderAction_ActionType extends $pb.ProtobufEnum {
  static const FoodFinderAction_ActionType ACTION_TYPE_UNDEFINED = FoodFinderAction_ActionType._(0, 'ACTION_TYPE_UNDEFINED');
  static const FoodFinderAction_ActionType add_to_list = FoodFinderAction_ActionType._(1, 'add_to_list');
  static const FoodFinderAction_ActionType pass = FoodFinderAction_ActionType._(2, 'pass');
  static const FoodFinderAction_ActionType never_show_again = FoodFinderAction_ActionType._(3, 'never_show_again');
  static const FoodFinderAction_ActionType open_resto_page = FoodFinderAction_ActionType._(4, 'open_resto_page');
  static const FoodFinderAction_ActionType remove_from_list = FoodFinderAction_ActionType._(5, 'remove_from_list');

  static const $core.List<FoodFinderAction_ActionType> values = <FoodFinderAction_ActionType> [
    ACTION_TYPE_UNDEFINED,
    add_to_list,
    pass,
    never_show_again,
    open_resto_page,
    remove_from_list,
  ];

  static final $core.Map<$core.int, FoodFinderAction_ActionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FoodFinderAction_ActionType valueOf($core.int value) => _byValue[value];

  const FoodFinderAction_ActionType._($core.int v, $core.String n) : super(v, n);
}

class Review_MealType extends $pb.ProtobufEnum {
  static const Review_MealType MEAL_TYPE_UNDEFINED = Review_MealType._(0, 'MEAL_TYPE_UNDEFINED');
  static const Review_MealType meal_type_restaurant = Review_MealType._(1, 'meal_type_restaurant');
  static const Review_MealType meal_type_home = Review_MealType._(2, 'meal_type_home');

  static const $core.List<Review_MealType> values = <Review_MealType> [
    MEAL_TYPE_UNDEFINED,
    meal_type_restaurant,
    meal_type_home,
  ];

  static final $core.Map<$core.int, Review_MealType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Review_MealType valueOf($core.int value) => _byValue[value];

  const Review_MealType._($core.int v, $core.String n) : super(v, n);
}

class Review_DeliveryApp extends $pb.ProtobufEnum {
  static const Review_DeliveryApp UNDEFINED = Review_DeliveryApp._(0, 'UNDEFINED');
  static const Review_DeliveryApp postmates = Review_DeliveryApp._(1, 'postmates');
  static const Review_DeliveryApp grub_hub = Review_DeliveryApp._(2, 'grub_hub');
  static const Review_DeliveryApp uber_eats = Review_DeliveryApp._(3, 'uber_eats');
  static const Review_DeliveryApp seamless = Review_DeliveryApp._(4, 'seamless');
  static const Review_DeliveryApp door_dash = Review_DeliveryApp._(5, 'door_dash');
  static const Review_DeliveryApp eat_24 = Review_DeliveryApp._(6, 'eat_24');

  static const $core.List<Review_DeliveryApp> values = <Review_DeliveryApp> [
    UNDEFINED,
    postmates,
    grub_hub,
    uber_eats,
    seamless,
    door_dash,
    eat_24,
  ];

  static final $core.Map<$core.int, Review_DeliveryApp> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Review_DeliveryApp valueOf($core.int value) => _byValue[value];

  const Review_DeliveryApp._($core.int v, $core.String n) : super(v, n);
}

class Review_BlackOwnedStatus extends $pb.ProtobufEnum {
  static const Review_BlackOwnedStatus BLACK_OWNED_UNDEFINED = Review_BlackOwnedStatus._(0, 'BLACK_OWNED_UNDEFINED');
  static const Review_BlackOwnedStatus restaurant_black_owned = Review_BlackOwnedStatus._(1, 'restaurant_black_owned');
  static const Review_BlackOwnedStatus restaurant_not_black_owned = Review_BlackOwnedStatus._(2, 'restaurant_not_black_owned');
  static const Review_BlackOwnedStatus user_selected_black_owned = Review_BlackOwnedStatus._(3, 'user_selected_black_owned');

  static const $core.List<Review_BlackOwnedStatus> values = <Review_BlackOwnedStatus> [
    BLACK_OWNED_UNDEFINED,
    restaurant_black_owned,
    restaurant_not_black_owned,
    user_selected_black_owned,
  ];

  static final $core.Map<$core.int, Review_BlackOwnedStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Review_BlackOwnedStatus valueOf($core.int value) => _byValue[value];

  const Review_BlackOwnedStatus._($core.int v, $core.String n) : super(v, n);
}

class Restaurant_Attributes_Address_Source extends $pb.ProtobufEnum {
  static const Restaurant_Attributes_Address_Source SOURCE_UNDEFINED = Restaurant_Attributes_Address_Source._(0, 'SOURCE_UNDEFINED');
  static const Restaurant_Attributes_Address_Source facebook = Restaurant_Attributes_Address_Source._(1, 'facebook');
  static const Restaurant_Attributes_Address_Source google_geocoder = Restaurant_Attributes_Address_Source._(2, 'google_geocoder');

  static const $core.List<Restaurant_Attributes_Address_Source> values = <Restaurant_Attributes_Address_Source> [
    SOURCE_UNDEFINED,
    facebook,
    google_geocoder,
  ];

  static final $core.Map<$core.int, Restaurant_Attributes_Address_Source> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Restaurant_Attributes_Address_Source valueOf($core.int value) => _byValue[value];

  const Restaurant_Attributes_Address_Source._($core.int v, $core.String n) : super(v, n);
}

class InstagramPost_PostType extends $pb.ProtobufEnum {
  static const InstagramPost_PostType POST_TYPE_UNDEFINED = InstagramPost_PostType._(0, 'POST_TYPE_UNDEFINED');
  static const InstagramPost_PostType instagram = InstagramPost_PostType._(1, 'instagram');
  static const InstagramPost_PostType taste = InstagramPost_PostType._(2, 'taste');

  static const $core.List<InstagramPost_PostType> values = <InstagramPost_PostType> [
    POST_TYPE_UNDEFINED,
    instagram,
    taste,
  ];

  static final $core.Map<$core.int, InstagramPost_PostType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InstagramPost_PostType valueOf($core.int value) => _byValue[value];

  const InstagramPost_PostType._($core.int v, $core.String n) : super(v, n);
}

class InstagramPost_PhotoClassification extends $pb.ProtobufEnum {
  static const InstagramPost_PhotoClassification PHOTO_CLASSIFICATION_UNDEFINED = InstagramPost_PhotoClassification._(0, 'PHOTO_CLASSIFICATION_UNDEFINED');
  static const InstagramPost_PhotoClassification food = InstagramPost_PhotoClassification._(1, 'food');

  static const $core.List<InstagramPost_PhotoClassification> values = <InstagramPost_PhotoClassification> [
    PHOTO_CLASSIFICATION_UNDEFINED,
    food,
  ];

  static final $core.Map<$core.int, InstagramPost_PhotoClassification> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InstagramPost_PhotoClassification valueOf($core.int value) => _byValue[value];

  const InstagramPost_PhotoClassification._($core.int v, $core.String n) : super(v, n);
}

class InstagramPost_InstagramPostSource extends $pb.ProtobufEnum {
  static const InstagramPost_InstagramPostSource InstagramPostSource_UNDEFINED = InstagramPost_InstagramPostSource._(0, 'InstagramPostSource_UNDEFINED');
  static const InstagramPost_InstagramPostSource queue_processor = InstagramPost_InstagramPostSource._(1, 'queue_processor');
  static const InstagramPost_InstagramPostSource cloud_function_trigger = InstagramPost_InstagramPostSource._(2, 'cloud_function_trigger');

  static const $core.List<InstagramPost_InstagramPostSource> values = <InstagramPost_InstagramPostSource> [
    InstagramPostSource_UNDEFINED,
    queue_processor,
    cloud_function_trigger,
  ];

  static final $core.Map<$core.int, InstagramPost_InstagramPostSource> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InstagramPost_InstagramPostSource valueOf($core.int value) => _byValue[value];

  const InstagramPost_InstagramPostSource._($core.int v, $core.String n) : super(v, n);
}

class Badge_BadgeType extends $pb.ProtobufEnum {
  static const Badge_BadgeType BADGE_TYPE_UNDEFINED = Badge_BadgeType._(0, 'BADGE_TYPE_UNDEFINED');
  static const Badge_BadgeType streak_longest = Badge_BadgeType._(1, 'streak_longest');
  static const Badge_BadgeType streak_active = Badge_BadgeType._(2, 'streak_active');
  static const Badge_BadgeType post_cities_total = Badge_BadgeType._(3, 'post_cities_total');
  static const Badge_BadgeType post_countries_total = Badge_BadgeType._(4, 'post_countries_total');
  static const Badge_BadgeType favorites_cities_total = Badge_BadgeType._(5, 'favorites_cities_total');
  static const Badge_BadgeType favorites_countries_total = Badge_BadgeType._(6, 'favorites_countries_total');
  static const Badge_BadgeType commenter_level_1 = Badge_BadgeType._(7, 'commenter_level_1');
  static const Badge_BadgeType emoji_flags_level_1 = Badge_BadgeType._(8, 'emoji_flags_level_1');
  static const Badge_BadgeType brainiac = Badge_BadgeType._(9, 'brainiac');
  static const Badge_BadgeType burgermeister = Badge_BadgeType._(10, 'burgermeister');
  static const Badge_BadgeType sushinista = Badge_BadgeType._(11, 'sushinista');
  static const Badge_BadgeType regular = Badge_BadgeType._(12, 'regular');
  static const Badge_BadgeType herbivore = Badge_BadgeType._(13, 'herbivore');
  static const Badge_BadgeType socialite = Badge_BadgeType._(14, 'socialite');
  static const Badge_BadgeType ramsay = Badge_BadgeType._(15, 'ramsay');
  static const Badge_BadgeType character = Badge_BadgeType._(16, 'character');
  static const Badge_BadgeType city_champion = Badge_BadgeType._(17, 'city_champion');
  static const Badge_BadgeType quarantine = Badge_BadgeType._(18, 'quarantine');
  static const Badge_BadgeType daily_tasty = Badge_BadgeType._(19, 'daily_tasty');
  static const Badge_BadgeType black_owned_restaurant_post = Badge_BadgeType._(20, 'black_owned_restaurant_post');

  static const $core.List<Badge_BadgeType> values = <Badge_BadgeType> [
    BADGE_TYPE_UNDEFINED,
    streak_longest,
    streak_active,
    post_cities_total,
    post_countries_total,
    favorites_cities_total,
    favorites_countries_total,
    commenter_level_1,
    emoji_flags_level_1,
    brainiac,
    burgermeister,
    sushinista,
    regular,
    herbivore,
    socialite,
    ramsay,
    character,
    city_champion,
    quarantine,
    daily_tasty,
    black_owned_restaurant_post,
  ];

  static final $core.Map<$core.int, Badge_BadgeType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Badge_BadgeType valueOf($core.int value) => _byValue[value];

  const Badge_BadgeType._($core.int v, $core.String n) : super(v, n);
}

class Contest_ContestType extends $pb.ProtobufEnum {
  static const Contest_ContestType contest_type_undefined = Contest_ContestType._(0, 'contest_type_undefined');
  static const Contest_ContestType contest_type_home_cooking = Contest_ContestType._(1, 'contest_type_home_cooking');
  static const Contest_ContestType contest_type_local_restaurants = Contest_ContestType._(2, 'contest_type_local_restaurants');

  static const $core.List<Contest_ContestType> values = <Contest_ContestType> [
    contest_type_undefined,
    contest_type_home_cooking,
    contest_type_local_restaurants,
  ];

  static final $core.Map<$core.int, Contest_ContestType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Contest_ContestType valueOf($core.int value) => _byValue[value];

  const Contest_ContestType._($core.int v, $core.String n) : super(v, n);
}

class InstagramToken_ImportStatus extends $pb.ProtobufEnum {
  static const InstagramToken_ImportStatus import_status_undefined = InstagramToken_ImportStatus._(0, 'import_status_undefined');
  static const InstagramToken_ImportStatus start = InstagramToken_ImportStatus._(1, 'start');
  static const InstagramToken_ImportStatus running = InstagramToken_ImportStatus._(2, 'running');
  static const InstagramToken_ImportStatus complete = InstagramToken_ImportStatus._(3, 'complete');
  static const InstagramToken_ImportStatus added_locations = InstagramToken_ImportStatus._(4, 'added_locations');

  static const $core.List<InstagramToken_ImportStatus> values = <InstagramToken_ImportStatus> [
    import_status_undefined,
    start,
    running,
    complete,
    added_locations,
  ];

  static final $core.Map<$core.int, InstagramToken_ImportStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InstagramToken_ImportStatus valueOf($core.int value) => _byValue[value];

  const InstagramToken_ImportStatus._($core.int v, $core.String n) : super(v, n);
}

class InstagramToken_TokenStatus extends $pb.ProtobufEnum {
  static const InstagramToken_TokenStatus token_status_undefined = InstagramToken_TokenStatus._(0, 'token_status_undefined');
  static const InstagramToken_TokenStatus token_failed = InstagramToken_TokenStatus._(1, 'token_failed');
  static const InstagramToken_TokenStatus short_term_token = InstagramToken_TokenStatus._(2, 'short_term_token');
  static const InstagramToken_TokenStatus long_term_token = InstagramToken_TokenStatus._(3, 'long_term_token');

  static const $core.List<InstagramToken_TokenStatus> values = <InstagramToken_TokenStatus> [
    token_status_undefined,
    token_failed,
    short_term_token,
    long_term_token,
  ];

  static final $core.Map<$core.int, InstagramToken_TokenStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InstagramToken_TokenStatus valueOf($core.int value) => _byValue[value];

  const InstagramToken_TokenStatus._($core.int v, $core.String n) : super(v, n);
}

