import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/screens/messaging/conversation_page.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'responses.dart';

class Conversation extends SnapshotHolder<$pb.Conversation> {
  Conversation(DocumentSnapshot snapshot) : super(snapshot);

  Set<DocumentReference> get otherUsers => proto.members
      .map((r) => r.ref)
      .toSet()
      .difference({currentUserReference});

  $pb.Conversation_Message get latestMessage =>
      proto.messages.max((msg) => msg.sentAt.toDateTime());
  String get _lastSeenKey =>
      proto.members.indexOf(currentUserReference.proto).toString();
  DateTime get lastSeen =>
      proto.lastSeen[_lastSeenKey]?.toDateTime() ?? _longAgo;
  static final _longAgo = DateTime(1970);
  bool get seen =>
      proto.seenBy.contains(currentUserReference.proto) ||
      lastSeen.isAfter(latestMessage?.sentAt?.toDateTime() ?? _longAgo);

  Future goToPage() async {
    final other = await otherUsers.first.fetch<TasteUser>();
    final image = other.profileImage();
    await quickPush(
        TAPage.conversation,
        (_) => ConversationPage(
            conversation: this, otherUser: other, otherUserPhotoUrl: image));
  }

  Future markWatching(bool enable) => reference.updateData({
        'last_seen.$_lastSeenKey': DateTime.now(),
        'seen_by': (enable ? FieldValue.arrayUnion : FieldValue.arrayRemove)([
          currentUserReference,
        ])
      });
}
