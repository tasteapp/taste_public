///
//  Generated code. Do not modify.
//  source: analytics.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class TATab extends $pb.ProtobufEnum {
  static const TATab discover_tab = TATab._(0, 'discover_tab');
  static const TATab food_finder_tab = TATab._(1, 'food_finder_tab');
  static const TATab create_tab = TATab._(2, 'create_tab');
  static const TATab map_tab = TATab._(3, 'map_tab');
  static const TATab profile_tab = TATab._(4, 'profile_tab');
  static const TATab profile_posts = TATab._(5, 'profile_posts');
  static const TATab profile_smart_sorted = TATab._(6, 'profile_smart_sorted');
  static const TATab profile_favorites = TATab._(7, 'profile_favorites');
  static const TATab profile_bookmarks = TATab._(8, 'profile_bookmarks');
  static const TATab profile_badges = TATab._(9, 'profile_badges');
  static const TATab dt_voting = TATab._(10, 'dt_voting');
  static const TATab dt_leaderboard = TATab._(11, 'dt_leaderboard');
  static const TATab dt_past_winnners = TATab._(12, 'dt_past_winnners');
  static const TATab search_places = TATab._(13, 'search_places');
  static const TATab search_dishes = TATab._(14, 'search_dishes');
  static const TATab search_trending = TATab._(15, 'search_trending');
  static const TATab search_people = TATab._(16, 'search_people');

  static const $core.List<TATab> values = <TATab> [
    discover_tab,
    food_finder_tab,
    create_tab,
    map_tab,
    profile_tab,
    profile_posts,
    profile_smart_sorted,
    profile_favorites,
    profile_bookmarks,
    profile_badges,
    dt_voting,
    dt_leaderboard,
    dt_past_winnners,
    search_places,
    search_dishes,
    search_trending,
    search_people,
  ];

  static final $core.Map<$core.int, TATab> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TATab valueOf($core.int value) => _byValue[value];

  const TATab._($core.int v, $core.String n) : super(v, n);
}

