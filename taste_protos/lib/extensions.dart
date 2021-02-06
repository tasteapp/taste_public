import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:edit_distance/edit_distance.dart';
import 'package:equatable/equatable.dart';
import 'package:protobuf/protobuf.dart';
import 'package:tuple/tuple.dart';

import 'gen/common.pb.dart' as $common;
import 'gen/common.pb.dart' as $pb;
import 'gen/firestore.pb.dart' as $pb;
import 'proto_transforms.dart';

extension ExtensionMap on Map<String, dynamic> {
  Map<String, dynamic> ensureAs(GeneratedMessage message,
          {bool explicitEmpties = false, bool explicitNulls = false}) =>
      ProtoTransforms.ensureAsMap(
        message,
        this,
        explicitEmpties: explicitEmpties ?? false,
        explicitNulls: explicitNulls ?? false,
      );
  Map<String, dynamic> get asJson => ProtoTransforms.toCallFnOutput(this);
  T asProto<T extends GeneratedMessage>(T message) =>
      ProtoTransforms.fromMap(message, this);
}

extension ExtensionProto on GeneratedMessage {
  Map<String, dynamic> get asJson => ProtoTransforms.toCallFnOutput(this);
  Map<String, dynamic> get asMap => ProtoTransforms.toMap(this);
}

extension GrouperIterable<T> on Iterable<T> {
  Iterable<Iterable<T>> chunk(int chunkSize) sync* {
    if (chunkSize <= 0) {
      throw Exception('Bad chunk size $chunkSize >= 0');
    }
    if (chunkSize >= length) {
      yield this;
      return;
    }
    var n = this;
    while (n.isNotEmpty) {
      yield n.take(chunkSize);
      n = n.skip(chunkSize);
    }
  }

  List<S> listMap<S>(S Function(T t) fn) => map(fn).toList();
  Iterable<T> distinctOn<K>(K Function(T t) fn) => keyOn(fn).values;

  Map<T, V> toMap<V>(V Function(T t) fn) => mapMap((t) => MapEntry(t, fn(t)));
  Future<List<S>> futureMap<S>(Future<S> Function(T t) fn) => map(fn).wait;
  Map<K, List<T>> groupBy<K>(K Function(T input) key) =>
      fold({}, (a, b) => a..putIfAbsent(key(b), () => []).add(b));
  Map<K, int> counts<K>(K Function(T value) key) => groupBy(key).count;
}

extension FutureListWait<T> on Iterable<Future<T>> {
  Future<List<T>> get wait async {
    final base = withoutNulls;
    final x = List<T>(base.length);
    for (final pair in base.enumerate) {
      x[pair.key] = await pair.value;
    }
    return x;
  }
}

extension CountExtension<K, V> on Map<K, Iterable<V>> {
  Map<V, Iterable<K>> get invert =>
      flatten.groupBy((e) => e.value).deepMap((v) => v.key);
  Map<K, Iterable<V>> get withoutNulls =>
      where((k, v) => (v?.isNotEmpty ?? false) && (k != null));
  Map<K, List<V>> get withoutEmpties => withoutNulls
      .where((k, v) => v?.isNotEmpty ?? false)
      .mapValue((_, v) => v.toList());
  Map<K, Iterable<V>> deepWhere(bool Function(K k, V v) fn) =>
      mapValue((k, v) => v.where((vv) => fn(k, vv))).withoutEmpties;
  Map<K, List<V>> sortBy(Comparable Function(V v) fn) =>
      mapValue((_, v) => v.sorted(fn));
  Map<K, V> reduce(V Function(V a, V b) fn) => mapValue((_, v) => v.reduce(fn));
  Map<K, Iterable<NV>> deepMap<NV>(NV Function(V v) fn) =>
      mapValue((k, v) => v.map(fn));
  Map<NK, Iterable<V>> rekey<NK>(NK Function(K k) fn) => entries
      .groupBy((input) => fn(input.key))
      .mapValue((k, v) => v.expand((e) => e.value));
  Map<K, int> get count => map((k, v) => MapEntry(k, v.length));
  Iterable<MapEntry<K, V>> get flatten =>
      entries.expand((e) => e.value.map((v) => MapEntry(e.key, v)));
}

