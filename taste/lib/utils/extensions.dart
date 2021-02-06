import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expire_cache/expire_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';
import 'package:protobuf/protobuf.dart';
import 'package:quiver/collection.dart';
import 'package:recase/recase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:s2geometry/s2geometry.dart';
import 'package:taste/algolia/algolia_restaurant.dart';
import 'package:taste/app_config.dart';
import 'package:taste/providers/remote_config.dart';
import 'package:taste/screens/profile/notifications/taste_notification_document.dart';
import 'package:taste/screens/user_list/user_list.dart';
import 'package:taste/taste_backend_client/backend.dart'
    show Bookmark, Comment, Photo, TasteUser, UserOwned, currentUserReference;
import 'package:taste/taste_backend_client/responses/badge.dart';
import 'package:taste/taste_backend_client/responses/city.dart';
import 'package:taste/taste_backend_client/responses/contest.dart';
import 'package:taste/taste_backend_client/responses/conversation.dart';
import 'package:taste/taste_backend_client/responses/daily_tasty_vote.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/responses/favorite.dart';
import 'package:taste/taste_backend_client/responses/follower.dart';
import 'package:taste/taste_backend_client/responses/instagram_token.dart';
import 'package:taste/taste_backend_client/responses/like.dart';
import 'package:taste/taste_backend_client/responses/recipe_request.dart';
import 'package:taste/taste_backend_client/responses/restaurant.dart';
import 'package:taste/taste_backend_client/responses/review.dart';
import 'package:taste/taste_backend_client/responses/snapshot_holder.dart';
import 'package:taste/taste_backend_client/responses/tag.dart';
import 'package:taste/taste_backend_client/responses/taste_bud_group.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste_protos/extensions.dart';
import 'package:taste_protos/proto_transforms.dart';
import 'package:taste_protos/registry.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'fire_photo.dart';
import 'logging.dart';
import 'utils.dart';

export 'package:rxdart/rxdart.dart';
export 'package:taste_protos/extensions.dart';

extension DRProto on $pb.DocumentReferenceProto {
  DocumentReference get ref => path?.isEmpty ?? true ? null : path.ref;
  Key get key => ref.key;
}

extension GeolocProto on $pb.GeoLoc {
  LatLng get latLng => LatLng(lat, lng);
}

extension RefString on String {
  DocumentReference get ref => Firestore.instance.document(this);
}

extension Merging<T> on Iterable<T> {
  List<T> listWhere(bool Function(T t) fn) => where(fn).toList();
  Iterable<T> mergeSorted(Iterable<T> other, Comparable Function(T t) key) {
    if (isEmpty || other.isEmpty) {
      return [...this, ...other];
    }
    final winner = key(first).compareTo(key(other.first)) < 0 ? this : other;
    final loser = winner == this ? other : this;
    return [winner.first, ...winner.skip(1).mergeSorted(loser, key)];
  }

  Iterable<T> interleave(Iterable<T> other) =>
      isEmpty ? other : [first, ...other.interleave(skip(1))];
}

extension ProtoTimestamp on $pb.Timestamp {
  Timestamp get firestoreTimestamp => Timestamp.fromDate(toDateTime());
}

extension DSExt on DocumentSnapshot {
  T proto<T extends GeneratedMessage>() =>
      ProtoTransforms.fromMap(reference.type.proto as T, data);
}

extension RefWrap on DocumentReference {
  bool isA(CollectionType type) => type.isA(this);
  CollectionType get type =>
      $pb.enumFromString(parent().id, CollectionType.values);
  Stream<T> _toStream<T>(T Function(DocumentSnapshot s) fn) =>
      snapshots().map(fn);
  Future<T> _fetch<T>(T Function(DocumentSnapshot s) fn,
          {bool useCache = true}) async =>
      useCache ? await _toStream(fn).firstOrNull : fn(await get());
  $pb.DocumentReferenceProto get proto =>
      $pb.DocumentReferenceProto()..path = path;
  Key get key => Key(path);
}

