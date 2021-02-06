import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/components/nav/nav.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/create_review/review/restaurant_chip_selector.dart';
import 'package:taste/screens/create_review/review/tagger_widget.dart';
import 'package:taste/taste_backend_client/responses/contest.dart';
import 'package:taste/taste_backend_client/responses/review.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/fb_places_api.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste/utils/unfocusable.dart';
import 'package:taste_protos/taste_protos.dart'
    show
        Reaction,
        Review_DeliveryApp,
        Review_BlackOwnedStatus,
        BlackCharity,
        Restaurant_Attributes_Address;
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'create_review.dart';
import 'data_correctness.dart';
import 'legal_taste_tags.dart';
import 'meal_mate.dart';
import 'post_photo_manager.dart';

part 'create_review_bloc.freezed.dart';

final _formKey = GlobalKey<FormState>();

@freezed
abstract class RestaurantRecord implements _$RestaurantRecord {
  RestaurantRecord._();
  factory RestaurantRecord.existing(Restaurant restaurant) = _Existing;
  factory RestaurantRecord.fbPlace(FacebookPlaceResult fbPlace) = _FbPlace;
  String get name => when(fbPlace: (a) => a.name, existing: (a) => a.name);
  GeoPoint get location => when(
      fbPlace: (a) => a.location.geoPoint,
      existing: (a) => a.location.geoPoint);
  Restaurant_Attributes_Address get address => when(
      fbPlace: (a) => a.address, existing: (a) => a.proto.attributes.address);
  List<String> get categories => when(
      fbPlace: (a) => a.restaurantCategories,
      existing: (a) => a.proto.attributes.categories);
}

@freezed
abstract class CreateReviewBlocState implements _$CreateReviewBlocState {
  factory CreateReviewBlocState({
    bool sealBroken,
    Set<MealMate> mealMates,
    Set<MealMate> taggedUsers,
    Review_DeliveryApp app,
    Set<PostVariable> postVariables,
    FacebookPlaceResult fbPlace,
    Set<String> emojis,
    Set<String> cuisine,
    Set<String> attributes,
    DocumentReference contest,
    Reaction reaction,
    List<FacebookPlaceResult> suggestions,
    Future<LatLng> location,
    Future<RestaurantRecord> restaurant,
    Set<String> autoTags,
    Review_BlackOwnedStatus blackOwned,
    BlackCharity blackCharity,
  }) = _Create;
  CreateReviewBlocState._();
  bool get isHome => postVariables.contains(PostVariable.homeCooking);
  bool get isDelivery => postVariables.contains(PostVariable.delivery);

  bool get isBlackOwned => {
        $pb.Review_BlackOwnedStatus.restaurant_black_owned,
        $pb.Review_BlackOwnedStatus.user_selected_black_owned
      }.contains(blackOwned);

  bool get hasContestVariable => postVariables.intersection({
        PostVariable.contestHomeCooking,
        PostVariable.contestRestaurant
      }).isNotEmpty;
  bool get hasContest => contest != null;

  CreateReviewBlocState toggleVariable(PostVariable variable) =>
      withVariable(variable, enable: !contains(variable));
  bool contains(PostVariable variable) => postVariables.contains(variable);
  CreateReviewBlocState withVariable(PostVariable variable,
      {bool enable = true}) {
    final implications =
        getImplications({variable: enable}.withoutNulls).invert;
    return copyWith(
        postVariables: postVariables
            .union(implications[true]?.toSet() ?? {})
            .difference(implications[false]?.toSet() ?? {}));
  }
}

