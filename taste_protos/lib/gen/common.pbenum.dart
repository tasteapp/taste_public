///
//  Generated code. Do not modify.
//  source: common.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class PlaceCategory extends $pb.ProtobufEnum {
  static const PlaceCategory PLACE_CATEGORY_UNDEFINED = PlaceCategory._(0, 'PLACE_CATEGORY_UNDEFINED');
  static const PlaceCategory restaurants = PlaceCategory._(1, 'restaurants');
  static const PlaceCategory cafes = PlaceCategory._(2, 'cafes');
  static const PlaceCategory desserts = PlaceCategory._(3, 'desserts');
  static const PlaceCategory bars = PlaceCategory._(4, 'bars');

  static const $core.List<PlaceCategory> values = <PlaceCategory> [
    PLACE_CATEGORY_UNDEFINED,
    restaurants,
    cafes,
    desserts,
    bars,
  ];

  static final $core.Map<$core.int, PlaceCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PlaceCategory valueOf($core.int value) => _byValue[value];

  const PlaceCategory._($core.int v, $core.String n) : super(v, n);
}

class PlaceType extends $pb.ProtobufEnum {
  static const PlaceType PLACE_TYPE_UNDEFINED = PlaceType._(0, 'PLACE_TYPE_UNDEFINED');
  static const PlaceType american_restaurant = PlaceType._(1, 'american_restaurant');
  static const PlaceType coffee_shop = PlaceType._(2, 'coffee_shop');
  static const PlaceType fast_food_restaurant = PlaceType._(3, 'fast_food_restaurant');
  static const PlaceType italian_restaurant = PlaceType._(4, 'italian_restaurant');
  static const PlaceType breakfast_and_brunch_restaurant = PlaceType._(5, 'breakfast_and_brunch_restaurant');
  static const PlaceType bar = PlaceType._(6, 'bar');
  static const PlaceType pizza_place = PlaceType._(7, 'pizza_place');
  static const PlaceType seafood_restaurant = PlaceType._(8, 'seafood_restaurant');
  static const PlaceType bakery = PlaceType._(9, 'bakery');
  static const PlaceType new_american_restaurant = PlaceType._(10, 'new_american_restaurant');
  static const PlaceType sushi_restaurant = PlaceType._(11, 'sushi_restaurant');
  static const PlaceType mexican_restaurant = PlaceType._(12, 'mexican_restaurant');
  static const PlaceType bar_and_grill = PlaceType._(13, 'bar_and_grill');
  static const PlaceType ice_cream_shop = PlaceType._(14, 'ice_cream_shop');
  static const PlaceType cafe = PlaceType._(15, 'cafe');
  static const PlaceType burger_restaurant = PlaceType._(16, 'burger_restaurant');
  static const PlaceType family_style_restaurant = PlaceType._(17, 'family_style_restaurant');
  static const PlaceType pub = PlaceType._(18, 'pub');
  static const PlaceType asian_fusion_restaurant = PlaceType._(19, 'asian_fusion_restaurant');
  static const PlaceType sandwich_shop = PlaceType._(20, 'sandwich_shop');
  static const PlaceType deli = PlaceType._(21, 'deli');
  static const PlaceType caterer = PlaceType._(22, 'caterer');
  static const PlaceType diner = PlaceType._(23, 'diner');
  static const PlaceType dessert_shop = PlaceType._(24, 'dessert_shop');
  static const PlaceType vegetarian_or_vegan_restaurant = PlaceType._(25, 'vegetarian_or_vegan_restaurant');
  static const PlaceType barbecue_restaurant = PlaceType._(26, 'barbecue_restaurant');
  static const PlaceType steakhouse = PlaceType._(27, 'steakhouse');
  static const PlaceType chinese_restaurant = PlaceType._(28, 'chinese_restaurant');
  static const PlaceType cocktail_bar = PlaceType._(29, 'cocktail_bar');
  static const PlaceType thai_restaurant = PlaceType._(30, 'thai_restaurant');
  static const PlaceType wine_bar = PlaceType._(31, 'wine_bar');
  static const PlaceType french_restaurant = PlaceType._(32, 'french_restaurant');
  static const PlaceType korean_restaurant = PlaceType._(33, 'korean_restaurant');
  static const PlaceType smoothie_and_juice_bar = PlaceType._(34, 'smoothie_and_juice_bar');
  static const PlaceType european_restaurant = PlaceType._(35, 'european_restaurant');
  static const PlaceType mediterranean_restaurant = PlaceType._(36, 'mediterranean_restaurant');
  static const PlaceType chicken_joint = PlaceType._(37, 'chicken_joint');
  static const PlaceType brewery = PlaceType._(38, 'brewery');
  static const PlaceType sports_bar = PlaceType._(39, 'sports_bar');
  static const PlaceType japanese_restaurant = PlaceType._(40, 'japanese_restaurant');
  static const PlaceType health_food_restaurant = PlaceType._(41, 'health_food_restaurant');
  static const PlaceType tea_room = PlaceType._(42, 'tea_room');
  static const PlaceType donut_shop = PlaceType._(43, 'donut_shop');
  static const PlaceType ramen_restaurant = PlaceType._(44, 'ramen_restaurant');
  static const PlaceType food_and_beverage = PlaceType._(45, 'food_and_beverage');
  static const PlaceType bubble_tea_shop = PlaceType._(46, 'bubble_tea_shop');
  static const PlaceType food_truck = PlaceType._(47, 'food_truck');
  static const PlaceType tapas_bar_and_restaurant = PlaceType._(48, 'tapas_bar_and_restaurant');
  static const PlaceType gastropub = PlaceType._(49, 'gastropub');
  static const PlaceType tex_mex_restaurant = PlaceType._(50, 'tex_mex_restaurant');
  static const PlaceType southern_restaurant = PlaceType._(51, 'southern_restaurant');
  static const PlaceType pho_restaurant = PlaceType._(52, 'pho_restaurant');
  static const PlaceType spanish_restaurant = PlaceType._(53, 'spanish_restaurant');
  static const PlaceType food_stand = PlaceType._(54, 'food_stand');
  static const PlaceType grocery_store = PlaceType._(55, 'grocery_store');
  static const PlaceType greek_restaurant = PlaceType._(56, 'greek_restaurant');
  static const PlaceType farmers_market = PlaceType._(57, 'farmers_market');
  static const PlaceType cantonese_restaurant = PlaceType._(58, 'cantonese_restaurant');
  static const PlaceType beer_bar = PlaceType._(59, 'beer_bar');
  static const PlaceType vietnamese_restaurant = PlaceType._(60, 'vietnamese_restaurant');
  static const PlaceType middle_eastern_restaurant = PlaceType._(61, 'middle_eastern_restaurant');
  static const PlaceType bagel_shop = PlaceType._(62, 'bagel_shop');
  static const PlaceType cupcake_shop = PlaceType._(63, 'cupcake_shop');
  static const PlaceType indian_restaurant = PlaceType._(64, 'indian_restaurant');
  static const PlaceType dim_sum_restaurant = PlaceType._(65, 'dim_sum_restaurant');
  static const PlaceType winery_or_vineyard = PlaceType._(66, 'winery_or_vineyard');
  static const PlaceType hawaiian_restaurant = PlaceType._(67, 'hawaiian_restaurant');
  static const PlaceType poke_restaurant = PlaceType._(68, 'poke_restaurant');
  static const PlaceType beer_garden = PlaceType._(69, 'beer_garden');
  static const PlaceType asian_restaurant = PlaceType._(70, 'asian_restaurant');
  static const PlaceType frozen_yogurt_shop = PlaceType._(71, 'frozen_yogurt_shop');
  static const PlaceType soup_restaurant = PlaceType._(72, 'soup_restaurant');
  static const PlaceType latin_american_restaurant = PlaceType._(73, 'latin_american_restaurant');
  static const PlaceType cajun_and_creole_restaurant = PlaceType._(74, 'cajun_and_creole_restaurant');
  static const PlaceType hot_dog_joint = PlaceType._(75, 'hot_dog_joint');
  static const PlaceType halal_restaurant = PlaceType._(76, 'halal_restaurant');
  static const PlaceType taiwanese_restaurant = PlaceType._(77, 'taiwanese_restaurant');
  static const PlaceType candy_store = PlaceType._(78, 'candy_store');
  static const PlaceType creperie = PlaceType._(79, 'creperie');
  static const PlaceType salad_bar = PlaceType._(80, 'salad_bar');
  static const PlaceType filipino_restaurant = PlaceType._(81, 'filipino_restaurant');
  static const PlaceType buffet_restaurant = PlaceType._(82, 'buffet_restaurant');
  static const PlaceType caribbean_restaurant = PlaceType._(83, 'caribbean_restaurant');
  static const PlaceType gelato_shop = PlaceType._(84, 'gelato_shop');
  static const PlaceType cafeteria = PlaceType._(85, 'cafeteria');
  static const PlaceType peruvian_restaurant = PlaceType._(86, 'peruvian_restaurant');
  static const PlaceType southwestern_restaurant = PlaceType._(87, 'southwestern_restaurant');
  static const PlaceType comfort_food_restaurant = PlaceType._(88, 'comfort_food_restaurant');
  static const PlaceType cuban_restaurant = PlaceType._(89, 'cuban_restaurant');
  static const PlaceType gluten_free_restaurant = PlaceType._(90, 'gluten_free_restaurant');
  static const PlaceType modern_european_restaurant = PlaceType._(91, 'modern_european_restaurant');
  static const PlaceType british_restaurant = PlaceType._(92, 'british_restaurant');
  static const PlaceType irish_restaurant = PlaceType._(93, 'irish_restaurant');
  static const PlaceType noodle_house = PlaceType._(94, 'noodle_house');
  static const PlaceType hot_pot_restaurant = PlaceType._(95, 'hot_pot_restaurant');
  static const PlaceType fish_and_chips_restaurant = PlaceType._(96, 'fish_and_chips_restaurant');
  static const PlaceType kosher_restaurant = PlaceType._(97, 'kosher_restaurant');
  static const PlaceType soul_food_restaurant = PlaceType._(98, 'soul_food_restaurant');
  static const PlaceType lebanese_restaurant = PlaceType._(99, 'lebanese_restaurant');
  static const PlaceType chocolate_shop = PlaceType._(100, 'chocolate_shop');
  static const PlaceType portuguese_restaurant = PlaceType._(101, 'portuguese_restaurant');
  static const PlaceType shaved_ice_shop = PlaceType._(102, 'shaved_ice_shop');
  static const PlaceType brazilian_restaurant = PlaceType._(103, 'brazilian_restaurant');
  static const PlaceType szechuan_or_sichuan_restaurant = PlaceType._(104, 'szechuan_or_sichuan_restaurant');
  static const PlaceType wine_or_spirits = PlaceType._(105, 'wine_or_spirits');
  static const PlaceType turkish_restaurant = PlaceType._(106, 'turkish_restaurant');
  static const PlaceType german_restaurant = PlaceType._(107, 'german_restaurant');
  static const PlaceType argentinian_restaurant = PlaceType._(108, 'argentinian_restaurant');
  static const PlaceType dive_bar = PlaceType._(109, 'dive_bar');
  static const PlaceType taco_restaurant = PlaceType._(110, 'taco_restaurant');
  static const PlaceType australian_restaurant = PlaceType._(111, 'australian_restaurant');
  static const PlaceType irish_pub = PlaceType._(112, 'irish_pub');
  static const PlaceType live_and_raw_food_restaurant = PlaceType._(113, 'live_and_raw_food_restaurant');
  static const PlaceType south_indian_restaurant = PlaceType._(114, 'south_indian_restaurant');
  static const PlaceType persian_or_iranian_restaurant = PlaceType._(115, 'persian_or_iranian_restaurant');
  static const PlaceType fondue_restaurant = PlaceType._(116, 'fondue_restaurant');
  static const PlaceType bed_and_breakfast = PlaceType._(117, 'bed_and_breakfast');
  static const PlaceType continental_restaurant = PlaceType._(118, 'continental_restaurant');
  static const PlaceType whisky_bar = PlaceType._(119, 'whisky_bar');
  static const PlaceType teppanyaki_restaurant = PlaceType._(120, 'teppanyaki_restaurant');
  static const PlaceType kebab_shop = PlaceType._(121, 'kebab_shop');
  static const PlaceType colombian_restaurant = PlaceType._(122, 'colombian_restaurant');
  static const PlaceType pakistani_restaurant = PlaceType._(123, 'pakistani_restaurant');
  static const PlaceType malaysian_restaurant = PlaceType._(124, 'malaysian_restaurant');
  static const PlaceType sake_bar = PlaceType._(125, 'sake_bar');
  static const PlaceType indonesian_restaurant = PlaceType._(126, 'indonesian_restaurant');
  static const PlaceType belgian_restaurant = PlaceType._(127, 'belgian_restaurant');
  static const PlaceType scandinavian_restaurant = PlaceType._(128, 'scandinavian_restaurant');
  static const PlaceType theme_restaurant = PlaceType._(129, 'theme_restaurant');
  static const PlaceType jamaican_restaurant = PlaceType._(130, 'jamaican_restaurant');
  static const PlaceType shabu_shabu_restaurant = PlaceType._(131, 'shabu_shabu_restaurant');
  static const PlaceType canadian_restaurant = PlaceType._(132, 'canadian_restaurant');
  static const PlaceType hong_kong_restaurant = PlaceType._(133, 'hong_kong_restaurant');
  static const PlaceType venezuelan_restaurant = PlaceType._(134, 'venezuelan_restaurant');
  static const PlaceType israeli_restaurant = PlaceType._(135, 'israeli_restaurant');
  static const PlaceType north_indian_restaurant = PlaceType._(136, 'north_indian_restaurant');
  static const PlaceType ethiopian_restaurant = PlaceType._(137, 'ethiopian_restaurant');
  static const PlaceType singaporean_restaurant = PlaceType._(138, 'singaporean_restaurant');
  static const PlaceType moroccan_restaurant = PlaceType._(139, 'moroccan_restaurant');
  static const PlaceType speakeasy = PlaceType._(140, 'speakeasy');
  static const PlaceType puerto_rican_restaurant = PlaceType._(141, 'puerto_rican_restaurant');
  static const PlaceType neapolitan_restaurant = PlaceType._(142, 'neapolitan_restaurant');
  static const PlaceType polynesian_restaurant = PlaceType._(143, 'polynesian_restaurant');
  static const PlaceType bavarian_restaurant = PlaceType._(144, 'bavarian_restaurant');
  static const PlaceType afghan_restaurant = PlaceType._(145, 'afghan_restaurant');
  static const PlaceType shanghainese_restaurant = PlaceType._(146, 'shanghainese_restaurant');
  static const PlaceType udon_restaurant = PlaceType._(147, 'udon_restaurant');
  static const PlaceType tuscan_restaurant = PlaceType._(148, 'tuscan_restaurant');
  static const PlaceType yakitori_restaurant = PlaceType._(149, 'yakitori_restaurant');
  static const PlaceType tiki_bar = PlaceType._(150, 'tiki_bar');
  static const PlaceType yakiniku_restaurant = PlaceType._(151, 'yakiniku_restaurant');
  static const PlaceType roman_restaurant = PlaceType._(152, 'roman_restaurant');
  static const PlaceType nepalese_restaurant = PlaceType._(153, 'nepalese_restaurant');
  static const PlaceType salvadoran_restaurant = PlaceType._(154, 'salvadoran_restaurant');
  static const PlaceType russian_restaurant = PlaceType._(155, 'russian_restaurant');
  static const PlaceType african_restaurant = PlaceType._(156, 'african_restaurant');
  static const PlaceType cambodian_restaurant = PlaceType._(157, 'cambodian_restaurant');
  static const PlaceType mongolian_restaurant = PlaceType._(158, 'mongolian_restaurant');
  static const PlaceType eastern_european_restaurant = PlaceType._(159, 'eastern_european_restaurant');
  static const PlaceType abruzzo_restaurant = PlaceType._(160, 'abruzzo_restaurant');
  static const PlaceType bunsik_restaurant = PlaceType._(161, 'bunsik_restaurant');
  static const PlaceType himalayan_restaurant = PlaceType._(162, 'himalayan_restaurant');
  static const PlaceType basque_restaurant = PlaceType._(163, 'basque_restaurant');
  static const PlaceType tonkatsu_restaurant = PlaceType._(164, 'tonkatsu_restaurant');
  static const PlaceType sicilian_restaurant = PlaceType._(165, 'sicilian_restaurant');
  static const PlaceType burmese_restaurant = PlaceType._(166, 'burmese_restaurant');
  static const PlaceType south_african_restaurant = PlaceType._(167, 'south_african_restaurant');
  static const PlaceType soba_restaurant = PlaceType._(168, 'soba_restaurant');
  static const PlaceType polish_restaurant = PlaceType._(169, 'polish_restaurant');
  static const PlaceType austrian_restaurant = PlaceType._(170, 'austrian_restaurant');
  static const PlaceType dominican_restaurant = PlaceType._(171, 'dominican_restaurant');
  static const PlaceType bossam_or_jokbal_restaurant = PlaceType._(172, 'bossam_or_jokbal_restaurant');
  static const PlaceType drive_in_restaurant = PlaceType._(173, 'drive_in_restaurant');
  static const PlaceType swiss_restaurant = PlaceType._(174, 'swiss_restaurant');
  static const PlaceType hungarian_restaurant = PlaceType._(175, 'hungarian_restaurant');
  static const PlaceType arabian_restaurant = PlaceType._(176, 'arabian_restaurant');
  static const PlaceType czech_restaurant = PlaceType._(177, 'czech_restaurant');
  static const PlaceType okonomiyaki_restaurant = PlaceType._(178, 'okonomiyaki_restaurant');
  static const PlaceType indo_chinese_restaurant = PlaceType._(179, 'indo_chinese_restaurant');
  static const PlaceType armenian_restaurant = PlaceType._(180, 'armenian_restaurant');
  static const PlaceType hunan_restaurant = PlaceType._(181, 'hunan_restaurant');
  static const PlaceType tempura_restaurant = PlaceType._(182, 'tempura_restaurant');
  static const PlaceType venetian_restaurant = PlaceType._(183, 'venetian_restaurant');
  static const PlaceType unagi_restaurant = PlaceType._(184, 'unagi_restaurant');
  static const PlaceType georgian_restaurant = PlaceType._(185, 'georgian_restaurant');
  static const PlaceType donburi_restaurant = PlaceType._(186, 'donburi_restaurant');
  static const PlaceType kaiseki_restaurant = PlaceType._(187, 'kaiseki_restaurant');
  static const PlaceType beijing_restaurant = PlaceType._(188, 'beijing_restaurant');
  static const PlaceType sri_lankan_restaurant = PlaceType._(189, 'sri_lankan_restaurant');
  static const PlaceType scottish_restaurant = PlaceType._(190, 'scottish_restaurant');
  static const PlaceType indian_chinese_restaurant = PlaceType._(191, 'indian_chinese_restaurant');
  static const PlaceType takoyaki_restaurant = PlaceType._(192, 'takoyaki_restaurant');
  static const PlaceType syrian_restaurant = PlaceType._(193, 'syrian_restaurant');
  static const PlaceType balinese_restaurant = PlaceType._(194, 'balinese_restaurant');
  static const PlaceType uzbek_restaurant = PlaceType._(195, 'uzbek_restaurant');
  static const PlaceType emilia_romagna_restaurant = PlaceType._(196, 'emilia_romagna_restaurant');
  static const PlaceType egyptian_restaurant = PlaceType._(197, 'egyptian_restaurant');
  static const PlaceType chilean_restaurant = PlaceType._(198, 'chilean_restaurant');
  static const PlaceType yoshoku_restaurant = PlaceType._(199, 'yoshoku_restaurant');
  static const PlaceType javanese_restaurant = PlaceType._(200, 'javanese_restaurant');
  static const PlaceType catalan_restaurant = PlaceType._(201, 'catalan_restaurant');
  static const PlaceType zhejiang_restaurant = PlaceType._(202, 'zhejiang_restaurant');
  static const PlaceType yunnan_restaurant = PlaceType._(203, 'yunnan_restaurant');
  static const PlaceType sukiyaki_restaurant = PlaceType._(204, 'sukiyaki_restaurant');
  static const PlaceType gukbap_restaurant = PlaceType._(205, 'gukbap_restaurant');
  static const PlaceType costa_rican_restaurant = PlaceType._(206, 'costa_rican_restaurant');
  static const PlaceType bengali_or_bangladeshi_restaurant = PlaceType._(207, 'bengali_or_bangladeshi_restaurant');
  static const PlaceType punjabi_restaurant = PlaceType._(208, 'punjabi_restaurant');
  static const PlaceType molecular_gastronomy_restaurant = PlaceType._(209, 'molecular_gastronomy_restaurant');
  static const PlaceType bolivian_restaurant = PlaceType._(210, 'bolivian_restaurant');
  static const PlaceType samgyetang_restaurant = PlaceType._(211, 'samgyetang_restaurant');
  static const PlaceType nabe_restaurant = PlaceType._(212, 'nabe_restaurant');
  static const PlaceType haitian_restaurant = PlaceType._(213, 'haitian_restaurant');
  static const PlaceType guatemalan_restaurant = PlaceType._(214, 'guatemalan_restaurant');
  static const PlaceType ecuadorian_restaurant = PlaceType._(215, 'ecuadorian_restaurant');
  static const PlaceType wagashi_restaurant = PlaceType._(216, 'wagashi_restaurant');
  static const PlaceType ukrainian_restaurant = PlaceType._(217, 'ukrainian_restaurant');
  static const PlaceType shaanxi_restaurant = PlaceType._(218, 'shaanxi_restaurant');
  static const PlaceType sardinian_restaurant = PlaceType._(219, 'sardinian_restaurant');
  static const PlaceType nicaraguan_restaurant = PlaceType._(220, 'nicaraguan_restaurant');
  static const PlaceType xinjiang_restaurant = PlaceType._(221, 'xinjiang_restaurant');
  static const PlaceType uruguayan_restaurant = PlaceType._(222, 'uruguayan_restaurant');
  static const PlaceType shanxi_restaurant = PlaceType._(223, 'shanxi_restaurant');
  static const PlaceType senegalese_restaurant = PlaceType._(224, 'senegalese_restaurant');
  static const PlaceType kushikatsu_restaurant = PlaceType._(225, 'kushikatsu_restaurant');
  static const PlaceType janguh_restaurant = PlaceType._(226, 'janguh_restaurant');
  static const PlaceType gujarati_restaurant = PlaceType._(227, 'gujarati_restaurant');
  static const PlaceType trinidadian_restaurant = PlaceType._(228, 'trinidadian_restaurant');
  static const PlaceType romanian_restaurant = PlaceType._(229, 'romanian_restaurant');
  static const PlaceType paraguayan_restaurant = PlaceType._(230, 'paraguayan_restaurant');
  static const PlaceType panamanian_restaurant = PlaceType._(231, 'panamanian_restaurant');
  static const PlaceType padangnese_restaurant = PlaceType._(232, 'padangnese_restaurant');
  static const PlaceType nigerian_restaurant = PlaceType._(233, 'nigerian_restaurant');
  static const PlaceType monjayaki_restaurant = PlaceType._(234, 'monjayaki_restaurant');
  static const PlaceType marche_restaurant = PlaceType._(235, 'marche_restaurant');
  static const PlaceType macanese_restaurant = PlaceType._(236, 'macanese_restaurant');
  static const PlaceType jiangsu_restaurant = PlaceType._(237, 'jiangsu_restaurant');
  static const PlaceType henan_restaurant = PlaceType._(238, 'henan_restaurant');
  static const PlaceType umbrian_restaurant = PlaceType._(239, 'umbrian_restaurant');
  static const PlaceType tamilian_restaurant = PlaceType._(240, 'tamilian_restaurant');
  static const PlaceType swabian_restaurant = PlaceType._(241, 'swabian_restaurant');
  static const PlaceType parsi_restaurant = PlaceType._(242, 'parsi_restaurant');
  static const PlaceType molise_restaurant = PlaceType._(243, 'molise_restaurant');
  static const PlaceType lombard_restaurant = PlaceType._(244, 'lombard_restaurant');
  static const PlaceType kurdish_restaurant = PlaceType._(245, 'kurdish_restaurant');
  static const PlaceType kerala_restaurant = PlaceType._(246, 'kerala_restaurant');
  static const PlaceType huaiyang_restaurant = PlaceType._(247, 'huaiyang_restaurant');
  static const PlaceType honduran_restaurant = PlaceType._(248, 'honduran_restaurant');
  static const PlaceType hainan_restaurant = PlaceType._(249, 'hainan_restaurant');
  static const PlaceType goan_restaurant = PlaceType._(250, 'goan_restaurant');
  static const PlaceType dongbei_restaurant = PlaceType._(251, 'dongbei_restaurant');
  static const PlaceType dhaba_restaurant = PlaceType._(252, 'dhaba_restaurant');
  static const PlaceType calabrian_restaurant = PlaceType._(253, 'calabrian_restaurant');
  static const PlaceType belizean_restaurant = PlaceType._(254, 'belizean_restaurant');
  static const PlaceType acehnese_restaurant = PlaceType._(255, 'acehnese_restaurant');

