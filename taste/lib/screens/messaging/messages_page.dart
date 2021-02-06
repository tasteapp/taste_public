import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/screens/messaging/conversation_page.dart';
import 'package:taste/screens/messaging/new_conversation_page.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/conversation.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: kPrimaryBackgroundColor,
        centerTitle: true,
        title: const Text('Messages', style: kAppBarTitleStyle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => quickPush(TAPage.new_conversation_page,
                (_) => const NewConversationPage()),
          )
        ],
      ),
      body: StreamBuilder<List<Conversation>>(
          stream: conversations(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              Crashlytics.instance.recordError(snapshot.error, null);
              return const Center(
                  child:
                      Text('Could not load messages, please try again soon'));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final conversations = snapshot.data
                .where((convo) => convo.proto.messages.isNotEmpty)
                .sorted((convo) => -convo.latestMessage.sentAt.seconds)
                .toList();
            if (conversations.isEmpty) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  'No messages',
                  style: TextStyle(fontSize: 20),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                final convo = conversations[index];
                // Currently assumes 2-person convos.
                final otherUserRef = convo.otherUsers.first;
                final latestMessage = convo.latestMessage;
                return ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  onTap: () async {
                    final otherUser = await otherUserRef.fetch<TasteUser>();
                    final otherUserPicUrl = otherUser.profileImage();
                    await quickPush(
                        TAPage.conversation,
                        (_) => ConversationPage(
                            conversation: convo,
                            otherUser: otherUser,
                            otherUserPhotoUrl: otherUserPicUrl));
                  },
                  title: StreamBuilder<TasteUser>(
                    stream: otherUserRef.stream(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data.username,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: kDarkGrey,
                            ),
                          ),
                          AutoSizeText(
                            '${latestMessage.user.ref == currentUserReference ? 'You: ' : ''}${latestMessage.text.ellipsis(20)} · ${timeago.format(latestMessage.sentAt.toDateTime())}',
                            maxFontSize: 15,
                            minFontSize: 12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  leading: ProfilePhoto(
                    user: otherUserRef,
                    radius: 20,
                    tapToProfileHero: true,
                  ),
                  trailing: convo.seen
                      ? null
                      : Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kSecondaryButtonColor,
                          ),
                        ),
                );
              },
              separatorBuilder: (_, idx) => const Divider(),
              itemCount: conversations.length,
            );
          }),
    );
  }
}
