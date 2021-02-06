import 'dart:async';
import 'dart:ui';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taste/app_config.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/screens/contest/daily_tasty_badge.dart';
import 'package:taste/screens/create_review/add_recipe_page.dart';
import 'package:taste/screens/create_review/review/legal_taste_tags.dart';
import 'package:taste/screens/create_review/review/restaurant_chip_selector.dart';
import 'package:taste/screens/create_review/review/select_delivery_app_page.dart';
import 'package:taste/screens/discover/components/heart.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/screens/profile/quick_edit_post_restaurant_button.dart';
import 'package:taste/screens/review/comment_text_widget.dart';
import 'package:taste/screens/review/components/add_comment_page.dart';
import 'package:taste/screens/review/meal_mates_inline_widget.dart';
import 'package:taste/screens/user_list/user_list.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/tag_search_page.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/buttons.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/pause_detector.dart';
import 'package:taste/utils/posts_list_provider.dart';
import 'package:taste/utils/unfocusable.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/photo_regexp.dart';
import 'package:taste_protos/taste_protos.dart'
    show DiscoverItem_Comment, Review_DeliveryApp, BlackCharity;
import 'package:timeago/timeago.dart' as timeago;

import 'expand_widget.dart';
import 'list_comment_widget.dart';

const int kMaxNumLettersInRestoTitle = 25;
const double avatarRadius = 10;
const double avatarGapFraction = 0.6;
const double avatarBorder = 0.3;
const double iconSpace = 8;

class _Data {
  _Data({
    @required this.discoverItem,
    @required this.isTodayWinner,
  });

  final DiscoverItem discoverItem;

  final bool isTodayWinner;
  String get restoName => discoverItem.proto.restaurant.name;

  bool get isEmptyInstagramDish =>
      discoverItem.proto.hasInstaPost() && discoverItem.proto.dish.isEmpty;
  bool get shouldShowAddDish => isEmptyInstagramDish && isMine;
  String get dish => isEmptyInstagramDish ? "" : discoverItem.proto.dish;

  Future<Review> get review => discoverItem.review;
  List<DiscoverItem_Comment> get comments => discoverItem.proto.comments;
  String get userName => discoverItem.proto.user.name;
  DocumentReference get userReference => discoverItem.proto.user.reference.ref;
  String get reviewText => discoverItem.proto.review.rawText;
  DateTime get date => discoverItem.proto.date.toDateTime();
  List<UserListUser> get likes =>
      discoverItem.proto.likes.listMap((l) => l.userListUser);
  Stream<int> get views => discoverItem.views;
  CountValue get reaction => discoverItem.proto.review.reaction.baseReaction;
  List<DocumentReference> get mealMates =>
      discoverItem.proto.review.mealMates.mealMates
          .map((e) => e.reference.ref)
          .toList();

  bool get hasNoTags => [mealMates, attributes, emojis].flatten.isEmpty;
  List<String> get attributes => discoverItem.proto.review.attributes;
  List<String> get emojis => discoverItem.proto.review.emojis;

  DocumentReference get reviewReference => discoverItem.proto.reference.ref;

  bool get isMine => discoverItem.isMine;

  bool get isResto => !discoverItem.isHomeCooked;

  DocumentReference get instaPost => discoverItem.proto.instaPost.ref;

  final userHero = Object();

  Future userTap(BuildContext context, DocumentReference userReference) =>
      userProfileTap(context,
          userReference ?? discoverItem.proto.user.reference.ref, userHero);
}

Future userProfileTap(BuildContext context, DocumentReference userReference,
    [Object profilePhotoHero]) async {
  TAEvent.tapped_user_photo({'tapped_user': userReference.path});
  return goToUserProfile(userReference, hero: profilePhotoHero);
}

abstract class _ChildWidget extends StatelessWidget {
  bool get listen => false;
  @override
  Widget build(BuildContext context) {
    return dataBuild(context, Provider.of(context, listen: listen));
  }

