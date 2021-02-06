import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show Favorite;

part 'favorite.g.dart';

@RegisterType()
mixin Favorite
    on
        FirestoreProto<$pb.Favorite>,
        ParentUpdater,
        UserOwned,
        ParentHolder,
        UniqueUserIndexed {
  static final triggers = trigger<Favorite>(
    delete: (r) => [
      r.updateParents(),
      r.ensureIndexDeleted,
      r.deleteLinkedNotifications()
    ],
    create: (r) => [
      r.updateParents(),
      r.ensureIndexCreated,
    ],
  );
  Future<Restaurant> get restaurant async =>
      Restaurants.make(await getRef(restaurantRef), transaction);

  DocumentReference get restaurantRef => proto.restaurant.ref;

  Future updateAlgoliaRecords() => [
        (() async => (await restaurant)?.updateAlgoliaRecords())(),
        (() async => (await user)?.updateAlgoliaRecords())(),
      ].wait;

  static Future<Favorite> createForRestaurantUser(
      Restaurant restaurant, TasteUser user) async {
    final data = {'user': user.ref, 'restaurant': restaurant.ref}
        .ensureAs($pb.Favorite())
        .documentData;
    final reference =
        await restaurant.addToCollection(Favorites.collection, data);
    return Favorites.makeSimple(data, reference, restaurant.transaction);
  }

  static Future<bool> removeFavoriteForUser(
      Restaurant restaurant, TasteUser user) async {
    final result = await restaurant.transaction.getQuery(CollectionType
        .favorites.coll
        .where('restaurant', isEqualTo: restaurant.ref)
        .where('user', isEqualTo: user.ref)
        .limit(1));
    if (result.isEmpty) {
      return false;
    }
    await restaurant.transaction.delete(result.documents.first.reference);
    return true;
  }

  @override
  String get parentField => 'restaurant';

  @override
  Future<List<DocumentReference>> get referencesToUpdate async =>
      (await [restaurant, user].wait).listMap((r) => r.ref);
}