class TAPage extends $pb.ProtobufEnum {
  static const TAPage discover_root = TAPage._(0, 'discover_root');
  static const TAPage food_finder_root = TAPage._(1, 'food_finder_root');
  static const TAPage create_root = TAPage._(2, 'create_root');
  static const TAPage map_root = TAPage._(3, 'map_root');
  static const TAPage profile_root = TAPage._(4, 'profile_root');
  static const TAPage tag_search = TAPage._(5, 'tag_search');
  static const TAPage posts = TAPage._(6, 'posts');
  static const TAPage profile_photo = TAPage._(7, 'profile_photo');
  static const TAPage edit_account = TAPage._(8, 'edit_account');
  static const TAPage report_bug = TAPage._(9, 'report_bug');
  static const TAPage talk_with_us = TAPage._(10, 'talk_with_us');
  static const TAPage daily_tasty = TAPage._(11, 'daily_tasty');
  static const TAPage conversations = TAPage._(12, 'conversations');
  static const TAPage conversation = TAPage._(13, 'conversation');
  static const TAPage user_map = TAPage._(14, 'user_map');
  static const TAPage followers_list = TAPage._(15, 'followers_list');
  static const TAPage following_list = TAPage._(16, 'following_list');
  static const TAPage likes = TAPage._(17, 'likes');
  static const TAPage add_comment = TAPage._(18, 'add_comment');
  static const TAPage edit_comment_page = TAPage._(19, 'edit_comment_page');
  static const TAPage select_photos = TAPage._(20, 'select_photos');
  static const TAPage edit_photos = TAPage._(21, 'edit_photos');
  static const TAPage create_post_page = TAPage._(22, 'create_post_page');
  static const TAPage edit_post_page = TAPage._(23, 'edit_post_page');
  static const TAPage search_place = TAPage._(24, 'search_place');
  static const TAPage edit_favorites = TAPage._(25, 'edit_favorites');
  static const TAPage city_champions = TAPage._(26, 'city_champions');
  static const TAPage dt_faq = TAPage._(27, 'dt_faq');
  static const TAPage user_level_page = TAPage._(28, 'user_level_page');
  static const TAPage user_leaderboard_page = TAPage._(29, 'user_leaderboard_page');
  static const TAPage ask_phone_number = TAPage._(30, 'ask_phone_number');
  static const TAPage find_friends = TAPage._(31, 'find_friends');
  static const TAPage dt_expanded_photo_page = TAPage._(32, 'dt_expanded_photo_page');
  static const TAPage crop_image_page = TAPage._(33, 'crop_image_page');
  static const TAPage select_cuisine_page = TAPage._(34, 'select_cuisine_page');
  static const TAPage select_emojis_page = TAPage._(35, 'select_emojis_page');
  static const TAPage select_delivery_app = TAPage._(36, 'select_delivery_app');
  static const TAPage tag_meal_mates = TAPage._(37, 'tag_meal_mates');
  static const TAPage select_contest_page = TAPage._(38, 'select_contest_page');
  static const TAPage comments_page = TAPage._(39, 'comments_page');
  static const TAPage reply_comment_page = TAPage._(40, 'reply_comment_page');
  static const TAPage insta_web_login_page = TAPage._(41, 'insta_web_login_page');
  static const TAPage videos_page = TAPage._(42, 'videos_page');
  static const TAPage restaurant_page = TAPage._(43, 'restaurant_page');
  static const TAPage profile_page = TAPage._(44, 'profile_page');
  static const TAPage badge_page = TAPage._(45, 'badge_page');
  static const TAPage search_city_champions = TAPage._(46, 'search_city_champions');
  static const TAPage new_conversation_page = TAPage._(47, 'new_conversation_page');
  static const TAPage add_favorite = TAPage._(48, 'add_favorite');
  static const TAPage user_leaderboard_help_page = TAPage._(49, 'user_leaderboard_help_page');
  static const TAPage notifications = TAPage._(50, 'notifications');
  static const TAPage meal_mates_page = TAPage._(51, 'meal_mates_page');
  static const TAPage post_page = TAPage._(52, 'post_page');
  static const TAPage bookmarkers_page = TAPage._(53, 'bookmarkers_page');
  static const TAPage add_recipe_page = TAPage._(54, 'add_recipe_page');
  static const TAPage recipe_requesters_page = TAPage._(55, 'recipe_requesters_page');
  static const TAPage base_log_in_page = TAPage._(56, 'base_log_in_page');
  static const TAPage email_view = TAPage._(57, 'email_view');
  static const TAPage connect_account_page = TAPage._(58, 'connect_account_page');
  static const TAPage blm_landing_page = TAPage._(59, 'blm_landing_page');
  static const TAPage discover_onboarding_page = TAPage._(60, 'discover_onboarding_page');
  static const TAPage search_onboarding_page = TAPage._(61, 'search_onboarding_page');
  static const TAPage posting_onboarding_page = TAPage._(62, 'posting_onboarding_page');
  static const TAPage map_onboarding_page = TAPage._(63, 'map_onboarding_page');
  static const TAPage profile_onboarding_page = TAPage._(64, 'profile_onboarding_page');
  static const TAPage food_finder_filters = TAPage._(65, 'food_finder_filters');
  static const TAPage maybe_list_page = TAPage._(66, 'maybe_list_page');

  static const $core.List<TAPage> values = <TAPage> [
    discover_root,
    food_finder_root,
    create_root,
    map_root,
    profile_root,
    tag_search,
    posts,
    profile_photo,
    edit_account,
    report_bug,
    talk_with_us,
    daily_tasty,
    conversations,
    conversation,
    user_map,
    followers_list,
    following_list,
    likes,
    add_comment,
    edit_comment_page,
    select_photos,
    edit_photos,
    create_post_page,
    edit_post_page,
    search_place,
    edit_favorites,
    city_champions,
    dt_faq,
    user_level_page,
    user_leaderboard_page,
    ask_phone_number,
    find_friends,
    dt_expanded_photo_page,
    crop_image_page,
    select_cuisine_page,
    select_emojis_page,
    select_delivery_app,
    tag_meal_mates,
    select_contest_page,
    comments_page,
    reply_comment_page,
    insta_web_login_page,
    videos_page,
    restaurant_page,
    profile_page,
    badge_page,
    search_city_champions,
    new_conversation_page,
    add_favorite,
    user_leaderboard_help_page,
    notifications,
    meal_mates_page,
    post_page,
    bookmarkers_page,
    add_recipe_page,
    recipe_requesters_page,
    base_log_in_page,
    email_view,
    connect_account_page,
    blm_landing_page,
    discover_onboarding_page,
    search_onboarding_page,
    posting_onboarding_page,
    map_onboarding_page,
    profile_onboarding_page,
    food_finder_filters,
    maybe_list_page,
  ];