  Widget dataBuild(BuildContext context, _Data data);
}

class ReviewInListWidget extends StatelessWidget {
  const ReviewInListWidget({
    Key key,
    @required this.discoverItem,
    this.onViewed,
  }) : super(key: key);

  final DiscoverItem discoverItem;
  final Function() onViewed;

  @override
  Widget build(BuildContext context) {
    return ExpandableProvider(
      child: Unfocusable(
        child: Provider<_Data>.value(
          value: _Data(
              discoverItem: discoverItem,
              isTodayWinner: discoverItem.dailyTasty?.isAfter(
                      DateTime.now().subtract(const Duration(days: 1))) ??
                  false),
          updateShouldNotify: (a, b) =>
              a.discoverItem.proto.hashCode != b.discoverItem.proto.hashCode,
          child: PauseDetector(
            key: ValueKey(discoverItem),
            didPause: () {
              discoverItem.markViewed();
              onViewed?.call();
            },
            child: TopLevelChild(),
          ),
        ),
      ),
    );
  }
}

class TopLevelChild extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _Data data) =>
      !(data.discoverItem?.exists ?? false)
          // TODO(jackdreilly): Filter the discover list higher up to
          // prevent non-existent reviews from even being given an
          // opportunity to render.
          ? Container()
          : _LoadedView();
}

class RestaurantSection extends _ChildWidget {
  @override
  bool get listen => true;
  @override
  Widget dataBuild(BuildContext context, _Data data) => Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          QuickEditPostRestaurantButton(
            padding: const EdgeInsets.only(right: 8.0),
            post: data.discoverItem,
            size: 20,
            resetWidget: data.discoverItem.isHomeCooked
                ? const Text('[Home-cooked?]',
                    style: TextStyle(fontSize: 20, color: Colors.blue))
                : null,
          ),
          Expanded(child: _RestaurantNameButton()),
        ]),
      );
}

class _RestaurantNameButton extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _Data data) =>
      data.discoverItem.isHomeCooked
          ? const SizedBox()
          : InkWell(
              onTap: () async =>
                  (await data.discoverItem.restaurant.first).goTo(),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: AutoSizeText(
                      '${data.restoName}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      maxLines: 2,
                      minFontSize: 7,
                      maxFontSize: 18,
                    ),
                  ),
                ],
              ),
            );
}

class _LoadedView extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _Data data) => Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: RestoDishHeader(),
              ),
              MainView(),
            ],
          ),
        ),
      );
}

class PostReaction extends _ChildWidget {
  @override
  bool get listen => true;
  @override
  Widget dataBuild(BuildContext context, _Data data) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: data.reaction.icon(size: 28),
      );
}

class RestoDishHeader extends _ChildWidget {
  @override
  bool get listen => true;
  @override
  Widget dataBuild(BuildContext context, _Data data) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  data.shouldShowAddDish
                      ? AddDishWidget(
                          instaPost: data.instaPost,
                          fontSize: 24,
                          maxFontSize: 26,
                          minFontSize: 18,
                          maxLines: 2,
                          color: const Color(0xFF5D5258))
                      : DishNameWidget(
                          text: data.dish,
                          fontSize: 24,
                          maxFontSize: 26,
                          minFontSize: 18,
                          maxLines: 2,
                          color: const Color(0xFF5D5258)),
                  RestaurantSection(),
                ].withoutNulls),
          ),
          PostReaction(),
        ],
      );
}

class AddDishWidget extends StatefulWidget {
  const AddDishWidget(
      {Key key,
      @required this.instaPost,
      this.fontSize,
      this.maxFontSize,
      this.minFontSize,
      this.maxLines,
      this.color,
      this.hintColor})
      : super(key: key);
  final DocumentReference instaPost;
  final double fontSize;
  final double maxFontSize;
  final double minFontSize;
  final int maxLines;
  final Color color;
  final Color hintColor;