extension UserQuery on Query {
  Stream<int> get count => snapshots().map((s) => s.documents.length);
  Future<List<T>> fetchOnceJ<T>(T Function(DocumentSnapshot s) fn,
          {bool useCache = true}) async =>
      (useCache ? await snapshots().first : await getDocuments())
          .documents
          .listMap(fn);
  Query forUser(DocumentReference user) =>
      user == null ? this : where('user', isEqualTo: user);
  Query get forMe => forUser(currentUserReference);
  Query forParent(DocumentReference parent) =>
      parent == null ? this : where('parent', isEqualTo: parent);
  Query visible([BuildContext context]) {
    if (!isProd || context == null) {
      return this;
    }
    if ($pb.Experiment.taste_hidden_experiment(context, defaultValue: 'true') ==
        'true') {
      // We are showing hidden stuff in this experiment.
      return this;
    }
    return where('hidden', isEqualTo: false);
  }

  Query visibleNoContext() {
    if (!isProd) {
      return this;
    }
    if ($pb.Experiment.taste_hidden_experiment
            .getStatic(defaultValue: 'true') ==
        'true') {
      return this;
    }
    return where('hidden', isEqualTo: false);
  }

  Query get byCreated => orderBy('_extras.created_at', descending: true);
  Query get byPopularity => orderBy('popularity_score', descending: true);
  Future<bool> get exists async => existsStream.first;
  Stream<bool> get existsStream =>
      limit(1).snapshots().map((s) => s.documents.isNotEmpty);
  Stream<List<T>> _innerMap<T>(T Function(DocumentSnapshot snapshot) fn) =>
      snapshots().map((s) => s.documents.listMap(fn));
}

extension AddressExtension on $pb.Restaurant_Attributes_Address {
  String get simple => (country == 'United States'
          ? [
              city,
              stateCode,
            ]
          : [
              city ?? state,
              country,
            ])
      .withoutEmpties
      .join(', ');
  String get detailed => [street, simple].withoutEmpties.join(', ');

  String get stateCode => stateAbbreviations[state] ?? state;
}

extension ExtrasMap on Map<String, dynamic> {
  Map<String, dynamic> get withExtras => {
        ...this,
        '_extras': {
          'created_at': FieldValue.serverTimestamp(),
          'updated_at': FieldValue.serverTimestamp(),
        }
      };
  Map<String, dynamic> get withUpdateExtras => {
        ...this,
        '_extras.updated_at': FieldValue.serverTimestamp(),
      };
}

final stateAbbreviations = BiMap<String, String>()
  ..addAll({
    'Alabama': 'AL',
    'Alaska': 'AK',
    'Arizona': 'AZ',
    'Arkansas': 'AR',
    'California': 'CA',
    'Colorado': 'CO',
    'Connecticut': 'CT',
    'Delaware': 'DE',
    'Florida': 'FL',
    'Georgia': 'GA',
    'Hawaii': 'HI',
    'Idaho': 'ID',
    'Illinois': 'IL',
    'Indiana': 'IN',
    'Iowa': 'IA',
    'Kansas': 'KS',
    'Kentucky': 'KY',
    'Louisiana': 'LA',
    'Maine': 'ME',
    'Maryland': 'MD',
    'Massachusetts': 'MA',
    'Michigan': 'MI',
    'Minnesota': 'MN',
    'Mississippi': 'MS',
    'Missouri': 'MO',
    'Montana': 'MT',
    'Nebraska': 'NE',
    'Nevada': 'NV',
    'New Hampshire': 'NH',
    'New Jersey': 'NJ',
    'New Mexico': 'NM',
    'New York': 'NY',
    'North Carolina': 'NC',
    'North Dakota': 'ND',
    'Ohio': 'OH',
    'Oklahoma': 'OK',
    'Oregon': 'OR',
    'Pennsylvania': 'PA',
    'Rhode Island': 'RI',
    'South Carolina': 'SC',
    'South Dakota': 'SD',
    'Tennessee': 'TN',
    'Texas': 'TX',
    'Utah': 'UT',
    'Vermont': 'VT',
    'Virginia': 'VA',
    'Washington': 'WA',
    'West Virginia': 'WV',
    'Wisconsin': 'WI',
    'Wyoming': 'WY',
    'Commonwealth/Territory:': 'Abbreviation:',
    'District of Columbia': 'DC',
    'Marshall Islands': 'MH',
  });