@freezed
abstract class CreateReviewBlocEvent with _$CreateReviewBlocEvent {
  const factory CreateReviewBlocEvent.toggleVariable(PostVariable variable) =
      _Enable;
  const factory CreateReviewBlocEvent.submit(BuildContext context) = _Submit;
  const factory CreateReviewBlocEvent.suggestions(
      List<FacebookPlaceResult> suggestions) = _Suggestions;
  const factory CreateReviewBlocEvent.contest(Contest contest) = _Contest;
  const factory CreateReviewBlocEvent.removeContest() = _RemoveContest;
  const factory CreateReviewBlocEvent.mate(MealMate mate) = _Mate;
  const factory CreateReviewBlocEvent.matesFinished(Set<MealMate> mate) =
      _MatesFinished;
  const factory CreateReviewBlocEvent.taggedUsers(Set<MealMate> mate) =
      _TagUser;
  const factory CreateReviewBlocEvent.emojis(Set<String> emojis) = _Emojis;
  const factory CreateReviewBlocEvent.cuisines(Set<String> cuisines) =
      _Cuisines;
  const factory CreateReviewBlocEvent.attribute(String attribute) = _Attribute;
  const factory CreateReviewBlocEvent.fbPlace(FacebookPlaceResult fbPlace) =
      _FBPlace;
  const factory CreateReviewBlocEvent.blackOwned(
      Review_BlackOwnedStatus blackOwned) = _BlackOwned;
  const factory CreateReviewBlocEvent.blackCharity(BlackCharity blackCharity) =
      _BlackCharity;
  const factory CreateReviewBlocEvent.removeFbPlace() = _RemoveFbPlace;
  const factory CreateReviewBlocEvent.breakSeal() = _BreakSeal;
  const factory CreateReviewBlocEvent.reaction(Reaction reaction) = _Reaction;
  const factory CreateReviewBlocEvent.deliveryApp(Review_DeliveryApp app) =
      _DeliveryApp;
  const factory CreateReviewBlocEvent.removeDelivery() = _RemoveDelivery;
  const factory CreateReviewBlocEvent.autoTags(Set<String> tags) = _AutoTags;
}