  @override
  AddDishWidgetState createState() => AddDishWidgetState();
}

class AddDishWidgetState extends State<AddDishWidget> {
  final TextEditingController dishNameController = TextEditingController();

  bool hasSubmitted = false;
  FocusNode focus;

  @override
  void initState() {
    super.initState();
    focus = FocusNode()
      ..addListener(() async {
        if (focus.hasFocus) {
          return;
        }
        if (dishNameController.text.isEmpty) {
          return;
        }
        setState(() => hasSubmitted = true);
        await widget.instaPost.updateData({'dish': dishNameController.text});
      });
  }

  @override
  Widget build(BuildContext context) {
    return hasSubmitted && dishNameController.text.isNotEmpty
        ? DishNameWidget(
            text: dishNameController.text,
            fontSize: widget.fontSize,
            maxFontSize: widget.maxFontSize,
            minFontSize: widget.minFontSize,
            maxLines: widget.maxLines,
            color: widget.color)
        : TextField(
            textCapitalization: TextCapitalization.words,
            maxLines: 1,
            style: TextStyle(
              color: widget.color,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "[Add Dish Name]",
              contentPadding: const EdgeInsets.all(0.0),
              isDense: true,
              hintStyle: TextStyle(
                color: widget.hintColor ?? widget.color.withOpacity(0.5),
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            focusNode: focus,
            controller: dishNameController,
            onSubmitted: (dish) async {
              if (dish.isEmpty) {
                return;
              }
              setState(() => hasSubmitted = true);
              await widget.instaPost.updateData({'dish': dish});
            },
          );
  }
}

class DishNameWidget extends StatelessWidget {
  const DishNameWidget(
      {Key key,
      @required this.text,
      this.fontSize,
      this.maxFontSize,
      this.minFontSize,
      this.maxLines,
      this.color})
      : super(key: key);
  final String text;
  final double fontSize;
  final double maxFontSize;
  final double minFontSize;
  final int maxLines;
  final Color color;

  @override
  Widget build(BuildContext context) => AutoSizeText(
        text,
        maxFontSize: maxFontSize ?? double.infinity,
        minFontSize: minFontSize ?? 12,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
        maxLines: maxLines,
        textAlign: TextAlign.left,
      );
}

class _TimeAgoWidget extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _Data data) =>
      AutoSizeText(timeago.format(data.date),
          style: const TextStyle(color: Colors.grey));
}

class MainView extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _Data data) => Column(children: [
        _PhotoSection(),
        _PosterSection(),
        _ExtrasSection(),
        Align(alignment: Alignment.topRight, child: _TimeAgoWidget()),
        _CommentsSection()
      ]);
}

class _ExtrasSection extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _Data data) => Container(
      padding: const EdgeInsets.only(right: 3),
      height: 27,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _LikeButton(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LikesWidget(data.likes),
              const SizedBox(width: 15),
              _ViewsWidget()
            ],
          ),
        ],
      ));
}

class _CommentsSection extends _ChildWidget {
  @override
  bool get listen => true;
  @override
  Widget dataBuild(BuildContext context, _Data data) => Material(
      child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommentsHeaderButton(post: data.discoverItem),
                _CommentsList(
                  data: data,
                  maxComments: 2,
                )
              ])));
}

class CommentsHeaderButton extends StatelessWidget {
  const CommentsHeaderButton({Key key, this.post}) : super(key: key);
  final DiscoverItem post;
  static const maxComments = 3;
  static const color = Colors.black54;
  int get count => post.proto.comments.length;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      IconButton(
          iconSize: 20,
          visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity),
          icon: const Icon(Icons.add_comment, color: color),
          onPressed: () async => AddCommentPage.go(post)),
      FlatButton(
        splashColor: Colors.grey,
        onPressed: post.goToComments,
        child: Row(
            children: <Widget>[
          Padding(
              key: const Key('comments-title'),
              padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
              child: Text(count == 0 ? 'No Comments Yet' : 'Comments',
                  style: const TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ))),
          if (count <= maxComments)
            null
          else
            Text(
              '+${count - maxComments} more',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
        ].withoutNulls),
      )
    ]);
  }
}

