import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/screens/discover/components/list_comment_widget.dart';
import 'package:taste/screens/review/comment_text_widget.dart';
import 'package:taste/screens/review/components/add_comment_page.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/utils.dart';

import 'expand_widget.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({Key key, this.post}) : super(key: key);
  final DiscoverItem post;
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title:
              const AutoSizeText('Comments', minFontSize: 12, maxFontSize: 18),
          actions: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: OutlineButton.icon(
                        label: const Text("Add Comment"),
                        icon: const Icon(Icons.add_comment,
                            color: kSecondaryButtonColor),
                        onPressed: () => AddCommentPage.go(post))))
          ]),
      body: StreamBuilder<DiscoverItem>(
          stream: post.asStream,
          initialData: post,
          builder: (context, snapshot) => ListView(
                  padding:
                      const EdgeInsets.only(right: 10, top: 16, bottom: 30),
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ProfilePhoto(
                          user: post.userReference,
                          radius: 20,
                          tapToProfileHero: true,
                        ),
                        Expanded(
                          child: ExpandWidget(
                            builder: (context, isExpanded, toggler) => InkWell(
                              onTap: toggler,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: CommentTextWidget(
                                  maxLines: isExpanded ? null : 5,
                                  fontSize: 14,
                                  text: post.proto.review.rawText,
                                  prefixes: [
                                    TextSpan(
                                      text: '${post.userName ?? ''} ',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(),
                    ),
                    ...snapshot.data.proto.comments
                        .sorted((c) => c.date.seconds)
                        .listMap(
                          (comment) => Row(
                            key: comment.reference.key,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ProfilePhoto(
                                user: comment.user.reference.ref,
                                radius: 20,
                                tapToProfileHero: true,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: ListCommentWidget(
                                    isDetailedView: true,
                                    item: post,
                                    comment: comment,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                  ])));

  static Future go(DiscoverItem post) => quickPush(
        TAPage.comments_page,
        (_) => CommentsPage(post: post),
        transitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder()
          },
        ),
      );
}
