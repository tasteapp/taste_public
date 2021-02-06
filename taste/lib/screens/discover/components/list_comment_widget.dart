import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/review/comment_text_widget.dart';
import 'package:taste/screens/review/components/add_comment_page.dart';
import 'package:taste/screens/review/components/edit_comment_page.dart';
import 'package:taste/screens/user_list/user_list.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/parent_user_index.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/utils/taste_bottom_sheet.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' show DiscoverItem_Comment;
import 'package:timeago/timeago.dart' as timeago;

import 'comments_page.dart';

class ListCommentWidget extends StatelessWidget {
  const ListCommentWidget({
    Key key,
    @required this.item,
    @required this.comment,
    this.isDetailedView = false,
  }) : super(key: key);
  final DiscoverItem item;
  final DiscoverItem_Comment comment;
  final bool isDetailedView;

  Function() actions(BuildContext c) =>
      () => showCommentActions(c, item, comment);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: isDetailedView ? actions(context) : () => CommentsPage.go(item),
        onLongPress: actions(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 0, left: 3, right: 8, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CommentTextWidget(
                      prefixes: [
                        TextSpan(
                            text: comment.user.name.append('  '),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                TAEvent.tapped_user_photo({
                                  'tapped_user': comment.user.reference.path
                                });
                                goToUserProfile(comment.user.reference.ref);
                              })
                      ],
                      text: comment.text,
                      maxLines: isDetailedView ? null : 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Row(
                        children: <Widget>[
                          Text(timeago.format(comment.date.toDateTime()),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              )),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: LikedByButton(
                                comment: comment.reference.ref,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
                visible: !comment.isMine(context),
                child: LikeCommentButton(comment: comment)),
          ],
        ),
      );
}

class ReplyToCommentTile extends StatelessWidget {
  const ReplyToCommentTile({Key key, this.item, this.comment})
      : super(key: key);
  final DiscoverItem item;
  final DiscoverItem_Comment comment;

  @override
  Widget build(BuildContext context) => ListTile(
      leading: const Icon(Icons.reply),
      title: const Text("Reply to Comment"),
      onTap: () {
        Navigator.pop(context);
        replyToComment(item, comment);
      });
}

void replyToComment(DiscoverItem item, DiscoverItem_Comment comment) =>
    quickPush(TAPage.reply_comment_page,
        (_) => AddCommentPage(item: item, reply: comment));

void showCommentActions(BuildContext context, DiscoverItem item,
        DiscoverItem_Comment comment) =>
    showTasteBottomSheet(
      context,
      (context) => Column(children: [
        ReplyToCommentTile(item: item, comment: comment),
        ...comment.isMine(context)
            ? [
                EditCommentTile(comment: comment, item: item),
                DeleteCommentTile(comment: comment, item: item),
              ]
            : []
      ]),
    );

class DeleteCommentTile extends StatelessWidget {
  const DeleteCommentTile({
    Key key,
    @required this.item,
    @required this.comment,
  }) : super(key: key);

  final DiscoverItem item;
  final DiscoverItem_Comment comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.delete),
        title: const Text("Delete Comment"),
        onTap: () async {
          unawaited(item.reference.updateData({
            'comments': FieldValue.arrayRemove([comment.asMap])
          }));
          TAEvent.tapped_delete_comment();
          Navigator.pop(context);
          final operation =
              CancelableOperation.fromFuture(5.seconds.wait).then((_) {
            TAEvent.deleted_comment();
            return comment.reference.ref.delete();
          }, propagateCancel: true);
          tasteSnackBar(
            SnackBar(
              duration: 5.seconds,
              behavior: SnackBarBehavior.floating,
              content: const Text('Deleting comment...'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () async {
                  TAEvent.undid_delete_comment();
                  hideSnackBar();
                  unawaited(item.reference.updateData({
                    'comments': FieldValue.arrayUnion([comment.asMap])
                  }));
                  await operation.cancel();
                  snackBarString("Delete undone");
                },
              ),
            ),
          );
        });
  }
}

class EditCommentTile extends StatelessWidget {
  const EditCommentTile({
    Key key,
    @required this.comment,
    @required this.item,
  }) : super(key: key);

  final DiscoverItem_Comment comment;
  final DiscoverItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.edit),
        title: const Text("Edit Comment"),
        onTap: () {
          Navigator.pop(context);
          quickPush(TAPage.edit_comment_page,
              (context) => EditCommentPage(comment: comment, item: item));
        });
  }
}

class LikeCommentButton extends StatelessWidget {
  const LikeCommentButton({@required this.comment});
  final DiscoverItem_Comment comment;
  @override
  Widget build(BuildContext context) {
    final likeable = likeableReference(comment.reference.ref);
    return StreamBuilder<bool>(
        stream: likeable.exists,
        builder: (context, snapshot) {
          final liked = snapshot.data ?? false;
          return IconButton(
              iconSize: 15,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              icon: Icon(
                Icons.thumb_up,
                color: liked ? Colors.blue : Colors.grey,
              ),
              onPressed:
                  snapshot.hasData ? () => likeable.toggle(!liked) : null);
        });
  }
}

class LikedByButton extends StatelessWidget {
  const LikedByButton({
    Key key,
    @required this.comment,
  }) : super(key: key);
  final DocumentReference comment;

  @override
  Widget build(BuildContext context) => StreamBuilder<List<TasteUser>>(
      stream: comment.get().asStream().switchMap((c) => Comment(c).likes),
      builder: (context, s) {
        final users = s.data ?? [];
        return Visibility(
          visible: users.isNotEmpty,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: InkWell(
            onTap: users.isEmpty
                ? null
                : () {
                    TAEvent.tapped_comment_likes();
                    quickPush(
                      TAPage.likes,
                      (_) => UserList(users: users, title: 'Likes'),
                    );
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
              child: AutoSizeText(
                'liked by '
                    .append(users.take(3).map((e) => e.meOrUsername).join(', '))
                    .append(users.length > 3 ? ' +${users.length - 3}' : ''),
                maxLines: 1,
                maxFontSize: 11,
                minFontSize: 9,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        );
      });
}

extension on DiscoverItem_Comment {
  bool isMine(BuildContext context) =>
      user.reference.ref == currentUserReference;
}