class _PosterSection extends _ChildWidget {
  @override
  bool get listen => true;

  @override
  Widget dataBuild(BuildContext context, _Data data) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            iconSize: 40,
            onPressed: () => data.userTap(context, data.userReference),
            icon: Hero(
              tag: data.userHero,
              child: ProfilePhoto(
                radius: 20,
                user: data.userReference,
              ),
            ),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 4),
                  child: Material(
                      child: InkWell(
                          onTap: () => ExpandableProvider.toggle(context),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                CommentTextWidget(
                                  prefixes: [
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => userProfileTap(
                                              context, data.userReference),
                                        text: data.userName.append('  '),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ))
                                  ],
                                  maxLines:
                                      ExpandableProvider.of(context) ? null : 4,
                                  text:
                                      " ${data.reviewText}${ExpandableProvider.of(context) && data.discoverItem.hasRecipe ? '\n\nRecipe:\n\n${data.discoverItem.recipe}' : ''}",
                                  fontSize: 14,
                                ),
                                Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: _TagsWidget())
                              ])))))
        ],
      ),
    );
  }
}

class _TagsWidget extends _ChildWidget {
  @override
  bool get listen => true;
  @override
  Widget dataBuild(BuildContext context, _Data data) =>
      !(data?.discoverItem?.exists ?? false)
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  MealMatesInlineWidget(
                      review: data.reviewReference, mates: data.mealMates),
                  data.discoverItem.isDelivery
                      ? _DeliveryTapper(data.discoverItem)
                      : null,
                  data.discoverItem.isHomeCooked &&
                          (!data.discoverItem.hasRecipe ||
                              !ExpandableProvider.of(context))
                      ? RecipeActionButton(post: data.discoverItem)
                      : null,
                  data.discoverItem.proto.blackOwned
                      ? const BlackOwnedTag()
                      : null,
                  data.discoverItem.proto.blackCharity ==
                          BlackCharity.CHARITY_UNDEFINED
                      ? null
                      : BlackCharityTag(
                          charity: data.discoverItem.proto.blackCharity),
                  ...[
                    ...data.emojis,
                    ...ExpandableProvider.of(context)
                        ? data.attributes
                        : <String>[],
                  ]
                      .where((e) => e != '#delivery')
                      .tupleSort((t) => [
                            -['Home-Cooked', 'Delivery', 'Daily Tasty']
                                .indexOf(t),
                            -t.length,
                            kCountryTasteTagsMap.containsKey(t) ? 0 : 1
                          ])
                      .map((e) => _EmojiTapper(text: e, term: e))
                ].withoutNulls,
              ));
}

class BlackOwnedTag extends StatelessWidget {
  const BlackOwnedTag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _EmojiTapper(
      secondary: true,
      widget: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4),
        height: 28,
        decoration: BoxDecoration(
          color: kChipActiveColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Image.asset('assets/ui/black_power.png'),
          const SizedBox(width: 7),
          const Text(
            'Black Owned',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]),
      ),
      onTap: () async {},
    );
  }
}

class BlackCharityTag extends StatelessWidget {
  const BlackCharityTag({Key key, this.charity}) : super(key: key);

  final BlackCharity charity;

  @override
  Widget build(BuildContext context) {
    return _EmojiTapper(
      secondary: true,
      widget: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4),
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey[300], width: 2.0),
        ),
        child: Image.asset(charities[charity]),
      ),
      onTap: () async {
        Scaffold.of(context).showSnackBar(const SnackBar(
          content: Text(
              "We are donating \$10 per post to certain charities that fight "
              "racial injustice in solidarity with the Black Lives Matter "
              "movement."),
          duration: Duration(seconds: 10),
        ));
      },
    );
  }
}

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
                            builder: (context, snapshot) => (snapshot.data ??
                                        0) <=
                                    0
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
                'widget': 'review_in_list',
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

