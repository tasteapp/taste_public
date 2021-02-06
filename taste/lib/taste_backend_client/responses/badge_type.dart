import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taste/components/icons.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/providers/firebase_user_provider.dart';
import 'package:taste/screens/contest/daily_tasty_badge.dart';
import 'package:taste/screens/create_review/review/legal_taste_tags.dart';
import 'package:taste/screens/create_review/review/taste_tags_picker_page.dart';
import 'package:taste/screens/discover/components/list_comment_widget.dart';
import 'package:taste/screens/map/map_page.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/screens/profile/simple_review_widget.dart';
import 'package:taste/screens/profile/streak_button.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste/utils/posts_list_provider.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart'
    show Badge_BadgeType, Badge_CityChampion_City, DiscoverItem_Comment;

import '../backend.dart';
import '../geocoding_manager.dart';
import '../search_city_champions_page.dart';
import '../tag_search_page.dart';
import '../value_stream_builder.dart';
import 'badge.dart';

const _defaultSize = 40.0;

enum BadgeLevel {
  bronze,
  silver,
  gold,
}

extension BadgeLevelExt on BadgeLevel {
  Widget sizedIcon(double size) => {
        BadgeLevel.bronze: Icon(Icons.stars, color: Colors.brown, size: size),
        BadgeLevel.silver: Icon(Icons.stars, color: Colors.grey, size: size),
        BadgeLevel.gold:
            Icon(Icons.stars, color: const Color(0xFFE9C46A), size: size),
      }[this];
  Widget get icon => sizedIcon(null);
}

typedef _LevelComputer = BadgeLevel Function(Badge badge);

_LevelComputer scoreTiered(int bronze, int silver, int gold) => (b) => {
      BadgeLevel.bronze: bronze,
      BadgeLevel.silver: silver,
      BadgeLevel.gold: gold
    }
        .entries
        .toList()
        .reversed
        .firstWhere((element) => b.countValue >= element.value,
            orElse: () => null)
        ?.key;
final _LevelComputer bronzeBinary =
    (b) => b.countValue > 0 ? BadgeLevel.bronze : null;

class BadgeDetails with EquatableMixin {
  BadgeDetails({
    this.type,
    this.description,
    this.explanation,
    this.sizedIcon,
    this.sortRank,
    this.extraPanel,
    @required this.level,
  });
  final _LevelComputer level;
  final Badge_BadgeType type;
  final String description;
  final String explanation;
  final Widget Function(BuildContext context, Badge badge, TasteUser user)
      extraPanel;
  Widget icon(Badge badge) => sizedIcon(_defaultSize, badge);

  final Widget Function(double size, Badge badge) sizedIcon;
  final int sortRank;

  @override
  List<Object> get props => [type];
}

class StackedIcon extends StatelessWidget {
  const StackedIcon({
    Key key,
    this.main,
    this.secondary,
  }) : super(key: key);

  final Widget secondary;
  final Widget main;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: Stack(alignment: Alignment.bottomRight, children: [
        Align(alignment: Alignment.topLeft, child: main),
        Positioned(bottom: 0, right: 0, child: secondary),
      ]),
    );
  }
}

