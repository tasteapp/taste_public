import 'package:taste_cloud_functions/taste_functions.dart';

/// Converts a non-iterable into a length-1 iterable containing itself, and
/// passes iterables through. Convenient way to simulate variadics.
Iterable<dynamic> singleToIterable(dynamic v) {
  if (v is Iterable) {
    return v;
  }
  return [v];
}

/// Typedef for the value that's stored in `main` `functions` registration.
typedef CloudFn = void Function(dynamic a, dynamic b);

UpdateData fromNestedMap(Map<String, dynamic> input) =>
    UpdateData.fromMap(dotFlatten(input));

Map<String, dynamic> dotFlatten(Map<String, dynamic> input) {
  Map<String, dynamic> fn(Map<String, dynamic> input, Iterable<String> path) =>
      Map.fromEntries(input.entries.expand((e) => e.value is Map
          ? fn(Map.from(e.value as Map), path.followedBy([e.key])).entries
          : [
              MapEntry(path.followedBy([e.key]).join('.'), e.value)
            ]));

  return fn(input, []);
}

String refLink(DocumentReference reference) =>
    'https://go/$goRef/${reference.path}';
final goRef = (buildType == BuildType.prod) ? 'ref' : 'dref';

final emptyDocData = DocumentData();

bool deepEquals(a, b) => const DeepCollectionEquality().equals(a, b);
bool firestoreEquals(a, b) => a is DocumentData
    ? firestoreEquals(a.toMap(), b)
    : b is DocumentData
        ? firestoreEquals(a, b.toMap())
        : (((a is Map) ^ (b is Map)) || ((a is Iterable) ^ (b is Iterable)))
            ? false
            : a is Map
                ? deepEquals(a, b)
                : (a is Iterable)
                    ? deepEquals(a.toList(), (b as Iterable).toList())
                    : a == b;

Review reviewOrHomeMeal(
        DocumentSnapshot snapshot, BatchedTransaction transaction) =>
    snapshot == null
        ? null
        : (snapshot.reference.isA(CollectionType.home_meals)
            ? HomeMeals.make
            : Reviews.make)(snapshot, transaction);

/// This transaction type is a bit of a lie, as it immediately performs any
/// action asked of it, outside the scope of any actual transaction.
class ImmediateTransaction implements BatchedTransaction {
  @override
  Future<T> inner<T>(Future<T> Function(BatchedTransaction t) fn) => fn(this);
  @override
  Future<DocumentReference> create(
      DocumentReference reference, DocumentData data) async {
    await reference.setData(data);
    return reference;
  }

  @override
  FutureOr<DocumentReference> delete(DocumentReference reference,
      {Timestamp lastUpdateTime}) async {
    await reference.delete();
    return reference;
  }

  @override
  Future<DocumentSnapshot> get(DocumentReference reference) => reference.get();

  @override
  Future<QuerySnapshot> getQuery(DocumentQuery query) => query.get();

  @override
  FutureOr<DocumentReference> set(
      DocumentReference reference, DocumentData data,
      {bool merge = false}) async {
    await reference.setData(data, SetOptions(merge: merge));
    return reference;
  }

  @override
  Future<DocumentReference> update(DocumentReference reference, UpdateData data,
      {Timestamp lastUpdateTime}) async {
    await reference.updateData(data);
    return reference;
  }

  @override
  void commit() {
    return null;
  }

  @override
  String get eventId => 'event-id';

  @override
  JsTransaction get nativeInstance => throw UnimplementedError();
}

final quickTrans = ImmediateTransaction();
