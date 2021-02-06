import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:deferrable/deferrable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:taste/components/abuse/report_content.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/conversation.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/taste_bottom_sheet.dart';
import 'package:taste_protos/taste_protos.dart' as $pb
    show Conversation_Message;
import 'package:timeago/timeago.dart' as timeago;

class ConversationPage extends StatefulWidget {
  const ConversationPage({
    Key key,
    this.conversation,
    this.otherUser,
    this.otherUserPhotoUrl,
  }) : super(key: key);

  final Conversation conversation;
  final TasteUser otherUser;
  final String otherUserPhotoUrl;

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> with Deferrable {
  @override
  bool get blockSetStateAfterDispose => false;
  final controller = ScrollController();
  final node = FocusNode();

  ChatUser me;

  ChatUser other;

  Stream<Conversation> stream;
  @override
  void initState() {
    super.initState();

    me = ChatUser(name: 'Me', uid: currentUserReference.path);
    other = ChatUser(
      name: widget.otherUser.name,
      uid: widget.otherUser.reference.path,
      avatar: widget.otherUserPhotoUrl,
    );
    defer(Stream.periodic(const Duration(minutes: 1))
        .startWith(null)
        .listen((_) => widget.conversation.markWatching(true))
        .cancel);
    // This value needs to be cached because it can be set null later.
    final markWatching = widget.conversation.markWatching;
    defer(() => markWatching(false));

    // Set to max scroll when keyboard focused or new message
    defer(Rx.merge([
      widget.conversation.reference
          .stream<Conversation>()
          .map((c) => c.latestMessage)
          .distinct()
          .skip(1),
      KeyboardVisibility.onChange.where((e) => e)
    ])
        .listen((_) => Future.delayed(const Duration(milliseconds: 200)).then(
            (_) => controller.jumpTo(controller.position.maxScrollExtent)))
        .cancel);
    stream = widget.conversation.reference.stream();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfilePhoto(
                user: widget.otherUser.reference,
                radius: 15,
                tapToProfileHero: true,
              ),
              const SizedBox(width: 10),
              Text(widget.otherUser.username, style: kAppBarTitleStyle)
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () => showTasteBottomSheetWithItems(context, [
                TasteBottomSheetItem(
                  title: 'Report Conversation',
                  callback: () => reportContent(context, widget.conversation),
                )
              ]),
            ),
          ],
        ),
        body: StreamBuilder<Conversation>(
          stream: stream,
          initialData: widget.conversation,
          builder: (_, snapshot) {
            final conversation = snapshot.data;
            return Stack(
              children: [
                DashChat(
                  scrollController: controller,
                  shouldShowLoadEarlier: false,
                  scrollToBottom: false,
                  // no-op but this needs to be here or throws errors.
                  onLoadEarlier: () => {},
                  user: me,
                  focusNode: node,
                  messages: conversation.proto.messages
                      .map((msg) => ChatMessage(
                            text: msg.text,
                            user: msg.user.ref == currentUserReference
                                ? me
                                : other,
                            createdAt: msg.sentAt.toDateTime(),
                          ))
                      .toList(),

                  onSend: (msg) => conversation.reference.updateData({
                    'messages': FieldValue.arrayUnion([
                      {
                        'user': currentUserReference,
                        'text': msg.text,
                        'sent_at': DateTime.now(),
                      }.ensureAs($pb.Conversation_Message())
                    ])
                  }),
                  inputMaxLines: 20,
                  messageBuilder: (chatMessage) => Align(
                      alignment: chatMessage.user == me
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: chatMessage.user == me
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey[300], width: 1.5),
                              color: chatMessage.user == me
                                  ? Colors.grey[300]
                                  : null,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 7),
                              child: Text(
                                chatMessage.text,
                                style: const TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 15,
                                  color: kDarkGrey,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              timeago.format(chatMessage.createdAt),
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 12),
                            ),
                          ),
                        ],
                      )),
                ),
                Visibility(
                    visible: conversation.proto.messages.isEmpty,
                    child: Center(
                      child: Text(
                        'Start your conversation with ${widget.otherUser.name}',
                        style: const TextStyle(fontSize: 15, color: kDarkGrey),
                      ),
                    ))
              ],
            );
          },
        ),
      );
}