extension MapEntryIterable<K, V> on Iterable<MapEntry<K, V>> {
  Future<List<S>> futureMap<S>(Future<S> Function(K k, V v) fn) =>
      entryMap(fn).wait;
  Iterable<V> get values => map((e) => e.value);
  Iterable<K> get keys => map((e) => e.key);
  Map<K, Iterable<V>> get multiMap =>
      groupBy((e) => e.key).deepMap((v) => v.value);
  Map<K, V> get mapify => Map.fromEntries(this);
  Iterable<T> entryMap<T>(T Function(K k, V v) fn) =>
      map((e) => fn(e.key, e.value));
}

W _giveNull<K, V, W>(K k, V v) => null;

extension GroupMap<K, V> on Map<K, V> {
  V getOrNull(K key) => this == null ? null : this[key];
  Map<K, ZipTuple<V, W>> leftJoin<W>(Map<K, W> other,
          {W Function(K k, V v) orElse}) =>
      mapValue((k, v) => ZipTuple(v, other[k] ?? (orElse ?? _giveNull)(k, v)));
  bool any(bool Function(K k, V v) fn) =>
      entries.any((e) => fn(e.key, e.value));
  Map<K, V> get withoutNulls => where((k, v) => (v != null) && (k != null));
  Map<K, V> where(bool Function(K k, V v) fn) =>
      entries.where((e) => fn(e.key, e.value)).mapify;
  Map<K, T> mapValue<T>(T Function(K k, V v) fn) =>
      map((k, v) => MapEntry(k, fn(k, v)));
  Map<NK, List<V>> groupBy<NK>(NK Function(K key, V value) key) => entries
      .groupBy((entry) => key(entry.key, entry.value))
      .map((k, v) => MapEntry(k, v.map((e) => e.value).toList()));
  Map<NK, int> counts<NK>(NK Function(K key, V value) key) =>
      groupBy(key).count;
  MapEntry<K, V> max(Comparable Function(K k, V v) fn) =>
      entries.max((e) => fn(e.key, e.value));
  MapEntry<K, V> min(Comparable Function(K k, V v) fn) =>
      entries.min((e) => fn(e.key, e.value));
  Map<V, List<K>> get invert => entries
      .groupBy((e) => e.value)
      .map((key, value) => MapEntry(key, value.map((v) => v.key).toList()));
  Future<Map<S, T>> mapFuture<S, T>(
          {FutureOr<S> Function(K k, V v) key,
          FutureOr<T> Function(K k, V v) value}) async =>
      Map.fromEntries(await entries.futureMap((k, v) async => MapEntry(
          key == null ? k as S : await key(k, v),
          value == null ? v as T : await value(k, v))));
}

class _TupleCompare with Comparable<_TupleCompare> {
  _TupleCompare(this.items);
  final Iterable<Comparable> items;

  @override
  int compareTo(_TupleCompare o) => items
      .zip(o.items)
      .map((e) => e.a.compareTo(e.b))
      .firstWhere((element) => element != 0, orElse: () => 0);
}

/// Returns the minimum value as defined by comparing the result of [fn]
/// element-by-element, in order of decreasing priority.
///
/// In other words, each element of type [T] in this iterable has a
/// corresponding priority defined by [fn]. [fn] returns an [Iterable] of
/// [Comparable] values. When deciding the ordering between two elements:
///  * First, we compute the priority [Iterable] for each value
///  * Then we compare the first values of each [Iterable] against each other.
///  * If the result is zero:
///    * we proceed to the next value in the priority [Iterable].
///    * Else, we return the non-zero value.
///  * If we run out of elements, returns 0.
///
/// As an example: Say we have a list of [jack, jill].
/// If `jack` returns [1,2,3] from [fn], and `jill` returns [1, 1, 4], then:
/// * The first element comparison returns 0 [1 vs. 1].
/// * We move to the second element, which returns 1 [2 vs. 1].
///   * Since 1 != 0, we return 1, which states that `jack` > `jill`.
/// * We ignore the last element comparison [3 vs. 4], since it has lower
///   priority than the [2 vs. 1] comparison.
Comparable Function(T t) _tupleCompare<T>(List<Comparable> Function(T t) fn) =>
    (t) => _TupleCompare(fn(t));

