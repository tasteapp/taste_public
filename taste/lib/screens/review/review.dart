import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_view/photo_view.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:share_api/composers/story_composer.dart';
import 'package:share_api/share_api.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taste/components/abuse/report_content.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/contest/daily_tasty_badge.dart';
import 'package:taste/screens/create_review/review/create_review.dart';
import 'package:taste/screens/discover/components/comments_page.dart';
import 'package:taste/screens/discover/components/discover_item_widget.dart';
import 'package:taste/screens/discover/components/heart.dart';
import 'package:taste/screens/discover/components/recipe_action_button.dart';
import 'package:taste/screens/profile/quick_edit_post_restaurant_button.dart';
import 'package:taste/screens/restaurant/restaurant_page.dart';
import 'package:taste/screens/user_list/user_list.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/taste_backend_client/responses/review.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/taste_backend_client/value_stream_builder.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste/utils/pause_detector.dart';
import 'package:taste/utils/taste_bottom_sheet.dart';
import 'package:taste/utils/unfocusable.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/photo_regexp.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'add_favorite_widgets.dart';
import 'comment_text_widget.dart';
import 'components/add_comment_page.dart';
import 'meal_mates_inline_widget.dart';

part 'review.freezed.dart';

@freezed
abstract class ReviewPageInput implements _$ReviewPageInput {
  const factory ReviewPageInput.review(Review review) = _Review;
  const factory ReviewPageInput.discoverItem(DiscoverItem item) = _DiscoverItem;
  const factory ReviewPageInput.reviewReference(DocumentReference reference) =
      _ReviewReference;
}

Future<int> goToReviewPage(ReviewPageInput input, [int photoIndex = 0]) async {
  final post = await spinner(() => input.when(
      review: (review) => review.discoverItem,
      discoverItem: (item) async => item,
      reviewReference: (r) => reviewDiscoverItem(r).first));
  final controller =
      PreloadPageController(initialPage: photoIndex ?? 0, keepPage: true);
  await quickPush(TAPage.post_page,
      (context) => ReviewPage(review: post, controller: controller));
  return controller.page.toInt();
}

enum _TapEvent {
  tap,
  expand,
  recipe,
}

class ReviewPageBloc extends Bloc<_TapEvent, _ViewStage> {
  ReviewPageBloc._(this.controller);
  final PreloadPageController controller;
  @override
  _ViewStage get initialState => _ViewStage.basic;

  @override
  Stream<_ViewStage> mapEventToState(_TapEvent event) async* {
    yield {
      _TapEvent.expand: state.expand,
      _TapEvent.tap: state.tap,
      _TapEvent.recipe: state.tapRecipe,
    }[event];
  }
}

class ReviewPage extends StatelessWidget {
  const ReviewPage({
    Key key,
    @required this.review,
    @required this.controller,
  }) : super(key: key);

  final DiscoverItem review;
  final PreloadPageController controller;

  @override
  Widget build(BuildContext context) => Unfocusable(
      child: StreamProvider<DiscoverItem>(
          create: (_) => review.asStream,
          initialData: review,
          updateShouldNotify: (a, b) {
            if (!(a.exists && b.exists)) {
              return true;
            }
            if (a.snapshot.data['_force_update'] !=
                b.snapshot.data['_force_update']) {
              return false;
            }
            return a.proto.hashCode != b.proto.hashCode;
          },
          child: Builder(builder: (context) {
            final review = Provider.of<DiscoverItem>(context, listen: false);
            if (!review.exists) {
              return FailPage();
            }

            return BlocProvider(
                create: (_) => ReviewPageBloc._(controller),
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle.light,
                    child: Scaffold(
                        extendBodyBehindAppBar: true,
                        appBar: AppBar(
                            elevation: 0,
                            brightness: Brightness.dark,
                            backgroundColor: Colors.transparent,
                            centerTitle: true,
                            title: review.hasDailyTasty
                                ? const Center(child: DailyTastyBadge())
                                : const SizedBox(),
                            iconTheme: const IconThemeData(color: Colors.white),
                            actionsIconTheme:
                                const IconThemeData(color: Colors.white),
                            actions: [MoreOptions()]),
                        body: InnerReviewWidget())));
          })));
}