  static final $core.Map<$core.int, TAPage> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TAPage valueOf($core.int value) => _byValue[value];

  const TAPage._($core.int v, $core.String n) : super(v, n);
}

class TAEvent extends $pb.ProtobufEnum {
  static const TAEvent liked_post = TAEvent._(0, 'liked_post');
  static const TAEvent liked_comment = TAEvent._(1, 'liked_comment');
  static const TAEvent bookmark_post = TAEvent._(2, 'bookmark_post');
  static const TAEvent click_post = TAEvent._(3, 'click_post');
  static const TAEvent expand_description = TAEvent._(4, 'expand_description');
  static const TAEvent click_likes = TAEvent._(5, 'click_likes');
  static const TAEvent drafted_comment = TAEvent._(6, 'drafted_comment');
  static const TAEvent edited_comment = TAEvent._(7, 'edited_comment');
  static const TAEvent submitted_comment = TAEvent._(8, 'submitted_comment');
  static const TAEvent deleted_comment = TAEvent._(9, 'deleted_comment');
  static const TAEvent draft_favorite = TAEvent._(10, 'draft_favorite');
  static const TAEvent clicked_add_favorite = TAEvent._(11, 'clicked_add_favorite');
  static const TAEvent remove_favorite = TAEvent._(12, 'remove_favorite');
  static const TAEvent swipe_multi_photo = TAEvent._(13, 'swipe_multi_photo');
  static const TAEvent swipe_multi_post = TAEvent._(14, 'swipe_multi_post');
  static const TAEvent draft_post = TAEvent._(15, 'draft_post');
  static const TAEvent create_post = TAEvent._(16, 'create_post');
  static const TAEvent submit_post_attempt = TAEvent._(29, 'submit_post_attempt');
  static const TAEvent submit_post_attempt_incomplete = TAEvent._(30, 'submit_post_attempt_incomplete');
  static const TAEvent discard_post = TAEvent._(17, 'discard_post');
  static const TAEvent start_edit_post = TAEvent._(18, 'start_edit_post');
  static const TAEvent complete_edit_post = TAEvent._(31, 'complete_edit_post');
  static const TAEvent delete_post = TAEvent._(19, 'delete_post');
  static const TAEvent dt_submit_vote = TAEvent._(20, 'dt_submit_vote');
  static const TAEvent dt_see_faq = TAEvent._(21, 'dt_see_faq');
  static const TAEvent discover_toggle_following = TAEvent._(22, 'discover_toggle_following');
  static const TAEvent discover_toggle_home_cooked = TAEvent._(23, 'discover_toggle_home_cooked');
  static const TAEvent nav_item_tap = TAEvent._(24, 'nav_item_tap');
  static const TAEvent remote_config = TAEvent._(25, 'remote_config');
  static const TAEvent cannot_find_badge = TAEvent._(26, 'cannot_find_badge');
  static const TAEvent clicked_invite_friend = TAEvent._(27, 'clicked_invite_friend');
  static const TAEvent dt_votes_ran_out = TAEvent._(28, 'dt_votes_ran_out');
  static const TAEvent selected_assets = TAEvent._(32, 'selected_assets');
  static const TAEvent selected_take_photo = TAEvent._(33, 'selected_take_photo');
  static const TAEvent tapped_cuisine_tag = TAEvent._(34, 'tapped_cuisine_tag');
  static const TAEvent tappe_emoji_tag = TAEvent._(35, 'tappe_emoji_tag');
  static const TAEvent replaced_selected_restaurant_chip = TAEvent._(36, 'replaced_selected_restaurant_chip');
  static const TAEvent tapped_restaurant_chip = TAEvent._(37, 'tapped_restaurant_chip');
  static const TAEvent clicked_clear_restaurant = TAEvent._(38, 'clicked_clear_restaurant');
  static const TAEvent selected_restaurant_from_search = TAEvent._(39, 'selected_restaurant_from_search');
  static const TAEvent clicked_comments = TAEvent._(40, 'clicked_comments');
  static const TAEvent tapped_user_photo = TAEvent._(41, 'tapped_user_photo');
  static const TAEvent web_map = TAEvent._(42, 'web_map');
  static const TAEvent map_promotion = TAEvent._(43, 'map_promotion');
  static const TAEvent clicked_report_bug = TAEvent._(44, 'clicked_report_bug');
  static const TAEvent clicked_share_taste = TAEvent._(45, 'clicked_share_taste');
  static const TAEvent discover_refreshed = TAEvent._(46, 'discover_refreshed');
  static const TAEvent discover_loaded = TAEvent._(47, 'discover_loaded');
  static const TAEvent cancelled_instagram_link = TAEvent._(48, 'cancelled_instagram_link');
  static const TAEvent linked_instagram = TAEvent._(49, 'linked_instagram');
  static const TAEvent unlinked_instagram = TAEvent._(50, 'unlinked_instagram');
  static const TAEvent clicked_sign_in = TAEvent._(51, 'clicked_sign_in');
  static const TAEvent force_setup_account = TAEvent._(52, 'force_setup_account');
  static const TAEvent clicked_add_favorites_snackbar = TAEvent._(53, 'clicked_add_favorites_snackbar');
  static const TAEvent map_tap = TAEvent._(54, 'map_tap');
  static const TAEvent map_my_location = TAEvent._(55, 'map_my_location');
  static const TAEvent map_go_to_search_result = TAEvent._(56, 'map_go_to_search_result');
  static const TAEvent map_marker_tap = TAEvent._(57, 'map_marker_tap');
  static const TAEvent map_tapped_preview = TAEvent._(58, 'map_tapped_preview');
  static const TAEvent map_review_clicked = TAEvent._(59, 'map_review_clicked');
  static const TAEvent map_preview_changed = TAEvent._(60, 'map_preview_changed');
  static const TAEvent tapped_map_following_filter = TAEvent._(61, 'tapped_map_following_filter');
  static const TAEvent tapped_map_settings = TAEvent._(62, 'tapped_map_settings');
  static const TAEvent go_to_profile = TAEvent._(63, 'go_to_profile');
  static const TAEvent map_swipe_page = TAEvent._(64, 'map_swipe_page');
  static const TAEvent clicked_tag = TAEvent._(65, 'clicked_tag');
  static const TAEvent city_champ_tile_tap = TAEvent._(66, 'city_champ_tile_tap');
  static const TAEvent favorites_duplicate_place = TAEvent._(67, 'favorites_duplicate_place');
  static const TAEvent favorites_city_limits_reached = TAEvent._(68, 'favorites_city_limits_reached');
  static const TAEvent favorites_added = TAEvent._(69, 'favorites_added');
  static const TAEvent routed_notification = TAEvent._(70, 'routed_notification');
  static const TAEvent tapped_trending_tag = TAEvent._(71, 'tapped_trending_tag');
  static const TAEvent fb_only_resto = TAEvent._(72, 'fb_only_resto');
  static const TAEvent clicked_search_suggestion = TAEvent._(73, 'clicked_search_suggestion');
  static const TAEvent clicked_badge_leaderboard_tile = TAEvent._(74, 'clicked_badge_leaderboard_tile');
  static const TAEvent clicked_user_map = TAEvent._(75, 'clicked_user_map');
  static const TAEvent clicked_edit_favorites = TAEvent._(76, 'clicked_edit_favorites');
  static const TAEvent tapped_notification = TAEvent._(77, 'tapped_notification');
  static const TAEvent added_favorite = TAEvent._(78, 'added_favorite');
  static const TAEvent tapped_bookmark_review = TAEvent._(79, 'tapped_bookmark_review');
  static const TAEvent tapped_badge_streak_button = TAEvent._(80, 'tapped_badge_streak_button');
  static const TAEvent empty_place_lookup = TAEvent._(81, 'empty_place_lookup');
  static const TAEvent selected_place_lookup_suggestion = TAEvent._(82, 'selected_place_lookup_suggestion');
  static const TAEvent tapped_restaurant_map_button = TAEvent._(83, 'tapped_restaurant_map_button');
  static const TAEvent tapped_meal_mate_text_link = TAEvent._(84, 'tapped_meal_mate_text_link');
  static const TAEvent tapped_delete_comment = TAEvent._(85, 'tapped_delete_comment');
  static const TAEvent undid_delete_comment = TAEvent._(86, 'undid_delete_comment');
  static const TAEvent tapped_comment_likes = TAEvent._(87, 'tapped_comment_likes');
  static const TAEvent tapped_post_on_restaurant = TAEvent._(88, 'tapped_post_on_restaurant');
  static const TAEvent tapped_reaction_in_review = TAEvent._(89, 'tapped_reaction_in_review');
  static const TAEvent tapped_category_chip = TAEvent._(90, 'tapped_category_chip');
  static const TAEvent tapped_city_chip = TAEvent._(91, 'tapped_city_chip');
  static const TAEvent searched = TAEvent._(92, 'searched');
  static const TAEvent tapped_daily_tasty_logo = TAEvent._(93, 'tapped_daily_tasty_logo');
  static const TAEvent tapped_user_rank = TAEvent._(94, 'tapped_user_rank');
  static const TAEvent tapped_badge = TAEvent._(95, 'tapped_badge');
  static const TAEvent favorites_place_lookup_no_selection = TAEvent._(96, 'favorites_place_lookup_no_selection');
  static const TAEvent double_tap_heart = TAEvent._(97, 'double_tap_heart');
  static const TAEvent attribution_success = TAEvent._(98, 'attribution_success');
  static const TAEvent attribution_failure = TAEvent._(99, 'attribution_failure');
  static const TAEvent resto_tapped_call_btn = TAEvent._(100, 'resto_tapped_call_btn');
  static const TAEvent resto_tapped_navigate_btn = TAEvent._(101, 'resto_tapped_navigate_btn');
  static const TAEvent resto_tapped_webpage_btn = TAEvent._(102, 'resto_tapped_webpage_btn');
  static const TAEvent resto_tapped_gmaps_rating = TAEvent._(103, 'resto_tapped_gmaps_rating');
  static const TAEvent tapped_map_black_owned = TAEvent._(104, 'tapped_map_black_owned');
  static const TAEvent tapped_search_black_owned = TAEvent._(105, 'tapped_search_black_owned');
  static const TAEvent selected_black_charity = TAEvent._(106, 'selected_black_charity');
  static const TAEvent did_not_select_black_charity = TAEvent._(107, 'did_not_select_black_charity');
  static const TAEvent resto_tapped_yelp_rating = TAEvent._(108, 'resto_tapped_yelp_rating');
  static const TAEvent intro_tabs_share_your_taste = TAEvent._(109, 'intro_tabs_share_your_taste');
  static const TAEvent intro_tabs_discover_new_food = TAEvent._(110, 'intro_tabs_discover_new_food');
  static const TAEvent intro_tabs_remember_your_eats = TAEvent._(111, 'intro_tabs_remember_your_eats');
  static const TAEvent discover_scrolled_to_item = TAEvent._(112, 'discover_scrolled_to_item');
  static const TAEvent tapped_recipe = TAEvent._(113, 'tapped_recipe');
  static const TAEvent unrequested_recipe = TAEvent._(114, 'unrequested_recipe');
  static const TAEvent fetched_starting_tab = TAEvent._(115, 'fetched_starting_tab');
  static const TAEvent failed_sign_in = TAEvent._(116, 'failed_sign_in');
  static const TAEvent clicked_link_account = TAEvent._(117, 'clicked_link_account');
  static const TAEvent failed_link_account = TAEvent._(118, 'failed_link_account');
  static const TAEvent create_post_presubmit_dialog_keep_editing = TAEvent._(119, 'create_post_presubmit_dialog_keep_editing');
  static const TAEvent create_post_presubmit_dialog_submit = TAEvent._(120, 'create_post_presubmit_dialog_submit');
  static const TAEvent popular_restaurants_scroll = TAEvent._(121, 'popular_restaurants_scroll');
  static const TAEvent friends_favorites_scroll = TAEvent._(122, 'friends_favorites_scroll');
  static const TAEvent visit_again_scroll = TAEvent._(123, 'visit_again_scroll');
  static const TAEvent discover_mode_most_popular = TAEvent._(124, 'discover_mode_most_popular');
  static const TAEvent discover_mode_most_recent = TAEvent._(125, 'discover_mode_most_recent');
  static const TAEvent discover_mode_nearby = TAEvent._(126, 'discover_mode_nearby');
  static const TAEvent discover_bor_banner_tap = TAEvent._(127, 'discover_bor_banner_tap');
  static const TAEvent discover_bor_banner_learn_more = TAEvent._(128, 'discover_bor_banner_learn_more');
  static const TAEvent discover_bor_banner_search_now = TAEvent._(129, 'discover_bor_banner_search_now');
  static const TAEvent search_page_resto_tap = TAEvent._(130, 'search_page_resto_tap');
  static const TAEvent discover_tap_first_to_post = TAEvent._(131, 'discover_tap_first_to_post');
  static const TAEvent dismiss_bor_banner = TAEvent._(132, 'dismiss_bor_banner');
  static const TAEvent discover_location_not_available = TAEvent._(133, 'discover_location_not_available');
  static const TAEvent location_available = TAEvent._(134, 'location_available');
  static const TAEvent location_unavailable = TAEvent._(135, 'location_unavailable');
  static const TAEvent resto_missing_ratings = TAEvent._(136, 'resto_missing_ratings');
  static const TAEvent selected_loc_lookup_suggestion = TAEvent._(137, 'selected_loc_lookup_suggestion');
  static const TAEvent empty_result_from_loc_lookup = TAEvent._(138, 'empty_result_from_loc_lookup');
  static const TAEvent tapped_filter_chip = TAEvent._(139, 'tapped_filter_chip');
  static const TAEvent food_finder_toggle_map = TAEvent._(141, 'food_finder_toggle_map');
  static const TAEvent resto_tapped_postmates_url = TAEvent._(142, 'resto_tapped_postmates_url');
  static const TAEvent resto_tapped_doordash_url = TAEvent._(143, 'resto_tapped_doordash_url');
  static const TAEvent resto_tapped_ubereats_url = TAEvent._(144, 'resto_tapped_ubereats_url');
  static const TAEvent resto_tapped_seamless_url = TAEvent._(145, 'resto_tapped_seamless_url');
  static const TAEvent resto_tapped_caviar_url = TAEvent._(146, 'resto_tapped_caviar_url');
  static const TAEvent resto_tapped_favor_url = TAEvent._(147, 'resto_tapped_favor_url');
  static const TAEvent resto_tapped_grubhub_url = TAEvent._(148, 'resto_tapped_grubhub_url');
  static const TAEvent food_finder_swipe_right = TAEvent._(149, 'food_finder_swipe_right');
  static const TAEvent food_finder_swipe_left = TAEvent._(150, 'food_finder_swipe_left');
  static const TAEvent food_finder_thumbs_up = TAEvent._(151, 'food_finder_thumbs_up');
  static const TAEvent food_finder_thumbs_down = TAEvent._(152, 'food_finder_thumbs_down');
  static const TAEvent food_finder_expand_resto = TAEvent._(153, 'food_finder_expand_resto');
  static const TAEvent food_finder_collapse_resto = TAEvent._(154, 'food_finder_collapse_resto');
  static const TAEvent food_finder_search = TAEvent._(155, 'food_finder_search');
  static const TAEvent food_finder_expand_filters = TAEvent._(156, 'food_finder_expand_filters');
  static const TAEvent food_finder_filters_cancel = TAEvent._(157, 'food_finder_filters_cancel');
  static const TAEvent food_finder_filters_apply = TAEvent._(158, 'food_finder_filters_apply');
  static const TAEvent food_finder_maybe_list = TAEvent._(159, 'food_finder_maybe_list');
  static const TAEvent food_finder_maybe_list_item = TAEvent._(160, 'food_finder_maybe_list_item');
  static const TAEvent food_finder_load = TAEvent._(161, 'food_finder_load');
  static const TAEvent food_finder_discover_items_load = TAEvent._(162, 'food_finder_discover_items_load');

