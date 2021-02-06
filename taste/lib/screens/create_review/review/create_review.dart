import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taste/algolia/search_result.dart';
import 'package:taste/components/nav/nav.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/screens/create_review/review/legal_taste_tags.dart';
import 'package:taste/screens/create_review/review/restaurant_chip_selector.dart';
import 'package:taste/screens/create_review/review/restaurant_selector_widget.dart';
import 'package:taste/screens/create_review/review/select_delivery_app_page.dart';
import 'package:taste/screens/create_review/review/taste_tags_picker_page.dart';
import 'package:taste/screens/review/components/user_tagging_widget.dart';
import 'package:taste/screens/review/search_tile.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/quick_stateful_widget.dart';
import 'package:taste/utils/unfocusable.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;
import 'package:taste_protos/taste_protos.dart' show Reaction;

import 'create_review_bloc.dart';
import 'create_review_edit_photos_page.dart';
import 'data_correctness.dart';
import 'meal_mate.dart';
import 'post_photo_manager.dart';

const deliveryEmoji = '#delivery';

class CreateOrUpdateReviewWidget extends StatelessWidget {
  const CreateOrUpdateReviewWidget._(
      {Key key, this.images, this.review, this.photoLocation})
      : super(key: key);
  factory CreateOrUpdateReviewWidget.create(
          {@required List<File> images, @required LatLng photoLocation}) =>
      CreateOrUpdateReviewWidget._(
          images: images, photoLocation: photoLocation);
  factory CreateOrUpdateReviewWidget.update(
          {@required Review review, @required List<File> images}) =>
      CreateOrUpdateReviewWidget._(review: review, images: images);
  final List<File> images;
  final Review review;
  final LatLng photoLocation;
  bool get isUpdate => review != null;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PostPhotoManager(this)),
          BlocProvider(create: (context) => CreateReviewBloc(this)),
        ],
        child: BlocBuilder<PostPhotoManager, PostPhotoState>(
          builder: (context, photoState) =>
              BlocBuilder<CreateReviewBloc, CreateReviewBlocState>(
            builder: (context, reviewState) => Provider.value(
              value: CreateReviewPageData(photoState, reviewState),
              child: TabAwareWillPopScope(
                  onWillPop: (_) async =>
                      await showDialog(
                          context: context,
                          builder: (dialogContext) => ExitDialog(
                              isUpdate: isUpdate,
                              photoBloc: photoBloc(context))) ??
                      false,
                  child: Scaffold(
                      appBar: PreferredSize(
                          preferredSize: const Size.fromHeight(75.0),
                          child: _AppBar()),
                      body: CreatePostForm())),
            ),
          ),
        ),
      );
}

class CreateReviewPageData {
  CreateReviewPageData(this.photoState, this.reviewState);
  final PostPhotoState photoState;
  final CreateReviewBlocState reviewState;
  static CreateReviewPageData of(BuildContext context) =>
      Provider.of(context, listen: false);
}

class ThinRestaurantRecord {
  const ThinRestaurantRecord(this.data, this.reference);
  final Map<String, dynamic> data;
  final DocumentReference reference;

  String get name => data['attributes']['name'] as String;

  GeoPoint get location => data['attributes']['location'] as GeoPoint;
}

const reactions = [Reaction.love, Reaction.up, Reaction.down];

PostPhotoManager photoBloc(BuildContext context) => BlocProvider.of(context);
CreateReviewBloc getReviewBloc(BuildContext context) =>
    BlocProvider.of(context);

class CreatePostForm extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      Unfocusable(
        child: Theme(
          data: Theme.of(context).copyWith(
              inputDecorationTheme: const InputDecorationTheme(
                  isDense: true, labelStyle: TextStyle(color: Colors.grey))),
          child: Form(
            autovalidate: false,
            key: reviewBloc.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ListView(
                    children: <Widget>[
                  _CommentTile(),
                  const Separator(),
                  RestaurantTile(),
                  const Separator(),
                  DishTile(),
                  const Separator(),
                  ...state.isHome ? [RecipeTile(), const Separator()] : [],
                  ReactionTile(),
                  const Separator(),
                  MealMatesTag(),
                  const Separator(),
                  TagsTile(),
                ].bookend(const SizedBox(height: 30))),
              ),
            ),
          ),
        ),
      );
}

