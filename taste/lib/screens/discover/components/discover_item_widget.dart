import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taste/components/abuse/report_content.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/screens/discover/components/heart.dart';
import 'package:taste/screens/discover/components/recipe_action_button.dart';
import 'package:taste/screens/review/comment_text_widget.dart';
import 'package:taste/screens/user_list/user_list.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/responses/restaurant.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/fire_photo.dart';
import 'package:taste/utils/pause_detector.dart';
import 'package:taste/utils/posts_list_provider.dart';
import 'package:taste/utils/taste_bottom_sheet.dart';
import 'package:taste/utils/unfocusable.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/photo_regexp.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'expand_widget.dart';

class DiscoverItemWidget extends StatelessWidget {
  const DiscoverItemWidget({
    Key key,
    @required this.discoverItem,
    this.onViewed,
  }) : super(key: key);

  final DiscoverItem discoverItem;
  final Function() onViewed;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DiscoverItem>(
      stream: discoverItem.reference.stream<DiscoverItem>(),
      builder: (context, snapshot) {
        final item = snapshot.hasData ? snapshot.data : discoverItem;
        return Provider<DiscoverItem>.value(
          value: item,
          updateShouldNotify: (a, b) => a.proto.hashCode != b.proto.hashCode,
          child: Unfocusable(
            child: PauseDetector(
              key: ValueKey(item),
              didPause: () {
                item.markViewed();
                onViewed?.call();
              },
              child: InkWell(
                onLongPress: () => showTasteBottomSheetWithItems(context, [
                  TasteBottomSheetItem(
                    title: 'Report Content',
                    callback: () => reportContent(context, item),
                  )
                ]),
                child: Stack(children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: _PhotoAndInfoSection(),
                  ),
                  _UserOverlay(),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _UserOverlay extends StatelessWidget {
  const _UserOverlay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = context.watch<DiscoverItem>();
    final userRefProto = item.proto.user.reference;
    final userTag = Object();
    return GestureDetector(
      onTap: () {
        TAEvent.tapped_user_photo({'tapped_user': userRefProto.path});
        goToUserProfile(userRefProto.ref, hero: userTag);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 19),
            child: RawMaterialButton(
              constraints: const BoxConstraints(minHeight: 36),
              onPressed: () {
                TAEvent.tapped_user_photo({'tapped_user': userRefProto.path});
                goToUserProfile(userRefProto.ref, hero: userTag);
              },
              elevation: 1.0,
              fillColor: Colors.white,
              padding: const EdgeInsets.all(3.0),
              shape: const CircleBorder(
                  side: BorderSide(
                width: 2.0,
                color: Colors.white,
              )),
              child: Hero(
                tag: userTag,
                child: ProfilePhoto(
                  radius: 26,
                  user: userRefProto.ref,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 5),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: AutoSizeText(
                item.proto.user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kDarkGrey,
                ),
                maxLines: 1,
                minFontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoAndInfoSection extends StatelessWidget {
  const _PhotoAndInfoSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _PhotoSection(),
        SizedBox(height: 10),
        _DishAndRestoLine(),
      ],
    );
  }
}

class _DishAndRestoLine extends StatelessWidget {
  const _DishAndRestoLine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = context.watch<DiscoverItem>();
    final goToRestoPage =
        () async => (await item.restaurantRef.fetch<Restaurant>()).goTo();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: goToRestoPage,
                child: AutoSizeText(
                  item.proto.dish.isEmpty
                      ? item.proto.restaurant.name
                      : item.proto.dish,
                  maxLines: 1,
                  minFontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kDarkGrey,
                  ),
                ),
              ),
              if (!item.isHomeCooked && item.proto.dish.isNotEmpty)
                const SizedBox(height: 3),
              if (!item.isHomeCooked && item.proto.dish.isNotEmpty)
                InkWell(
                  onTap: goToRestoPage,
                  child: AutoSizeText(
                    'From ${item.proto.restaurant.name}',
                    maxLines: 1,
                    minFontSize: 12,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949AA2),
                    ),
                  ),
                ),
              if (!item.isHomeCooked && item.proto.hasRestaurant())
                InkWell(
                  onTap: goToRestoPage,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      getLocationText(item, context),
                      style: const TextStyle(
                        color: Color(0xFF75A563),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              ExpandableProvider(
                child: Builder(
                  builder: (context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => ExpandableProvider.toggle(context),
                        child: CommentTextWidget(
                          maxLines: ExpandableProvider.of(context) ? null : 2,
                          text: item.proto.review.rawText.trim().append(
                              item.hasRecipe
                                  ? '\n\nRecipe: \n\n${item.recipe.trim()}'
                                  : ''),
                          fontSize: 13,
                        ),
                      ),
                      if (item.isHomeCooked &&
                          !(item.hasRecipe && ExpandableProvider.of(context)))
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: RecipeActionButton(post: item),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!item.isHomeCooked)
              FutureBuilder<String>(
                  future: getCategory(item),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data.isEmpty) {
                      return Container();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kChipActiveColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            snapshot.data,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: kDarkGrey,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            if (item.isHomeCooked)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryButtonColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Home-Cooked',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: kDarkGrey,
                      ),
                    ),
                  ),
                ),
              ),
            if (item.proto.likes.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: LikesWidget(
                  item.proto.likes.map((like) => like.userListUser).toList(),
                  color: kDarkGrey,
                  showWord: true,
                  take: 2,
                ),
              ),
            AutoSizeText(
              timeago.format(item.proto.date.toDateTime()),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String getLocationText(DiscoverItem item, BuildContext context) {
  final latLng = LocationBuilder.of(context);
  if (latLng == null) {
    return item.address.simple;
  }
  final distanceMiles = latLng.distanceMeters(item.latLng) / kMetersPerMile;
  if (distanceMiles < 1) {
    return '${distanceMiles.toStringAsFixed(1)} mi away';
  }
  if (distanceMiles < 7.5) {
    return '${distanceMiles.round()} mi away';
  }
  if (distanceMiles < 40) {
    return '${distanceMiles.round()} mi away, ${item.address.simple}';
  }
  if (distanceMiles > 40) {
    return item.address.simple;
  }
  return '${distanceMiles.round()} mi away';
}

Future<String> getCategory(DiscoverItem item) async {
  if (!item.isHomeCooked) {
    final restaurant = await item.restaurantRef.fetch<Restaurant>();
    final filteredCategories = restaurant.proto.attributes.placeTypes.enumerate
        // Sort by place type enum value.
        .tupleSort((entry) => [entry.value.value])
        .where((entry) =>
            restaurant.proto.attributes.placeTypeScores[entry.key] > 0.3)
        .values
        .map((x) => x.displayString)
        .where((x) => x.isNotEmpty);
    return filteredCategories.firstOrNull;
  }
  final possibleTags = item.proto.tags.where((tag) => tag != 'Delivery');
  if (possibleTags.isEmpty) {
    return '';
  }
  return possibleTags.first;
}

String cleanCategory(String category) {
  for (final word in ['Restaurant', 'Company', 'Shop', 'Store']) {
    category = category.replaceAll(' $word', '');
  }
  return category
      .split(' ')
      .map((w) => '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');
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
      ? Container()
      : InkWell(
          onTap: () => showLikedUsers(
            context: context,
            users: likes,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: RowSuper(
                  innerDistance: -7,
                  children: likes.take(take).listMap(
                        (user) => CircleAvatar(
                          key: ValueKey(user),
                          radius: 13,
                          backgroundColor: Colors.white,
                          child: ProfilePhoto(
                            user: user.reference,
                            path: user.userListPhoto,
                            radius: 12,
                          ),
                        ),
                      ),
                ),
              ),
              Visibility(
                visible: showWord,
                child: Text(
                  [likes.length, 'like'.pluralize(likes.length)].join(' '),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: color,
                  ),
                ),
              )
            ],
          ),
        );
}

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

class _PhotoSection extends StatelessWidget {
  const _PhotoSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = PreloadPageController(keepPage: true);
    final discoverItem = context.watch<DiscoverItem>();
    return InkWell(
      onTap: () => PostsListProvider.go(context, discoverItem,
          postPhotoIndex: controller.page.toInt()),
      child: WithBookmarkWidget(
        item: discoverItem,
        child: Container(
          height: 285,
          child: Stack(
            children: <Widget>[
              DoubleTapHeartWidget(
                onDoubleTap: () async => discoverItem.like(true),
                child: _PhotoPagesView(controller: controller),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Visibility(
                  visible: discoverItem.isMultiPhoto,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SmoothPageIndicator(
                        effect: SlideEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          radius: 5,
                          activeDotColor: Colors.white,
                          dotColor: Colors.white.withOpacity(0.5),
                        ),
                        controller: controller,
                        count: discoverItem.firePhotos.length),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoPagesView extends StatelessWidget {
  const _PhotoPagesView({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final PreloadPageController controller;

  @override
  Widget build(BuildContext context) {
    final discoverItem = context.watch<DiscoverItem>();
    return PreloadPageView(
      preloadPagesCount: 2,
      controller: controller,
      onPageChanged: (i) =>
          TAEvent.swipe_multi_photo({'index': i, 'view': 'discover'}),
      children: discoverItem.firePhotos.enumerate
          .entryMap(
            (i, photo) => Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  side: discoverItem.hasDailyTasty && false
                      ? BorderSide(
                          width: 2,
                          color: Color.alphaBlend(
                              kPrimaryButtonColor.withOpacity(0.7),
                              Colors.white))
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(5),
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