class _DeliveryTapper extends StatelessWidget {
  const _DeliveryTapper(this.discoverItem);

  final DiscoverItem discoverItem;

  @override
  Widget build(BuildContext context) {
    if (!discoverItem.proto.review.hasDeliveryApp() ||
        discoverItem.proto.review.deliveryApp == Review_DeliveryApp.UNDEFINED) {
      return const _EmojiTapper(
          text: 'Delivery', secondary: true, term: 'delivery');
    }
    Review_DeliveryApp deliveryApp = discoverItem.proto.review.deliveryApp;
    return _EmojiTapper(
        widget: Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: ColorFiltered(
            colorFilter:
                const ColorFilter.mode(Color(0xff777777), BlendMode.srcIn),
            child: Image.asset(
              deliveryApps[deliveryApp],
              height: {
                    Review_DeliveryApp.postmates: 15.0,
                    Review_DeliveryApp.eat_24: 12.0,
                    Review_DeliveryApp.door_dash: 10.0,
                    Review_DeliveryApp.uber_eats: 10.5,
                    Review_DeliveryApp.grub_hub: 12.0,
                    Review_DeliveryApp.seamless: 16.0,
                  }[deliveryApp] ??
                  12.8,
            ),
          ),
        ),
        deliveryApp: deliveryApp,
        term: deliveryApp.toString());
  }
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

class LikesWidget extends StatelessWidget {
  const LikesWidget(this.likes,
      {this.color = Colors.black, this.showWord = true, this.take = 5})
      : super();
  final List<UserListUser> likes;
  final Color color;
  final bool showWord;
  final int take;

  @override
  Widget build(BuildContext context) => (likes?.isEmpty ?? true)
      ? Container(height: 26)
      : InkWell(
          onTap: () => showLikedUsers(
                context: context,
                users: likes,
              ),
          child: Row(children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: RowSuper(
                    innerDistance: -7,
                    children: likes.take(take).listMap((user) => CircleAvatar(
                          key: ValueKey(user),
                          radius: 13,
                          backgroundColor: Colors.white,
                          child: ProfilePhoto(
                            user: user.reference,
                            path: user.userListPhoto,
                            radius: 12,
                          ),
                        )))),
            Visibility(
                visible: showWord,
                child: Text(
                    [likes.length, 'like'.pluralize(likes.length)].join(' '),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: color,
                    )))
          ]));
}

class _ViewsWidget extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _Data data) => InkWell(
        onDoubleTap: isProd
            ? null
            : () => CollectionType.bad_crops.coll
                .add({'post': data.reviewReference}),
        child: StreamBuilder<int>(
            stream: data.views.take(1),
            builder: (context, snapshot) {
              return Row(
                children: <Widget>[
                  Text(snapshot.data?.toString() ?? ''),
                  const Padding(
                    padding: EdgeInsets.only(left: 2.0, right: 8.0),
                    child: Icon(Icons.remove_red_eye,
                        color: Colors.grey, size: 15),
                  ),
                ],
              );
            }),
      );
}

class _PhotoSection extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _Data data) {
    final controller = PreloadPageController(keepPage: true);
    return InkWell(
      onTap: () => PostsListProvider.go(context, data.discoverItem,
          postPhotoIndex: controller.page.toInt()),
      child: WithBookmarkWidget(
        item: data.discoverItem,
        child: Container(
          height: (MediaQuery.of(context).size.width *
                  data.discoverItem.firePhoto.aspect)
              .clamp(250, 375)
              .toDouble(),
          child: Stack(
            children: <Widget>[
              DoubleTapHeartWidget(
                onDoubleTap: () async => data.discoverItem.like(true),
                child: PhotoPagesView(controller: controller),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Visibility(
                      visible: data.discoverItem.isMultiPhoto,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          margin: const EdgeInsets.all(8),
                          elevation: 0,
                          color: Colors.white.withOpacity(0.0),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SmoothPageIndicator(
                                effect: SlideEffect(
                                    dotHeight: 10,
                                    dotWidth: 10,
                                    radius: 5,
                                    activeDotColor: Colors.white,
                                    dotColor: Colors.white.withOpacity(0.2)),
                                controller: controller,
                                count: data.discoverItem.firePhotos.length),
                          )))),
              data.discoverItem.hasDailyTasty
                  ? Positioned(
                      bottom: 6,
                      right: 6,
                      child:
                          DailyTastyBadge(size: 15, today: data.isTodayWinner))
                  : null,
            ].withoutNulls,
          ),
        ),
      ),
    );
  }
}