class DishTile extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          maxLines: 1,
          controller: reviewBloc.dishController,
          focusNode: reviewBloc.dishNode,
          style: reviewTextStyle(fontSize: 16.0),
          decoration: InputDecoration.collapsed(
            border: InputBorder.none,
            hintText: 'Dish/drink name',
            hintStyle: reviewTextStyle(
                fontSize: 16.0, fontWeight: FontWeight.bold, opacity: 0.5),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a dish/drink';
            }
            return null;
          },
          onFieldSubmitted: (_) => reviewBloc.unfocus(context),
        ),
      );
}

class RecipeTile extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      Visibility(
        visible: reviewBloc.state.isHome,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.words,
            maxLines: null,
            controller: reviewBloc.recipeController,
            focusNode: reviewBloc.recipeNode,
            style: reviewTextStyle(fontSize: 16.0),
            decoration: InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: 'Recipe, Ingredients',
              hintStyle: reviewTextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.bold, opacity: 0.5),
            ),
            onFieldSubmitted: (_) => reviewBloc.unfocus(context),
          ),
        ),
      );
}

class _CommentTile extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 14.0),
          Expanded(
              flex: 1,
              child: Provider.value(
                value: this,
                child: EditPhotosPreviewWidget(),
              )),
          const SizedBox(width: 16.0),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  focusNode: reviewBloc.textNode,
                  controller: reviewBloc.textController,
                  maxLines: null,
                  style: reviewTextStyle(fontSize: 16.0),
                  decoration: InputDecoration.collapsed(
                    border: InputBorder.none,
                    hintText: 'Write a comment...',
                    hintStyle: reviewTextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        opacity: 0.5),
                  ),
                ),
                UserTaggingWidget(
                  controller: reviewBloc.textController,
                  taggedUsers: (users) =>
                      reviewBloc.add(CreateReviewBlocEvent.taggedUsers(users)),
                  fieldNode: reviewBloc.textNode,
                ),
              ],
            ),
          ),
        ],
      );
}

class TasteTagsHeader extends StatelessWidget {
  const TasteTagsHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      child: Text(
        "Taste Tags",
        style: reviewTextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}

abstract class CreateReviewChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CreateReviewPageData>(context, listen: false);
    return childBuild(context, photoBloc(context), data.reviewState,
        getReviewBloc(context), data.photoState);
  }

  Widget childBuild(
      BuildContext context,
      PostPhotoManager bloc,
      CreateReviewBlocState state,
      CreateReviewBloc reviewBloc,
      PostPhotoState photoState);
}

class _AppBar extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      AppBar(
        leading: Container(
          margin: const EdgeInsets.only(top: 15.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: Color(0xFF707070), size: 18.0),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
        centerTitle: true,
        title: Container(
          margin: const EdgeInsets.only(top: 15.0),
          child: Text(
            '${reviewBloc.isUpdate ? "Update" : "Finish"} Your Post',
            style: reviewTextStyle(),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 25.0, right: 18.0),
            child: InkWell(
              onTap: () async =>
                  reviewBloc.add(CreateReviewBlocEvent.submit(context)),
              child: Text(reviewBloc.isUpdate ? 'Update' : 'Post',
                  style: reviewTextStyle(
                    color: const Color(0xFF0091FF),
                  ),
                  maxLines: 1),
            ),
          ),
        ],
      );
}

class ExitDialog extends StatelessWidget {
  const ExitDialog({
    Key key,
    @required this.isUpdate,
    @required this.photoBloc,
  }) : super(key: key);