extension MaxIterable<T> on Iterable<T> {
  double average(num Function(T t) fn) =>
      isEmpty ? double.nan : sum(fn) / length;
  N sum<N extends num>(N Function(T t) fn) => map(fn).sum;
  List<T> bookend(T t) => [t, ...this, t];
  List<T> divide(T t) => zip(Iterable.generate(length - 1, (_) => t))
      .expand((a) => [a.a, a.b])
      .followedBy([last]).toList();
  Iterable<ZipTuple<T, S>> cartesian<S>(Iterable<S> s) =>
      expand((t) => s.map((s) => ZipTuple(t, s)));
  List<T> sideEffect(Function(Iterable<T> t) fn) {
    final list = toList();
    fn(list);
    return list;
  }

  Map<K, V> mapMap<K, V>(MapEntry<K, V> Function(T t) fn) {
    final x = <K, V>{};
    for (final e in map(fn)) {
      x.putIfAbsent(e.key, () => e.value);
    }
    return x;
  }

  Map<K, T> keyOn<K>(K Function(T t) fn) => mapMap((v) => MapEntry(fn(v), v));
  T _comp(Comparable Function(T t) fn, bool max) => isEmpty
      ? null
      : zipWith(fn)
          .reduce((a, b) => (a.b.compareTo(b.b) * (max ? -1 : 1)) >= 0 ? b : a)
          .a;
  T max(Comparable Function(T t) fn) => _comp(fn, true);
  T min(Comparable Function(T t) fn) => _comp(fn, false);
  Iterable<ZipTuple<T, S>> zip<S>(Iterable<S> other, {bool nullPad = false}) {
    final a = this == null ? [] : toList();
    final b = other?.toList() ?? const [];
    final length =
        nullPad ? math.max(a.length, b.length) : math.min(a.length, b.length);
    return Iterable.generate(
        length, (i) => ZipTuple(a.getOrNull(i), b.getOrNull(i)));
  }

  Iterable<ZipTuple<T, T>> get pair => zip(skip(1));
  Iterable<ZipTuple<T, T>> get pairCycle => zip(cycle(1));
  Iterable<T> cycle(int n) => skip(n % length).followedBy(take(n % length));
  Iterable<ZipTuple<T, S>> zipWith<S>(S Function(T) fn) => zip(map(fn));
  T get firstOrNull => isEmpty ? null : first;
  T get lastOrNull => isEmpty ? null : last;
}

extension ZipIterable<T, S> on Iterable<ZipTuple<T, S>> {
  Iterable<T> get a => map((a) => a.a);
  Iterable<S> get b => map((a) => a.b);
  Iterable<V> zipMap<V>(V Function(T t, S s) fn) => map((a) => fn(a.a, a.b));
}

class ZipTuple<A, B> with EquatableMixin {
  ZipTuple(this.a, this.b);
  final A a;
  final B b;

  @override
  List<Object> get props => [a, b];
  @override
  String toString() => '($a, $b)';
}

extension CompMap<K, V extends Comparable> on Map<K, V> {
  MapEntry<K, V> get maxByValue => max((k, v) => v);
  MapEntry<K, V> get minByValue => min((k, v) => v);
}

extension NumIterable<T extends num> on Iterable<T> {
  T get sum {
    final x = withoutNulls;
    return x.isEmpty ? 0 : reduce((a, b) => a + b);
  }
}

extension Flatten<T> on Iterable<Iterable<T>> {
  Iterable<T> get flatten => expand((i) => i);
}

