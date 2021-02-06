import 'package:taste_cloud_functions/taste_functions.dart';

Future batchDedupeRestos(BatchedTransaction transaction) async {
  final dump = await BatchDump.fetch(
    transaction,
    {
      CollectionType.favorites,
      CollectionType.restaurants,
      CollectionType.reviews,
    },
    queries: {
      CollectionType.reviews: (q) => q.select(['restaurant']),
      CollectionType.restaurants: (q) => q.select([
            'attributes.location',
            'attributes.fb_place_id',
            'attributes.google_place_id',
          ]).orderBy('attributes.google_place_id'),
    },
  );
  // Find duplicates paired up by google place ID.
  // Every restaurant in the DB should have a unique Google place ID.
  // Thus, we migrate all data from non-unique ID's to one restaurant, the one
  // with the most reviews on our site.
  final duplicates = dump
      .typed<Restaurant>()
      .groupBy((resto) => resto.googlePlaceId)
      .where((k, v) => (k?.isNotEmpty ?? false) && v.length > 1);
  print(['duplicates', duplicates]);
  final reviews = dump.reviews.groupBy((t) => t.restaurantRef);
  final favorites = dump.typed<Favorite>().groupBy((t) => t.restaurantRef);
  final winners = duplicates.mapValue(
      (k, v) => v.tupleMax((t) => [reviews[t.ref]?.length ?? 0, t.ref.path]));

  /// Update review#restaurant/_location for migrated restos.
  await winners.values.futureMap((winner) async {
    final matches = duplicates[winner.googlePlaceId];
    final dupes = [...matches]..remove(winner);
    final dupeReviews = dupes.expand((r) => reviews[r.ref] ?? <Review>[]);
    await dupeReviews.futureMap(
      (review) => review.updateSelf(
        {
          'restaurant': winner.ref,
          'restaurant_location': winner.geoPoint,
        },
        validate: true,
        changeUpdatedAt: false,
      ),
    );
    final faves = duplicates[winner.googlePlaceId]
        .expand((r) => favorites[r.ref] ?? <Favorite>[]);
    await faves
        .groupBy((f) => f.userReference)
        .entries
        .futureMap((user, faves) async {
      await faves.futureMap((f) => f.deleteSelf());
      await Favorites.createNew(transaction,
          data: {'user': user, 'restaurant': winner}
              .ensureAs(Favorites.emptyInstance)
              .documentData
              .withExtras);
    });
    final fbIds =
        matches.map((d) => d.fbPlaceId).toSet().toList().withoutEmpties;
    if (fbIds.isNotEmpty) {
      await winner.updateSelf(
        {
          'attributes': {
            'all_fb_place_ids': Firestore.fieldValues.arrayUnion(fbIds),
          },
        },
      );
    }
    await winner.deleteDynamic(dupes);
  });
}