  final bool isUpdate;
  final PostPhotoManager photoBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TasteDialog(
        title: isUpdate ? "Discard edits?" : "Restart post?",
        content: Text(
            "All ${isUpdate ? 'edits' : 'information'} will be discarded."),
        buttons: [
          TasteDialogButton(
              onPressed: () => Navigator.pop(context, false), text: 'Cancel'),
          TasteDialogButton(
              onPressed: () {
                photoBloc.add(const PostPhotoEvent.abort());
                TAEvent.discard_post();
                Navigator.pop(context, true);
              },
              text: 'Ok')
        ],
      ),
    );
  }
}

const double cardWidth = 70;
const double ratio = 6 / 5;
const double padding = 6;
const cardHeight = cardWidth * ratio;
const containerHeight = cardHeight + padding;
const containerWidth = cardWidth + padding;

class EditPhotosPreviewWidget extends CreateReviewChildWidget {
  @override
  Widget childBuild(
      BuildContext context,
      PostPhotoManager bloc,
      CreateReviewBlocState state,
      CreateReviewBloc reviewBloc,
      PostPhotoState photoState) {
    Future tap(List<File> files) =>
        quickPush(TAPage.edit_photos, (_) => CreateReviewEditPhotosPage(bloc));
    return Material(
        child: InkWell(
            onTap: () => tap(photoState.files),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                height: containerHeight,
                width: containerWidth,
                child: Stack(
                    children: photoState.files
                        .take(2)
                        .enumerate
                        .entryMap(
                            (i, image) => PhotoPreviewCard(i: i, image: image))
                        .toList()
                        .reversed
                        .toList()),
              ),
              const Center(child: Text("Edit"))
            ])));
  }
}

class PhotoPreviewCard extends CreateReviewChildWidget {
  PhotoPreviewCard({
    @required this.i,
    @required this.image,
  });

  final int i;
  final File image;

  @override
  Widget childBuild(
      BuildContext context,
      PostPhotoManager bloc,
      CreateReviewBlocState state,
      CreateReviewBloc reviewBloc,
      PostPhotoState photoState) {
    return Container(
      height: cardHeight,
      width: cardWidth,
      padding: photoState.files.length > 1
          ? i == 0
              ? const EdgeInsets.only(left: padding, bottom: padding)
              : const EdgeInsets.only(right: padding, top: padding)
          : EdgeInsets.zero,
      child: Card(
          semanticContainer: true,
          elevation: 5,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white, width: 0.5),
              borderRadius: BorderRadius.circular(5)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(children: <Widget>[
            Image.file(image,
                height: cardHeight,
                width: cardWidth,
                filterQuality: FilterQuality.low,
                fit: BoxFit.cover),
            Visibility(
                visible: i == 1,
                child: Positioned.fill(
                    child: Container(color: Colors.white.withOpacity(0.5))))
          ])),
    );
  }
}

class ChooseMatesPage extends StatelessWidget {
  const ChooseMatesPage(this.bloc);
  final CreateReviewBloc bloc;