class PhotoPagesView extends _ChildWidget {
  PhotoPagesView({
    @required this.controller,
  });

  final PreloadPageController controller;

  @override
  bool get listen => true;

  @override
  Widget dataBuild(BuildContext context, _Data data) {
    return PreloadPageView(
      preloadPagesCount: 2,
      controller: controller,
      onPageChanged: (i) =>
          TAEvent.swipe_multi_photo({'index': i, 'view': 'discover'}),
      children: data.discoverItem.firePhotos.enumerate
          .entryMap(
            (i, photo) => Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  side: data.discoverItem.hasDailyTasty && false
                      ? BorderSide(
                          width: 2,
                          color: Color.alphaBlend(
                              kPrimaryButtonColor.withOpacity(0.7),
                              Colors.white))
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: photo.progressive(
                  Resolution.medium,
                  Resolution.thumbnail,
                  BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                )),
          )
          .toList(),
    );
  }
}

class _LikeButton extends _ChildWidget {
  @override
  Widget dataBuild(BuildContext context, _Data data) => Visibility(
        visible: !data.isMine || data.discoverItem.isLiked,
        child: IconButton(
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          iconSize: 20,
          icon: Icon(
            Icons.thumb_up,
            color: data.discoverItem.isLiked ? Colors.blue : Colors.grey,
          ),
          onPressed: () => data.discoverItem.like(!data.discoverItem.isLiked),
        ),
      );
}

class LikeImage extends StatelessWidget {
  const LikeImage(this.liked);
  final bool liked;
  @override
  Widget build(BuildContext context) => Image.asset(
      liked ? 'assets/ui/like_black.png' : 'assets/ui/like_outline_black.png');
}

class _CommentsList extends StatelessWidget {
  const _CommentsList({Key key, this.data, this.maxComments}) : super(key: key);
  final _Data data;
  final int maxComments;
  int get take => maxComments ?? count;
  int get count => data.comments.length;
  @override
  Widget build(BuildContext context) => Column(
      children: data.comments
          .sorted((c) => c.date.seconds)
          .takeFromEnd(take)
          .listMap((comment) => Padding(
              key: comment.reference.key,
              padding: const EdgeInsets.only(left: 5),
              child: ListCommentWidget(
                  item: data.discoverItem, comment: comment))));
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

Future recipeRequestersPage(Post post) =>
    quickPush(TAPage.recipe_requesters_page, (_) => RecipeRequestersPage(post));

/// Adds a gradient and bookmark button to be used with a review photo view.
class WithBookmarkWidget extends StatelessWidget {
  const WithBookmarkWidget({Key key, this.item, this.child}) : super(key: key);

  final DiscoverItem item;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final topGradient = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.2),
            Colors.transparent,
          ],
        ),
      ),
      height: 80,
    );
    final enabled = item.isBookmarked;
    return Stack(children: <Widget>[
      child,
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: topGradient,
      ),
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: IconButton(
            icon: Icon(
              enabled
                  ? MaterialCommunityIcons.bookmark
                  : MaterialCommunityIcons.bookmark_outline,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () => item.bookmark(!enabled),
          ),
        ),
      ),
    ]);
  }
}

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
