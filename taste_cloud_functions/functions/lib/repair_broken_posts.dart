import 'package:taste_cloud_functions/taste_functions.dart';

class _Result {
  _Result._(this.reference, this.info, this.reason, this.action);
  static _Result parse(List<String> s) =>
      _Result._(s[0].ref, s[1], s[2], toDartEnum(s[3], _Action.values));
  final DocumentReference reference;
  final String info;
  final String reason;
  final _Action action;
  @override
  String toString() => [reference, info, reason, action].toString();
}

enum _Action {
  // ignore: constant_identifier_names
  repair_photos,
  // ignore: constant_identifier_names
  convert_to_review,
  delete,
}
typedef _Perform = Future Function(
    List<DocumentReference> r, BatchedTransaction t);

final _actions = <_Action, _Perform>{
  _Action.repair_photos: (r, t) async => structuredLog(
      'repair_broken_posts', t.eventId, 'bad_photos', r.listMap((r) => r.path)),
  _Action.convert_to_review: (r, t) async =>
      (await r.futureMap((r) => HomeMeals.forRef(r, t)))
          .futureMap((h) => h.migrateBetweenMealTypes()),
  _Action.delete: (r, t) async => r.futureMap((r) async => t.delete(r)),
};

Future<List<_Result>> get _results => tasteBQ(
    '''SELECT reference, info, reason, action FROM `$projectId.firestore_export.broken_posts`''',
    _Result.parse);

Future checkBrokenPosts() async {
  final results = await _results;
  if (results.isEmpty) {
    return;
  }
  await sendSlack(
      '${results.length} broken posts detected http://go/broken-posts${buildType.isDev ? '-dev' : ''}');
}

final registerCheckBrokenPosts = () {
  final fn = tasteFunctions.pubsub
      .schedule('every 24 hours')
      .onRun((_, __) => checkBrokenPosts());
  registerFunction('check_broken_posts', fn, fn);
}();

Future repairBrokenPosts([bool dryRun = false]) async {
  await autoBatch(
    (t) async => (await _results)
        .sorted((x) => x.action.index)
        .distinctOn((x) => x.reference)
        .groupBy((x) => x.action)
        .withoutEmpties
        .entries
        .sideEffect((x) => print(x.map((x) => [x.key, x.value]).join('\n')))
        .futureMap((k, v) => _actions[k](v.listMap((v) => v.reference), t)),
    eventId: 'repair_broken_posts',
    dryRun: dryRun,
  );
}

Future photoFixProposals(bool dryRun) async {
  final results = (await tasteBQ(
      '''SELECT reference, proposal, 'reason', 'repair_photos' FROM `$projectId.firestore_export.photo_fix_proposals`''',
      _Result.parse));
  await autoBatch(
      (t) async => (await results.futureMap((r) async =>
                  reviewOrHomeMeal(await t.get(r.reference), t).tupled(r.info)))
              .futureMap((z) async {
            final r = z.a;
            final path = z.b ?? '';
            print([r.path, path]);
            if (r.proto.firePhotos.isNotEmpty) {
              print('fire-photos not empty');
              return null;
            }
            final allPhotos = [r.proto.photo, ...r.proto.morePhotos];
            final keepers = await allPhotos
                .where((x) => x.exists)
                .futureWhere((x) async => (await x.ref.tGet(t)).exists);
            if (keepers.length == allPhotos.length) {
              print('recaching fire-photos');
              return r.recacheFirePhotos();
            }
            if (keepers.isNotEmpty) {
              print('removing bad photos');
              return r.updateSelf({
                'photo': keepers.first,
                'more_photos': keepers.skip(1).toList(),
                'fire_photos': []
              }.ensureAs(r.prototype, explicitEmpties: true));
            }
            if (path.isEmpty) {
              print('deleting bogus post');
              return r.deleteSelf();
            }
            final photo = await Photos.createNew(t,
                data: {'firebase_storage_path': path}.documentData);
            print('creating new photo $photo');
            return r.updateSelf({
              'photo': photo,
              'more_photos': [],
              'fire_photos': []
            }.ensureAs(r.prototype, explicitEmpties: true));
          }),
      eventId: 'fix_photos',
      dryRun: dryRun);
  if (results.isNotEmpty) {
    await sendSlack('${results.length} broken photos fixed');
  }
}