  @override
  Widget build(BuildContext context) =>
      QuickStatefulWidget<TextEditingController>(
        initState: (_) => TextEditingController(),
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const AutoSizeText("Tag friends", style: kAppBarTitleStyle),
            centerTitle: true,
            actions: [AcceptButton()],
          ),
          body: BlocBuilder<CreateReviewBloc, CreateReviewBlocState>(
            bloc: bloc,
            builder: (context, reviewState) {
              final mealMates = reviewState.mealMates.toSet();
              return Unfocusable(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    Wrap(
                        spacing: 4,
                        children: mealMates
                            .map((v) => Chip(
                                avatar: ProfilePhoto(user: v.ref),
                                label: Text(v.name.split(' ').first),
                                onDeleted: () =>
                                    bloc.add(CreateReviewBlocEvent.mate(v))))
                            .toList()),
                    TypeAheadField<SearchResult>(
                        keepSuggestionsOnSuggestionSelected: true,
                        animationDuration: const Duration(),
                        getImmediateSuggestions: false,
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: state.t,
                          textCapitalization: TextCapitalization.words,
                          autofocus: true,
                          autocorrect: false,
                          decoration: const InputDecoration(
                              hintText: 'Search friends you ate with'),
                        ),
                        suggestionsCallback: (searchTerm) async {
                          searchTerm = searchTerm.trim();
                          if (searchTerm.isEmpty) {
                            return [];
                          }
                          final results = await searchEverything(
                              tags: {'user'}, term: searchTerm);
                          final removeReferences = {
                            currentUserReference,
                            ...mealMates.map((e) => e.ref)
                          };
                          return results
                              .where((r) =>
                                  !removeReferences.contains(r.reference))
                              .toList();
                        },
                        itemBuilder: (context, searchResult) => SearchTile(
                              key: Key(searchResult.reference.path),
                              id: searchResult.reference.path,
                              text: searchResult.snapshot['name'] as String,
                              subtitle:
                                  searchResult.snapshot['username'] as String,
                              type: CollectionType.users,
                            ),
                        hideOnEmpty: true,
                        onSuggestionSelected: (s) {
                          state.t.clear();
                          bloc.add(CreateReviewBlocEvent.mate(
                              MealMate.searchResult(s)));
                        })
                  ]),
                ),
              );
            },
          ),
        ),
      );
}

class AcceptButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
      icon: const Icon(Icons.check), onPressed: () => Navigator.pop(context));
}

class Separator extends StatelessWidget {
  const Separator([this.size = 10]);
  final double size;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: size),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color(0xFF2F3542).withOpacity(0.15)))),
      );
}

TextStyle reviewTextStyle(
        {double fontSize = 18.0,
        FontWeight fontWeight = FontWeight.bold,
        Color color = const Color(0xFF2F3542),
        double opacity = 1.0}) =>
    TextStyle(
        fontFamily: "Quicksand",
        color: color.withOpacity(opacity),
        fontSize: fontSize,
        fontWeight: fontWeight);

class TagsSection extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      Wrap(
        alignment: WrapAlignment.start,
        spacing: 15,
        runSpacing: 15,
        children: <Widget>[
          DeliveryTag(),
          CuisineTag(),
          EmojiTag(),
          BlackOwnedTag(),
          BlackCharityTag(),
          AutoTags(),
        ],
      );
}

class BlackOwnedTag extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      Visibility(
        visible: !reviewBloc.isUpdate &&
            {
              $pb.Review_BlackOwnedStatus.user_selected_black_owned,
              $pb.Review_BlackOwnedStatus.restaurant_not_black_owned
            }.contains(state.blackOwned),
        child: TasteTagChip(
          selected: state.isBlackOwned,
          onSelected: (enabled) async {
            final blackOwnedStatus =
                await showDialog<$pb.Review_BlackOwnedStatus>(
                        context: context,
                        builder: (context) {
                          return TasteDialog(
                            title: "Is this a black owned restaurant?",
                            buttons: [
                              TasteDialogButton(
                                  text: 'No / Unsure',
                                  onPressed: () => Navigator.of(context).pop($pb
                                      .Review_BlackOwnedStatus
                                      .restaurant_not_black_owned)),
                              TasteDialogButton(
                                  text: 'Yes',
                                  onPressed: () => Navigator.of(context).pop($pb
                                      .Review_BlackOwnedStatus
                                      .user_selected_black_owned)),
                            ],
                          );
                        }) ??
                    state.blackOwned;
            reviewBloc.add(CreateReviewBlocEvent.blackOwned(blackOwnedStatus));
          },
          avatar: Padding(
            padding: const EdgeInsets.all(4),
            child: Image.asset('assets/ui/black_power.png'),
          ),
          label: Text(
            'Black Owned',
            style: reviewTextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      );
}

class BlackCharityTag extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      Visibility(
        visible: reviewBloc.isUpdate && state.isBlackOwned,
        child: TasteTagChip(
          selected: state.isDelivery,
          onSelected: (_) async {
            final selectedCharity =
                await selectBlackCharity(context, reviewBloc);
            if (selectedCharity != null) {
              reviewBloc
                ..add(CreateReviewBlocEvent.blackCharity(selectedCharity))
                ..unfocus(context);
            }
          },
          avatar: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset('assets/ui/charity.png'),
          ),
          label: (state.blackCharity?.value ?? 0) != 0
              ? Container(
                  constraints:
                      const BoxConstraints(maxHeight: 16, maxWidth: 110),
                  padding: const EdgeInsets.only(left: 10),
                  child: Image.asset(charities[state.blackCharity]),
                )
              : Text(
                  "Charity",
                  style: reviewTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
        ),
      );
}

