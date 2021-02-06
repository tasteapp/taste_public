import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb
    show BugReport, BugReportType;

part 'bug_report.g.dart';

@RegisterType()
mixin BugReport on FirestoreProto<$pb.BugReport> {
  static final triggers = trigger<BugReport>(
      create: (report) => [
            sendSlack(
                "${report.isBug ? "Bug" : "Feedback"} Reported: ${refLink(report.ref)}: ${report.text}"),
            createIssue(
              '${report.proto.reportType}: ${report.text}',
              '${refLink(report.ref)}\n\nMetadata: ${report.proto.metadata}',
            )
          ]);
  String get text => proto.text;
  bool get isBug => proto.reportType == $pb.BugReportType.bug_report;
}
