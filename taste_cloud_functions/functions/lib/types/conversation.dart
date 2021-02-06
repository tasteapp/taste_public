import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show Conversation;
import 'package:taste_protos/taste_protos.dart'
    show Conversation_Message, Notification_FCMSettings;

part 'conversation.g.dart';

@RegisterType()
mixin Conversation on FirestoreProto<$pb.Conversation> {
  static final triggers = trigger<Conversation>(
    update: (convo, change) =>
        (change.before.messagesCount < convo.messagesCount ||
                convo.messagesCount == 1)
            ? convo.notifyMembers()
            : null,
  );

  Set<DocumentReference> get seenBy => proto.seenBy.map((r) => r.ref).toSet();
  bool saw(TasteUser member) => seenBy.contains(member.ref);
  int get messagesCount => proto.messages.length;

  Future notifyMembers() async {
    final latestMessage = proto.messages.max((m) => m.sentAt.toDateTime());
    final sender = await latestMessage.user.fetch(TasteUsers.make, transaction);
    final members = await proto.members.fetch(TasteUsers.make, transaction);

    for (final member in members) {
      if (sender.path == member.path) {
        continue;
      }
      if (member.username == 'taste') {
        // Taste account send Slack.
        await sendSlack('Message from ${sender.username}: $latestMessage\n\n'
            'https://go/ref/${ref.path}');
      }
      await member.sendNotification(
        documentLink: ref,
        title: 'New message from ${sender.username}',
        body: '${sender.username}: ${latestMessage.trimmedText}',
        update: true,
        seen: saw(member),
        notificationType: NotificationType.conversation,
        fcmSettings: !saw(member)
            ? Notification_FCMSettings.fcm_settings_on_all_events
            : null,
      );
    }
  }
}

const _maxCharsInNotification = 50;

extension on Conversation_Message {
  String get trimmedText => text.ellipsis(_maxCharsInNotification);
}
