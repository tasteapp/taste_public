import 'package:quiver/iterables.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'badge.g.dart';

final characterStartDate = DateTime.parse('2020-03-19');
final quarantineStartDate = DateTime.parse('2020-03-19');

Map<String, dynamic> _addCount(Map<String, dynamic> mainPayload, int count) =>
    (Map<String, dynamic>.from(mainPayload)..addAll(countBadgeWrap(count)))
        .ensureAs(Badges.emptyInstance);
Map<String, dynamic> _matchingReferencesPayload(
        Iterable<DocumentReference> references) =>
    {'matching_references': references.toList()};
Map<String, dynamic> _matchingReferencesPayloadCount(
        Iterable<DocumentReference> references) =>
    _addCount(_matchingReferencesPayload(references), references.length);

int commentsBadge(List<Comment> comments) => comments.length;
Map<String, dynamic> emojiFlags(List<Review> reviews) {
  final flags =
      reviews.expand((r) => r.emojis).toSet().intersection(flagEmojis);
  return _addCount(
      {
        'emoji_flags': {'flags': flags}
      },
      min([
        flags.length,
        reviews
            .where((r) => r.emojis.intersection(flagEmojis).isNotEmpty)
            .length
      ]));
}

int hotStreak(List<Review> reviews) => DateTime.now()
    .difference([DateTime.now()]
            .followedBy(reviews.reversed.map((r) => r.createdAt.toDateTime()))
            .pair
            .takeWhile((i) => i.a.difference(i.b) <= week)
            .map((i) => i.b)
            .lastOrNull ??
        DateTime.now())
    .inWeeks;
Map<String, dynamic> quarantine(List<Review> reviews) {
  final matches = reviews.where((review) =>
      review.createdAt.toDateTime().isAfter(quarantineStartDate) &&
      (review.isHome ||
          review.emojis
              .toSet()
              .intersection({'#quarantine', '#delivery'}).isNotEmpty));
  return _addCount(
      _matchingReferencesPayload(matches.map((e) => e.ref)),
      matches
          .groupBy((value) =>
              value.createdAt
                  .toDateTime()
                  .difference(quarantineStartDate)
                  .inHours ~/
              3)
          .length);
}

Map<String, dynamic> cityChampion(Iterable<City> cities) => _addCount({
      'city_champion_data': {'cities': cities.map((city) => city.json).toList()}
    }, cities.length);
int character(List<Review> reviews) => reviews
    .where((review) =>
        review.createdAt
            .toDateTime()
            .difference(characterStartDate)
            .inSeconds >=
        0)
    .where((review) => !review.isInstagramImport)
    .groupBy((review) => [
          review.createdAt.toDateTime().difference(characterStartDate).inDays,
          review.isHome ? 'home' : review.proto.restaurant.ref,
        ].join(','))
    .length;
Map<String, dynamic> brainiac(List<Review> reviews) {
  final posts = reviews.where((r) => r.proto.attributes.isNotEmpty).length;
  final attributes = reviews.expand((r) => r.proto.attributes).toSet();
  return _addCount({
    'brainiac_info': {'attributes': attributes}
  }, posts);
}

Map<String, dynamic> dailyTastyBadge(List<Review> reviews) =>
    _matchingReferencesPayloadCount(
        reviews.where((r) => r.hasDailyTasty).map((e) => e.ref));

Future<Map<String, dynamic>> blackOwnedRestaurantBadge(List<Review> reviews,
    [FutureOr<bool> Function(Review review) isBlackOwned]) async {
  isBlackOwned ??= (r) async => (await r.restaurant)?.blackOwned ?? false;
  final blackOwnedReviews = <Review>[];
  for (final review in reviews) {
    if (await isBlackOwned(review)) {
      blackOwnedReviews.add(review);
    }
  }
  return _matchingReferencesPayloadCount(blackOwnedReviews.map((e) => e.ref));
}

Map<String, dynamic> burgermeister(List<Review> reviews) =>
    _matchingReferencesPayloadCount(reviews
        .where((r) =>
            r.proto.attributes.any((a) => a.toLowerCase().contains('burger')))
        .map((e) => e.ref));
Map<String, dynamic> sushinista(List<Review> reviews) =>
    _matchingReferencesPayloadCount(reviews
        .where((r) =>
            r.proto.emojis.toSet().intersection({'🍣'}).isNotEmpty ||
            r.proto.attributes.any((a) => {
                  'sushi',
                  'california roll',
                  'salmon roll',
                  'sashimi',
                }.any(
                    (other) => a.toLowerCase().contains(other.toLowerCase()))))
        .map((e) => e.ref));
Map<String, dynamic> herbivore(List<Review> reviews) =>
    _matchingReferencesPayloadCount(reviews
        .where((r) =>
            r.proto.emojis.toSet().intersection(
                {'🥬', '🥗', '🌿', '#veggie', '#vegan'}).isNotEmpty ||
            r.proto.attributes.any((a) => {
                  'vegan',
                  'vegetarian',
                }.any(
                    (other) => a.toLowerCase().contains(other.toLowerCase()))))
        .map((e) => e.ref));