extension PermsExtensions on PermissionHandler {
  Future<bool> neverAsk(PermissionGroup group) async {
    final request = await checkPermissionStatus(group);
    if (request == PermissionStatus.neverAskAgain) {
      return true;
    }
    if (request != PermissionStatus.denied) {
      return false;
    }
    if (Platform.isIOS) {
      return true;
    }
    return !(await shouldShowRequestPermissionRationale(group));
  }
}

extension CollectStream<T> on Stream<T> {
  ValueStream<T> get subscribe => shareValue()..subscribe;
  Future<T> get firstOrNull async => (await take(1).toList()).firstOrNull;
  Stream<T> get withoutNulls => where((t) => t != null);
  Stream<List<T>> get collect =>
      scan<List<T>>((a, b, _) => a..add(b), []).startWith([]);
}

extension CityChampionCityExt on $pb.Badge_CityChampion_City {
  String get summary {
    if (country == 'United States') {
      if (state.isEmpty) {
        return 'United States';
      }
      if (city.isEmpty) {
        return stateAbbreviations.inverse[state] ?? state;
      }
      return [city, state].withoutEmpties.join(', ');
    }
    if (city.isEmpty) {
      return country;
    }
    return [city, country].withoutEmpties.join(', ');
  }
}

extension AlgoliaRestaurantListExt on Iterable<AlgoliaRestaurant> {
  List<Restaurant> get toRestaurants =>
      listMap((u) => u.restoWrapper.restaurant).withoutNulls;
}

extension RestaurantListExt on Iterable<Restaurant> {
  List<AlgoliaRestaurant> get toAlgoliaRestaurants =>
      listMap(AlgoliaRestaurant.fromRestaurant);
}

extension ExtGeoPoint on GeoPoint {
  double distanceMeters(GeoPoint other) =>
      S2LatLng.fromDegrees(latitude, longitude)
          .getDistance(S2LatLng.fromDegrees(other.latitude, other.longitude))
          .meters;
  LatLng get latLng => LatLng(latitude, longitude);
}

extension ExtLocData on LocationData {
  LatLng get latLng => LatLng(latitude, longitude);
  GeoPoint get geoPoint => GeoPoint(latitude, longitude);
}

extension S2Ext on LatLng {
  S2LatLng get s2 => S2LatLng.fromDegrees(latitude, longitude);
  double distanceMeters(LatLng o) => s2.getDistance(o.s2).meters;
  GeoPoint get geoPoint => GeoPoint(latitude, longitude);
}

extension ProtoLatLng on $pb.LatLng {
  GeoPoint get geoPoint => GeoPoint(latitude, longitude);
  LatLng get latLng => LatLng(latitude, longitude);
}

enum PeriodOfDay { evening, morning, afternoon }
enum Meal { breakfast, lunch, dinner, snack }

extension DayPeriodExt on PeriodOfDay {
  String get description => toString().split('.').last.titleCase;
  Meal get meal => const {
        PeriodOfDay.morning: Meal.breakfast,
        PeriodOfDay.afternoon: Meal.lunch,
        PeriodOfDay.evening: Meal.dinner,
      }[this];
  int get endHour => const {
        PeriodOfDay.evening: 3,
        PeriodOfDay.morning: 12,
        PeriodOfDay.afternoon: 17,
      }[this];
}

extension MealExt on Meal {
  String get description => toString().split('.').last.titleCase;
}

