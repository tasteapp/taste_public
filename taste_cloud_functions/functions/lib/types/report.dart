import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'report.g.dart';

@RegisterType()
mixin Report on FirestoreProto<$pb.Report>, UserOwned, ParentHolder {
  static final triggers = trigger<Report>(
      create: (r) => sendSlack('User Report: ${refLink(r.ref)}'),
      update: (r, _) async => r.proto.resolved &&
              r.proto.sendNotification &&
              r.proto.resolutionText.isNotEmpty
          ? (await r.user).sendNotification(
              notificationType: NotificationType.flagged_review_update,
              title: 'Update on Flagged Review',
              body: r.proto.resolutionText,
              documentLink: r.ref)
          : true);
}
