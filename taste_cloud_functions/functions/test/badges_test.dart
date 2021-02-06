import 'utilities.dart';

void main() {
  group('badges', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('many-writes', () async {
      final fixture = Fixture();
      await updateBadges();
      expect(await Badges.get(), isEmpty);
      final n = 20;
      await Iterable.generate(n).futureMap((_) => fixture.newUser);
      expect(await TasteUsers.get(), hasLength(n));
      await updateBadges();
      expect(await Badges.get(),
          hasLength(n * (Badge_BadgeType.values.length - 1)));
    });
    test('no dupes', () async {
      Future sizeIs(int size) async =>
          expect(await Badges.get(), hasLength(size));
      final fixture = Fixture();
      final user = await fixture.user;
      final otherUser = await fixture.otherUser;
      Future<Badge> create(
              {TasteUser tasteUser, Badge_BadgeType type, int count}) =>
          Badge.updateBadge(
              quickTrans,
              tasteUser ?? user,
              type ?? Badge_BadgeType.post_cities_total,
              countBadgeWrap(count ?? 1));

      await sizeIs(0);
      await create();
      await sizeIs(1);
      await create(count: 3);
      await sizeIs(1);
      await create(type: Badge_BadgeType.post_countries_total);
      await sizeIs(2);
      await create(type: Badge_BadgeType.post_countries_total, count: 4);
      await sizeIs(2);
      await create(tasteUser: otherUser);
      await sizeIs(3);
      await create(tasteUser: otherUser);
      await sizeIs(3);
      expect(await create(), equals(await create()));
      expect(await create(count: 3), equals(await create(count: 5)));
      expect(
          await create(count: 3, type: Badge_BadgeType.post_countries_total),
          equals(await create(
              count: 5, type: Badge_BadgeType.post_countries_total)));
      expect(await create(), isNot(equals(await create(tasteUser: otherUser))));
    });

    test('counts', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      Future countsAre(expected) async {
        await updateBadges();
        final userCounted = (await CollectionType.badges.coll.get())
            .documents
            .map((d) => Badges.make(d, quickTrans))
            .where((b) => {
                  Badge_BadgeType.favorites_cities_total,
                  Badge_BadgeType.favorites_countries_total,
                  Badge_BadgeType.post_cities_total,
                  Badge_BadgeType.post_countries_total,
                }.contains(b.proto.type))
            .groupBy((b) => b.userReference)
            .map((user, badges) => MapEntry(
                user,
                badges.asMap().map((_, badge) =>
                    MapEntry(badge.proto.type, badge.proto.countData.count))));
        expect(userCounted, equals(expected));
      }

      var restoNameCounter = 0;
      Future createReview(TasteUser user, String city, String country) async {
        await fixture.createReview(
            restaurant: await fixture.createRestaurant(
                restoName: 'resto-${restoNameCounter++}',
                address: {'city': city, 'country': country}
                    .asProto(Restaurant_Attributes_Address())),
            user: user);
      }

      Future createFavorite(TasteUser user, String city, String country) async {
        await fixture.favorite(
            user,
            await fixture.createRestaurant(
                restoName: 'resto-${restoNameCounter++}',
                address: {'city': city, 'country': country}
                    .asProto(Restaurant_Attributes_Address())));
      }

      await countsAre({
        user.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 0,
          Badge_BadgeType.post_countries_total: 0,
        }
      });

      await createReview(user, 'city-a', 'country-a');
      await countsAre({
        user.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 1,
          Badge_BadgeType.post_countries_total: 1,
        }
      });

      final otherUser = await fixture.otherUser;
      await countsAre({
        user.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 1,
          Badge_BadgeType.post_countries_total: 1,
        },
        otherUser.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 0,
          Badge_BadgeType.post_countries_total: 0,
        },
      });

      await createReview(user, 'city-a', 'country-a');
      await countsAre({
        user.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 1,
          Badge_BadgeType.post_countries_total: 1,
        },
        otherUser.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 0,
          Badge_BadgeType.post_countries_total: 0,
        },
      });

      await createReview(user, 'city-b', 'country-a');
      await countsAre({
        user.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 2,
          Badge_BadgeType.post_countries_total: 1,
        },
        otherUser.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 0,
          Badge_BadgeType.post_countries_total: 0,
        },
      });
      await createReview(user, 'city-c', 'country-a');
      await countsAre({
        user.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 3,
          Badge_BadgeType.post_countries_total: 1,
        },
        otherUser.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 0,
          Badge_BadgeType.post_countries_total: 0,
        },
      });
      await createReview(user, 'city-a', 'country-b');
      await countsAre({
        user.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 4,
          Badge_BadgeType.post_countries_total: 2,
        },
        otherUser.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 0,
          Badge_BadgeType.post_countries_total: 0,
        },
      });
      await createReview(otherUser, 'city-a', 'country-a');
      await countsAre({
        user.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 4,
          Badge_BadgeType.post_countries_total: 2,
        },
        otherUser.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 1,
          Badge_BadgeType.post_countries_total: 1,
        },
      });
      await createFavorite(user, 'city-a', 'country-a');
      await countsAre({
        user.ref: {
          Badge_BadgeType.favorites_cities_total: 1,
          Badge_BadgeType.favorites_countries_total: 1,
          Badge_BadgeType.post_cities_total: 4,
          Badge_BadgeType.post_countries_total: 2,
        },
        otherUser.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 1,
          Badge_BadgeType.post_countries_total: 1,
        },
      });
      await createFavorite(user, 'city-b', 'country-a');
      await countsAre({
        user.ref: {
          Badge_BadgeType.favorites_cities_total: 2,
          Badge_BadgeType.favorites_countries_total: 1,
          Badge_BadgeType.post_cities_total: 4,
          Badge_BadgeType.post_countries_total: 2,
        },
        otherUser.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 1,
          Badge_BadgeType.post_countries_total: 1,
        },
      });
      await createFavorite(user, 'city-a', 'country-b');
      await countsAre({
        user.ref: {
          Badge_BadgeType.favorites_cities_total: 3,
          Badge_BadgeType.favorites_countries_total: 2,
          Badge_BadgeType.post_cities_total: 4,
          Badge_BadgeType.post_countries_total: 2,
        },
        otherUser.ref: {
          Badge_BadgeType.favorites_cities_total: 0,
          Badge_BadgeType.favorites_countries_total: 0,
          Badge_BadgeType.post_cities_total: 1,
          Badge_BadgeType.post_countries_total: 1,
        },
      });
      await createFavorite(otherUser, 'city-a', 'country-a');
      await countsAre({
        user.ref: {
          Badge_BadgeType.favorites_cities_total: 3,
          Badge_BadgeType.favorites_countries_total: 2,
          Badge_BadgeType.post_cities_total: 4,
          Badge_BadgeType.post_countries_total: 2,
        },
        otherUser.ref: {
          Badge_BadgeType.favorites_cities_total: 1,
          Badge_BadgeType.favorites_countries_total: 1,
          Badge_BadgeType.post_cities_total: 1,
          Badge_BadgeType.post_countries_total: 1,
        },
      });
    });

    test('streak-reactive', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final now = DateTime.now();
      Future<Review> review(int daysAgo) async {
        final review = await fixture.createReview();
        await review.updateSelf({
          '_extras': {'created_at': now.subtract(Duration(days: daysAgo))}
        }, changeUpdatedAt: false);
        return review;
      }

      Future check(int value) => eventually(
          () async => (await user.badge(Badge_BadgeType.streak_active)).value,
          value);
      await check(0);
      final review5 = await review(5);
      await check(1);
      await review(8);
      await check(2);
      await review(10);
      await check(2);
      await review5.deleteSelf();
      await check(0);
      await review(5);
      await check(2);
      await review(9);
      await check(2);
      await review(15);
      await check(3);
      await review(21);
      await review(22);
      await check(4);
      await review(25);
      await review(29);
      await check(5);
    });

    test('streak', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final now = DateTime.now();
      Future review(int daysAgo) async {
        final review = await fixture.createReview();
        await review.updateSelf({
          '_extras': {'created_at': now.subtract(Duration(days: daysAgo))}
        }, changeUpdatedAt: false);
      }

      Future streakIs(int active, int longest) async {
        await updateBadges();
        expect(
            ((await user.badges)
                  ..removeWhere((k, v) => !k.name.contains('streak')))
                .map((k, v) => MapEntry(k, v.proto.countData.count)),
            equals({
              Badge_BadgeType.streak_active: active,
              Badge_BadgeType.streak_longest: longest
            }));
      }

      await streakIs(0, 0);
      await review(1000);
      await streakIs(0, 1);
      await review(1005);
      await streakIs(0, 1);
      await review(1010);
      await streakIs(0, 2);
      await review(1015);
      await streakIs(0, 3);
      await review(1020);
      await streakIs(0, 3);

      await review(900);
      await review(905);
      await review(910);
      await review(915);
      await review(920);
      await streakIs(0, 3);
      await review(925);
      await streakIs(0, 4);

      await review(1100);
      await review(1105);
      await review(1110);
      await review(1115);
      await review(1120);
      await review(1125);
      await streakIs(0, 4);
      await review(1130);
      await streakIs(0, 5);

      await review(1);
      await review(5);
      await streakIs(1, 5);
      await review(10);
      await streakIs(2, 5);
      await review(15);
      await streakIs(3, 5);
      await review(20);
      await review(25);
      await review(30);
      await review(35);
      await review(40);
      await streakIs(6, 6);
    });

    test('comments', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      Future comment() async => fixture.comment(user);
      Future value(int active) async {
        await updateBadges();
        expect((await user.badges)[Badge_BadgeType.commenter_level_1]?.value,
            active);
      }

      await value(0);
      await comment();
      await value(1);
      await comment();
      await value(2);
      await comment();
      await value(3);
    });
    test('flags', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      final flags = flagEmojis.toList();
      Future review(int flagIndex) =>
          fixture.createReview(emoji: flags[flagIndex]);
      Future flagsValue(int i) async {
        await updateBadges();
        final badge = (await user.badges)[Badge_BadgeType.emoji_flags_level_1];
        expect(badge, isNotNull);
        expect(badge.value, i, reason: i.toString());
      }

      await flagsValue(0);
      await review(0);
      await flagsValue(1);
      await review(0);
      await flagsValue(1);
      await review(1);
      await flagsValue(2);
      await review(1);
      await flagsValue(2);
      await review(3);
      await flagsValue(3);
      expect(
          (await user.badge(Badge_BadgeType.emoji_flags_level_1))
              .proto
              .emojiFlags
              .flags,
          containsExactly([0, 1, 3].map((e) => flags[e])));
    });

    test('just made a post', () async {
      final fixture = Fixture();
      await fixture.review;
      await updateBadges();
      expect(
          (await (await fixture.user).badges)[Badge_BadgeType.streak_active]
              .value,
          equals(1));
    });

    test('burgermeister', () async {
      Future burgerScore(int score, List<List<String>> attributes) async =>
          expect(
              await reviewBasedScore(attributes, burgermeister), equals(score));
      await burgerScore(0, []);
      await burgerScore(0, [[]]);
      await burgerScore(0, [
        ['']
      ]);
      await burgerScore(0, [
        ['burg']
      ]);
      await burgerScore(1, [
        ['burger']
      ]);
      await burgerScore(1, [
        ['double-burger']
      ]);
      await burgerScore(1, [
        ['burger', 'double-burger']
      ]);
      await burgerScore(2, [
        ['burger', 'double-burger'],
        ['burger', 'double-burger'],
      ]);
      await burgerScore(2, [
        ['burger', 'double-burger'],
        ['burger', 'double-burger'],
        ['berger'],
      ]);
      await burgerScore(3, [
        ['burger', 'double-burger'],
        ['burger', 'double-burger'],
        ['berger'],
        ['other burger', 'not-berger'],
      ]);
    });
    test('socialite', () async {
      Future socialiteScore(int score, List<bool> mealMate) async => expect(
          await reviewBasedScore(
              mealMate.map((e) => <String>[]).toList(), socialite,
              mealMate: mealMate),
          equals(score));
      await socialiteScore(0, []);
      await socialiteScore(0, [false]);
      await socialiteScore(1, [false, true]);
      await socialiteScore(3, [false, true, false, true, true]);
    });
    test('ramsay', () async {
      for (final nHomeMeals in {1, 243, 0, 12, 5}) {
        final fixture = Fixture();
        final user = await fixture.newUser;
        final reviews = <Review>[];
        for (var i = 0; i < 5; i++) {
          reviews.add(await fixture.createReview(user: user));
        }
        for (var i = 0; i < nHomeMeals; i++) {
          reviews.add(await fixture.createReview(user: user, home: true));
        }
        expect(reviews, hasLength(nHomeMeals + 5));
        expect(ramsay(reviews).asProto(Badges.emptyInstance).countData.count,
            nHomeMeals);
      }
    });
    test('herbivore', () async {
      Future herbivoreScore(
              int score, List<List<List<String>>> attributesEmojis) async =>
          expect(
              await reviewBasedScore(
                  attributesEmojis.map((e) => e[0]).toList(), herbivore,
                  emojis: attributesEmojis.map((e) => e[1]).toList()),
              equals(score),
              reason: attributesEmojis.toString());
      await herbivoreScore(0, []);
      await herbivoreScore(0, [
        [[], []]
      ]);
      await herbivoreScore(0, [
        [
          ['noveeeegan'],
          []
        ]
      ]);
      await herbivoreScore(0, [
        [
          ['noveeeegan'],
          ['#novegan']
        ]
      ]);
      await herbivoreScore(1, [
        [
          ['noveeeegan'],
          ['#vegan']
        ]
      ]);
      await herbivoreScore(1, [
        [
          ['noveeeegan'],
          ['#vegan', '#novegan']
        ]
      ]);
      await herbivoreScore(1, [
        [
          ['noveeeegan'],
          ['#vegan', '#novegan', '#veggie']
        ]
      ]);
      await herbivoreScore(1, [
        [
          ['noveeeegan', 'vegan'],
          ['#vegan', '#novegan', '#veggie']
        ]
      ]);
      await herbivoreScore(1, [
        [
          ['vegan'],
          [],
        ]
      ]);
      await herbivoreScore(1, [
        [
          ['vegetarian'],
          [],
        ]
      ]);
      await herbivoreScore(0, [
        [
          ['notveeeegetarian'],
          [],
        ]
      ]);
      await herbivoreScore(2, [
        [
          ['vegetarian'],
          [],
        ],
        [
          ['vegetarian'],
          [],
        ]
      ]);
      await herbivoreScore(1, [
        [
          ['vegetarian'],
          [],
        ],
        [
          ['veeeeeegetarian'],
          [],
        ]
      ]);
      await herbivoreScore(2, [
        [
          ['vegetarian'],
          [],
        ],
        [
          ['veeeeeegetarian'],
          [],
        ],
        [
          ['veeeeeegetarian'],
          ['🥗'],
        ]
      ]);
    });
    test('sushinista', () async {
      Future sushiScore(int score, List<List<String>> attributes,
              [List<List<String>> emojis]) async =>
          expect(await reviewBasedScore(attributes, sushinista, emojis: emojis),
              equals(score));
      await sushiScore(0, []);
      await sushiScore(0, [
        ['sashim']
      ]);
      await sushiScore(1, [
        ['sashimi']
      ]);
      await sushiScore(1, [
        ['Sashimi']
      ]);
      await sushiScore(1, [
        ['salmon Sashimi']
      ]);
      await sushiScore(0, [
        ['salmon']
      ]);
      await sushiScore(1, [
        ['california roll']
      ]);
      await sushiScore(0, [
        ['chicken roll']
      ]);
      await sushiScore(1, [
        ['any sushi']
      ]);
      await sushiScore(1, [
        ['any sushi', 'sashimi']
      ]);
      await sushiScore(1, [
        ['any sushi', 'sashimi'],
        ['roll'],
      ]);
      await sushiScore(2, [
        ['any sushi', 'sashimi'],
        ['roll'],
        ['california roll'],
      ]);
      await sushiScore(0, [
        ['nothing']
      ], [
        ['nothing']
      ]);
      await sushiScore(1, [
        ['nothing']
      ], [
        ['🍣']
      ]);
      await sushiScore(1, [
        ['sashimi']
      ], [
        ['🍣']
      ]);
      await sushiScore(2, [
        [],
        []
      ], [
        [
          '🍣',
        ],
        [
          '🍣',
        ]
      ]);
    });
    test('brainiac', () async {
      Future brainiacScore(int score, List<List<String>> attributes) async =>
          expect(await reviewBasedScore(attributes, brainiac), equals(score));
      await brainiacScore(0, []);
      await brainiacScore(0, [[]]);
      await brainiacScore(0, [[], []]);
      await brainiacScore(1, [
        [],
        ['a']
      ]);
      await brainiacScore(1, [
        [],
        ['a', 'b']
      ]);
      await brainiacScore(2, [
        ['a'],
        ['a'],
      ]);
    });
    test('regular', () async {
      Future regularScore(int score, List<List<int>> restoDaysAgo) async {
        final fixture = Fixture();
        final user = await fixture.user;
        final restaurants = (await restoDaysAgo
                .map((e) => e[0])
                .toSet()
                .futureMap(
                    (e) => fixture.createRestaurant(restoName: e.toString())))
            .asMap()
            .map((_, value) => MapEntry(int.parse(value.name), value));
        expect(
            theRegular(await restoDaysAgo.futureMap((e) => fixture.createReview(
                    user: user, restaurant: restaurants[e[0]], daysAgo: e[1])))
                .asProto(Badges.emptyInstance)
                .countData
                .count,
            equals(score),
            reason: restoDaysAgo.toString());
      }

      await regularScore(0, []);
      await regularScore(0, [
        [0, 0]
      ]);
      await regularScore(0, [
        [0, 0],
        [1, 0]
      ]);
      await regularScore(0, [
        [0, 0],
        [1, 10]
      ]);
      await regularScore(0, [
        [0, 0],
        [0, 1]
      ]);
      await regularScore(2, [
        [0, 0],
        [0, 10]
      ]);
      await regularScore(2, [
        [0, 0],
        [0, 10],
        [1, 0],
        [1, 1],
        [1, 2],
        [1, 3],
      ]);
      await regularScore(3, [
        [0, 0],
        [0, 10],
        [1, 0],
        [1, 1],
        [1, 3],
        [1, 5],
      ]);
      await regularScore(0, [
        [0, 0],
        [2, 20],
        [3, 25],
        [4, 25],
        [5, 25],
        [6, 25],
        [7, 25],
        [8, 25],
      ]);
      await regularScore(2, [
        [0, 0],
        [2, 20],
        [3, 25],
        [4, 25],
        [5, 25],
        [6, 25],
        [7, 25],
        [8, 25],
        [8, 30],
      ]);
      await regularScore(5, [
        [0, 0],
        [0, 20],
        [0, 21],
        [0, 21],
        [0, 25],
        [0, 25],
        [0, 30],
        [0, 30],
        [0, 30],
        [0, 35],
        [0, 35],
      ]);
    });
    test('city-champion-e2e', () async {
      final fixture = Fixture();
      final users = <int, TasteUser>{};
      final cities = <int, City>{};
      Future<TasteUser> getUser(int i) async {
        if (users.containsKey(i)) {
          return users[i];
        }
        final user = await fixture.newUser;
        users[i] = user;
        return user;
      }

      int userInt(DocumentReference user) => users.entries
          .firstWhere((e) => e.value.ref == user, orElse: () => null)
          ?.key;

      City getCity(int i) => cities.putIfAbsent(
          i, () => City(i.toString(), i.toString(), i.toString()));
      var resto = 0;
      String restoName() => (resto++).toString();
      Future<Review> review(int user, int city) async => fixture.createReview(
          user: await getUser(user),
          restaurant: await fixture.createRestaurant(
              restoName: restoName(),
              address: {
                'city': getCity(city).city,
                'country': getCity(city).country,
                'state': getCity(city).state,
              }.asProto(Restaurant_Attributes_Address())));
      Future<Map<int, Set<String>>> badges() async {
        await updateBadges();
        return (await Badges.get())
            .where((e) => e.proto.type == Badge_BadgeType.city_champion)
            .keyOn((t) => userInt(t.userReference))
            .withoutNulls
            .mapValue((_, v) => v.proto.cityChampionData.cities
                .map((e) => [e.city, e.state, e.country].join(','))
                .toSet());
      }

      await review(0, 0);
      expect(await badges(), {
        0: {'0,0,0', ',,0'}
      });
      await review(0, 0);
      expect(await badges(), {
        0: {'0,0,0', ',,0'}
      });
      await review(0, 1);
      expect(await badges(), {
        0: {'0,0,0', ',,0', '1,1,1', ',,1'},
      });
      await review(1, 0);
      expect(await badges(), {
        0: {'0,0,0', ',,0', '1,1,1', ',,1'},
        1: <int>{},
      });
      await review(1, 0);
      await review(1, 0);
      expect(await badges(), {
        0: {'1,1,1', ',,1'},
        1: {'0,0,0', ',,0'},
      });
      await review(0, 0);
      await review(0, 0);
      expect(await badges(), {
        0: {'0,0,0', ',,0', '1,1,1', ',,1'},
        1: <int>{},
      });
    });
    test('city-champion-unit', () async {
      expect(cityChampion([]), {
        'count_data': {'count': 0},
        'city_champion_data': {},
      });
      expect(cityChampion([City('a', 'a', 'a'), City('c', 'd', 'e')]), {
        'count_data': {'count': 2},
        'city_champion_data': {
          'cities': [
            {'city': 'a', 'country': 'a', 'state': 'a'},
            {'city': 'c', 'country': 'd', 'state': 'e'},
          ]
        }
      });
    });
    test('character', () async {
      Future check(
          int expected, List<double> daysAgo, List<int> restaurants) async {
        final restos = <int, Future<Restaurant>>{};
        final fixture = Fixture();
        final user = await fixture.user;
        final reviews = await daysAgo
            .zip(restaurants)
            .map((e) async => fixture.createReview(
                user: user,
                date: characterStartDate
                    .add(Duration(minutes: (e.a * 60 * 24).round())),
                restaurant: await restos.putIfAbsent(e.b,
                    () => fixture.createRestaurant(restoName: e.b.toString()))))
            .wait;
        expect(character(reviews), expected,
            reason: [daysAgo, restaurants].toString());
      }

      await check(0, [], []);
      await check(0, [-1], [0]);
      await check(1, [-10, -1, 1.2], [0, 0, 0]);
      await check(1, [-10, -1, 1.2, 1.4], [0, 0, 0, 0]);
      await check(2, [-10, -1, 1.2, 1.4], [0, 0, 0, 1]);
      await check(3, [-10, -1, 1.2, 1.4, 2.5], [0, 0, 0, 1, 0]);
    });
    test('daily-tasty', () async {
      final fixture = Fixture();
      final userA = await fixture.createUser();
      final userB = await fixture.createUser();
      await fixture.createReview(user: userA);
      await fixture.createReview(user: userA, dailyTasty: true);
      await fixture.createReview(user: userA, dailyTasty: true);
      await fixture.createReview(user: userB);
      await fixture.createReview(user: userB);
      await fixture.createReview(user: userB, dailyTasty: true);
      await updateBadges();
      expect((await userA.badge(Badge_BadgeType.daily_tasty)).value, 2);
      expect((await userB.badge(Badge_BadgeType.daily_tasty)).value, 1);
    });
    test('black-owned-restaurant-post', () async {
      final fixture = Fixture();
      final userA = await fixture.createUser();
      final userB = await fixture.createUser();
      await fixture.createReview(
          user: userA,
          restaurant: await fixture.createRestaurant(blackOwned: true));
      await fixture.createReview(
          user: userA,
          dailyTasty: true,
          restaurant: await fixture.createRestaurant(blackOwned: true));
      await fixture.createReview(user: userA, dailyTasty: true);
      await fixture.createReview(user: userB);
      await fixture.createReview(user: userB);
      await fixture.createReview(user: userB, dailyTasty: true);
      await updateBadges();
      expect(
          (await userA.badge(Badge_BadgeType.black_owned_restaurant_post))
              .value,
          2);
      expect(
          (await userB.badge(Badge_BadgeType.black_owned_restaurant_post))
              .value,
          0);
    });
    test('live-update-character', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      expect(await user.badges, isEmpty);
      await fixture.createReview(date: characterStartDate);
      expect(
          await waitForEquals(
              1,
              () async =>
                  (await user.badges)[Badge_BadgeType.character]?.value),
          isTrue);
      await fixture.createReview(home: true, date: characterStartDate);
      expect(
          await waitForEquals(
              2,
              () async =>
                  (await user.badges)[Badge_BadgeType.character]?.value),
          isTrue);
    });
    test('do-not-include-insta', () async {
      final fixture = Fixture();
      final user = await fixture.user;
      var day = 1;
      Future countAfterPostIs(int count, bool isInsta) async {
        await fixture.createReview(
            date: characterStartDate.add(Duration(days: day++)),
            instaPost: isInsta ? 'a/b'.ref : null);
        await updateBadges();
        expect((await user.badges)[Badge_BadgeType.character]?.value, count);
      }

      await countAfterPostIs(0, true);
      await countAfterPostIs(1, false);
      await countAfterPostIs(1, true);
      await countAfterPostIs(2, false);
      await countAfterPostIs(3, false);
      await countAfterPostIs(3, true);
    });
  });
}

Future<int> reviewBasedScore(List<List<String>> attributes,
    dynamic Function(List<Review> reviews) scorer,
    {List<int> daysAgo, List<List<String>> emojis, List<bool> mealMate}) async {
  final fixture = Fixture();
  final user = await fixture.newUser;
  final result = scorer(await attributes.asMap().entries.futureMap(
      (key, value) async => fixture.createReview(
          user: user,
          attributes: value.toSet(),
          mealMate: (mealMate?.elementAt(key) ?? false)
              ? await fixture.newUser
              : null,
          emojis: emojis == null ? {} : emojis[key].toSet(),
          daysAgo: daysAgo == null ? null : daysAgo[key])));
  return result is int
      ? result
      : (result as Map<String, dynamic>)
          .asProto(Badges.emptyInstance)
          .countData
          .count;
}