extension ExtDateTime on DateTime {
  Timestamp get timestamp => Timestamp.fromDate(this);
  PeriodOfDay get periodOfDay => PeriodOfDay.values
      .firstWhere((e) => hour < e.endHour, orElse: () => PeriodOfDay.evening);
}

extension UserStream on Stream<List<UserOwned>> {
  Stream<List<TasteUser>> get toUsers =>
      asyncMap((b) => b.futureMap((e) => e.user));
}

extension StreamExts<T> on Stream<T> {
  Stream<T> log([Function(T t) fn]) =>
      sideEffect((t) => logger.d((fn ?? identity)(t)));
  Stream<T> mustFinishIn(Duration duration) => Rx.race([
        this,
        Future.delayed(duration).asStream().map(
            (event) => throw Exception("mustFinishOn timed out in $duration"))
      ]);
}

extension Expire<K, V> on ExpireCache<K, Future<V>> {
  Future<V> putIfAbsent(K k, Future<V> Function() ifAbsent) async =>
      await get(k) ??
      (() {
        final Future<V> v = ifAbsent();
        set(k, v);
        return v;
      }());
}

extension DistinctStream<T, I extends Iterable<T>> on Stream<I> {
  Stream<I> get setDistinct =>
      distinct((a, b) => setEquals(a.toSet(), b.toSet()));
  Stream<I> get listDistinct =>
      distinct((a, b) => listEquals(a.toList(), b.toList()));
}

extension DeepMapStream<T> on Stream<Iterable<T>> {
  Stream<List<T>> listWhere(bool Function(T t) fn) =>
      map((x) => x?.listWhere(fn));
  Stream<List<S>> deepMap<S>(Stream<S> Function(T t) fn) =>
      switchMap((x) => (x?.isEmpty ?? true)
          ? Stream.value(<S>[])
          : Rx.combineLatestList(x.map(fn)));
}

/// Duplicate from above because dart's type inference covariance blah blah isn't good enough.
extension DeepMapStreamSet<T> on Stream<Set<T>> {
  Stream<List<S>> deepMap<S>(Stream<S> Function(T t) fn) =>
      switchMap((x) => (x?.isEmpty ?? true)
          ? Stream.value(<S>[])
          : Rx.combineLatestList(x.map(fn)));
}

/// Duplicate from above because dart's type inference covariance blah blah isn't good enough.
extension DeepMapStreamList<T> on Stream<List<T>> {
  Stream<List<S>> deepMap<S>(Stream<S> Function(T t) fn) =>
      switchMap((x) => (x?.isEmpty ?? true)
          ? Stream.value([])
          : Rx.combineLatestList(x.map(fn)));
}

extension DeepStreamMap<T> on Iterable<Stream<T>> {
  Stream<List<T>> get combineLatest =>
      isEmpty ? Stream.value([]) : Rx.combineLatestList(this);
}

extension DeepStreamMapIter<T> on Iterable<Stream<Iterable<T>>> {
  Stream<List<T>> get combineLatestFlat =>
      combineLatest.map((x) => x.flatten.toList());
}

extension StreamCombine<T> on Iterable<T> {
  List<T> log([Function(T t) fn]) => sideEffect(
      (t) => logger.d(t.map(fn ?? identity).listMap((x) => x.toString())));
  Stream<List<S>> streamCombine<S>(Stream<S> Function(T t) fn) =>
      isEmpty ? Stream.value([]) : Rx.combineLatestList(map(fn));
}

Future sleep(Duration d) => Future.delayed(d);

extension TextEditingControllerExt on TextEditingController {
  void setToEnd() =>
      selection = TextSelection.fromPosition(TextPosition(offset: text.length));
  void append(String s) => this
    ..text = text.append(s)
    ..setToEnd();
}