class MoreOptions extends _ChildWidget {
  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => showTasteBottomSheet(context,
              (_) => _DiscoverItemMoreOptionsBottomSheet(review: review)));
}

const double avatarRadius = 15;
const double avatarGapFraction = 0.6;
const double avatarBorder = 0;
const double iconSpace = 8;

/// A [ReviewPage] can cycle through a number of different stages, e.g., the
/// text-description is expanded, or the overlays are hidden.
///
/// This enum tracks all the valid stages the [ReviewPage] can be in, and how
/// each stage transitions to the next based on [tap]/[expand] events.
///
/// The basic principle is that all non-[basic] stages map back [basic], while
/// [tap] events map away from [basic] to [hidden], and [expand] events map away
/// from [basic] to [expanded].
enum _ViewStage { basic, expanded, hidden, recipe }

extension _ViewStageExt on _ViewStage {
  /// Next stage after a tap event.
  _ViewStage get tap => {
        _ViewStage.basic: _ViewStage.hidden,
        _ViewStage.hidden: _ViewStage.basic,
        _ViewStage.expanded: _ViewStage.basic,
        _ViewStage.recipe: _ViewStage.basic,
      }[this];

  /// Next stage after a tap recipe event.
  _ViewStage get tapRecipe => {
        _ViewStage.basic: _ViewStage.recipe,
        _ViewStage.hidden: _ViewStage.recipe,
        _ViewStage.expanded: _ViewStage.recipe,
        _ViewStage.recipe: _ViewStage.basic,
      }[this];

  /// Next stage after an expand event.
  _ViewStage get expand => {
        _ViewStage.basic: _ViewStage.expanded,
        _ViewStage.hidden: _ViewStage.basic,
        _ViewStage.expanded: _ViewStage.basic,
        _ViewStage.recipe: _ViewStage.expanded,
      }[this];
  bool get isHidden => this == _ViewStage.hidden;
  bool get isExpanded => this == _ViewStage.expanded;
  bool get showsRecipeBar => this == _ViewStage.recipe;
}

const _countsStyle = TextStyle(color: Colors.white, fontSize: 16);

abstract class _ChildWidget extends StatelessWidget {
  //ignore: prefer_const_constructors_in_immutables
  _ChildWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => blocBuild(
        context,
        BlocProvider.of<ReviewPageBloc>(context),
        Provider.of(context),
      );

  Widget blocBuild(
      BuildContext context, ReviewPageBloc bloc, DiscoverItem review);
}

abstract class _ChildStateWidget extends _ChildWidget {
  _ChildStateWidget({Key key}) : super(key: key);
  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      BlocBuilder<ReviewPageBloc, _ViewStage>(
          builder: (context, stage) => blocStateBuild(context,
              BlocProvider.of<ReviewPageBloc>(context), review, stage));

  Widget blocStateBuild(BuildContext context, ReviewPageBloc bloc,
      DiscoverItem review, _ViewStage stage);
}

class InnerReviewWidget extends _ChildWidget {
  InnerReviewWidget();
  @override
  Widget blocBuild(
      BuildContext context, ReviewPageBloc bloc, DiscoverItem review) {
    return !review.exists
        ? const Center(child: Text("Deleting..."))
        : PauseDetector(
            key: ValueKey(review),
            didPause: review.markViewed,
            child: DoubleTapHeartWidget(
              onDoubleTap: () => review.like(true),
              child: Stack(alignment: Alignment.bottomCenter, children: [
                _PhotosView(),
                SafeArea(
                    child: Material(
                        color: Colors.transparent, child: _OverlaysView()))
              ]),
            ));
  }
}

class _OverlaysView extends _ChildStateWidget {
  _OverlaysView();

  @override
  Widget blocStateBuild(BuildContext context, ReviewPageBloc bloc,
          DiscoverItem review, _ViewStage stage) =>
      Visibility(
          visible: !stage.isHidden,
          maintainAnimation: true,
          maintainInteractivity: false,
          maintainSize: true,
          maintainState: true,
          maintainSemantics: true,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(child: ReviewInformationWidget()),
                    ActionsLikesRow(),
                    CommentsTimeRow(),
                    Align(alignment: Alignment.centerLeft, child: RecipeRow()),
                  ])));
}