class Pair<T> {
  final T first;
  final T second;

  Pair(this.first, this.second);
}

extension FirstNull<T> on Iterable<T> {
  Future<Iterable<T>> futureWhere(Future<bool> Function(T t) fn) async =>
      zip(await futureMap(fn)).where((x) => x.b).a;
  Iterable<MapEntry<int, T>> get enumerate => toList().asMap().entries;
  Iterable<T> takeFromEnd(int n) => length <= n ? this : skip(length - n);
  Iterable<T> get withoutNulls => where((s) => s != null);

  List<T> sorted(Comparable Function(T) fn, {bool desc = false}) =>
      (zipWith(fn).toList()
            ..sort((a, b) => (desc ? -1 : 1) * a.b.compareTo(b.b)))
          .a
          .toList();
  List<T> _sorted(Comparable Function(T) fn, {bool desc = false}) =>
      sorted(fn, desc: desc);
  List<T> tupleSort(List<Comparable> Function(T t) fn, {bool desc = false}) =>
      _sorted(_tupleCompare(fn), desc: desc);
  List<T> iTupleSort(List<Comparable> Function(T t, int i) fn,
          {bool desc = false}) =>
      enumerate
          .tupleSort((t) => fn(t.value, t.key), desc: desc)
          .values
          .toList();

  T tupleMax(List<Comparable> Function(T t) fn) => max(_tupleCompare(fn));
  T tupleMin(List<Comparable> Function(T t) fn) => min(_tupleCompare(fn));
}

extension MinIterableSelf<T extends Comparable> on Iterable<T> {
  T get minSelf => min(identity);
  T get maxSelf => max(identity);
}

T identity<T>(T t) => t;

extension StreamExtensions<T> on Stream<T> {
  Stream<T> sideEffect(Function(T t) fn) => map((t) {
        fn(t);
        return t;
      });
}

extension TagifyExtension on String {
  String append(String s) => '${this}$s';
  String get tagify => dashify.replaceAll(RegExp(r'(#|💡)'), '');
  String get dashify => trim().toLowerCase().replaceAll(RegExp(r'\s+'), '-');
  String ellipsis(int take) =>
      length <= take ? this : substring(0, take).append('…');
  String pluralize(int c) => append(c == 1 ? '' : 's');
  String ifEmpty(String s) => (this == null || isEmpty ?? true) ? s : this;
}

extension ProtoReviewExtension on $pb.Review {
  String get displayText =>
      '${emojis.join(' ')} ${attributes.map((r) => '💡${r.tagify}').join(' ')} $text';
}

extension DocRefProto on $common.DocumentReferenceProto {
  //ignore: unnecessary_this
  bool get exists => this?.path?.isNotEmpty ?? false;
}

extension IntPlace on int {
  int quantize(int v, {bool up = false}) {
    final base = this / v;
    final round = up ? base.ceil() : base.floor();
    return round * v;
  }

  String get place => (this + 1).toString().append((this + 1)._suffix);
  String get _suffix => (this % 100) ~/ 10 == 1
      ? 'th'
      : {1: 'st', 2: 'nd', 3: 'rd'}[this] ?? 'th';
}

extension ListExt<T> on List<T> {
  List<T> get withoutNulls => where((x) => x != null).toList();
  T getOrNull(int i) => i >= length || i < 0 ? null : this[i];
  List<T> repeat(int n) => Iterable.generate(n, (_) => this).flatten.toList();
}

extension StringList on List<String> {
  List<String> get withoutEmpties =>
      //ignore: unnecessary_cast
      (this as Iterable<String>).withoutEmpties.toList();
}

extension StringIter on Iterable<String> {
  Iterable<String> get withoutEmpties =>
      withoutNulls.where((x) => x.isNotEmpty);
}

