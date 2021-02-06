import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taste/algolia/search_result.dart';
import 'package:taste/screens/create_review/review/meal_mate.dart';
import 'package:taste/screens/review/search_tile.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/utils/collection_type.dart';

class UserTaggingWidget extends StatefulWidget {
  const UserTaggingWidget(
      {Key key,
      @required this.controller,
      @required this.taggedUsers,
      @required this.fieldNode,
      this.scroll = true})
      : super(key: key);

  final TextEditingController controller;
  final FocusNode fieldNode;
  final void Function(Set<MealMate> selected) taggedUsers;
  final bool scroll;

  @override
  _UserTaggingWidgetState createState() => _UserTaggingWidgetState();
}

class _UserTaggingWidgetState extends State<UserTaggingWidget> {
  Stream<List<SearchResult>> stream;
  final Set<MealMate> taggedUsers = {};
  final _c = StreamController<String>();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (_c.isClosed) {
        return;
      }
      _c.add(widget.controller.text);
      taggedUsers.retainWhere(
          (user) => widget.controller.text.contains('@${user.username}'));
      widget.taggedUsers(taggedUsers);
    });
    stream = _c.stream.startWith('').asyncMap((event) async {
      final lastWord = event.split(' ').last;
      return lastWord.startsWith('@')
          ? (await searchEverything(
                  tags: {'user'}, term: lastWord.substring(1)))
              .where((element) =>
                  (element.snapshot['username'] as String)?.isNotEmpty ?? false)
              .toList()
          : <SearchResult>[];
    }).debounceTime(const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _c.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<Iterable<SearchResult>>(
      stream: stream,
      initialData: const [],
      builder: (c, s) => ((s.data?.isEmpty ?? true) ||
              !widget.fieldNode.hasFocus)
          ? const SizedBox()
          : Card(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: LimitedBox(
                maxHeight: 150,
                child: ListView(
                    shrinkWrap: true,
                    children: s.data
                        .map((searchResult) => InkWell(
                              onTap: () {
                                taggedUsers
                                    .add(MealMate.searchResult(searchResult));
                                widget.controller
                                  ..text =
                                      '${widget.controller.text.substring(0, widget.controller.text.lastIndexOf('@'))}@${searchResult.snapshot['username'] as String} '
                                  ..setToEnd();
                              },
                              child: SearchTile(
                                key: Key(searchResult.reference.path),
                                text: searchResult.snapshot['name'] as String,
                                subtitle:
                                    searchResult.snapshot['username'] as String,
                                id: searchResult.reference.path,
                                type: CollectionType.users,
                              ),
                            ))
                        .toList()),
              ),
            ));
}