  static const $core.List<PlaceType> values = <PlaceType> [
    PLACE_TYPE_UNDEFINED,
    american_restaurant,
    coffee_shop,
    fast_food_restaurant,
    italian_restaurant,
    breakfast_and_brunch_restaurant,
    bar,
    pizza_place,
    seafood_restaurant,
    bakery,
    new_american_restaurant,
    sushi_restaurant,
    mexican_restaurant,
    bar_and_grill,
    ice_cream_shop,
    cafe,
    burger_restaurant,
    family_style_restaurant,
    pub,
    asian_fusion_restaurant,
    sandwich_shop,
    deli,
    caterer,
    diner,
    dessert_shop,
    vegetarian_or_vegan_restaurant,
    barbecue_restaurant,
    steakhouse,
    chinese_restaurant,
    cocktail_bar,
    thai_restaurant,
    wine_bar,
    french_restaurant,
    korean_restaurant,
    smoothie_and_juice_bar,
    european_restaurant,
    mediterranean_restaurant,
    chicken_joint,
    brewery,
    sports_bar,
    japanese_restaurant,
    health_food_restaurant,
    tea_room,
    donut_shop,
    ramen_restaurant,
    food_and_beverage,
    bubble_tea_shop,
    food_truck,
    tapas_bar_and_restaurant,
    gastropub,
    tex_mex_restaurant,
    southern_restaurant,
    pho_restaurant,
    spanish_restaurant,
    food_stand,
    grocery_store,
    greek_restaurant,
    farmers_market,
    cantonese_restaurant,
    beer_bar,
    vietnamese_restaurant,
    middle_eastern_restaurant,
    bagel_shop,
    cupcake_shop,
    indian_restaurant,
    dim_sum_restaurant,
    winery_or_vineyard,
    hawaiian_restaurant,
    poke_restaurant,
    beer_garden,
    asian_restaurant,
    frozen_yogurt_shop,
    soup_restaurant,
    latin_american_restaurant,
    cajun_and_creole_restaurant,
    hot_dog_joint,
    halal_restaurant,
    taiwanese_restaurant,
    candy_store,
    creperie,
    salad_bar,
    filipino_restaurant,
    buffet_restaurant,
    caribbean_restaurant,
    gelato_shop,
    cafeteria,
    peruvian_restaurant,
    southwestern_restaurant,
    comfort_food_restaurant,
    cuban_restaurant,
    gluten_free_restaurant,
    modern_european_restaurant,
    british_restaurant,
    irish_restaurant,
    noodle_house,
    hot_pot_restaurant,
    fish_and_chips_restaurant,
    kosher_restaurant,
    soul_food_restaurant,
    lebanese_restaurant,
    chocolate_shop,
    portuguese_restaurant,
    shaved_ice_shop,
    brazilian_restaurant,
    szechuan_or_sichuan_restaurant,
    wine_or_spirits,
    turkish_restaurant,
    german_restaurant,
    argentinian_restaurant,
    dive_bar,
    taco_restaurant,
    australian_restaurant,
    irish_pub,
    live_and_raw_food_restaurant,
    south_indian_restaurant,
    persian_or_iranian_restaurant,
    fondue_restaurant,
    bed_and_breakfast,
    continental_restaurant,
    whisky_bar,
    teppanyaki_restaurant,
    kebab_shop,
    colombian_restaurant,
    pakistani_restaurant,
    malaysian_restaurant,
    sake_bar,
    indonesian_restaurant,
    belgian_restaurant,
    scandinavian_restaurant,
    theme_restaurant,
    jamaican_restaurant,
    shabu_shabu_restaurant,
    canadian_restaurant,
    hong_kong_restaurant,
    venezuelan_restaurant,
    israeli_restaurant,
    north_indian_restaurant,
    ethiopian_restaurant,
    singaporean_restaurant,
    moroccan_restaurant,
    speakeasy,
    puerto_rican_restaurant,
    neapolitan_restaurant,
    polynesian_restaurant,
    bavarian_restaurant,
    afghan_restaurant,
    shanghainese_restaurant,
    udon_restaurant,
    tuscan_restaurant,
    yakitori_restaurant,
    tiki_bar,
    yakiniku_restaurant,
    roman_restaurant,
    nepalese_restaurant,
    salvadoran_restaurant,
    russian_restaurant,
    african_restaurant,
    cambodian_restaurant,
    mongolian_restaurant,
    eastern_european_restaurant,
    abruzzo_restaurant,
    bunsik_restaurant,
    himalayan_restaurant,
    basque_restaurant,
    tonkatsu_restaurant,
    sicilian_restaurant,
    burmese_restaurant,
    south_african_restaurant,
    soba_restaurant,
    polish_restaurant,
    austrian_restaurant,
    dominican_restaurant,
    bossam_or_jokbal_restaurant,
    drive_in_restaurant,
    swiss_restaurant,
    hungarian_restaurant,
    arabian_restaurant,
    czech_restaurant,
    okonomiyaki_restaurant,
    indo_chinese_restaurant,
    armenian_restaurant,
    hunan_restaurant,
    tempura_restaurant,
    venetian_restaurant,
    unagi_restaurant,
    georgian_restaurant,
    donburi_restaurant,
    kaiseki_restaurant,
    beijing_restaurant,
    sri_lankan_restaurant,
    scottish_restaurant,
    indian_chinese_restaurant,
    takoyaki_restaurant,
    syrian_restaurant,
    balinese_restaurant,
    uzbek_restaurant,
    emilia_romagna_restaurant,
    egyptian_restaurant,
    chilean_restaurant,
    yoshoku_restaurant,
    javanese_restaurant,
    catalan_restaurant,
    zhejiang_restaurant,
    yunnan_restaurant,
    sukiyaki_restaurant,
    gukbap_restaurant,
    costa_rican_restaurant,
    bengali_or_bangladeshi_restaurant,
    punjabi_restaurant,
    molecular_gastronomy_restaurant,
    bolivian_restaurant,
    samgyetang_restaurant,
    nabe_restaurant,
    haitian_restaurant,
    guatemalan_restaurant,
    ecuadorian_restaurant,
    wagashi_restaurant,
    ukrainian_restaurant,
    shaanxi_restaurant,
    sardinian_restaurant,
    nicaraguan_restaurant,
    xinjiang_restaurant,
    uruguayan_restaurant,
    shanxi_restaurant,
    senegalese_restaurant,
    kushikatsu_restaurant,
    janguh_restaurant,
    gujarati_restaurant,
    trinidadian_restaurant,
    romanian_restaurant,
    paraguayan_restaurant,
    panamanian_restaurant,
    padangnese_restaurant,
    nigerian_restaurant,
    monjayaki_restaurant,
    marche_restaurant,
    macanese_restaurant,
    jiangsu_restaurant,
    henan_restaurant,
    umbrian_restaurant,
    tamilian_restaurant,
    swabian_restaurant,
    parsi_restaurant,
    molise_restaurant,
    lombard_restaurant,
    kurdish_restaurant,
    kerala_restaurant,
    huaiyang_restaurant,
    honduran_restaurant,
    hainan_restaurant,
    goan_restaurant,
    dongbei_restaurant,
    dhaba_restaurant,
    calabrian_restaurant,
    belizean_restaurant,
    acehnese_restaurant,
  ];

