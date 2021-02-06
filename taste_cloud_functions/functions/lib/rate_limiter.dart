/// Trigger a rate-limited event using RateLimiter.user_badge(referenceToUpdate)
///
/// The call above is the only public API access.
///
/// [registerRateLimiter] must be called on initialization.
import 'taste_functions.dart';

enum RateLimiter {
  // ignore: constant_identifier_names
  user_badge,
}

extension RateLimiterExt on RateLimiter {
  Future call(DocumentReference reference) =>
      firestore.runTransaction((t) async {
        final ref = _ref(reference);
        final snapshot = await t.get(ref);
        if (!snapshot.exists) {
          return t.create(ref, DocumentData());
        }
        final date =
            snapshot.data.getTimestamp('date')?.toDateTime() ?? DateTime(0);
        if (date > DateTime.now() + _quantum) {
          return null;
        }
        await t.set(
            ref,
            DocumentData.fromMap(
                {'date': (DateTime.now() + _delay).quantize(_quantum)}));
      });
  DocumentReference _ref(DocumentReference reference) =>
      'rate_limiters/$_key/c/${reference.parent.id}/i/${reference.documentID}'
          .ref;
  String get _key => enumToString(this);
}

final _quantum = 5.seconds;
final _delay = _quantum * 2;

final _lookup =
    <RateLimiter, Future Function(BatchedTransaction t, DocumentReference ref)>{
  RateLimiter.user_badge: (t, ref) async =>
      (await TasteUsers.forRef(ref, t))?.updateUserBadgesRateLimited(),
};
final registerRateLimiter = () {
  final fn = tasteFunctions.firestore
      .document('rate_limiters/{type}/c/{c}/i/{i}')
      .onWrite((c, _) {
    if (!c.after.exists) {
      return null;
    }
    final snapshot = c.after;
    final paths = snapshot.reference.path.split('/').reversed.toList();
    final type =
        RateLimiter.values.firstWhere((x) => enumToString(x) == paths[4]);
    final ref = [paths[2], paths[0]].join('/').ref;
    final date =
        snapshot.data.getTimestamp('date')?.toDateTime() ?? DateTime(0);
    return BatchedTransaction.batchedTransaction('trigger', (t) async {
      await date.waitUntil;
      await _lookup[type](t, ref);
    });
  });
  registerFunction('trigger_rate_limiters', fn, fn);
}();