extension ValueStreamExt<T> on ValueStream<T> {
  StreamSubscription<T> get subscribe => listen((_) {});
  ValueStream<S> valueMap<S>(S Function(T) fn) =>
      map(fn).shareValueSeeded(fn(value));
  Future<T> get firstNonNull async => value ?? await withoutNulls.firstOrNull;
}

ValueStream<T> fixedValueStream<T>(T t) => Stream.value(t).shareValueSeeded(t);

class _Maker<P extends GeneratedMessage, S extends SnapshotHolder<P>> {
  _Maker(this.maker);
  final S Function(DocumentSnapshot s) maker;

  Type get proto => P;
  Set<CollectionType> get types => protoToTypes[proto];
}

final registry = () {
  final r = <Type, _Maker>{};
  void _r<P extends GeneratedMessage, S extends SnapshotHolder<P>>(
          S Function(DocumentSnapshot s) fn) =>
      r.putIfAbsent(S, () => _Maker<P, S>(fn));
  // Alas, type inference isn't good enough to infer [P] automatically.
  _r<$pb.Review, Review>(Review.make);
  _r<$pb.Restaurant, Restaurant>(Restaurant.make);
  _r<$pb.TasteUser, TasteUser>(TasteUser.from);
  _r<$pb.Review, Review>((b) => Review(b));
  _r<$pb.Favorite, Favorite>((b) => Favorite(b));
  _r<$pb.Badge, Badge>((b) => Badge(b));
  _r<$pb.DiscoverItem, DiscoverItem>((b) => DiscoverItem(b));
  _r<$pb.Follower, Follower>((b) => Follower(b));
  _r<$pb.Like, Like>((b) => Like(b));
  _r<$pb.Bookmark, Bookmark>((b) => Bookmark(b));
  _r<$pb.DailyTastyVote, DailyTastyVote>((b) => DailyTastyVote(b));
  _r<$pb.Tag, Tag>((b) => Tag(b));
  _r<$pb.TasteBudGroup, TasteBudGroup>((b) => TasteBudGroup(b));
  _r<$pb.Photo, Photo>((b) => Photo(b));
  _r<$pb.InstagramToken, InstagramToken>((b) => InstagramToken(b));
  _r<$pb.Conversation, Conversation>((b) => Conversation(b));
  _r<$pb.Contest, Contest>((b) => Contest(b));
  _r<$pb.City, City>((b) => City(b));
  _r<$pb.Notification, TasteNotificationDocument>(
      (b) => TasteNotificationDocument(b));
  _r<$pb.RecipeRequest, RecipeRequest>(RecipeRequest.make);
  _r<$pb.Comment, Comment>((b) => Comment(b));
  return r;
}();

extension RegistryExtension on DocumentReference {
  T Function(DocumentSnapshot s) _transform<T>() {
    final record = registry[T];
    assert(record != null);
    assert(record.types.any(isA));
    return (a) => record.maker(a) as T;
  }

  Future<T> fetch<T>({bool useCache = true}) =>
      _fetch(_transform(), useCache: useCache);

  Stream<T> stream<T>() => _toStream(_transform());
}

extension RegistryExtensionQuery on Query {
  T Function(DocumentSnapshot s) _transform<T>() {
    final record = registry[T];
    assert(record != null);
    final coll = buildArguments()['path'].split('/').first as String;
    assert(record.types.any((t) => t.name == coll));
    return (a) => record.maker(a) as T;
  }

  Stream<List<T>> stream<T>() => _innerMap(_transform());

  Future<List<T>> fetch<T>({bool useCache = false}) =>
      fetchOnceJ(_transform(), useCache: useCache);
}

extension DIU on $pb.DiscoverItem_User {
  UserListUser get userListUser => UserListUser.make(
      name,
      reference.ref == currentUserReference,
      reference.ref,
      fixedFirePhoto(photo).url(Resolution.thumbnail));
}

extension DIUList on Iterable<$pb.DiscoverItem_User> {
  List<UserListUser> get userListUsers => listMap((u) => u.userListUser);
}