Map<String, dynamic> theRegular(List<Review> reviews) {
  final match = reviews
      .where((review) => review.isRestaurant)
      .groupBy((review) => review.proto.restaurant)
      .entries
      .zipWith((restoReviews) => restoReviews.value.count((r) =>
          r.createdAt.toDateTime().difference(DateTime.now()).inDays ~/ 2))
      .max((a) => a.b);
  return (match?.b ?? 0) < 2
      ? countBadgeWrap(0)
      : _addCount(_matchingReferencesPayload([match.a.key.ref]), match.b);
}

Map<String, dynamic> socialite(List<Review> reviews) {
  final count = reviews.where((r) => r.proto.mealMates.isNotEmpty).length;
  final mates =
      reviews.expand((r) => r.proto.mealMates).map((e) => e.ref).toSet();
  return _addCount(_matchingReferencesPayload(mates), count);
}

Map<String, dynamic> ramsay(List<Review> reviews) =>
    _matchingReferencesPayloadCount(
        reviews.where((r) => r.isHome).map((e) => e.ref));

@RegisterType()
mixin Badge on FirestoreProto<$pb.Badge>, UserOwned {
  static Future<Badge> updateBadge(
          BatchedTransaction transaction,
          TasteUser user,
          $pb.Badge_BadgeType type,
          Map<String, dynamic> payload,
          {BadgeIndex index}) =>
      (index ?? BadgeIndex._(transaction: transaction))
          .update(user, type, payload);

  Future<Badge> updatePayload(Map<String, dynamic> payload) async {
    await transaction.set(
        ref, payload.ensureAs(Badges.emptyInstance).documentData,
        merge: true);
    return this;
  }

  static void registerInternal() {
    // final fn = tasteFunctions.pubsub
    //     .schedule('every 24 hours')
    //     .onRun((message, context) => updateBadges());
    // registerFunction('update_badges', fn, fn);
  }

  int get value => proto.countData.count;
}

class BadgeKey with EquatableMixin {
  final DocumentReference reference;
  final $pb.Badge_BadgeType type;

  BadgeKey(this.reference, this.type);

  @override
  List<Object> get props => [reference, type];
}

class BadgeIndex {
  final BatchedTransaction transaction;
  final Map<BadgeKey, Badge> _index;

  BadgeIndex._({this.transaction, final Map<BadgeKey, Badge> index})
      : _index = index;
  DocumentReference get _newReference => Badges.collectionType.coll.document();
  Future<Badge> update(TasteUser user, $pb.Badge_BadgeType type,
      Map<String, dynamic> payload) async {
    return await (await () async {
          if (_index != null) {
            return _index[BadgeKey(user.ref, type)];
          }
          return (await Badges.get(
                  trans: transaction,
                  queryFn: (q) => q
                      .where('user', isEqualTo: user.ref)
                      .where('type', isEqualTo: type.name)
                      .limit(1)))
              ?.firstOrNull;
        }())
            ?.updatePayload(payload) ??
        await _createBadge(user, type, payload);
  }

  Future<Badge> _createBadge(TasteUser user, $pb.Badge_BadgeType type,
      Map<String, dynamic> payload) async {
    final data = ({
      'user': user.ref,
      'type': type,
    }..addAll(payload))
        .ensureAs(Badges.emptyInstance)
        .documentData;
    final reference = _newReference;
    await transaction.set(reference, data);
    return Badges.makeSimple(data, reference, transaction);
  }
}

Future<BadgeIndex> batchBadgeIndex(BatchedTransaction transaction) async =>
    BadgeIndex._(
        transaction: transaction,
        index: (await Badges.get(trans: transaction))
            .groupBy((t) => BadgeKey(t.proto.user.ref, t.proto.type))
            .mapValue((key, badges) {
          badges.skip(1).forEach((badge) => badge.deleteSelf());
          return badges.first;
        }));

extension<T> on List<T> {
  int count(Object Function(T input) key) => map(key)
      .toSet()
      .where((s) => (s is! String) || ((s as String)?.isNotEmpty ?? false))
      .length;
}

