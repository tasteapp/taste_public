import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste_protos/taste_protos.dart' show DiscoverItem_Comment;
import 'package:taste_protos/taste_protos.dart' as $pb;

class EditCommentPage extends StatelessWidget {
  EditCommentPage({Key key, @required this.comment, @required this.item})
      : controller = TextEditingController(text: comment.text),
        super(key: key);

  final DiscoverItem_Comment comment;
  final DiscoverItem item;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text("Edit Comment", style: kAppBarTitleStyle),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => editComment(context, controller.text))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          controller: controller,
          textCapitalization: TextCapitalization.sentences,
          expands: true,
          maxLines: null,
          autofocus: true,
          onFieldSubmitted: (text) => editComment(context, text),
        ),
      ));

  Future editComment(BuildContext context, String text) async {
    Navigator.pop(context);
    text = text.trim();
    if (text == comment.text || text.isEmpty) {
      return;
    }
    await Firestore.instance.runTransaction((transaction) async {
      final discoverItem = (await transaction.get(item.reference))
          .data
          .asProto($pb.DiscoverItem());
      final matchingComment = discoverItem.comments.firstWhere(
          (comment) => comment.reference == this.comment.reference,
          orElse: () => null);
      if (matchingComment == null) {
        await Crashlytics.instance
            .recordError('Unstable comment edit $comment', null);
        return;
      }
      matchingComment.text = text;
      transaction
        //ignore: unawaited_futures
        ..update(item.reference,
            {'comments': discoverItem.comments.listMap((t) => t.asMap)})
        //ignore: unawaited_futures
        ..update(comment.reference.ref, {'text': text}.withUpdateExtras);
    });
  }
}
