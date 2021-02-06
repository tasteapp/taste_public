import 'package:flutter/material.dart';
import 'package:taste/screens/profile/posts_tab.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';

import 'post_interface.dart';

class BookmarksTab extends StatelessWidget {
  const BookmarksTab({Key key, this.user}) : super(key: key);
  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>>(
        stream: user.bookmarks,
        builder: (context, snapshot) => snapshot.hasError
            ? const Center(
                child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("Trouble loading bookmarks..."),
              ))
            : !snapshot.hasData
                ? const Center(child: CircularProgressIndicator())
                : SmartSortedGrid(
                    key: const PageStorageKey("bookmarks"),
                    reviews: snapshot.data,
                    emptyWidget: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 92, 50, 0),
                      child: Text(
                        user.isMe
                            ? "Posts you save will appear here, tap the save icon on posts "
                                "that you want to try, and they'll appear here!"
                            : "${user.name} hasn't saved anything yet.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "Quicksand",
                          color: Color(0xFF6D7278),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ));
  }
}
