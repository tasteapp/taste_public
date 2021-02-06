import 'package:taste_protos/taste_protos.dart' as pb;

import 'utilities.dart';

void main() {
  group('proto-transforms', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('nullify enum', () {
      expect(nullifyEnum(null), isNull);
      expect(nullifyEnum(pb.NotificationType.UNDEFINED), isNull);
      expect(nullifyEnum(pb.NotificationType.message),
          equals(pb.NotificationType.message));
    });
    test('to ref', () async {
      final comment = pb.Comment();
      comment.ensureParent().path = 'review/a';
      expect(comment.asMap.documentData.getReference('review').path,
          equals('review/a'));
    });
    test('timestamp', () async {
      final now = DateTime.now().toUtc();
      final comment = pb.Comment();
      comment.ensureExtras().createdAt = pb.Timestamp.fromDateTime(now);
      final data = comment.documentData;
      expect(
          data
              .getNestedData('_extras')
              .getTimestamp('created_at')
              .toDateTime()
              .toUtc(),
          equals(now));
      final fullLoop = data.asProto(pb.Comment());
      expect(fullLoop.extras.createdAt.toDateTime().toUtc(), equals(now));
    });
    test('enum', () {
      expect(ProtoTransforms.toCallFnOutput(pb.NotificationType.UNDEFINED),
          isNull);
      expect(ProtoTransforms.toCallFnOutput(pb.NotificationType.message),
          equals('message'));
      expect(
          ProtoTransforms.fromMap(
              pb.Notification(), {'notification_type': null}).notificationType,
          equals(pb.NotificationType.UNDEFINED));
      expect(ProtoTransforms.fromMap(pb.Notification(), {}).notificationType,
          equals(pb.NotificationType.UNDEFINED));
      expect(
          ProtoTransforms.fromMap(
                  pb.Notification(), {'notification_type': 'message'})
              .notificationType,
          equals(pb.NotificationType.message));
      expect(
          {'notification_type': 'message'}
              .ensureAs(pb.Notification())
              .documentData
              .getString('notification_type'),
          equals('message'));
      expect(ProtoTransforms.fromMap(pb.Notification(), {}), isNotNull);
      expect(
          <String, dynamic>{}
              .ensureAs(pb.Notification())
              .documentData
              .getString('notification_type'),
          isNull);
      expect(
          {'notification_type': 'UNDEFINED'}
              .ensureAs(pb.Notification())
              .documentData
              .getString('notification_type'),
          equals('UNDEFINED'));
    });
  });
}