extension BadgeTypeExtension on Badge_BadgeType {
  BadgeDetails get details => [
        BadgeDetails(
            type: Badge_BadgeType.favorites_cities_total,
            level: scoreTiered(5, 15, 30),
            description: "Cities Favorited",
            explanation: "Boost this badge by adding more "
                "favorites! While you can only add a few favorites per city, "
                "there's a lot of cities out there, so get favoriting!",
            sizedIcon: (s, _) => StackedIcon(
                main: Icon(
                  TrophyIcons.trophy,
                  size: s,
                  color: Colors.amberAccent,
                ),
                secondary: const Icon(
                  Icons.location_city,
                  color: Colors.grey,
                )),
            sortRank: 6),
        BadgeDetails(
          type: Badge_BadgeType.favorites_countries_total,
          level: scoreTiered(2, 5, 10),
          description: "Countries Favorited",
          explanation:
              "Hey 🌎 Traveler! Boost this badge by adding more favorites "
              "across the world. Remember that awesome sashimi spot in Tokyo, "
              "or Carne Asada joint in Mexico City? Add it to your favorites "
              "and watch this badge skyrocket!",
          sizedIcon: (s, _) => StackedIcon(
            main: Icon(
              TrophyIcons.trophy,
              size: s,
              color: Colors.amberAccent,
            ),
            secondary: const Icon(
              Icons.local_airport,
              color: Colors.grey,
            ),
          ),
          sortRank: 7,
        ),
        BadgeDetails(
            type: Badge_BadgeType.post_cities_total,
            level: scoreTiered(5, 15, 30),
            description: "Jet Setter",
            explanation:
                "Boost this badge by posting in more 🌉🌇🌃! Explore nearby "
                "towns, or remember to share on your weekend getaways, and this "
                "badge will level up!",
            sizedIcon: (s, _) => Icon(
                  Icons.local_airport,
                  size: s,
                ),
            sortRank: 4,
            extraPanel: (context, badge, user) => badge.countValue <= 0
                ? null
                : StreamBuilder<List<MapEntry<Badge_CityChampion_City, int>>>(
                    stream: user.restaurantPosts.map((reviews) => reviews
                        .counts((review) => Badge_CityChampion_City()
                          ..city = review.address.city
                          ..state = review.address.state
                          ..country = review.address.country)
                        .entries
                        .sorted((i) => -i.value)
                        .take(6)
                        .toList()),
                    builder: (context, snapshot) => Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: AutoSizeText(
                              "${user.nameAsOwner} Top Cities",
                              maxLines: 1,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          CityCardWrap(user: user, cities: snapshot.data ?? []),
                        ]))),
        BadgeDetails(
          type: Badge_BadgeType.post_countries_total,
          level: scoreTiered(2, 5, 10),
          description: "Countries Posted",
          explanation: "Forget local-vore, you're a uni-vore! Show how 🌏🌎🌍 "
              "you are by posting in each new country you visit while doing "
              "your globe-trotting!",
          sizedIcon: (s, _) => StackedIcon(
              main: Icon(
                Icons.rate_review,
                size: s,
                color: Colors.lightGreenAccent,
              ),
              secondary: const Icon(
                Icons.local_airport,
                color: Colors.grey,
              )),
          sortRank: 5,
        ),
        BadgeDetails(
          type: Badge_BadgeType.streak_active,
          level: scoreTiered(1, 4, 10),
          description: "Hot Streak",
          explanation:
              "You're on 🔥! The number indicates how many weeks in a row you've posted. Keep the streak alive!",
          sizedIcon: (s, badge) =>
              StreakBadgeWidget(badge: badge, badgeSize: s),
          sortRank: -10,
        ),
        BadgeDetails(
          type: Badge_BadgeType.streak_longest,
          level: scoreTiered(2, 8, 15),
          description: "Longest Post-Streak",
          explanation: "This badge shows your longest post-streak ever. "
              "Wear this one with pride!",
          sizedIcon: (s, _) => StackedIcon(
              main:
                  Icon(Icons.whatshot, color: Colors.deepOrangeAccent, size: s),
              secondary: Icon(
                Icons.history,
                size: s / 2,
                color: Colors.grey,
              )),
          sortRank: 1,
        ),
        BadgeDetails(
            type: Badge_BadgeType.commenter_level_1,
            level: scoreTiered(3, 15, 50),
            description: "Chatty Cathy",
            explanation: "Hey Chatterbox! Leave some comments on your "
                "friend's posts to level-up this badge!",
            sizedIcon: (s, _) =>
                Icon(Icons.comment, color: kTasteBrandColorRight, size: s),
            sortRank: 3,
            extraPanel: (context, badge, user) => badge.countValue <= 0
                ? null
                : StreamBuilder<
                        List<ZipTuple<DiscoverItem_Comment, DiscoverItem>>>(
                    // Grab user comments, find their parent discover items, then
                    // take out only those comments owned by the user.
                    // This seems backwards but gives us access to the
                    // DiscoverItem view of the comments.
                    stream: CollectionType.comments.coll
                        .orderBy('_extras.created_at', descending: true)
                        .forUser(user.reference)
                        .limit(15)
                        .stream<Comment>()
                        // Grab the corresponding discover item.
                        .asyncMap((c) => c
                            .map((c) => c.parent)
                            .toSet()
                            .futureMap((t) => discoverItem(t).first))
                        // Grab the user's comments inside item
                        .map((items) => items
                            .expand((item) => item.proto.comments
                                .where((c) =>
                                    c.user.reference.ref == user.reference)
                                .zipWith((_) => item))
                            .take(5)
                            .toList()),
                    builder: (context, snapshot) {
                      return Column(
                          children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: AutoSizeText(
                            "${user.nameAsOwner} Recent Comments",
                            maxLines: 1,
                            style: const TextStyle(fontSize: 18),
                          ),
                        )
                      ]
                              .followedBy((snapshot.data ?? [])
                                  .sorted((a) => -a.a.date.seconds)
                                  .take(4)
                                  .map((e) => ListCommentWidget(
                                      key: e.b.key, item: e.b, comment: e.a)))
                              .toList());
                    })),
        BadgeDetails(
            type: Badge_BadgeType.emoji_flags_level_1,
            level: scoreTiered(3, 8, 20),
            description: "Flag Bearer",
            explanation:
                "You can now add 'Cuisine' Countries on post to show how "
                "multi-lingual your taste-tongue is! Tag at least 3 posts with "
                "different Cuisine Flags (like 🇺🇸,🇨🇳,🇦🇫) to level-up "
                "Flag Bearer!.",
            sizedIcon: (s, _) =>
                Icon(Icons.flag, color: kTasteBrandColorRight, size: s),
            sortRank: 2,
            extraPanel: (context, badge, user) => badge.countValue <= 0
                ? null
                : Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AutoSizeText(
                          "${user.nameAsOwner} Cuisine Flags",
                          maxLines: 1,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: badge.proto.emojiFlags.flags
                              .map((e) => FlatButton(
                                    onPressed: () =>
                                        TagSearchPage.goTo(context, e),
                                    child: TasteTagTile(
                                      emoji: e,
                                      subtitle: kCountryTasteTagsMap[e],
                                    ),
                                  ))
                              .toList()),
                    ],
                  )),
        BadgeDetails(
            type: Badge_BadgeType.socialite,
            level: scoreTiered(1, 5, 15),
            description: "Socialite",
            explanation:
                "Hey Socialite! As Kim and Paris know, eating out is more fun "
                "with friends. You can now tag friends on your posts to loop "
                "them in on the post's conversation. Tag a friend (or two!) on "
                "your next post to level-up this uber-elite badge.",
            sizedIcon: (s, _) => Icon(Icons.people, size: s),
            sortRank: 2,
            extraPanel: (context, badge, user) => badge.countValue <= 0
                ? null
                : Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AutoSizeText(
                          "${user.nameAsOwner} Meal Mates",
                          maxLines: 1,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: badge.proto.matchingReferences
                              .listMap((e) => ActionChip(
                                  onPressed: () async => goToUserProfile(e.ref),
                                  avatar: ProfilePhoto(user: e.ref),
                                  label: StreamBuilder<TasteUser>(
                                      stream: e.ref.stream(),
                                      builder: (context, snapshot) {
                                        return Text(snapshot.data?.username ??
                                            snapshot.data?.name ??
                                            '');
                                      }))))
                    ],
                  )),
        BadgeDetails(
            type: Badge_BadgeType.herbivore,
            level: scoreTiered(1, 5, 15),
            description: "Herbivore",
            explanation: "Even The Terminator's on the vegan bandwagon! Add a "
                "plant-friendly Taste-Tag to your next post to showcase "
                "your 🌿-pride",
            sizedIcon: (s, _) => Text('🌿', style: TextStyle(fontSize: s)),
            sortRank: 2,
            extraPanel: (context, badge, user) =>
                badge.proto.matchingReferences.isEmpty
                    ? null
                    : ReviewScrollerBadgeWidget(
                        badge: badge, user: user, header: "Veggie Posts")),
        BadgeDetails(
            type: Badge_BadgeType.burgermeister,
            level: scoreTiered(1, 3, 8),
            description: "Burgermeister",
            explanation: "Artisinal, kobe beef, gruyere? Whopper Big-mac, "
                "american slice? You don't care! Just burger-me. "
                "Add any burger Auto-Tag to your next burger post to level up!",
            sizedIcon: (s, _) => Text('🍔', style: TextStyle(fontSize: s)),
            sortRank: 2,
            extraPanel: (context, badge, user) =>
                badge.proto.matchingReferences.isEmpty
                    ? null
                    : ReviewScrollerBadgeWidget(
                        badge: badge, user: user, header: "Burger Posts")),
        BadgeDetails(
            type: Badge_BadgeType.sushinista,
            level: scoreTiered(1, 3, 8),
            description: "Sushinista",
            explanation: "Dragon, Cali, Spicy Tuna: You're on a roll! Level-up "
                "Sushinista by Auto-Tagging or Taste-Tagging your next "
                "sushi post.",
            sizedIcon: (s, _) => Text('🍣', style: TextStyle(fontSize: s)),
            sortRank: 2,
            extraPanel: (context, badge, user) =>
                badge.proto.matchingReferences.isEmpty
                    ? null
                    : ReviewScrollerBadgeWidget(
                        badge: badge, user: user, header: "Sushi Posts")),
        BadgeDetails(
            type: Badge_BadgeType.regular,
            level: scoreTiered(2, 4, 8),
            description: 'The "Regular"',
            explanation:
                "Shine on you creature of habit! You've got your favorite spot "
                "you hit up weekly, why not show off your pride by posting "
                "every darn time you go there.\n\nLevel-up by multi-posting the "
                "restaurant you're the 'Regular' at.",
            sizedIcon: (s, _) => Icon(Icons.star, size: s),
            sortRank: 2,
            extraPanel: (context, badge, user) =>
                badge.proto.matchingReferences.isEmpty
                    ? null
                    : ReviewScrollerBadgeWidget(
                        badge: badge,
                        user: user,
                        header: 'Regular Spot',
                        reviews: badge.proto.matchingReferences.first.ref
                            .stream<Restaurant>()
                            .switchMap((r) => r.reviews)
                            .map((r) => r
                                .where((r) => r.userReference == user.reference)
                                .toList()),
                      )),
        BadgeDetails(
            type: Badge_BadgeType.brainiac,
            level: scoreTiered(1, 4, 10),
            description: "Brainiac",
            explanation:
                "We use a fleet of robo-Tasters to guess what you're eating in "
                "your posts. Add one of these *Auto Tags* on your next post to "
                "unlock this badge.",
            sizedIcon: (s, _) =>
                Image.asset('./assets/ui/brain.png', height: s, width: s),
            sortRank: -1,
            extraPanel: (context, badge, user) => badge.countValue <= 0
                ? null
                : Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AutoSizeText(
                          "${user.nameAsOwner} Auto-tags",
                          maxLines: 1,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: badge.proto.brainiacInfo.attributes
                              .map((a) => ActionChip(
                                  onPressed: () =>
                                      TagSearchPage.goTo(context, a),
                                  avatar: const Icon(Icons.lightbulb_outline),
                                  label: Text(a)))
                              .toList())
                    ],
                  )),
        BadgeDetails(
            type: Badge_BadgeType.ramsay,
            level: scoreTiered(1, 3, 10),
            description: "Chef",
            explanation:
                "Did you know Taste lets you show off your home-cooked meals? "
                "Post your next one (and make sure to hit the Taste-Apron icon "
                "while posting!) to level-up the chef badge!",
            sizedIcon: (s, _) =>
                Image.asset('./assets/ui/chefs_hat.png', height: s, width: s),
            sortRank: 1,
            extraPanel: (context, badge, user) => badge.countValue <= 0
                ? null
                : ReviewScrollerBadgeWidget(
                    badge: badge,
                    user: user,
                    header: "Home Meals",
                    reviews: user.homeMeals)),
        BadgeDetails(
            type: Badge_BadgeType.daily_tasty,
            level: scoreTiered(1, 2, 4),
            description: "Daily Tasty",
            explanation:
                "Who needs a Pomme d'Or, you can't even eat it! While the Daily Tasty might not hold the same cachet in Cannes, it's GOLD around here! Win a Daily Tasty by being voted top post of the day on Taste.",
            sizedIcon: (s, _) =>
                DailyTastyBadgeInner(size: s / 2, twoLines: true),
            sortRank: -99999,
            extraPanel: (context, badge, user) => badge.countValue <= 0
                ? null
                : ReviewScrollerBadgeWidget(
                    badge: badge,
                    user: user,
                    header: "Daily Tasties",
                    reviews: user.myDailyTastys)),
        BadgeDetails(
            type: Badge_BadgeType.black_owned_restaurant_post,
            level: scoreTiered(2, 6, 15),
            description: "Black Owned Diner",
            explanation:
                "Like to show your support for Black owned businesses? "
                "Well that doesn't go unnoticed here at Taste 🖤.\n\nMake "
                "posts from Black owned restaurants to level up on this badge.",
            sizedIcon: (s, _) => Container(
                height: s,
                width: s,
                child: Image.asset('assets/ui/black_power.png')),
            sortRank: -99999,
            extraPanel: (context, badge, user) => badge.countValue <= 0
                ? null
                : ReviewScrollerBadgeWidget(
                    badge: badge,
                    user: user,
                    header: "Black Owned Diner Posts",
                    reviews: user.borReviews)),
        BadgeDetails(
            type: Badge_BadgeType.quarantine,
            level: scoreTiered(1, 4, 10),
            description: "Homebody",
            explanation:
                "Post all your home-delivered (hit the 'Delivery' Taste-tag while posting) and home-cooked meals on Taste. We'll send awesome prizes to weekly winners!",
            sizedIcon: (s, _) => Text('🏠', style: TextStyle(fontSize: s)),
            sortRank: -9999,
            extraPanel: (context, badge, user) =>
                badge.proto.matchingReferences.isEmpty
                    ? null
                    : ReviewScrollerBadgeWidget(
                        badge: badge, user: user, header: "Homebody Posts")),
        BadgeDetails(
            type: Badge_BadgeType.character,
            level: scoreTiered(1, 15, 40),
            description: "Celebrity Spirit Food",
            explanation:
                "Spirit-animals are worn out... Express yourself through your Celebrity-Spirit-Food instead! Each post might unlock your newest spirit, so keep sharing!",
            sizedIcon: (s, b) {
              final spirit = foodlebrity(b);
              return FoodSpiritIcon(spirit: spirit, size: s * 1.3);
            },
            sortRank: -100,
            extraPanel: (context, badge, user) => badge.countValue <= 0
                ? null
                : Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AutoSizeText(
                          "${user.isMe ? 'My' : '${user.name}\'s  Unlocked'} Spirit Foods",
                          maxLines: 1,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: foodlebrities
                            .where((element) =>
                                element.score < 1000 &&
                                (element.score > 0 ||
                                    foodlebrities.length <= 1))
                            .where((e) =>
                                user.isMe || (e.score <= badge.countValue))
                            .map((e) => FoodSpiritIcon(
                                key: Key(e.assetKey),
                                spirit: e,
                                size: 85,
                                clickable: true))
                            .toList(),
                      ),
                    ],
                  )),
        BadgeDetails(
            type: Badge_BadgeType.city_champion,
            level: scoreTiered(1, 5, 15),
            description: "City Guv'nah",
            explanation:
                "Cheers Guv'nah! Become the sole guv'nah of a city by having its most high-quality reviews. You can have an unlimited number of Guv'nah-ships, but you'll probably have to upgrade your giant, ribbon-cutting scissor closet.",
            sizedIcon: (s, _) => Text('🎩', style: TextStyle(fontSize: s)),
            sortRank: 0,
            extraPanel: (context, badge, user) => Column(
                  children: <Widget>[
                    OutlineButton.icon(
                      textTheme: ButtonTextTheme.primary,
                      onPressed: () => quickPush(TAPage.search_city_champions,
                          (context) => SearchCityChampionsPage()),
                      label: const Text("Search for Guv'nah by City"),
                      icon: const Icon(Icons.search),
                    ),
                    if (badge.proto.cityChampionData.cities.isEmpty)
                      null
                    else
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: AutoSizeText(
                              "${user.nameAsOwner} Guv'nah Cities",
                              maxLines: 1,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          CityCardWrap(
                              user: user,
                              cities: badge.proto.cityChampionData.cities
                                  .map((c) => MapEntry(c, null))
                                  .toList()),
                        ],
                      ),
                  ].withoutNulls,
                )),
      ].asMap().map((_, v) => MapEntry(v.type, v))[this];
}