class CommentsTimeRow extends _ChildWidget {
  CommentsTimeRow();

  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CommentsHeaderButton(), TimeagoWidget()]);
}

class TimeagoWidget extends _ChildWidget {
  TimeagoWidget();

  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      Text(
        timeago.format(review.createTime),
        style: const TextStyle(color: Colors.grey, fontSize: 14),
      );
}

class ActionsLikesRow extends _ChildWidget {
  ActionsLikesRow();

  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LikeReviewButton(),
          LikesCountWidget(),
          BookmarkReviewWidget(),
          BookmarksCountWidget(),
          ViewsIcon(),
          ViewsCountWidget(),
          review.isHomeCooked ? ShowRecipeButton() : null,
          const Spacer(),
          LikesWidget(
            review.proto.likes.userListUsers,
            color: Colors.white,
            showWord: MediaQuery.of(context).size.width > 400,
            take: 4,
          ),
        ].withoutNulls,
      );
}

class ViewsCountWidget extends _ChildWidget {
  ViewsCountWidget();

  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      StreamBuilder<int>(
          stream: review.views,
          builder: (context, snapshot) {
            return Text('${snapshot.data ?? '0'}', style: _countsStyle);
          });
}

class ViewsIcon extends _ChildWidget {
  ViewsIcon();

  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      IconButton(
        icon: const Icon(Icons.remove_red_eye),
        color: Colors.white,
        onPressed: () {},
      );
}

class BookmarksCountWidget extends _ChildWidget {
  BookmarksCountWidget();

  @override
  Widget blocBuild(
      BuildContext context, ReviewPageBloc bloc, DiscoverItem review) {
    final bookmarkers = review.proto.bookmarks.userListUsers;
    return InkWell(
        onTap: () => quickPush(
            TAPage.bookmarkers_page,
            (context) => UserList(
                  users: bookmarkers,
                  title:
                      '${bookmarkers.length} bookmark${bookmarkers.length == 1 ? '' : 's'}',
                )),
        child: Text('${bookmarkers.length}', style: _countsStyle));
  }
}

class LikesCountWidget extends _ChildWidget {
  LikesCountWidget();

  @override
  Widget blocBuild(
      BuildContext context, ReviewPageBloc bloc, DiscoverItem review) {
    final likers = review.proto.likes.userListUsers;
    return InkWell(
        onTap: () => quickPush(
            TAPage.likes,
            (context) => UserList(
                  users: likers,
                  title:
                      '${likers.length} like${likers.length == 1 ? '' : 's'}',
                )),
        child: Text('${likers.length}', style: _countsStyle));
  }
}

class _PhotosView extends _ChildStateWidget {
  _PhotosView();

  @override
  Widget blocStateBuild(BuildContext context, ReviewPageBloc bloc,
          DiscoverItem review, _ViewStage stage) =>
      GestureDetector(
          onTap: () => bloc.add(_TapEvent.tap),
          child: Stack(children: [
            MultiPhotoView(),
            // Use IgnorePointer so that rawImage recieves touch events.
            IgnorePointer(
                child: Visibility(
                    visible: !stage.isHidden,
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0, 0.15, 0.5, 0.8, 1],
                                colors: stage.isExpanded
                                    ? [
                                        Colors.black.withOpacity(0.75),
                                        Colors.black.withOpacity(0.75),
                                        Colors.black.withOpacity(0.75),
                                        Colors.black.withOpacity(0.75),
                                        Colors.black.withOpacity(0.75),
                                      ]
                                    : [
                                        Colors.black.withOpacity(0.6),
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.75),
                                        Colors.black.withOpacity(0.9),
                                      ])))))
          ]));
}