  static final $core.Map<$core.int, PlaceType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PlaceType valueOf($core.int value) => _byValue[value];

  const PlaceType._($core.int v, $core.String n) : super(v, n);
}

class FoodType extends $pb.ProtobufEnum {
  static const FoodType FOOD_TYPE_UNDEFINED = FoodType._(0, 'FOOD_TYPE_UNDEFINED');
  static const FoodType dessert = FoodType._(1, 'dessert');
  static const FoodType breakfast = FoodType._(2, 'breakfast');
  static const FoodType ice_cream = FoodType._(3, 'ice_cream');
  static const FoodType snack = FoodType._(4, 'snack');
  static const FoodType salad = FoodType._(5, 'salad');
  static const FoodType seafood = FoodType._(6, 'seafood');
  static const FoodType cocktail = FoodType._(7, 'cocktail');
  static const FoodType soup = FoodType._(8, 'soup');
  static const FoodType noodle = FoodType._(9, 'noodle');
  static const FoodType curry = FoodType._(10, 'curry');
  static const FoodType coffee = FoodType._(11, 'coffee');
  static const FoodType wine = FoodType._(12, 'wine');
  static const FoodType beer = FoodType._(13, 'beer');
  static const FoodType pizza = FoodType._(14, 'pizza');
  static const FoodType chicken = FoodType._(15, 'chicken');
  static const FoodType sandwich = FoodType._(16, 'sandwich');
  static const FoodType pastry = FoodType._(17, 'pastry');
  static const FoodType taco = FoodType._(18, 'taco');
  static const FoodType french_fries = FoodType._(19, 'french_fries');
  static const FoodType fried_chicken = FoodType._(20, 'fried_chicken');
  static const FoodType donut = FoodType._(21, 'donut');
  static const FoodType pasta = FoodType._(22, 'pasta');
  static const FoodType sushi = FoodType._(23, 'sushi');
  static const FoodType confectionery = FoodType._(24, 'confectionery');
  static const FoodType bread = FoodType._(25, 'bread');
  static const FoodType dim_sum = FoodType._(26, 'dim_sum');
  static const FoodType shrimp = FoodType._(27, 'shrimp');
  static const FoodType noodle_soup = FoodType._(28, 'noodle_soup');
  static const FoodType street_food = FoodType._(29, 'street_food');
  static const FoodType egg = FoodType._(30, 'egg');
  static const FoodType ramen = FoodType._(31, 'ramen');
  static const FoodType cupcake = FoodType._(32, 'cupcake');
  static const FoodType steak = FoodType._(33, 'steak');
  static const FoodType hors_doeuvre = FoodType._(34, 'hors_doeuvre');
  static const FoodType cookie = FoodType._(35, 'cookie');
  static const FoodType latte = FoodType._(36, 'latte');
  static const FoodType macaron = FoodType._(37, 'macaron');
  static const FoodType oyster = FoodType._(38, 'oyster');
  static const FoodType fish = FoodType._(39, 'fish');
  static const FoodType beef = FoodType._(40, 'beef');
  static const FoodType gyro = FoodType._(41, 'gyro');
  static const FoodType dumpling = FoodType._(42, 'dumpling');
  static const FoodType chow_mein = FoodType._(43, 'chow_mein');
  static const FoodType pancake = FoodType._(44, 'pancake');
  static const FoodType pho = FoodType._(45, 'pho');
  static const FoodType hot_pot = FoodType._(46, 'hot_pot');
  static const FoodType udon = FoodType._(47, 'udon');
  static const FoodType soup_dumpling = FoodType._(48, 'soup_dumpling');
  static const FoodType salmon = FoodType._(49, 'salmon');
  static const FoodType waffle = FoodType._(50, 'waffle');
  static const FoodType nachos = FoodType._(51, 'nachos');
  static const FoodType muffin = FoodType._(52, 'muffin');
  static const FoodType croissant = FoodType._(53, 'croissant');
  static const FoodType scone = FoodType._(54, 'scone');
  static const FoodType risotto = FoodType._(55, 'risotto');
  static const FoodType cheese_fries = FoodType._(56, 'cheese_fries');
  static const FoodType burrito = FoodType._(57, 'burrito');
  static const FoodType cannoli = FoodType._(58, 'cannoli');
  static const FoodType cheesecake = FoodType._(59, 'cheesecake');
  static const FoodType fried_rice = FoodType._(60, 'fried_rice');
  static const FoodType churro = FoodType._(61, 'churro');
  static const FoodType espresso = FoodType._(62, 'espresso');
  static const FoodType lobster_roll = FoodType._(63, 'lobster_roll');
  static const FoodType charcuterie = FoodType._(64, 'charcuterie');
  static const FoodType malasada = FoodType._(65, 'malasada');
  static const FoodType eggs_benedict = FoodType._(66, 'eggs_benedict');
  static const FoodType shaved_ice = FoodType._(67, 'shaved_ice');
  static const FoodType cake = FoodType._(68, 'cake');
  static const FoodType burgers_and_chicken_sandwiches = FoodType._(69, 'burgers_and_chicken_sandwiches');