class CityCardWrap extends StatelessWidget {
  const CityCardWrap({
    Key key,
    @required this.cities,
    @required this.user,
  }) : super(key: key);
  final List<MapEntry<Badge_CityChampion_City, int>> cities;
  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: cities.map((entry) {
        final city = entry.key;
        final count = entry.value;
        return Card(
            elevation: 5,
            margin: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 75,
                  child: InkWell(
                      onTap: () async {
                        final location = await spinner(() => getLocation(
                            city: city.city, country: city.country));
                        if (location == null) {
                          return;
                        }
                        TAEvent.city_champ_tile_tap({
                          'other_user': user.reference.path,
                          'city': city.city,
                          'state': city.state,
                          'country': city.country,
                          'lat': location.latitude,
                          'lng': location.longitude,
                        });
                        await quickPush(
                            TAPage.map_root,
                            (context) => MapPage(
                                  initialLocation: location,
                                  initialZoom: 13,
                                  jumpAfter: false,
                                ));
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: AutoSizeText(city.summary,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              wrapWords: false,
                              minFontSize: 6,
                              maxFontSize: 18,
                              style: const TextStyle(fontSize: 18)),
                        ),
                      )),
                ),
                if (count == null)
                  null
                else
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '$count ${count == 1 ? 'Post' : 'Posts'}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                        fontSize: 9,
                      ),
                    ),
                  ),
              ].withoutNulls,
            ));
      }).toList(),
    );
  }
}