class AutoTags extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      Wrap(
          spacing: 4,
          children: {...state.attributes, ...state.autoTags}
              .listMap((tag) => ChoiceChip(
                    elevation: kChipElevation,
                    avatar: state.attributes.contains(tag)
                        ? null
                        : const Icon(Icons.lightbulb_outline),
                    selected: state.attributes.contains(tag),
                    onSelected: (s) =>
                        reviewBloc.add(CreateReviewBlocEvent.attribute(tag)),
                    selectedColor: kPrimaryButtonColor,
                    label: Text('#$tag'),
                  )));
}

class EmojiTag extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      TasteTagChip(
        selected: state.emojis.isNotEmpty,
        onSelected: (i) async {
          TAEvent.tappe_emoji_tag();
          await quickPush(
            TAPage.select_emojis_page,
            (context) => TasteTagsPickerPage(
              selected: state.emojis,
              title: "Add Emojis",
              tags: kEmojiTagsMap,
            ),
          );
          reviewBloc
            ..add(CreateReviewBlocEvent.emojis(state.emojis))
            ..unfocus(context);
        },
        avatar: Text('😋',
            style: reviewTextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            )),
        label: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Emojis${state.emojis.isEmpty ? " " : ": "}',
                style: reviewTextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              ...state.emojis.map((t) => Text(t)),
            ],
          ),
        ),
      );
}

class CuisineTag extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      TasteTagChip(
        selected: state.cuisine.isNotEmpty,
        onSelected: (_) async {
          TAEvent.tapped_cuisine_tag();
          await quickPush(
              TAPage.select_cuisine_page,
              (context) => TasteTagsPickerPage(
                    selected: state.cuisine,
                    title: "Cuisine by Country",
                    tags: kCountryTasteTagsMap,
                    subtitle: true,
                  ));
          reviewBloc.unfocus(context);
        },
        avatar: Icon(
          Icons.public,
          color: state.cuisine.isNotEmpty ? Colors.white : null,
        ),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Cuisine${state.cuisine.isEmpty ? " " : ": "}',
              style: reviewTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            ...state.cuisine.map((t) => Text(t)),
          ],
        ),
      );
}

class DeliveryTag extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      Visibility(
          visible: !state.isHome,
          child: TasteTagChip(
              selected: state.isDelivery,
              onSelected: (_) async {
                final $pb.Review_DeliveryApp app = await quickPush(
                    TAPage.select_delivery_app,
                    (context) => const SelectDeliveryAppPage());
                reviewBloc
                  ..add(app == null
                      ? const CreateReviewBlocEvent.removeDelivery()
                      : CreateReviewBlocEvent.deliveryApp(app))
                  ..unfocus(context);
              },
              avatar: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('assets/ui/delivery.png'),
              ),
              label: (state.app?.value ?? 0) != 0
                  ? Container(
                      constraints:
                          const BoxConstraints(maxHeight: 16, maxWidth: 110),
                      padding: const EdgeInsets.only(left: 10),
                      child: Image.asset(
                        deliveryApps[state.app],
                      ),
                    )
                  : Text("Delivery",
                      style: reviewTextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ))));
}