/// Make higher number of votes more valuable by using a 99% confidence interval
/// around the score assuming fixed std-dev between different posts.
/// See: https://en.wikipedia.org/wiki/Confidence_interval#Basic_steps
double normalizeDailyTastyVote(double score, int numVotes) {
  if (numVotes <= 0) {
    return score;
  }
  // 2.576 is a constant from the 99% choice.
  return score - 2.576 / math.sqrt(numVotes);
}

extension DurationInt on int {
  Duration get hours => Duration(hours: this);
  Duration get minutes => Duration(minutes: this);
  Duration get seconds => Duration(seconds: this);
  Duration get millis => Duration(milliseconds: this);
  Duration get days => Duration(days: this);
  Iterable<int> get times => Iterable.generate(this, identity);
}

extension DateTimeExtensions on DateTime {
  DateTime operator -(Duration d) => subtract(d);
  DateTime operator +(Duration d) => add(d);
  bool operator >(DateTime d) => isAfter(d);
  bool operator <(DateTime d) => isBefore(d);
  bool operator >=(DateTime d) => isAfter(d) || isAtSameMomentAs(d);
  bool operator <=(DateTime d) => isBefore(d) || isAtSameMomentAs(d);
  DateTime quantize(Duration d, {bool up = true}) =>
      DateTime.fromMicrosecondsSinceEpoch(
          microsecondsSinceEpoch.quantize(d.inMicroseconds, up: up));
  Future get waitUntil async {
    final now = DateTime.now();
    if (this <= now) {
      return null;
    }
    await difference(now).wait;
  }
}

extension DurationExtension on Duration {
  Future get wait => Future.delayed(this);
}

extension Tupler<T> on T {
  ZipTuple<T, S> tupled<S>(S s) => ZipTuple(this, s);
}

extension PhotoFirePhotoExtension on $pb.Photo {
  $pb.FirePhoto firePhoto($pb.DocumentReferenceProto reference) => {
        'photo_reference': reference,
        'firebase_storage': firebaseStoragePath,
        'center': inferenceData.detectionCenter,
        'photo_size': photoSize,
      }.asProto($pb.FirePhoto());
}

String enumToString(Object object) => object.toString().split('.').last;
T toDartEnum<T>(String v, List<T> enumValues, {T defaultValue}) => enumValues
    .firstWhere((x) => enumToString(x) == v, orElse: () => defaultValue);

const _latPerM = 1 / 111111.0;

Set<String> tiles(num lat, num lng, int zoom, num radiusMeters) => [-1, 0, 1]
    .cartesian([-1, 0, 1])
    .zipMap((a, b) =>
        [lat + a * radiusMeters * _latPerM, lng + b * radiusMeters * _latPerM])
    .map((l) {
      final latitude = l[0].clamp(-90, 90);
      final n = 1 << zoom;
      final x = n * ((l[1] + 180 + 360) % 360) / 360;
      final lat = latitude * math.pi / 180;
      final y =
          n * (1 - (math.log(math.tan(lat) + 1 / math.cos(lat)) / math.pi)) / 2;
      return [x, y, zoom].map((x) => x.floor()).join(',');
    })
    .toSet();