class CreateReviewBloc
    extends Bloc<CreateReviewBlocEvent, CreateReviewBlocState> {
  CreateReviewBloc(this.parent) {
    _subs
      ..add(autoTags(parent.images).listen((tags) {
        cloudLog({'label': 'auto_tags', 'tags': tags.toList()});
        add(CreateReviewBlocEvent.autoTags(tags));
      }));
    textNode.addListener(() => add(const CreateReviewBlocEvent.breakSeal()));
    if (isUpdate) {
      textController.text = review.rawText;
      dishController.text = review.dish;
      recipeController.text = review.recipe;
      review.proto.mealMates
          .futureMap((m) => MealMate.reference(m.ref))
          .then((ms) => add(CreateReviewBlocEvent.matesFinished(ms.toSet())));
    }
    recipeNode.addListener(() async {
      if (!recipeNode.hasFocus) {
        return;
      }
      final text = (await Clipboard.getData('text/plain'))?.text ?? '';
      if (text.isEmpty) {
        return;
      }
      tasteSnackBar(
        SnackBar(
          content: Text("Add Contents from Clipboard? '${text.ellipsis(60)}'"),
          action: SnackBarAction(
            label: "Add",
            onPressed: () => recipeController.append(' $text'),
          ),
        ),
      );
    });
  }
  void unfocus(BuildContext context) {
    keyboardUnfocus(context);
    dishNode.unfocus();
    textNode.unfocus();
  }

  final textNode = FocusNode();
  final dishNode = FocusNode();
  final recipeNode = FocusNode();
  final List<StreamSubscription> _subs = [];
  $pb.Contest_ContestType get forcedContestType => isUpdate
      ? review.isHomeCooked
          ? $pb.Contest_ContestType.contest_type_home_cooking
          : $pb.Contest_ContestType.contest_type_local_restaurants
      : null;
  final CreateOrUpdateReviewWidget parent;

  bool get isUpdate => review != null;
  Review get review => parent.review;
  final textController = TextEditingController();
  final dishController = TextEditingController();
  final recipeController = TextEditingController();
  GlobalKey<FormState> get formKey => _formKey;

  @override
  Future<void> close() async {
    _subs.forEach((e) => e.cancel());
    return super.close();
  }

  @override
  CreateReviewBlocState get initialState => isUpdate
      ? CreateReviewBlocState(
          attributes: review.proto.attributes.toSet(),
          app: review.proto.deliveryApp,
          contest: review.proto.contest.ref,
          emojis: review.emojis.difference(kCountryTasteTagsMap.keys.toSet()),
          cuisine:
              review.emojis.intersection(kCountryTasteTagsMap.keys.toSet()),
          fbPlace: null,
          mealMates: {},
          reaction: review.reaction,
          postVariables: {
            PostVariable.homeCooking: review.isHomeCooked,
            PostVariable.contestRestaurant: review.proto.hasContest(),
            PostVariable.delivery: review.isDelivery,
            PostVariable.restaurant: !review.isHomeCooked,
            PostVariable.contestHomeCooking: review.proto.hasContest(),
          }.where((k, v) => v).keys.toSet(),
          sealBroken: true,
          suggestions: null,
          taggedUsers: {},
          location: null,
          autoTags: {},
          blackOwned: review.proto.blackOwned,
          blackCharity: review.proto.blackCharity,
        )
      : CreateReviewBlocState(
          attributes: {},
          app: null,
          contest: null,
          emojis: {},
          cuisine: {},
          fbPlace: null,
          mealMates: {},
          taggedUsers: {},
          postVariables: {PostVariable.restaurant},
          sealBroken: false,
          reaction: Reaction.up,
          suggestions: null,
          autoTags: {},
          blackOwned: null,
          blackCharity: null,
          location: (() async {
            final location =
                await _location.timeout(10.seconds, onTimeout: () => null);
            add(CreateReviewBlocEvent.suggestions(await FacebookPlacesManager
                .instance
                .nearbyPlaces(location: location)));
            return location;
          })());

  Future<LatLng> get _location async {
    if (isUpdate) {
      return null;
    }
    if (parent.photoLocation != null) {
      return parent.photoLocation;
    }
    await requestLocationPermissions;
    return myLocation();
  }

  @override
  Stream<CreateReviewBlocState> mapEventToState(CreateReviewBlocEvent event) =>
      event.when(
          autoTags: (t) => Stream.value(state.copyWith(autoTags: t)),
          submit: (context) async* {
            await submitReview(context, BlocProvider.of(context), this, state);
            yield state;
          },
          removeDelivery: () => Stream.value(state
              .withVariable(PostVariable.delivery, enable: false)
              .copyWith(app: null)),
          deliveryApp: (app) => Stream.value(
              state.withVariable(PostVariable.delivery).copyWith(app: app)),
          suggestions: (suggestions) =>
              Stream.value(state.copyWith(suggestions: suggestions)),
          taggedUsers: (taggedUsers) =>
              Stream.value(state.copyWith(taggedUsers: taggedUsers.toSet())),
          cuisines: (cuisines) =>
              Stream.value(state.copyWith(cuisine: cuisines.toSet())),
          breakSeal: () => Stream.value(state.copyWith(sealBroken: true)),
          reaction: (r) => Stream.value(state.copyWith(reaction: r)),
          toggleVariable: (value) => Stream.value(state.toggleVariable(value)),
          mate: (value) => Stream.value(
              state.copyWith(mealMates: _toggle(state.mealMates, value))),
          matesFinished: (mates) =>
              Stream.value(state.copyWith(mealMates: mates)),
          emojis: (emojis) =>
              Stream.value(state.copyWith(emojis: emojis.toSet())),
          attribute: (value) => Stream.value(state.copyWith(attributes: _toggle(state.attributes, value))),
          contest: (c) => Stream.value(state.withVariable(c.isHomeCooking ? PostVariable.contestHomeCooking : c.isRestaurant ? PostVariable.contestRestaurant : null).copyWith(contest: c.reference)),
          removeContest: () => Stream.value(state.withVariable(PostVariable.contestHomeCooking, enable: false).withVariable(PostVariable.contestRestaurant, enable: false).copyWith(contest: null)),
          fbPlace: (place) => Stream.value(state.copyWith(fbPlace: place, restaurant: restaurantByFbPlace(place).then((value) => value == null ? RestaurantRecord.fbPlace(place) : RestaurantRecord.existing(value)))),
          blackOwned: (blackOwned) => Stream.value(state.copyWith(blackOwned: blackOwned)),
          blackCharity: (blackCharity) => Stream.value(state.copyWith(blackCharity: blackCharity)),
          removeFbPlace: () => Stream.value(state.copyWith(fbPlace: null, restaurant: null, blackOwned: null)));

  Set<T> _toggle<T>(Set<T> set, T value, {bool enable}) {
    final copy = set.toSet();
    enable ?? !set.contains(value) ? copy.add(value) : copy.remove(value);
    return copy;
  }

  bool validate() => _formKey.currentState.validate();

  @override
  void onTransition(
      Transition<CreateReviewBlocEvent, CreateReviewBlocState> transition) {
    super.onTransition(transition);
    if (!transition.nextState.hasContestVariable &&
        transition.nextState.hasContest) {
      add(const CreateReviewBlocEvent.removeContest());
    }
    if (transition.nextState.isDelivery &&
        !transition.nextState.contains(PostVariable.delivery)) {
      add(const CreateReviewBlocEvent.removeDelivery());
    }
    if (!transition.nextState.contains(PostVariable.restaurant)) {
      // I think caching the previously selected restaurant is a bad/surprising
      // UX, since it was previously "cleared" as far as the user can tell.
      add(const CreateReviewBlocEvent.removeFbPlace());
    }
    if (transition.nextState.isDelivery ^ transition.currentState.isDelivery) {
      final emojis = transition.nextState.emojis.toSet();
      transition.nextState.isDelivery
          ? emojis.add(deliveryEmoji)
          : emojis.remove(deliveryEmoji);
      add(CreateReviewBlocEvent.emojis(emojis));
    }
  }
}