class MultiPhotoView extends _ChildWidget {
  MultiPhotoView();
  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      Stack(
        alignment: Alignment.topCenter,
        children: [
          PreloadPageView(
            key: PageStorageKey('${review.path} PhotoPageView'),
            controller: bloc.controller,
            onPageChanged: (i) =>
                TAEvent.swipe_multi_photo({'index': i, 'view': 'full'}),
            children: review.firePhotos.listMap(
              (photo) => Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: PhotoView.customChild(
                  minScale: 1.0,
                  maxScale: 1.0,
                  child: photo.progressive(
                    Resolution.full,
                    Resolution.medium,
                    BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, -0.8),
            child: Visibility(
              visible: review.isMultiPhoto,
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
                      dotColor: Colors.white.withOpacity(0.5),
                    ),
                    controller: bloc.controller,
                    count: review.firePhotos.length,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

class ReviewInformationWidget extends _ChildWidget {
  ReviewInformationWidget();

  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: review.isHomeCooked
                ? null
                : () async => goToRestaurantPage(
                    restaurant: await review.restaurantRef.fetch()),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Dish name if it exists or resto name as title along with the
                  // reaction.
                  TitleHeader(),
                  // Restaurant name if dish name exists or empty.
                  OverlaySubtitle(),
                  Flexible(
                    child: InkWell(
                      onTap: () => bloc.add(_TapEvent.expand),
                      child: UserReviewOverlay(),
                    ),
                  ),
                ].withoutNulls),
          ));
}

class UserReviewOverlay extends _ChildWidget {
  UserReviewOverlay();

  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => goToUserProfile(review.userReference),
              icon: ProfilePhoto(
                  radius: 20,
                  user: review.userReference,
                  path: fixedFirePhoto(review.proto.user.photo)
                      .url(Resolution.thumbnail)),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SingleChildScrollView(child: ReviewTextWidget())))
          ]));
}

class OverlaySubtitle extends _ChildWidget {
  OverlaySubtitle();

  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      Row(
        children: [
          QuickEditPostRestaurantButton(
              didSwitchTypes: () => Navigator.pop(context),
              padding: const EdgeInsets.only(right: 8.0),
              post: review,
              size: 20,
              resetWidget: review.isHomeCooked
                  ? const Text('[Home-cooked?]',
                      style: TextStyle(fontSize: 20, color: Colors.blue))
                  : null),
          (review.displayDish.isNotEmpty && !review.isHomeCooked)
              ? Expanded(
                  child: AutoSizeText(
                    'from ${review.restaurantName}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : null
        ].withoutNulls,
      );
}

class TitleHeader extends _ChildWidget {
  TitleHeader();

  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: review.shouldShowAddDish
                ? AddDishWidget(
                    instaPost: review.instaPost,
                    fontSize: 28,
                    maxLines: 2,
                    color: Colors.white,
                    hintColor: Colors.white.withOpacity(0.75),
                  )
                : DishNameWidget(
                    text: review.dish.isEmpty
                        ? (review.isHomeCooked
                            ? review.displayDish ?? ''
                            : review.restaurantName ?? '')
                        : review.dish,
                    fontSize: 28,
                    maxLines: 2,
                    color: Colors.white),
          ),
          InkWell(
            onTap: () {
              snackBarString(
                'This is the rating for this post. If you want '
                'to like the post, you can double-tap the photo or hit '
                'the thumbs up icon at the bottom left of this screen.',
                seconds: 7,
              );
              TAEvent.tapped_reaction_in_review();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: review.reaction.baseReaction.icon(size: 35),
            ),
          ),
        ],
      );
}

class LikeReviewButton extends _ChildWidget {
  LikeReviewButton();

  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      IconButton(
          icon: Icon(
            Icons.thumb_up,
            color: review.isLiked ? Colors.blue : Colors.white,
          ),
          onPressed: () => review.like(!review.isLiked));
}

class BookmarkReviewWidget extends _ChildWidget {
  BookmarkReviewWidget();

  @override
  Widget blocBuild(
          BuildContext context, ReviewPageBloc bloc, DiscoverItem review) =>
      IconButton(
          icon: Icon(
            Icons.bookmark,
            color: review.isBookmarked ? Colors.blue : Colors.white,
          ),
          onPressed: () => review.bookmark(!review.isBookmarked));
}

class _DiscoverItemMoreOptionsBottomSheet extends StatelessWidget {
  const _DiscoverItemMoreOptionsBottomSheet({this.review});

  final DiscoverItem review;