final foodTypesCutoffs = {
  'dessert': 0.86,
  'breakfast': 0.91,
  'ice cream': 0.87,
  'snack': 0.8,
  'salad': 0.93,
  'seafood': 0.75,
  'cocktail': 0.67,
  'hamburger': 0.9,
  'soup': 0.76,
  'noodle': 0.78,
  'curry': 0.93,
  'coffee': 0.88,
  'wine': 0.83,
  'beer': 0.915,
  'pizza': 0.85,
  'chicken meat': 0.86,
  'sandwich': 0.765,
  'pastry': 0.66,
  'taco': 0.93,
  'french fries': 0.71,
  'fried chicken': 0.84,
  'doughnut': 0.79,
  'spaghetti': 0.92,
  'sushi': 0.84,
  'confectionery': 0.85,
  'bread': 0.89,
  'dim sum': 0.72,
  'shrimp': 0.92,
  'noodle soup': 0.63,
  'street food': 0.8,
  'poached egg': 0.59,
  'petit four': 0.865,
  'ramen': 0.92,
  'cupcake': 0.86,
  'steak': 0.9,
  'fried egg': 0.865,
  "hors d'oeuvre": 0.69,
  'cookie': 0.83,
  'latte': 0.6,
  'macaroon': 0.96,
  'oyster': 0.91,
  'fish': 0.9,
  'beef': 0.78,
  'gyro': 0.91,
  'wonton': 0.93,
  'dumpling': 0.65,
  'chow mein': 0.92,
  'pâtisserie': 0.69,
  'pancake': 0.83,
  'pho': 0.94,
  'hot pot': 0.87,
  'udon': 0.85,
  'xiaolongbao': 0.97,
  'smoked salmon': 0.9,
  'waffle': 0.87,
  'nachos': 0.87,
  'muffin': 0.9,
  'pasta': 0.65,
  'croissant': 0.87,
  'scone': 0.8,
  'risotto': 0.8,
  'cheese fries': 0.87,
  'burrito': 0.865,
  'cannoli': 0.95,
  'cheesecake': 0.77,
  'thai fried rice': 0.9,
  'churro': 0.75,
  'espresso': 0.9,
  'lobster roll': 0.7,
  'charcuterie': 0.87,
  'malasada': 0.8,
  'eggs benedict': 0.66,
  'kakigōri': 0.76,
  'cake': 0.916,
  'capellini': 0.905
};

final foodTypesWhitelist = foodTypesCutoffs.keys.toList();

const _foodTypeExceptions = {
  $pb.FoodType.hors_doeuvre: "Hors d'oeuvre",
};

extension FoodTypeDisplay on $pb.FoodType {
  String get displayString =>
      _foodTypeExceptions[this] ??
      toString()
          .replaceAll('_', ' ')
          .split(' ')
          .map((w) => '${w[0].toUpperCase()}${w.substring(1)}')
          .join(' ')
          .replaceAll(' Or ', '/')
          .replaceAll(' And ', ' and ')
          .trim();
}

// We remap some of the detected labels to the FoodType enum.
const foodTypesRemap = {
  'hamburger': $pb.FoodType.burgers_and_chicken_sandwiches,
  'chicken meat': $pb.FoodType.chicken,
  'doughnut': $pb.FoodType.donut,
  'spaghetti': $pb.FoodType.pasta,
  'poached egg': $pb.FoodType.egg,
  'petit four': $pb.FoodType.confectionery,
  'fried egg': $pb.FoodType.egg,
  'macaroon': $pb.FoodType.macaron,
  'wonton': $pb.FoodType.dumpling,
  'xiaolongbao': $pb.FoodType.soup_dumpling,
  'smoked salmon': $pb.FoodType.salmon,
  'thai fried rice': $pb.FoodType.fried_rice,
  'kakigōri': $pb.FoodType.shaved_ice,
  'pâtisserie': $pb.FoodType.confectionery,
  'capellini': $pb.FoodType.pasta,
};

const foodTypesBlacklist = {'coffee cup'};

$pb.FoodType toFoodType(String str) {
  final normalizedStr = str.toLowerCase().replaceAll(RegExp('[ -]'), '_');
  return $pb.FoodType.values
      .where((type) => type.toString() == normalizedStr)
      .firstOrNull;
}

/// Convert a FB place category/type to PlaceType enum. This has been tested
/// on all resto PlaceTypes as of August 2020.
$pb.PlaceType toPlaceType(String str) {
  final normalizedStr = str
      .toLowerCase()
      .replaceAll(' & ', '_and_')
      .replaceAll(RegExp('[ -]'), '_')
      .replaceAll('ê', 'e')
      .replaceAll('/', '_or_');
  return $pb.PlaceType.values
      .where((type) => type.toString() == normalizedStr)
      .firstOrNull;
}