Future<void> submitReview(BuildContext context, PostPhotoManager bloc,
    CreateReviewBloc reviewBloc, CreateReviewBlocState state) async {
  final isUpdate = reviewBloc.isUpdate;
  final home = state.isHome;
  final fbPlace = state.fbPlace;
  TAEvent.submit_post_attempt({'update': isUpdate});
  if (fbPlace == null && !home && !isUpdate) {
    TAEvent.submit_post_attempt_incomplete({'update': isUpdate});
    tasteSnackBar(SnackBar(
      backgroundColor: kPrimaryButtonColor,
      content: Text(
        "Please add place (or tag as Homecooked)",
        style: reviewTextStyle(
            fontSize: 17.0, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      duration: const Duration(seconds: 5),
    ));
    return;
  }
  if (!reviewBloc.validate()) {
    return TAEvent.submit_post_attempt_incomplete({'update': isUpdate});
  }
  FocusScope.of(context).unfocus();
  if (!state.sealBroken &&
      !(await showDialog(
              context: context,
              builder: (context) => const AreYouSureDialog()) ??
          false)) {
    reviewBloc.add(const CreateReviewBlocEvent.breakSeal());
    reviewBloc.textNode.requestFocus();
    return;
  }
  BlackCharity selectedCharity;
  if (state.isBlackOwned && !isUpdate) {
    selectedCharity = await selectBlackCharity(context, reviewBloc);
    if (selectedCharity == null) {
      return;
    }
  }
  void _completePhotos(DocumentReference reference) =>
      bloc.add(PostPhotoEvent.complete(reference));
  final allEmojis = state.emojis.union(state.cuisine);
  final mealMates = state.mealMates.listMap((t) => t.ref);
  final taggedUsers = state.taggedUsers.listMap((t) => t.ref);
  final snapshot = await spinner(() async {
    if (isUpdate) {
      final review = reviewBloc.review;
      await review.reference.updateData({
        'dish': reviewBloc.dishController.text,
        'text': reviewBloc.textController.text,
        'reaction': state.reaction,
        'emojis': allEmojis,
        'attributes': state.attributes,
        'meal_mates': mealMates,
        'user_tags_in_text': taggedUsers,
        'contest': state.contest,
        'delivery_app': state.app,
        'recipe': home ? reviewBloc.recipeController.text : null,
        'black_owned': state.blackOwned,
        'black_charity': state.blackCharity,
      }
          .ensureAs($pb.Review(), explicitEmpties: true, explicitNulls: true)
          .withUpdateExtras);
      _completePhotos(review.reference);
      return review.snapshot;
    }
    final batch = Firestore.instance.batch();

    final reference =
        (home ? CollectionType.home_meals : CollectionType.reviews)
            .coll
            .document();
    _completePhotos(reference);
    // Maybe null.
    final restaurant = await state.restaurant;
    final restaurantReference = await restaurant?.when(
        existing: (r) async => r.reference,
        fbPlace: (fbPlace) async {
          final reference = CollectionType.restaurants.coll.document();
          final data = {
            'attributes': {
              'location': {
                'latitude': fbPlace.location.latitude,
                'longitude': fbPlace.location.longitude,
              },
              'name': fbPlace.name,
              'address': fbPlace.address,
              'fb_place_id': fbPlace.id,
              'categories': fbPlace.restaurantCategories,
            }
          }.ensureAs($pb.Restaurant()).withExtras;
          batch.setData(reference, data);
          return reference;
        });
    batch.setData(
        reference,
        {
          'user': currentUserReference,
          'dish': reviewBloc.dishController.text,
          'restaurant': restaurantReference,
          'restaurant_name': restaurant?.name,
          'restaurant_location': restaurant?.location,
          'categories': (restaurant?.categories ?? []).isEmpty
              ? null
              : restaurant.categories,
          'meal_type': home ? $pb.Review_MealType.meal_type_home : null,
          'location': {
            'latitude': (await state.location)?.latitude,
            'longitude': (await state.location)?.longitude,
          },
          'address': restaurant?.address,
          'text': reviewBloc.textController.text,
          'reaction': state.reaction,
          'emojis': allEmojis,
          'attributes': state.attributes,
          'meal_mates': mealMates,
          'user_tags_in_text': taggedUsers,
          'contest': state.contest,
          'delivery_app': state.app,
          'recipe': home ? reviewBloc.recipeController.text : null,
          'black_owned': state.blackOwned,
          'black_charity': selectedCharity,
          'hidden': false,
        }.ensureAs($pb.Review()).withExtras);
    await batch.commit();
    return reference.get();
  });
  final review = Review(snapshot);
  TAEvent.create_post({'post': review.reference.path});
  isUpdate ? Navigator.pop(context) : goToTab(0);
  snackBarString(isUpdate
      ? "Your updates will appear soon"
      : "Thanks for sharing! Your post will appear soon.");
}

class AreYouSureDialog extends StatelessWidget {
  const AreYouSureDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TasteDialog(
        title: "Submit post?",
        content: const Text(
            "You can add more details like tags and your written review."),
        buttons: [
          TasteDialogButton(
              onPressed: () {
                TAEvent.create_post_presubmit_dialog_keep_editing();
                Navigator.pop(context, false);
              },
              text: 'Keep editing'),
          TasteDialogButton(
              onPressed: () {
                TAEvent.create_post_presubmit_dialog_submit();
                Navigator.pop(context, true);
              },
              text: 'Submit')
        ],
      ),
    );
  }
}