Future updateBadges() => autoBatch((batch) async {
      final badgeIndex = await batchBadgeIndex(batch);

      final dump = await BatchDump.fetch(batch, {
        CollectionType.users,
        CollectionType.comments,
        CollectionType.reviews,
        CollectionType.favorites,
        CollectionType.home_meals,
      });
      final _favoritedRestaurants = (await dump
              .typed<Favorite>()
              .distinctOn((t) => t.restaurantRef)
              .futureMap(
                  (t) async => MapEntry(dump.owner(t), await t.restaurant)))
          .multiMap
          .mapValue((k, v) => v.toList());
      final favoritedRestaurants =
          (BatchDumpUserRecord u) => _favoritedRestaurants[u.user] ?? [];

      final cityChampions = dump.reviews
          .expand((review) {
            final city = review.proto.address.city;
            final country = review.proto.address.country;
            final state = review.proto.address.state;
            return [
              City(city, country, state),
              City('', country, ''),
              country == 'United States' ? City('', country, state) : null,
            ].withoutNulls.zipWith((_) => review);
          })
          .groupBy((pair) => pair.a)
          .mapValue((city, pairs) => pairs
              .map((p) => p.b)
              .groupBy((review) => review.userReference)
              .mapValue(
                  (_, reviews) => reviews.map((review) => review.score).sum)
              .maxByValue
              .key)
          .invert
          .rekey(dump.user);

      final blackOwnedRestos = (await Restaurants.get(
              trans: batch,
              queryFn: (q) =>
                  q.where('attributes.black_owned', isEqualTo: true)))
          .map((e) => e.ref)
          .toSet();

      // Define the badge computations.
      String cityString($pb.Restaurant_Attributes_Address add) =>
          '${add.city}, ${add.country}';
      final badges =
          <$pb.Badge_BadgeType, Function(BatchDumpUserRecord record)>{
        $pb.Badge_BadgeType.city_champion: (record) =>
            cityChampion(cityChampions[record.user] ?? []),
        $pb.Badge_BadgeType.character: (record) => character(record.reviews),
        $pb.Badge_BadgeType.daily_tasty: (record) =>
            dailyTastyBadge(record.reviews),
        $pb.Badge_BadgeType.black_owned_restaurant_post: (record) =>
            blackOwnedRestaurantBadge(record.reviews,
                (r) => blackOwnedRestos.contains(r.restaurantRef)),
        $pb.Badge_BadgeType.herbivore: (record) => herbivore(record.reviews),
        $pb.Badge_BadgeType.socialite: (record) => socialite(record.reviews),
        $pb.Badge_BadgeType.ramsay: (record) => ramsay(record.reviews),
        $pb.Badge_BadgeType.brainiac: (record) => brainiac(record.reviews),
        $pb.Badge_BadgeType.burgermeister: (record) =>
            burgermeister(record.reviews),
        $pb.Badge_BadgeType.sushinista: (record) => sushinista(record.reviews),
        $pb.Badge_BadgeType.regular: (record) => theRegular(record.reviews),
        $pb.Badge_BadgeType.commenter_level_1: (record) =>
            commentsBadge(record.comments),
        $pb.Badge_BadgeType.emoji_flags_level_1: (record) =>
            emojiFlags(record.reviews),
        $pb.Badge_BadgeType.favorites_cities_total: (record) =>
            favoritedRestaurants(record)
                .count((r) => cityString(r.proto.attributes.address)),
        $pb.Badge_BadgeType.favorites_countries_total: (record) =>
            favoritedRestaurants(record)
                .count((r) => r.proto.attributes.address.country),
        $pb.Badge_BadgeType.post_cities_total: (record) =>
            record.reviews.count((r) => cityString(r.proto.address)),
        $pb.Badge_BadgeType.post_countries_total: (record) =>
            record.reviews.count((r) => r.proto.address.country),
        $pb.Badge_BadgeType.streak_longest: (record) => record.reviews.isEmpty
            ? 0
            : (record.reviews.map((r) => r.createdAt.toDateTime()).fold(
                    [const Duration(days: 1), longTimeAgo, longTimeAgo],
                    (a, date) => date.difference(a[2] as DateTime) > week
                        ? [a[0], date, date]
                        : [
                            max([
                              a[0] as Duration,
                              date.difference(a[1] as DateTime)
                            ]),
                            a[1],
                            date
                          ])[0] as Duration)
                .inWeeks,
        $pb.Badge_BadgeType.streak_active: (record) =>
            hotStreak(record.reviews),
        $pb.Badge_BadgeType.quarantine: (record) => quarantine(record.reviews),
      };

      // Group all the data by user and compute all badges for all users, while
      // using the batch-transaction mechanism to auto-commit every 500 records.
      for (final record in dump.userRecords.values) {
        for (final badgeEntry in badges.entries) {
          await Badge.updateBadge(
            batch,
            record.user,
            badgeEntry.key,
            // Some of the badge resolution functions return Futures.
            genericBadgeWrap(await badgeEntry.value(record)),
            index: badgeIndex,
          );
        }
      }
    });

Map<String, dynamic> genericBadgeWrap(dynamic i) =>
    i is int ? countBadgeWrap(i) : Map<String, dynamic>.from(i as Map);
Map<String, dynamic> countBadgeWrap(int count) => {
      'count_data': {'count': count}
    };

final longTimeAgo = DateTime.fromMillisecondsSinceEpoch(0);
const daysPerWeek = 7;
const week = Duration(days: daysPerWeek);

extension on Duration {
  bool get isEmpty => inMicroseconds <= 0;
  int get inWeeks => max([isEmpty ? 0 : 1, (inDays / daysPerWeek).ceil()]);
}
