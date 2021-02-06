import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expire_cache/expire_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taste/components/nav/nav.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/utils.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage(this.post);
  final Post post;

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  DocumentReference get ref => widget.post.postReference;
  final clipboard = Clipboard.getData('text/plain');
  final controller = TextEditingController();
  var pasted = false;
  static final _formKey = GlobalKey<FormState>();
  static final _cache = ExpireCache<DocumentReference, String>(
      sizeLimit: 10, expireDuration: const Duration(days: 30));

  @override
  void initState() {
    super.initState();
    controller.text = widget.post.recipe;
    setup();
    initPersistence();
  }

  Future initPersistence() async {
    final data = await _cache.get(ref) ?? '';
    if (data.isNotEmpty) {
      setState(() => controller.append(data));
    }
  }

  Future setup() async {
    final text = await clipText;
    if (controller.text.contains(text)) {
      setState(() => pasted = true);
      return;
    }
    if (!text.contains('http')) {
      return;
    }
    snackBarString(
      "Add Contents from Clipboard? '${text.ellipsis(60)}'",
      actionLabel: "Add",
      action: paste,
    );
  }

  Future<String> get clipText async => (await clipboard)?.text ?? '';

  Future paste() async {
    final text = await clipText;
    setState(() {
      controller.append(' $text ');
      pasted = true;
    });
  }

  void submit([String input]) {
    _cache.invalidate(ref);
    final text = input ?? controller.text ?? '';
    Firestore.instance.batch()
      ..updateData(widget.post.reference, {'review.recipe': text})
      ..updateData(widget.post.postReference, {'recipe': text})
      ..commit();
    Navigator.pop(context, text.isNotEmpty);
  }

  void save([String s]) => _cache.set(ref, controller.text);

  @override
  Widget build(BuildContext context) => TabAwareWillPopScope(
        onWillPop: (_) async {
          _formKey.currentState.save();
          if (controller.text.isNotEmpty) {
            snackBarString('Recipe draft saved.', seconds: 5);
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
              title: const AutoSizeText(
                "Add Recipe",
                style: kAppBarTitleStyle,
              ),
              centerTitle: true,
              actions: [
                IconButton(icon: const Icon(Icons.check), onPressed: submit),
              ]),
          body: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 8),
              StreamBuilder<Set<DocumentReference>>(
                stream: recipeRequesters(widget.post.postReference),
                initialData: const {},
                builder: (context, snapshot) => Visibility(
                  visible: !pasted || (snapshot.data?.isNotEmpty ?? false),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ...snapshot.data?.isEmpty ?? true
                                ? const <Widget>[]
                                : [
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text("Requests",
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 42,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: (snapshot.data ?? {})
                                              .take(8)
                                              .listMap(
                                                (t) => ProfilePhoto(
                                                  key: ValueKey(t),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 2.0),
                                                  tapToProfileHero: true,
                                                  user: t,
                                                  radius: 20,
                                                ),
                                              ),
                                        ),
                                      ),
                                    )
                                  ],
                            !pasted
                                ? FlatButton.icon(
                                    padding: const EdgeInsets.all(8.0),
                                    onPressed: paste,
                                    label: const Text("Paste Link"),
                                    icon: const Icon(Icons.content_paste),
                                  )
                                : null,
                          ].withoutNulls,
                        ),
                        const Divider(color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: controller,
                    onSaved: save,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                    decoration:
                        const InputDecoration(hintText: "Recipe or link"),
                    autofocus: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

Future<bool> addRecipePage(Post post) async =>
    await quickPush(TAPage.add_recipe_page, (_) => AddRecipePage(post)) ??
    false;
