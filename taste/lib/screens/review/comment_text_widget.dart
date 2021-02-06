import 'package:deferrable/deferrable.dart';
import 'package:expire_cache/expire_cache.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quiver/collection.dart';
import 'package:taste/screens/create_review/review/legal_taste_tags.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/tag_search_page.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import 'tokenizer.dart';

class _Token {
  const _Token(this.text);
  final String text;
  bool get isUsername => text.startsWith('@');
  bool get isLink => text.startsWith('http');
  bool get isRecipeHeader => recipeHeaderRegex.hasMatch(text);
  bool get isDelivery => text == '#delivery';
  static final _tagRegex =
      RegExp(kTasteTagsMap.keys.followedBy({'#', '💡'}).join('|'));
  bool get isTag => text.startsWith(_tagRegex);
}

class CommentTextWidget extends StatefulWidget {
  const CommentTextWidget({
    Key key,
    @required this.text,
    this.white = false,
    this.maxLines,
    this.prefixes = const [],
    this.fontSize = 14,
  })  : assert(prefixes != null),
        super(key: key);

  final String text;

  final List<InlineSpan> prefixes;
  final int maxLines;
  final bool white;
  final double fontSize;

  @override
  _CommentTextWidgetState createState() => _CommentTextWidgetState();
}

final _usernameLookup = LruMap<String, TasteUser>(maximumSize: 1000);
final _missLookup = ExpireCache<String, bool>(
    sizeLimit: 200, expireDuration: const Duration(hours: 1));

class _CommentTextWidgetState extends State<CommentTextWidget> with Deferrable {
  @override
  final blockSetStateAfterDispose = true;
  List<_Token> tokens;
  @override
  void initState() {
    super.initState();
    updateBlocks();
  }

  @override
  void didUpdateWidget(CommentTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      updateBlocks();
    }
  }

  void updateBlocks() {
    tokens = tokenize(widget.text).map((e) => _Token(e)).toList();
    Future.microtask(() => tokens
        .where((token) =>
            !_missLookup.containsKey(token.text) &&
            !_usernameLookup.containsKey(token.text) &&
            token.isUsername)
        .forEach((token) => userByUsername(token.text.substring(1)).then((u) =>
            (u == null)
                ? _missLookup.set(token.text, true)
                : setState(() => _usernameLookup[token.text] = u))));
  }

  @override
  Widget build(BuildContext context) => Text.rich(
      TextSpan(
          style: TextStyle(
            color: widget.white ? Colors.white : Colors.black,
            fontSize: widget.fontSize,
          ),
          children: widget.prefixes
              .followedBy(tokens.map((block) => block.isLink
                  ? TextSpan(
                      text: '${Uri.parse(block.text).authority}…',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launch(block.text))
                  : _usernameLookup.containsKey(block.text)
                      ? TextSpan(
                          text: block.text,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              TAEvent.tapped_meal_mate_text_link();
                              _usernameLookup[block.text].goToProfile();
                            },
                          style: const TextStyle(color: Colors.blue),
                        )
                      : block.isDelivery
                          ? WidgetSpan(
                              child: InkWell(
                              onTap: () =>
                                  TagSearchPage.goTo(context, block.text),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Image.asset('assets/ui/delivery.png',
                                    height: 17),
                              ),
                            ))
                          : block.isTag
                              ? TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        TagSearchPage.goTo(context, block.text),
                                  text: block.text.dashify,
                                  style: const TextStyle(color: Colors.blue))
                              : TextSpan(
                                  text: block.text.append(' '),
                                )))
              .toList()),
      maxLines: widget.maxLines,
      overflow: widget.maxLines == null ? null : TextOverflow.ellipsis);
}