  static const $core.List<FoodType> values = <FoodType> [
    FOOD_TYPE_UNDEFINED,
    dessert,
    breakfast,
    ice_cream,
    snack,
    salad,
    seafood,
    cocktail,
    soup,
    noodle,
    curry,
    coffee,
    wine,
    beer,
    pizza,
    chicken,
    sandwich,
    pastry,
    taco,
    french_fries,
    fried_chicken,
    donut,
    pasta,
    sushi,
    confectionery,
    bread,
    dim_sum,
    shrimp,
    noodle_soup,
    street_food,
    egg,
    ramen,
    cupcake,
    steak,
    hors_doeuvre,
    cookie,
    latte,
    macaron,
    oyster,
    fish,
    beef,
    gyro,
    dumpling,
    chow_mein,
    pancake,
    pho,
    hot_pot,
    udon,
    soup_dumpling,
    salmon,
    waffle,
    nachos,
    muffin,
    croissant,
    scone,
    risotto,
    cheese_fries,
    burrito,
    cannoli,
    cheesecake,
    fried_rice,
    churro,
    espresso,
    lobster_roll,
    charcuterie,
    malasada,
    eggs_benedict,
    shaved_ice,
    cake,
    burgers_and_chicken_sandwiches,
  ];

  static final $core.Map<$core.int, FoodType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FoodType valueOf($core.int value) => _byValue[value];

  const FoodType._($core.int v, $core.String n) : super(v, n);
}

