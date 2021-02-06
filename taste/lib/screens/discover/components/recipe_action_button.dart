import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taste/screens/create_review/add_recipe_page.dart';
import 'package:taste/screens/discover/components/expand_widget.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/screens/user_list/user_list.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/taste_backend_client/tag_search_page.dart';
import 'package:taste/theme/buttons.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' show Review_DeliveryApp;

class RecipeActionButton extends StatelessWidget {
  const RecipeActionButton({
    Key key,
    @required this.post,
    this.big = false,
    this.onSuccess,
    this.analyticsContext = const {},
  }) : super(key: key);
  final Post post;
  final bool big;
  final Function() onSuccess;
  final Map<String, dynamic> analyticsContext;

  Color get textColor => Colors.black;

  double get scale => big ? 1.3 : 1;

  @override
  Widget build(BuildContext context) => StreamBuilder<bool>(
      stream: post.requestedRecipe(),
      initialData: false,
      builder: (context, snapshot) => _EmojiTapper(
            secondary: true,
            widget: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.0 * scale, vertical: 4 * scale),
              decoration: BoxDecoration(
                color: kChipActiveColor,
                borderRadius: BorderRadius.circular(5 * scale),
              ),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(textColor, BlendMode.srcIn),
                        child: Image.asset('assets/ui/recipe.png',
                            scale: 7.5 / scale)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0 * scale),
                      child: Text(
                        post.hasRecipe
                            ? "Recipe"
                            : post.isMine
                                ? "Add Recipe"
                                : snapshot.data ?? false
                                    ? "Requested"
                                    : "Request Recipe",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 13 * scale,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    post.hasRecipe
                        ? null
                        : StreamBuilder<int>(
                            stream: CollectionType.recipe_requests.coll
                                .forParent(post.postReference)
                                .count,
                            builder: (_, snapshot) => (snapshot.data ?? 0) <= 0
                                ? const SizedBox()
                                : AutoSizeText(
                                    '+${snapshot.data}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: (13 * scale).roundToDouble(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    minFontSize: 8,
                                    maxFontSize: (13 * scale).roundToDouble(),
                                  ),
                          ),
                  ].withoutNulls),
            ),
            onTap: () async {
              final hasRequested = snapshot.data ?? false;
              TAEvent.tapped_recipe({
                'post': post.postReference.path,
                'has_recipe': post.hasRecipe,
                'is_mine': post.isMine,
                'has_requested': hasRequested,
                'expanded': analyticsContext['expanded'] ??
                    ExpandableProvider.of(context, listen: false),
                ...analyticsContext ?? const {},
              });
              return post.hasRecipe
                  ? ExpandableProvider.toggle(context)
                  : post.isMine
                      ? (await addRecipePage(post)
                          ? (onSuccess ??
                              () => ExpandableProvider.expand(context))()
                          : null)
                      : hasRequested
                          ? recipeRequestersPage(post)
                          : post.requestRecipe();
            },
          ));
}

Future recipeRequestersPage(Post post) =>
    quickPush(TAPage.recipe_requesters_page, (_) => RecipeRequestersPage(post));

class RemoveRecipeRequestButton extends StatelessWidget {
  const RemoveRecipeRequestButton({Key key, this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) => TasteButton(
        text: "Remove",
        onPressed: post.removeRecipeRequest,
        options: kTastePrimaryButtonOptions.copyWith(color: Colors.red),
      );
}

class RecipeRequestersPage extends StatelessWidget {
  const RecipeRequestersPage(this.post);
  final Post post;
  @override
  Widget build(BuildContext context) => StreamBuilder<List<TasteUser>>(
      stream: recipeRequesters(post.postReference)
          // Type munging to fight off errors, don't remove
          .whereType<Iterable<DocumentReference>>()
          .deepMap((u) => u.stream()),
      builder: (context, snapshot) => UserList(
            title: "Recipe Requests",
            users: snapshot.data ?? [],
            meWidget: RemoveRecipeRequestButton(post: post),
          ));
}

class _EmojiTapper extends StatelessWidget {
  const _EmojiTapper(
      {this.term,
      this.text,
      this.widget,
      this.deliveryApp,
      this.secondary = false,
      this.onTap})
      : assert((widget != null) ^ (text != null));
  final String term;
  final String text;
  final Widget widget;
  final Review_DeliveryApp deliveryApp;
  final bool secondary;
  final Future Function() onTap;
  bool get isSingle => !(text?.startsWith(RegExp(r'[a-zA-Z0-9#]')) ?? false);
  Color get color => secondary ? kPrimaryButtonColor : kChipActiveColor;
  EdgeInsets get innerPadding => isSingle
      ? null
      : const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4);
  Decoration get decoration => isSingle
      ? null
      : BoxDecoration(color: color, borderRadius: BorderRadius.circular(5));
  double get fontSize => isSingle ? 19 : 13;
  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onTap ??
          (term == null
              ? null
              : () => TagSearchPage.goTo(context, term.tagify,
                  deliveryApp: deliveryApp)),
      child: Container(
          padding: innerPadding,
          decoration: decoration,
          child: widget ??
              Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )));
}