const _placeTypeExceptions = {
  $pb.PlaceType.beer_bar: 'Beer',
  $pb.PlaceType.ice_cream_shop: 'Ice Cream',
  $pb.PlaceType.gelato_shop: 'Gelatos',
  $pb.PlaceType.taco_restaurant: 'Taco Joint',
  $pb.PlaceType.live_and_raw_food_restaurant: 'Live/Raw Food',
  $pb.PlaceType.frozen_yogurt_shop: 'Frozen Yogurt',
  $pb.PlaceType.cupcake_shop: 'Cupcakes',
  $pb.PlaceType.bagel_shop: 'Bagels',
  $pb.PlaceType.tapas_bar_and_restaurant: 'Tapas',
  $pb.PlaceType.dessert_shop: 'Desserts',
  $pb.PlaceType.bubble_tea_shop: 'Milk Tea/Boba',
  $pb.PlaceType.chocolate_shop: 'Chocolate',
};

extension PlaceTypeDisplay on $pb.PlaceType {
  String get displayString {
    if (_placeTypeExceptions.containsKey(this)) {
      return _placeTypeExceptions[this];
    }
    return toString()
        .replaceAll('_', ' ')
        .replaceAll(' restaurant', '')
        .replaceAll('restaurant', '')
        .split(' ')
        .map((w) => '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ')
        .replaceAll(' Or ', '/')
        .replaceAll(' And ', ' and ')
        .trim();
  }
}

final placeTypes = $pb.PlaceType.values.skip(1).listMap((x) => x.displayString)
  ..sort((a, b) => a.compareTo(b));

// Run `dart lib/extensions.dart` to test foodTypeSearch/placeTypeSearch
void main() {
  readLine().listen((line) {
    print('FoodType results: ' +
        foodTypeSearch
            .search(line)
            .map((result) => '${result.object.displayString} (${result.score})')
            .join(', '));
    print('PlaceType results: ' +
        placeTypeSearch
            .search(line)
            .map((result) => '${result.object.displayString} (${result.score})')
            .join(', '));
  });
}

Stream<String> readLine() =>
    stdin.transform(utf8.decoder).transform(const LineSplitter());

void processLine(String line) {
  print(line);
}

/// Represents a single item that can be searched for. The `terms` are all
/// variants that match the item. For e.g. the item `$pb.PlaceType.coffee_shop`
/// could have terms: 'coffee', 'latte', etc.
class TextSearchItem<T> {
  final T object;
  final List<String> terms;

  const TextSearchItem(this.object, this.terms);
}

/// A search result containing the matching `object` along with the `score`.
class TextSearchResult<T> {
  final T object;
  final double score;

  TextSearchResult(this.object, this.score);
}

/// Used for doing simple in-memory text searching based on a given set of
/// `TextSearchItem`s. Lower scores are better, with exact case-insensitive
/// matches scoring 0. Uses `JaroWinkler` distance.
class TextSearch<T> {
  TextSearch(this.items);
  static final _editDistance = JaroWinkler();

  final List<TextSearchItem<T>> items;

  List<TextSearchResult<T>> search(String term, {double matchThreshold = 1.0}) {
    return items
        .map((item) => Tuple2(
            item,
            item.terms
                .map((itemTerm) => _scoreTerm(term, itemTerm))
                .reduce(math.min)))
        .tupleSort((t) => [t.item2])
        .where((t) => t.item2 < matchThreshold)
        .map((t) => TextSearchResult(t.item1.object, t.item2))
        .toList();
  }

  double _scoreTerm(String searchTerm, String itemTerm) {
    searchTerm = searchTerm.toLowerCase();
    itemTerm = itemTerm.toLowerCase();
    if (searchTerm == itemTerm) {
      return 0;
    }
    return _editDistance.normalizedDistance(
            searchTerm.toLowerCase(), itemTerm.toLowerCase()) *
        searchTerm.length;
  }
}

