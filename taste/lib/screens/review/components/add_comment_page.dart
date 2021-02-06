import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:taste/components/nav/nav.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/create_review/review/meal_mate.dart';
import 'package:taste/screens/review/components/form_persistence.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'user_tagging_widget.dart';

final _key = GlobalKey<FormState>();

class AddCommentPage extends StatefulWidget {
  const AddCommentPage({Key key, @required this.item, this.reply})
      : super(key: key);
  final DiscoverItem item;
  final $pb.DiscoverItem_Comment reply;
  @override
  _AddCommentPageState createState() => _AddCommentPageState();

  static Future go(DiscoverItem item) =>
      quickPush(TAPage.add_comment, (_) => AddCommentPage(item: item));
}

class _AddCommentPageState extends State<AddCommentPage> {
  final controller = TextEditingController();
  final node = FocusNode();
  final Set<MealMate> taggedUsers = {};
  final expanded = ValueNotifier(false);
  bool get isNotReply => !isReply;
  bool get isReply => widget.reply != null;
  String get prefix => isReply ? '@${widget.reply.user.name} ' : '';
  Future<String> get persistedValue => getPersistedFormField(persistenceKey);
  String get persistenceKey =>
      [widget.reply?.reference?.path, item?.postReference?.path].join('');
  DiscoverItem get item => widget.item;

  @override
  void initState() {
    super.initState();
    if (isReply) {
      taggedUsers.add(MealMate.itemUser(widget.reply.user));
    }
  }

  @override
  Widget build(BuildContext context) => Provider.value(
      value: this,
      child: TabAwareWillPopScope(
          onWillPop: (_) async {
            _key.currentState.save();
            if (controller.text.isNotEmpty) {
              snackBarString('Comment draft saved.', seconds: 5);
            }
            return true;
          },
          child: Scaffold(
              appBar: AppBar(
                title: AutoSizeText(
                  isNotReply
                      ? "Add Comment"
                      : "Reply To ${widget.reply.user.name}",
                  style: kAppBarTitleStyle,
                ),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () => submit(controller.text))
                ],
              ),
              body: FutureBuilder<String>(
                  future: persistedValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Container();
                    }
                    controller.text = snapshot.data ?? prefix;

                    return Padding(
                        padding: const EdgeInsets.all(20.0), child: Body());
                  }))));

  Future submit(String text) async {
    text = text?.trim();
    if (!_key.currentState.validate()) {
      return;
    }

    TAEvent.submitted_comment();

    final reference = CollectionType.comments.coll.document();
    Future _firestoreSubmit() async {
      final user = await cachedLoggedInUser;
      final payload = await discoverCacheCommentPayload(text, user, reference);
      final batch = Firestore.instance.batch()
        ..updateData(item.reference, {
          'comments': FieldValue.arrayUnion([payload])
        })
        ..setData(
            reference,
            {
              'text': text,
              'parent': item.postReference,
              'user': currentUserReference,
              'tagged_users': taggedUsers.map((e) => e.ref).toSet(),
            }.ensureAs($pb.Comment()).withExtras);
      await batch.commit();
    }

    unawaited(_firestoreSubmit());

    Navigator.pop(context);
    snackBarString('Adding comment...');
  }

  Future<Map<String, dynamic>> discoverCacheCommentPayload(
          String text, TasteUser user, DocumentReference reference) async =>
      {
        'text': text,
        'user': {
          'name': user.usernameOrName,
          'photo': user.profileImage(),
          'reference': user.reference,
        },
        'reference': reference,
        'date': DateTime.now().timestamp
      }.ensureAs($pb.DiscoverItem_Comment());
}

abstract class _ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      dataBuild(context, Provider.of(context));

  Widget dataBuild(BuildContext context, _AddCommentPageState data);
}

class Body extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _AddCommentPageState data) =>
      ListView(children: <Widget>[
        CommentInfoHeader(),
        const Divider(),
        CommentForm(),
        UserTaggingWidget(
            scroll: false,
            controller: data.controller,
            fieldNode: data.node,
            taggedUsers: (s) => data.taggedUsers
              ..clear()
              ..addAll(s))
      ]);
}

class CommentForm extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _AddCommentPageState data) => Form(
        key: _key,
        child: TextFormField(
            onSaved: (text) => persistFormField(data.persistenceKey, text),
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                prefixIconConstraints: const BoxConstraints(
                  maxHeight: 80,
                  maxWidth: 80,
                ),
                // https://github.com/flutter/flutter/issues/42651
                // We want to align the icon to the top, but this is
                // currently not seemingly possible inside of
                // TextField.
                prefixIcon: PostPhotoPrefix(),
                labelText: "Comment",
                hintText: "Add comment, tag @username"),
            textAlignVertical: TextAlignVertical.top,
            focusNode: data.node,
            controller: data.controller,
            maxLines: null,
            validator: (t) =>
                t.trim().isEmpty ? 'Write something, anything!' : null,
            autofocus: true,
            onFieldSubmitted: data.submit),
      );
}

class PostPhotoPrefix extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _AddCommentPageState data) =>
      Container(
          padding: const EdgeInsets.fromLTRB(4, 4, 10, 4),
          child: Card(
              elevation: 3,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: data.widget.item.firePhoto.progressive(
                  Resolution.thumbnail, null, BoxFit.cover,
                  height: 100, width: 100)));
}

class CommentInfoHeader extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _AddCommentPageState data) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ParentUserAvatar(),
        Expanded(child: ParentCommentText())
      ]));
}

class ParentCommentText extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _AddCommentPageState data) =>
      Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 8.0),
          child: ValueListenableBuilder<bool>(
              valueListenable: data.expanded,
              builder: (context, isExpanded, _) => InkWell(
                  onTap: () => data.expanded.value = !data.expanded.value,
                  child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: (data.isNotReply
                                    ? data.item.userName
                                    : data.widget.reply.user.name)
                                .append('  '),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: data.isNotReply
                                ? data.item.proto.review.rawText
                                : data.widget.reply.text)
                      ]),
                      maxLines: isExpanded ? null : 3))));
}

class ParentUserAvatar extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _AddCommentPageState data) => data
          .isNotReply
      ? ProfilePhoto(user: data.item.userReference, radius: 15)
      : ProfilePhoto(user: data.widget.reply.user.reference.ref, radius: 15);
}
