import 'utilities.dart';

void main() {
  group('instagram-post-review', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('update-index', () async {
      final post = await InstagramPosts.createNew(quickTrans,
          data: {
            'location': {'latitude': 37, 'longitude': -122}
          }.documentData);
      expect(post.proto.hasSpatialIndex(), isFalse);
      Future updateSpatialIndex([String startingId]) => autoBatch((t) async {
            var snapshot = startingId == null
                ? null
                : await InstagramPosts.collection.document(startingId).get();
            final batch = 10000;
            var total = 0;
            while (true) {
              final posts = await InstagramPosts.get(
                  trans: t,
                  queryFn: (q) {
                    q = q.select(['location']).limit(batch);
                    if (snapshot != null) {
                      q = q.startAfter(snapshot: snapshot);
                    }
                    return q;
                  });
              await posts.futureMap((p) => p.updateSelf({
                    'spatial_index': p.spatialIndex
                  }.ensureAs(InstagramPosts.emptyInstance)));
              await t.commit();
              if (posts.length < batch) {
                return true;
              }
              snapshot = posts.last.snapshot;
              print([total += posts.length, snapshot?.reference?.path]);
            }
          });
      await updateSpatialIndex();
      expect((await post.refetch).proto.spatialIndex.levels, hasLength(21));
    });
    test('location prefers restaurant', () async {
      final fixture = Fixture();
      final restaurant = await fixture.restaurant;
      final restoLat = restaurant.geoPoint.latitude;
      final reviewLat = restoLat + 1;
      final review = await fixture.createReview(
          location: LatLng(reviewLat, 0), restaurant: restaurant);
      expect(review.proto.location.latitude, equals(reviewLat));
      expect(review.restaurantLocation.latitude, equals(restoLat));
      expect(
          InstagramPosts.make(
                  await first(CollectionType.instagram_posts.coll), quickTrans)
              .proto
              .location
              .latitude,
          equals(restoLat));
    });
    test('classification', () async {
      await Fixture().review;
      expect(
          InstagramPosts.make(
                  await first(CollectionType.instagram_posts.coll), quickTrans)
              .proto
              .classifications,
          equals([InstagramPost_PhotoClassification.food]));
    });
    test('cell id', () async {
      await Fixture().review;
      expect(
          InstagramPosts.make(
                  await first(CollectionType.instagram_posts.coll), quickTrans)
              .proto
              .spatialIndex
              .asMap,
          equals({
            'cell_id': '533026,518461,20',
            'levels': [
              '0,0,0',
              '1,0,1',
              '2,1,2',
              '4,3,3',
              '8,7,4',
              '16,15,5',
              '32,31,6',
              '65,63,7',
              '130,126,8',
              '260,253,9',
              '520,506,10',
              '1041,1012,11',
              '2082,2025,12',
              '4164,4050,13',
              '8328,8100,14',
              '16657,16201,15',
              '33314,32403,16',
              '66628,64807,17',
              '133256,129615,18',
              '266513,259230,19',
              '533026,518461,20'
            ]
          }));
    });
  });
}