  @override
  Widget build(BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: ListTile.divideTiles(
              context: context,
              tiles: {
                ShareDiscoverItemTile(review: review): review.isMine,
                EditDiscoverItemTile(review: review): review.isMine,
                DeleteDiscoverItemTile(review: review): review.isMine,
                AddFavoriteTile(restaurant: review.restaurantRef):
                    !review.isHomeCooked,
                ReportTile(review: review): review.isNotMine
              }.where((k, v) => v).keys)
          .toList());
}

class ShareDiscoverItemTile extends StatelessWidget {
  const ShareDiscoverItemTile({
    Key key,
    @required this.review,
  }) : super(key: key);

  final DiscoverItem review;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(FontAwesome.share_square_o),
        title: const Text("Post to Instagram Story"),
        onTap: () async {
          Navigator.pop(context);
          await showDialog<bool>(
              context: context,
              builder: (context) => TasteDialog(
                    title: "Share to Instagram",
                    content: const Text.rich(TextSpan(children: [
                      TextSpan(text: "The contest hash-tag "),
                      TextSpan(
                          text: "#TasteContest @trytasteapp",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              " has been copied to your clipboard. Tag us (and DM us if you're private) in your story to be entered into the TasteOff Challenge!")
                    ])),
                    buttons: [
                      TasteDialogButton(
                          text: 'Cancel',
                          onPressed: () => Navigator.pop(context, false)),
                      TasteDialogButton(
                          text: 'Yes',
                          onPressed: () => Navigator.pop(context, true)),
                    ],
                  )).then(
            (a) async => !(a ?? false)
                ? null
                : ShareApi.viaInstagram.shareToStory(
                    StoryComposer(
                      backgroundMediaType: 'image/*',
                      backgroundFile:
                          (await review.firePhoto.file(Resolution.full).first)
                              .path,
                    ),
                  ),
          );
        });
  }
}

class DeleteDiscoverItemTile extends StatelessWidget {
  const DeleteDiscoverItemTile({
    Key key,
    @required this.review,
  }) : super(key: key);

  final DiscoverItem review;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.delete),
        title: const Text("Delete Post"),
        onTap: () async {
          Navigator.pop(context);
          if (!await showDialog(
                  context: context,
                  builder: (context) => const DeleteDiscoverItemDialog()) ??
              false) {
            return;
          }
          await quickPop();
          await <SnapshotHolder>[review, await review.discoverItem]
              .futureMap((t) => t.delete());
          TAEvent.delete_post({'review_ref': review.reference.path});
          snackBarString("Deleted post");
        });
  }
}

class DeleteDiscoverItemDialog extends StatelessWidget {
  const DeleteDiscoverItemDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TasteDialog(
      title: 'Are you sure you want to delete this post (forever)?',
      buttons: [
        TasteDialogButton(
            text: 'Cancel',
            color: Colors.grey,
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(false)),
        TasteDialogButton(
            text: 'Delete',
            color: Colors.red,
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(true)),
      ],
    );
  }
}

class ReportTile extends StatelessWidget {
  const ReportTile({
    Key key,
    @required this.review,
  }) : super(key: key);

  final DiscoverItem review;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.feedback),
        title: const Text("Report Offensive Content"),
        onTap: () async {
          await reportContent(context, review, description: "post");
          Navigator.pop(context);
        });
  }
}

class EditDiscoverItemTile extends StatelessWidget {
  const EditDiscoverItemTile({
    Key key,
    @required this.review,
  }) : super(key: key);

  final DiscoverItem review;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.edit),
        title: const Text("Edit Post"),
        onTap: () async {
          // TODO(multiimage): Preload just the thumbnails to make this
          // snappy, and then full-load the big images later.
          final files = await spinner(() => review.firePhotos
              .streamCombine((t) => t.file(Resolution.full))
              .first);
          TAEvent.start_edit_post();
          final actualReview = await review.postReference.fetch<Review>();
          await quickPush(
              TAPage.edit_post_page,
              (_) => CreateOrUpdateReviewWidget.update(
                  review: actualReview, images: files));
          Navigator.pop(context);
        });
  }
}

class ReviewTextWidget extends _ChildStateWidget {
  ReviewTextWidget();

