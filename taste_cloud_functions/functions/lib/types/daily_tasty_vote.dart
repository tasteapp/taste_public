import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_cloud_functions/types/daily_tasty.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show DailyTastyVote;

part 'daily_tasty_vote.g.dart';

const _parentField = 'post';

@RegisterType()
mixin DailyTastyVote
    on
        FirestoreProto<$pb.DailyTastyVote>,
        ParentUpdater,
        UserOwned,
        ParentHolder,
        UniqueUserIndexed {
  static final triggers = trigger<DailyTastyVote>(
    create: (r) => [
      r.ensureIndexCreated,
    ],
    delete: (r) => [
      r.ensureIndexDeleted,
    ],
  );

  double get score => proto.score;

  @override
  String get parentField => _parentField;

  @override
  Future<List<DocumentReference>> get referencesToUpdate async => [parent];

  static void registerInternal() {
    final fn = tasteFunctions.pubsub
        .schedule('0 0 * * *')
        .timeZone('America/Los_Angeles')
        .onRun((message, context) => awardDailyTasty());
    registerFunction('daily_tasty_pubsub', fn, fn);
  }
}
