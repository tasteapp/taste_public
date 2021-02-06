import '../utilities.dart';

export 'import_mailchimp.dart';
export 'missing_photos_fix.dart';

Future batchForceUpdateQuery(
  List<QuerySnapshot> query, {
  Duration duration,
  String updateField = '_force_update',
}) async {
  duration ??= 0.seconds;
  final doBatch = duration != null;
  final documents = query.expand((c) => c.documents);
  final chunkSize = doBatch ? 150 : documents.length;
  final groups = documents.chunk(chunkSize);
  final waitTime = duration ~/ groups.length;
  for (final group in groups.enumerate) {
    await autoBatch(
      (t) => group.value.futureMap((s) async => t.update(s.reference,
          {updateField: DateTime.now().millisecondsSinceEpoch}.updateData)),
    );
    print('updated ${chunkSize * (1 + group.key)} of ${documents.length}');
    await waitTime.wait;
  }
}

Future batchForceUpdateCollection(
  Set<CollectionType> collectionsToUpdate, {
  Duration duration,
  String updateField = '_force_update',
}) async {
  duration ??= 0.seconds;
  final collections =
      await collectionsToUpdate.futureMap((c) => c.coll.select([]).get());
  await batchForceUpdateQuery(collections, duration: duration);
}

Future seedTestDb() async {
  final fixture = Fixture();
  final user = await fixture.createUser(
      username: 'jackdreilly',
      vanityPhoto: await fixture.createPhoto(
          path:
              'users/HgYyNvShldgtcb7xHtHnxQK30lz1/uploads/1586348050865.jpg'));
  final photo = await fixture.createPhoto(
      photoUser: user,
      path: 'users/HgYyNvShldgtcb7xHtHnxQK30lz1/uploads/1580058433815.jpg');
  await fixture.createReview(user: user, photo: photo);
  await fixture.createReview(
      user: user, home: true, photo: photo, dish: 'Home Cooked Deliciousness');
}

Future backfillUids() async =>
    autoBatch((t) async => (await TasteUsers.get(trans: t))
        .futureMap((t) => t.updateSelf({'uid': t.uid})));
