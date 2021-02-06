import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taste/algolia/search_result.dart';
import 'package:taste/screens/messaging/conversation_page.dart';
import 'package:taste/screens/review/search_tile.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste/utils/utils.dart';

class NewConversationPage extends StatefulWidget {
  const NewConversationPage({Key key}) : super(key: key);

  @override
  _NewConversationPageState createState() => _NewConversationPageState();
}

class _NewConversationPageState extends State<NewConversationPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('New Message', style: kAppBarTitleStyle),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(hintText: 'Search user...'),
                textAlignVertical: TextAlignVertical.top,
                controller: controller,
                maxLines: 1,
                autofocus: true,
              ),
            ),
            Expanded(child: SearchResults(textController: controller)),
          ],
        ));
  }
}

class SearchResults extends StatefulWidget {
  const SearchResults({Key key, this.textController}) : super(key: key);

  final TextEditingController textController;

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  Stream<List<SearchResult>> stream;
  final _textStreamController = StreamController<String>();

  @override
  void initState() {
    super.initState();

    final user = currentUserReference;
    widget.textController.addListener(() {
      if (_textStreamController.isClosed) {
        return;
      }
      _textStreamController.add(widget.textController.text);
    });
    stream = _textStreamController.stream
        .startWith('')
        .sampleTime(const Duration(milliseconds: 300))
        .asyncMap((searchText) async {
          if (searchText.isEmpty) {
            return <SearchResult>[];
          }

          return searchEverything(tags: {'user'}, term: searchText);
        })
        .debounceTime(const Duration(milliseconds: 300))
        .map((s) => s.where((s) => s.reference != user).toList());
  }

  @override
  void dispose() {
    _textStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SearchResult>>(
      stream: stream,
      initialData: const [],
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Crashlytics.instance.recordError(snapshot.error, null);
          return const Center(
              child:
                  Text('Could not search for users... please try again soon.'));
        }
        final results = snapshot.data;

        return ListView.builder(
          itemBuilder: (_, idx) {
            final searchResult = results[idx];
            return SearchTile(
              key: Key(searchResult.reference.path),
              text: searchResult.snapshot['name'] as String,
              subtitle: searchResult.snapshot['username'] as String,
              id: searchResult.reference.path,
              type: CollectionType.users,
              onTap: () async {
                final otherUser =
                    await searchResult.reference.fetch<TasteUser>();
                // Ensure we pop out of the search screen, so that navigating
                // back takes us to the "Messages" page.
                await quickPop();
                await startConversation(
                  otherUser: otherUser,
                );
              },
            );
          },
          itemCount: results.length,
        );
      },
    );
  }
}

Future<void> startConversation({
  TasteUser otherUser,
}) async {
  final convo = await spinner(() => conversationWith(otherUser.reference));
  final otherUserPhotoUrl = otherUser.profileImage();
  await quickPush(
    TAPage.conversation,
    (_) => ConversationPage(
      conversation: convo,
      otherUser: otherUser,
      otherUserPhotoUrl: otherUserPhotoUrl,
    ),
  );
}