final _placeTypeSearchTermExceptions = {
  $pb.PlaceType.chicken_joint: [
    'chicken joint',
    'chicken',
    'fried chicken',
    'chicken sandwich',
  ],
  $pb.PlaceType.bubble_tea_shop: ['bubble tea', 'milk tea', 'boba'],
  $pb.PlaceType.frozen_yogurt_shop: ['frozen yogurt', 'fro yo', 'fro-yo'],
  $pb.PlaceType.sandwich_shop: ['sandwiches', 'sandwich', 'sando'],
  $pb.PlaceType.pizza_place: ['pizza', 'pizzeria'],
  $pb.PlaceType.breakfast_and_brunch_restaurant: ['brunch', 'breakfast'],
  $pb.PlaceType.coffee_shop: [
    'coffee',
    'latte',
    'cappuccino',
    'macchiato',
    'espresso',
  ],
  $pb.PlaceType.cafe: ['cafe', 'café'],
  $pb.PlaceType.creperie: ['crepes', 'crêpes', 'creperie', 'crêperie'],
  $pb.PlaceType.sushi_restaurant: ['sushi', 'sashimi', 'nigiri'],
  $pb.PlaceType.burger_restaurant: ['hamburger', 'burger'],
  $pb.PlaceType.deli: ['deli', 'delicatessen'],
  $pb.PlaceType.vegetarian_or_vegan_restaurant: ['vegetarian', 'vegan'],
  $pb.PlaceType.gluten_free_restaurant: ['gf', 'gluten free'],
  $pb.PlaceType.smoothie_and_juice_bar: ['smoothies', 'juice bar'],
  $pb.PlaceType.donut_shop: ['doughnut', 'donuts', 'donut shop'],
  $pb.PlaceType.dim_sum_restaurant: ['dim sum', 'dumplings', 'wonton'],
  $pb.PlaceType.wine_or_spirits: ['wine', 'spirits'],
  $pb.PlaceType.winery_or_vineyard: ['vineyard', 'winery'],
  $pb.PlaceType.szechuan_or_sichuan_restaurant: ['szechuan', 'sichuan'],
  $pb.PlaceType.persian_or_iranian_restaurant: ['iranian', 'persian'],
  $pb.PlaceType.bossam_or_jokbal_restaurant: ['bossam', 'jokbal'],
  $pb.PlaceType.bengali_or_bangladeshi_restaurant: ['benagli', 'bangladeshi'],
  $pb.PlaceType.udon_restaurant: ['noodles', 'yaki udon', 'udon'],
  $pb.PlaceType.noodle_house: ['noodles', 'noodle soup'],
  $pb.PlaceType.ramen_restaurant: ['ramen', 'ramen noodles', 'noodles'],
  $pb.PlaceType.seafood_restaurant: [
    'fish',
    'shrimp',
    'lobster',
    'scallops',
    'crab',
    'oyster',
    'mussles',
    'seafood',
  ],
};

final _placeTypeSearchItems = $pb.PlaceType.values
    // Skip UNDEFINED
    .skip(1)
    .map((p) => TextSearchItem(
        p, _placeTypeSearchTermExceptions[p] ?? [p.displayString]))
    .toList();

final placeTypeSearch = TextSearch(_placeTypeSearchItems);

const _foodTypeSearchTermExceptions = {
  $pb.FoodType.burgers_and_chicken_sandwiches: [
    'burgers',
    'hamburgers',
  ],
  $pb.FoodType.hors_doeuvre: ["Hors d'oeuvre"],
};

final _foodTypeSearchItems = $pb.FoodType.values
    // Skip UNDEFINED
    .skip(1)
    .map((p) => TextSearchItem(
        p, _foodTypeSearchTermExceptions[p] ?? [p.displayString]))
    .toList();

final foodTypeSearch = TextSearch(_foodTypeSearchItems);

// Queried from 180k restos.
const kGmYelpMean = 1022.15;
const kGmYelpStdDev = 408.5;
const kIgMean = 881.69744;
const kIgStdDev = 15007.14342;

extension RestoScore on num {
  double zScore(double mu, double sigma) => _clampZScores((this - mu) / sigma);
}

double _clampZScores(double score) =>
    score < 8 ? score : 8 + math.sqrt(score - 8);