class MealMatesTag extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      InkWell(
          onTap: () async {
            await quickPush(
                TAPage.tag_meal_mates, (_) => ChooseMatesPage(reviewBloc));
            reviewBloc.unfocus(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child:
                      Text('Tag Friends', style: reviewTextStyle(fontSize: 16)),
                ),
                Visibility(
                  visible: state.mealMates.isEmpty,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.people),
                  ),
                ),
                Expanded(
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: state.mealMates.listMap((user) => Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ProfilePhoto(radius: 16, user: user.ref),
                          ))),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.arrow_forward_ios,
                      color: Color(0xFF707070), size: 18.0),
                )
              ],
            ),
          ));
}

class HomecookedSelector extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      TasteTagChip(
        selected: state.isHome,
        onSelected: reviewBloc.isUpdate
            ? null
            : (_) {
                TAEvent.discover_toggle_home_cooked({'state': state.isHome});
                reviewBloc.add(const CreateReviewBlocEvent.toggleVariable(
                    PostVariable.homeCooking));
              },
        avatar: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset('assets/ui/chefs_hat_fill_white.png')),
        label: Text("Homecooked",
            style: reviewTextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            )),
        color: Colors.grey[400],
      );
}

class TasteTagChip extends StatelessWidget {
  const TasteTagChip(
      {Key key,
      @required this.selected,
      this.onSelected,
      this.avatar,
      @required this.label,
      this.color})
      : super(key: key);
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Widget avatar;
  final Widget label;
  final Color color;

  @override
  Widget build(BuildContext context) => ChoiceChip(
        backgroundColor: color ?? kChipBackgroundColor,
        elevation: kChipElevation,
        padding: kChipPadding,
        labelPadding:
            const EdgeInsets.only(left: 3, right: 20, top: 5, bottom: 5),
        selected: selected,
        onSelected: onSelected,
        avatar: avatar,
        selectedColor: kPrimaryButtonColor,
        label: label,
      );
}

class RestaurantTile extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      state.isHome
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ChoseHomecookedWidget(),
            )
          : reviewBloc.isUpdate
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ChosenPlaceWidget(
                      name: reviewBloc.review.restaurantName,
                      address: reviewBloc.review.proto.address),
                )
              : state.fbPlace != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ChosenPlaceWidget(),
                    )
                  : SelectPlaceWidget();
}

class ReactionTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const ReactionHeader(), ReactionSelector()]),
      );
}

class ReactionSelector extends CreateReviewChildWidget {
  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.favorite, color: Color(0xFFE69a9a), size: 38),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset("assets/ui/thumbs_up.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset("assets/ui/thumbs_down.png"),
              ),
            ]
                .zip(reactions)
                .zipMap((icon, reaction) => ReactionButton(reaction, icon))
                .toList(),
          ),
        ),
      );
}

class ReactionButton extends CreateReviewChildWidget {
  ReactionButton(this.reaction, this.icon);
  final Reaction reaction;
  final Widget icon;

  @override
  Widget childBuild(
          BuildContext context,
          PostPhotoManager bloc,
          CreateReviewBlocState state,
          CreateReviewBloc reviewBloc,
          PostPhotoState photoState) =>
      IconButton(
        onPressed: () =>
            reviewBloc.add(CreateReviewBlocEvent.reaction(reaction)),
        iconSize: 56,
        icon: Center(
          child: Container(
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(
                  color: reaction == state.reaction
                      ? kPrimaryButtonColor
                      : const Color(0xFF6C727C).withOpacity(0.75),
                  width: 2.0,
                ),
                shape: BoxShape.circle,
                color: reaction == state.reaction
                    ? Colors.green.withOpacity(0.1)
                    : Colors.white,
              ),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: icon,
              )),
        ),
      );
}

class ReactionHeader extends StatelessWidget {
  const ReactionHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text(
        "Your Rating",
        style: reviewTextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class TagsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const TasteTagsHeader(), TagsSection()]),
      );
}