  static const $core.List<TAEvent> values = <TAEvent> [
    liked_post,
    liked_comment,
    bookmark_post,
    click_post,
    expand_description,
    click_likes,
    drafted_comment,
    edited_comment,
    submitted_comment,
    deleted_comment,
    draft_favorite,
    clicked_add_favorite,
    remove_favorite,
    swipe_multi_photo,
    swipe_multi_post,
    draft_post,
    create_post,
    submit_post_attempt,
    submit_post_attempt_incomplete,
    discard_post,
    start_edit_post,
    complete_edit_post,
    delete_post,
    dt_submit_vote,
    dt_see_faq,
    discover_toggle_following,
    discover_toggle_home_cooked,
    nav_item_tap,
    remote_config,
    cannot_find_badge,
    clicked_invite_friend,
    dt_votes_ran_out,
    selected_assets,
    selected_take_photo,
    tapped_cuisine_tag,
    tappe_emoji_tag,
    replaced_selected_restaurant_chip,
    tapped_restaurant_chip,
    clicked_clear_restaurant,
    selected_restaurant_from_search,
    clicked_comments,
    tapped_user_photo,
    web_map,
    map_promotion,
    clicked_report_bug,
    clicked_share_taste,
    discover_refreshed,
    discover_loaded,
    cancelled_instagram_link,
    linked_instagram,
    unlinked_instagram,
    clicked_sign_in,
    force_setup_account,
    clicked_add_favorites_snackbar,
    map_tap,
    map_my_location,
    map_go_to_search_result,
    map_marker_tap,
    map_tapped_preview,
    map_review_clicked,
    map_preview_changed,
    tapped_map_following_filter,
    tapped_map_settings,
    go_to_profile,
    map_swipe_page,
    clicked_tag,
    city_champ_tile_tap,
    favorites_duplicate_place,
    favorites_city_limits_reached,
    favorites_added,
    routed_notification,
    tapped_trending_tag,
    fb_only_resto,
    clicked_search_suggestion,
    clicked_badge_leaderboard_tile,
    clicked_user_map,
    clicked_edit_favorites,
    tapped_notification,
    added_favorite,
    tapped_bookmark_review,
    tapped_badge_streak_button,
    empty_place_lookup,
    selected_place_lookup_suggestion,
    tapped_restaurant_map_button,
    tapped_meal_mate_text_link,
    tapped_delete_comment,
    undid_delete_comment,
    tapped_comment_likes,
    tapped_post_on_restaurant,
    tapped_reaction_in_review,
    tapped_category_chip,
    tapped_city_chip,
    searched,
    tapped_daily_tasty_logo,
    tapped_user_rank,
    tapped_badge,
    favorites_place_lookup_no_selection,
    double_tap_heart,
    attribution_success,
    attribution_failure,
    resto_tapped_call_btn,
    resto_tapped_navigate_btn,
    resto_tapped_webpage_btn,
    resto_tapped_gmaps_rating,
    tapped_map_black_owned,
    tapped_search_black_owned,
    selected_black_charity,
    did_not_select_black_charity,
    resto_tapped_yelp_rating,
    intro_tabs_share_your_taste,
    intro_tabs_discover_new_food,
    intro_tabs_remember_your_eats,
    discover_scrolled_to_item,
    tapped_recipe,
    unrequested_recipe,
    fetched_starting_tab,
    failed_sign_in,
    clicked_link_account,
    failed_link_account,
    create_post_presubmit_dialog_keep_editing,
    create_post_presubmit_dialog_submit,
    popular_restaurants_scroll,
    friends_favorites_scroll,
    visit_again_scroll,
    discover_mode_most_popular,
    discover_mode_most_recent,
    discover_mode_nearby,
    discover_bor_banner_tap,
    discover_bor_banner_learn_more,
    discover_bor_banner_search_now,
    search_page_resto_tap,
    discover_tap_first_to_post,
    dismiss_bor_banner,
    discover_location_not_available,
    location_available,
    location_unavailable,
    resto_missing_ratings,
    selected_loc_lookup_suggestion,
    empty_result_from_loc_lookup,
    tapped_filter_chip,
    food_finder_toggle_map,
    resto_tapped_postmates_url,
    resto_tapped_doordash_url,
    resto_tapped_ubereats_url,
    resto_tapped_seamless_url,
    resto_tapped_caviar_url,
    resto_tapped_favor_url,
    resto_tapped_grubhub_url,
    food_finder_swipe_right,
    food_finder_swipe_left,
    food_finder_thumbs_up,
    food_finder_thumbs_down,
    food_finder_expand_resto,
    food_finder_collapse_resto,
    food_finder_search,
    food_finder_expand_filters,
    food_finder_filters_cancel,
    food_finder_filters_apply,
    food_finder_maybe_list,
    food_finder_maybe_list_item,
    food_finder_load,
    food_finder_discover_items_load,
  ];

  static final $core.Map<$core.int, TAEvent> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TAEvent valueOf($core.int value) => _byValue[value];

  const TAEvent._($core.int v, $core.String n) : super(v, n);
}