  @override
  Widget blocStateBuild(BuildContext context, ReviewPageBloc bloc,
          DiscoverItem review, _ViewStage stage) =>
      InkWell(
        onTap: () => bloc.add(_TapEvent.expand),
        child: Theme(
          data: Theme.of(context)
              .copyWith(textTheme: Typography.whiteMountainView),
          child: MealMatesBuilder(
            review: review,
            builder: (context, mates) => CommentTextWidget(
                maxLines: stage.isExpanded ? null : 4,
                fontSize: 14,
                white: true,
                text:
                    " ${review.displayText}${stage.isExpanded && review.hasRecipe ? '\n\nRecipe:\n\n${review.recipe}' : ''}",
                prefixes: <InlineSpan>[
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => goToUserProfile(review.userReference),
                    text: review.proto.user.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  (mates?.isEmpty ?? true)
                      ? null
                      : TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                goToMealMatesPage(context, review: review),
                          text: () {
                            final names = mates
                                .map((m) => m.usernameOrName)
                                .withoutNulls
                                .where((i) => i.isNotEmpty);
                            final written = names.take(2).join(', ');
                            final ellipsis = names.length > 2 ? '…' : '';
                            return '(w/ $written$ellipsis) ';
                          }(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                ].withoutNulls),
          ),
        ),
      );
}

class CommentsHeaderButton extends _ChildStateWidget {
  CommentsHeaderButton();
  static const maxComments = 3;
  static const color = Colors.grey;

  @override
  Widget blocStateBuild(BuildContext context, ReviewPageBloc bloc,
          DiscoverItem review, _ViewStage stage) =>
      ValueStreamBuilder<int>(
          stream: review.nComments,
          builder: (context, snapshot) {
            final count = snapshot.data;
            final post = review.discoverItem;
            return Row(children: <Widget>[
              IconButton(
                  iconSize: 20,
                  visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity),
                  icon: const Icon(Icons.add_comment, color: color),
                  onPressed: () async => AddCommentPage.go(await post)),
              FlatButton(
                  splashColor: Colors.grey,
                  onPressed: () async => CommentsPage.go(await post),
                  child: Row(
                      children: <Widget>[
                    Padding(
                        key: const Key('comments-title'),
                        padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
                        child: Text(
                            count == null
                                ? 'Comments'
                                : count == 0
                                    ? 'No Comments Yet'
                                    : count == 1
                                        ? '1 Comment'
                                        : '$count Comments',
                            style: const TextStyle(
                              color: color,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )))
                  ].withoutNulls))
            ]);
          });
}

class FailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Failed to load"),
      ));
}

class ShowRecipeButton extends _ChildStateWidget {
  @override
  Widget blocStateBuild(BuildContext context, ReviewPageBloc bloc,
          DiscoverItem review, _ViewStage stage) =>
      IconButton(
        icon: ColorFiltered(
          colorFilter: ColorFilter.mode(
            stage.showsRecipeBar || (stage.isExpanded && review.hasRecipe)
                ? Colors.blue
                : Colors.white,
            BlendMode.srcIn,
          ),
          child: Image.asset(
            'assets/ui/recipe.png',
            scale: 5,
          ),
        ),
        onPressed: () {
          TAEvent.tapped_recipe({
            'post': review.path,
            'has_recipe': review.hasRecipe,
            'is_mine': review.isMine,
            'widget': 'review_reveal',
            'expanded':
                stage.showsRecipeBar || (stage.isExpanded && review.hasRecipe)
          });
          bloc.add(review.hasRecipe ? _TapEvent.expand : _TapEvent.recipe);
        },
      );
}

class RecipeRow extends _ChildStateWidget {
  @override
  Widget blocStateBuild(BuildContext context, ReviewPageBloc bloc,
          DiscoverItem review, _ViewStage stage) =>
      AnimatedContainer(
        duration: 300.millis,
        height: stage.showsRecipeBar && !review.hasRecipe ? 50 : 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.close),
              onPressed: () => bloc
                  .add(review.hasRecipe ? _TapEvent.expand : _TapEvent.recipe),
            ),
            RecipeActionButton(
              post: review,
              big: false,
              onSuccess: () => bloc.add(_TapEvent.expand),
              analyticsContext: {
                'widget': 'review',
                'expanded': stage.showsRecipeBar ||
                    (stage.isExpanded && review.hasRecipe),
              },
            ),
          ],
        ),
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