class FoodSpiritIcon extends StatelessWidget {
  FoodSpiritIcon({
    Key key,
    @required FoodSpirit spirit,
    @required this.size,
    this.clickable = false,
    this.alignment = Alignment.bottomCenter,
  })  : spirit = spirit ?? foodlebrities.first,
        super(key: key);

  final FoodSpirit spirit;
  final double size;
  final Alignment alignment;
  final bool clickable;

  @override
  Widget build(BuildContext context) {
    return ValueStreamBuilder<FoodSpirit>(
        stream: foodSpiritStream.valueMap((a) => a.a),
        builder: (context, snapshot) {
          final locked = (snapshot.data?.score ?? 0) < spirit.score;
          return GestureDetector(
            onTap: !clickable || !locked
                ? null
                : () => showDialog(
                    context: context,
                    useRootNavigator: false,
                    builder: (context) => TasteDialog(
                          title: locked ? "Locked Food Spirit" : spirit.name,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (locked)
                                const Text(
                                  "Keep posting your meals on Taste to unlock this Food Spirit",
                                  textAlign: TextAlign.center,
                                )
                              else
                                null,
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: FoodSpiritIcon(
                                    spirit: spirit,
                                    size: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.5),
                              )
                            ].withoutNulls,
                          ),
                          buttons: [
                            TasteDialogButton(
                                text: 'Ok',
                                onPressed: () => Navigator.pop(context)),
                          ],
                        )),
            child: Stack(
              alignment: alignment,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: alignment.y == -1 ? size / 12 : 0,
                    bottom: alignment.y == 1 ? size / 4 : 0,
                  ),
                  child: Card(
                    elevation: 5,
                    shape: const CircleBorder(),
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: size / 2,
                          child: spirit?.name?.isEmpty ?? false
                              ? Text("?",
                                  style: TextStyle(fontSize: size * 0.8))
                              : null,
                        ),
                        if (spirit?.name?.isEmpty ?? true)
                          null
                        else
                          Image.asset(spirit.assetPath,
                              width: size, height: size, fit: BoxFit.contain),
                        if (locked)
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(size / 2 - 1),
                              child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 7.5, sigmaY: 7.5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.4)),
                                    child: Center(
                                        child: Text("?",
                                            style:
                                                TextStyle(fontSize: size / 2))),
                                  )),
                            ),
                          )
                        else
                          const SizedBox(height: 0, width: 0)
                      ].withoutNulls,
                    ),
                  ),
                ),
                Visibility(
                  visible: !locked,
                  child: Container(
                    width: size,
                    child: AutoSizeText(spirit?.name ?? "",
                        maxLines: 2,
                        maxFontSize: 26,
                        minFontSize: 7,
                        wrapWords: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size / 6,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

const badgeWhitelist = {
  Badge_BadgeType.post_cities_total,
  Badge_BadgeType.commenter_level_1,
  Badge_BadgeType.emoji_flags_level_1,
  Badge_BadgeType.streak_active,
  Badge_BadgeType.socialite,
  Badge_BadgeType.herbivore,
  Badge_BadgeType.regular,
  Badge_BadgeType.ramsay,
  Badge_BadgeType.sushinista,
  Badge_BadgeType.burgermeister,
  Badge_BadgeType.brainiac,
  Badge_BadgeType.character,
  Badge_BadgeType.city_champion,
  Badge_BadgeType.quarantine,
  Badge_BadgeType.daily_tasty,
  Badge_BadgeType.black_owned_restaurant_post,
};

class FoodSpirit {
  const FoodSpirit(this.score, this.assetKey, this.name);
  final int score;
  final String assetKey;
  final String name;
  String get assetPath => 'assets/characters/$assetKey.png';
  @override
  String toString() => ['Food Spirit', score, assetKey, name].join(', ');
}

const foodlebrities = [
  FoodSpirit(0, 'lox', ''),
  FoodSpirit(1, 'salma', 'Salmon Hayek'),
  FoodSpirit(4, 'judy', 'Fudge Judy'),
  FoodSpirit(8, 'jason', 'Jason Mimosa'),
  FoodSpirit(16, 'paak', 'Anderson SnackPaak'),
  FoodSpirit(30, 'randy', 'Machoman Randy Cabbage'),
  FoodSpirit(1000, 'fka', 'FKA Figs'),
  FoodSpirit(1000, 'selena', 'Selena Quesadilla'),
  FoodSpirit(1000, 'maple', 'M. Brian Maple Syrup'),
  FoodSpirit(1000, 'roberto', 'Roberto Durazno'),
  FoodSpirit(1000, 'elvis', 'Elvis Parsley'),
  FoodSpirit(1000, 'michelle', 'Michelle Wiener'),
  FoodSpirit(1000, 'steve', 'Steve Torte'),
];

FoodSpirit foodlebrity(Badge badge) => badge == null
    ? null
    : badge.type != Badge_BadgeType.character
        ? null
        : foodlebrities.reversed
                .firstWhere((element) => element.score <= badge.countValue) ??
            foodlebrities.first;

class ReviewScrollerBadgeWidget extends StatelessWidget {
  const ReviewScrollerBadgeWidget(
      {Key key,
      @required this.badge,
      @required this.user,
      @required this.header,
      this.reviews})
      : super(key: key);
  final Badge badge;
  final TasteUser user;
  final String header;
  final Stream<List<Post>> reviews;
  String get widgetHeader => "${user.nameAsOwner} $header";

  @override
  Widget build(BuildContext context) => Container(
        height: 310,
        padding: const EdgeInsets.all(8),
        child: StreamBuilder<List<Post>>(
            stream: reviews ??
                badge.proto.matchingReferences
                    .futureMap((r) => reviewDiscoverItem(r.ref).first)
                    .asStream(),
            initialData: const [],
            builder: (context, snapshot) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(widgetHeader,
                            style: const TextStyle(fontSize: 24),
                            minFontSize: 16,
                            maxFontSize: 24,
                            maxLines: 1),
                      ),
                      Expanded(
                        child: PostsListProvider(
                          posts: snapshot.data ?? [],
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data?.enumerate
                                      ?.entryMap((i, d) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: SimpleReviewWidget(
                                                key: ValueKey(d), review: d),
                                          ))
                                      ?.toList() ??
                                  []),
                        ),
                      )
                    ])),
      );
}

final foodSpiritStream = tasteFirebaseUser
    .switchMap((user) => user.maybeWhen(
          user: (user) => CollectionType.badges.coll
              .forUser('users/${user.uid}'.ref)
              .where('type', isEqualTo: 'character')
              .limit(1)
              .stream<Badge>()
              .map((x) => x.firstOrNull)
              .withoutNulls
              .map(foodlebrity)
              .map((x) => x.tupled(user)),
          orElse: () => Stream.value(null),
        ))
    .shareValue()
      ..subscribe;
