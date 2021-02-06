// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'create_review_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$RestaurantRecordTearOff {
  const _$RestaurantRecordTearOff();

  _Existing existing(Restaurant restaurant) {
    return _Existing(
      restaurant,
    );
  }

  _FbPlace fbPlace(FacebookPlaceResult fbPlace) {
    return _FbPlace(
      fbPlace,
    );
  }
}

// ignore: unused_element
const $RestaurantRecord = _$RestaurantRecordTearOff();

mixin _$RestaurantRecord {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result existing(Restaurant restaurant),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result existing(Restaurant restaurant),
    Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result existing(_Existing value),
    @required Result fbPlace(_FbPlace value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result existing(_Existing value),
    Result fbPlace(_FbPlace value),
    @required Result orElse(),
  });
}

abstract class $RestaurantRecordCopyWith<$Res> {
  factory $RestaurantRecordCopyWith(
          RestaurantRecord value, $Res Function(RestaurantRecord) then) =
      _$RestaurantRecordCopyWithImpl<$Res>;
}

class _$RestaurantRecordCopyWithImpl<$Res>
    implements $RestaurantRecordCopyWith<$Res> {
  _$RestaurantRecordCopyWithImpl(this._value, this._then);

  final RestaurantRecord _value;
  // ignore: unused_field
  final $Res Function(RestaurantRecord) _then;
}

abstract class _$ExistingCopyWith<$Res> {
  factory _$ExistingCopyWith(_Existing value, $Res Function(_Existing) then) =
      __$ExistingCopyWithImpl<$Res>;
  $Res call({Restaurant restaurant});
}

class __$ExistingCopyWithImpl<$Res> extends _$RestaurantRecordCopyWithImpl<$Res>
    implements _$ExistingCopyWith<$Res> {
  __$ExistingCopyWithImpl(_Existing _value, $Res Function(_Existing) _then)
      : super(_value, (v) => _then(v as _Existing));

  @override
  _Existing get _value => super._value as _Existing;

  @override
  $Res call({
    Object restaurant = freezed,
  }) {
    return _then(_Existing(
      restaurant == freezed ? _value.restaurant : restaurant as Restaurant,
    ));
  }
}

class _$_Existing extends _Existing with DiagnosticableTreeMixin {
  _$_Existing(this.restaurant)
      : assert(restaurant != null),
        super._();

  @override
  final Restaurant restaurant;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RestaurantRecord.existing(restaurant: $restaurant)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RestaurantRecord.existing'))
      ..add(DiagnosticsProperty('restaurant', restaurant));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Existing &&
            (identical(other.restaurant, restaurant) ||
                const DeepCollectionEquality()
                    .equals(other.restaurant, restaurant)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(restaurant);

  @override
  _$ExistingCopyWith<_Existing> get copyWith =>
      __$ExistingCopyWithImpl<_Existing>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result existing(Restaurant restaurant),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
  }) {
    assert(existing != null);
    assert(fbPlace != null);
    return existing(restaurant);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result existing(Restaurant restaurant),
    Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (existing != null) {
      return existing(restaurant);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result existing(_Existing value),
    @required Result fbPlace(_FbPlace value),
  }) {
    assert(existing != null);
    assert(fbPlace != null);
    return existing(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result existing(_Existing value),
    Result fbPlace(_FbPlace value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (existing != null) {
      return existing(this);
    }
    return orElse();
  }
}

abstract class _Existing extends RestaurantRecord {
  _Existing._() : super._();
  factory _Existing(Restaurant restaurant) = _$_Existing;

  Restaurant get restaurant;
  _$ExistingCopyWith<_Existing> get copyWith;
}

abstract class _$FbPlaceCopyWith<$Res> {
  factory _$FbPlaceCopyWith(_FbPlace value, $Res Function(_FbPlace) then) =
      __$FbPlaceCopyWithImpl<$Res>;
  $Res call({FacebookPlaceResult fbPlace});
}

class __$FbPlaceCopyWithImpl<$Res> extends _$RestaurantRecordCopyWithImpl<$Res>
    implements _$FbPlaceCopyWith<$Res> {
  __$FbPlaceCopyWithImpl(_FbPlace _value, $Res Function(_FbPlace) _then)
      : super(_value, (v) => _then(v as _FbPlace));

  @override
  _FbPlace get _value => super._value as _FbPlace;

  @override
  $Res call({
    Object fbPlace = freezed,
  }) {
    return _then(_FbPlace(
      fbPlace == freezed ? _value.fbPlace : fbPlace as FacebookPlaceResult,
    ));
  }
}

class _$_FbPlace extends _FbPlace with DiagnosticableTreeMixin {
  _$_FbPlace(this.fbPlace)
      : assert(fbPlace != null),
        super._();

  @override
  final FacebookPlaceResult fbPlace;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RestaurantRecord.fbPlace(fbPlace: $fbPlace)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RestaurantRecord.fbPlace'))
      ..add(DiagnosticsProperty('fbPlace', fbPlace));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FbPlace &&
            (identical(other.fbPlace, fbPlace) ||
                const DeepCollectionEquality().equals(other.fbPlace, fbPlace)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(fbPlace);

  @override
  _$FbPlaceCopyWith<_FbPlace> get copyWith =>
      __$FbPlaceCopyWithImpl<_FbPlace>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result existing(Restaurant restaurant),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
  }) {
    assert(existing != null);
    assert(fbPlace != null);
    return fbPlace(this.fbPlace);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result existing(Restaurant restaurant),
    Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fbPlace != null) {
      return fbPlace(this.fbPlace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result existing(_Existing value),
    @required Result fbPlace(_FbPlace value),
  }) {
    assert(existing != null);
    assert(fbPlace != null);
    return fbPlace(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result existing(_Existing value),
    Result fbPlace(_FbPlace value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fbPlace != null) {
      return fbPlace(this);
    }
    return orElse();
  }
}

abstract class _FbPlace extends RestaurantRecord {
  _FbPlace._() : super._();
  factory _FbPlace(FacebookPlaceResult fbPlace) = _$_FbPlace;

  FacebookPlaceResult get fbPlace;
  _$FbPlaceCopyWith<_FbPlace> get copyWith;
}

class _$CreateReviewBlocStateTearOff {
  const _$CreateReviewBlocStateTearOff();

  _Create call(
      {bool sealBroken,
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
      BlackCharity blackCharity}) {
    return _Create(
      sealBroken: sealBroken,
      mealMates: mealMates,
      taggedUsers: taggedUsers,
      app: app,
      postVariables: postVariables,
      fbPlace: fbPlace,
      emojis: emojis,
      cuisine: cuisine,
      attributes: attributes,
      contest: contest,
      reaction: reaction,
      suggestions: suggestions,
      location: location,
      restaurant: restaurant,
      autoTags: autoTags,
      blackOwned: blackOwned,
      blackCharity: blackCharity,
    );
  }
}

// ignore: unused_element
const $CreateReviewBlocState = _$CreateReviewBlocStateTearOff();

mixin _$CreateReviewBlocState {
  bool get sealBroken;
  Set<MealMate> get mealMates;
  Set<MealMate> get taggedUsers;
  Review_DeliveryApp get app;
  Set<PostVariable> get postVariables;
  FacebookPlaceResult get fbPlace;
  Set<String> get emojis;
  Set<String> get cuisine;
  Set<String> get attributes;
  DocumentReference get contest;
  Reaction get reaction;
  List<FacebookPlaceResult> get suggestions;
  Future<LatLng> get location;
  Future<RestaurantRecord> get restaurant;
  Set<String> get autoTags;
  Review_BlackOwnedStatus get blackOwned;
  BlackCharity get blackCharity;

  $CreateReviewBlocStateCopyWith<CreateReviewBlocState> get copyWith;
}

abstract class $CreateReviewBlocStateCopyWith<$Res> {
  factory $CreateReviewBlocStateCopyWith(CreateReviewBlocState value,
          $Res Function(CreateReviewBlocState) then) =
      _$CreateReviewBlocStateCopyWithImpl<$Res>;
  $Res call(
      {bool sealBroken,
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
      BlackCharity blackCharity});
}

class _$CreateReviewBlocStateCopyWithImpl<$Res>
    implements $CreateReviewBlocStateCopyWith<$Res> {
  _$CreateReviewBlocStateCopyWithImpl(this._value, this._then);

  final CreateReviewBlocState _value;
  // ignore: unused_field
  final $Res Function(CreateReviewBlocState) _then;

  @override
  $Res call({
    Object sealBroken = freezed,
    Object mealMates = freezed,
    Object taggedUsers = freezed,
    Object app = freezed,
    Object postVariables = freezed,
    Object fbPlace = freezed,
    Object emojis = freezed,
    Object cuisine = freezed,
    Object attributes = freezed,
    Object contest = freezed,
    Object reaction = freezed,
    Object suggestions = freezed,
    Object location = freezed,
    Object restaurant = freezed,
    Object autoTags = freezed,
    Object blackOwned = freezed,
    Object blackCharity = freezed,
  }) {
    return _then(_value.copyWith(
      sealBroken:
          sealBroken == freezed ? _value.sealBroken : sealBroken as bool,
      mealMates:
          mealMates == freezed ? _value.mealMates : mealMates as Set<MealMate>,
      taggedUsers: taggedUsers == freezed
          ? _value.taggedUsers
          : taggedUsers as Set<MealMate>,
      app: app == freezed ? _value.app : app as Review_DeliveryApp,
      postVariables: postVariables == freezed
          ? _value.postVariables
          : postVariables as Set<PostVariable>,
      fbPlace:
          fbPlace == freezed ? _value.fbPlace : fbPlace as FacebookPlaceResult,
      emojis: emojis == freezed ? _value.emojis : emojis as Set<String>,
      cuisine: cuisine == freezed ? _value.cuisine : cuisine as Set<String>,
      attributes:
          attributes == freezed ? _value.attributes : attributes as Set<String>,
      contest:
          contest == freezed ? _value.contest : contest as DocumentReference,
      reaction: reaction == freezed ? _value.reaction : reaction as Reaction,
      suggestions: suggestions == freezed
          ? _value.suggestions
          : suggestions as List<FacebookPlaceResult>,
      location:
          location == freezed ? _value.location : location as Future<LatLng>,
      restaurant: restaurant == freezed
          ? _value.restaurant
          : restaurant as Future<RestaurantRecord>,
      autoTags: autoTags == freezed ? _value.autoTags : autoTags as Set<String>,
      blackOwned: blackOwned == freezed
          ? _value.blackOwned
          : blackOwned as Review_BlackOwnedStatus,
      blackCharity: blackCharity == freezed
          ? _value.blackCharity
          : blackCharity as BlackCharity,
    ));
  }
}

abstract class _$CreateCopyWith<$Res>
    implements $CreateReviewBlocStateCopyWith<$Res> {
  factory _$CreateCopyWith(_Create value, $Res Function(_Create) then) =
      __$CreateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool sealBroken,
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
      BlackCharity blackCharity});
}

class __$CreateCopyWithImpl<$Res>
    extends _$CreateReviewBlocStateCopyWithImpl<$Res>
    implements _$CreateCopyWith<$Res> {
  __$CreateCopyWithImpl(_Create _value, $Res Function(_Create) _then)
      : super(_value, (v) => _then(v as _Create));

  @override
  _Create get _value => super._value as _Create;

  @override
  $Res call({
    Object sealBroken = freezed,
    Object mealMates = freezed,
    Object taggedUsers = freezed,
    Object app = freezed,
    Object postVariables = freezed,
    Object fbPlace = freezed,
    Object emojis = freezed,
    Object cuisine = freezed,
    Object attributes = freezed,
    Object contest = freezed,
    Object reaction = freezed,
    Object suggestions = freezed,
    Object location = freezed,
    Object restaurant = freezed,
    Object autoTags = freezed,
    Object blackOwned = freezed,
    Object blackCharity = freezed,
  }) {
    return _then(_Create(
      sealBroken:
          sealBroken == freezed ? _value.sealBroken : sealBroken as bool,
      mealMates:
          mealMates == freezed ? _value.mealMates : mealMates as Set<MealMate>,
      taggedUsers: taggedUsers == freezed
          ? _value.taggedUsers
          : taggedUsers as Set<MealMate>,
      app: app == freezed ? _value.app : app as Review_DeliveryApp,
      postVariables: postVariables == freezed
          ? _value.postVariables
          : postVariables as Set<PostVariable>,
      fbPlace:
          fbPlace == freezed ? _value.fbPlace : fbPlace as FacebookPlaceResult,
      emojis: emojis == freezed ? _value.emojis : emojis as Set<String>,
      cuisine: cuisine == freezed ? _value.cuisine : cuisine as Set<String>,
      attributes:
          attributes == freezed ? _value.attributes : attributes as Set<String>,
      contest:
          contest == freezed ? _value.contest : contest as DocumentReference,
      reaction: reaction == freezed ? _value.reaction : reaction as Reaction,
      suggestions: suggestions == freezed
          ? _value.suggestions
          : suggestions as List<FacebookPlaceResult>,
      location:
          location == freezed ? _value.location : location as Future<LatLng>,
      restaurant: restaurant == freezed
          ? _value.restaurant
          : restaurant as Future<RestaurantRecord>,
      autoTags: autoTags == freezed ? _value.autoTags : autoTags as Set<String>,
      blackOwned: blackOwned == freezed
          ? _value.blackOwned
          : blackOwned as Review_BlackOwnedStatus,
      blackCharity: blackCharity == freezed
          ? _value.blackCharity
          : blackCharity as BlackCharity,
    ));
  }
}

class _$_Create extends _Create with DiagnosticableTreeMixin {
  _$_Create(
      {this.sealBroken,
      this.mealMates,
      this.taggedUsers,
      this.app,
      this.postVariables,
      this.fbPlace,
      this.emojis,
      this.cuisine,
      this.attributes,
      this.contest,
      this.reaction,
      this.suggestions,
      this.location,
      this.restaurant,
      this.autoTags,
      this.blackOwned,
      this.blackCharity})
      : super._();

  @override
  final bool sealBroken;
  @override
  final Set<MealMate> mealMates;
  @override
  final Set<MealMate> taggedUsers;
  @override
  final Review_DeliveryApp app;
  @override
  final Set<PostVariable> postVariables;
  @override
  final FacebookPlaceResult fbPlace;
  @override
  final Set<String> emojis;
  @override
  final Set<String> cuisine;
  @override
  final Set<String> attributes;
  @override
  final DocumentReference contest;
  @override
  final Reaction reaction;
  @override
  final List<FacebookPlaceResult> suggestions;
  @override
  final Future<LatLng> location;
  @override
  final Future<RestaurantRecord> restaurant;
  @override
  final Set<String> autoTags;
  @override
  final Review_BlackOwnedStatus blackOwned;
  @override
  final BlackCharity blackCharity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocState(sealBroken: $sealBroken, mealMates: $mealMates, taggedUsers: $taggedUsers, app: $app, postVariables: $postVariables, fbPlace: $fbPlace, emojis: $emojis, cuisine: $cuisine, attributes: $attributes, contest: $contest, reaction: $reaction, suggestions: $suggestions, location: $location, restaurant: $restaurant, autoTags: $autoTags, blackOwned: $blackOwned, blackCharity: $blackCharity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocState'))
      ..add(DiagnosticsProperty('sealBroken', sealBroken))
      ..add(DiagnosticsProperty('mealMates', mealMates))
      ..add(DiagnosticsProperty('taggedUsers', taggedUsers))
      ..add(DiagnosticsProperty('app', app))
      ..add(DiagnosticsProperty('postVariables', postVariables))
      ..add(DiagnosticsProperty('fbPlace', fbPlace))
      ..add(DiagnosticsProperty('emojis', emojis))
      ..add(DiagnosticsProperty('cuisine', cuisine))
      ..add(DiagnosticsProperty('attributes', attributes))
      ..add(DiagnosticsProperty('contest', contest))
      ..add(DiagnosticsProperty('reaction', reaction))
      ..add(DiagnosticsProperty('suggestions', suggestions))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('restaurant', restaurant))
      ..add(DiagnosticsProperty('autoTags', autoTags))
      ..add(DiagnosticsProperty('blackOwned', blackOwned))
      ..add(DiagnosticsProperty('blackCharity', blackCharity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Create &&
            (identical(other.sealBroken, sealBroken) ||
                const DeepCollectionEquality()
                    .equals(other.sealBroken, sealBroken)) &&
            (identical(other.mealMates, mealMates) ||
                const DeepCollectionEquality()
                    .equals(other.mealMates, mealMates)) &&
            (identical(other.taggedUsers, taggedUsers) ||
                const DeepCollectionEquality()
                    .equals(other.taggedUsers, taggedUsers)) &&
            (identical(other.app, app) ||
                const DeepCollectionEquality().equals(other.app, app)) &&
            (identical(other.postVariables, postVariables) ||
                const DeepCollectionEquality()
                    .equals(other.postVariables, postVariables)) &&
            (identical(other.fbPlace, fbPlace) ||
                const DeepCollectionEquality()
                    .equals(other.fbPlace, fbPlace)) &&
            (identical(other.emojis, emojis) ||
                const DeepCollectionEquality().equals(other.emojis, emojis)) &&
            (identical(other.cuisine, cuisine) ||
                const DeepCollectionEquality()
                    .equals(other.cuisine, cuisine)) &&
            (identical(other.attributes, attributes) ||
                const DeepCollectionEquality()
                    .equals(other.attributes, attributes)) &&
            (identical(other.contest, contest) ||
                const DeepCollectionEquality()
                    .equals(other.contest, contest)) &&
            (identical(other.reaction, reaction) ||
                const DeepCollectionEquality()
                    .equals(other.reaction, reaction)) &&
            (identical(other.suggestions, suggestions) ||
                const DeepCollectionEquality()
                    .equals(other.suggestions, suggestions)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.restaurant, restaurant) ||
                const DeepCollectionEquality()
                    .equals(other.restaurant, restaurant)) &&
            (identical(other.autoTags, autoTags) ||
                const DeepCollectionEquality()
                    .equals(other.autoTags, autoTags)) &&
            (identical(other.blackOwned, blackOwned) ||
                const DeepCollectionEquality()
                    .equals(other.blackOwned, blackOwned)) &&
            (identical(other.blackCharity, blackCharity) ||
                const DeepCollectionEquality()
                    .equals(other.blackCharity, blackCharity)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(sealBroken) ^
      const DeepCollectionEquality().hash(mealMates) ^
      const DeepCollectionEquality().hash(taggedUsers) ^
      const DeepCollectionEquality().hash(app) ^
      const DeepCollectionEquality().hash(postVariables) ^
      const DeepCollectionEquality().hash(fbPlace) ^
      const DeepCollectionEquality().hash(emojis) ^
      const DeepCollectionEquality().hash(cuisine) ^
      const DeepCollectionEquality().hash(attributes) ^
      const DeepCollectionEquality().hash(contest) ^
      const DeepCollectionEquality().hash(reaction) ^
      const DeepCollectionEquality().hash(suggestions) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(restaurant) ^
      const DeepCollectionEquality().hash(autoTags) ^
      const DeepCollectionEquality().hash(blackOwned) ^
      const DeepCollectionEquality().hash(blackCharity);

  @override
  _$CreateCopyWith<_Create> get copyWith =>
      __$CreateCopyWithImpl<_Create>(this, _$identity);
}

abstract class _Create extends CreateReviewBlocState {
  _Create._() : super._();
  factory _Create(
      {bool sealBroken,
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
      BlackCharity blackCharity}) = _$_Create;

  @override
  bool get sealBroken;
  @override
  Set<MealMate> get mealMates;
  @override
  Set<MealMate> get taggedUsers;
  @override
  Review_DeliveryApp get app;
  @override
  Set<PostVariable> get postVariables;
  @override
  FacebookPlaceResult get fbPlace;
  @override
  Set<String> get emojis;
  @override
  Set<String> get cuisine;
  @override
  Set<String> get attributes;
  @override
  DocumentReference get contest;
  @override
  Reaction get reaction;
  @override
  List<FacebookPlaceResult> get suggestions;
  @override
  Future<LatLng> get location;
  @override
  Future<RestaurantRecord> get restaurant;
  @override
  Set<String> get autoTags;
  @override
  Review_BlackOwnedStatus get blackOwned;
  @override
  BlackCharity get blackCharity;
  @override
  _$CreateCopyWith<_Create> get copyWith;
}

class _$CreateReviewBlocEventTearOff {
  const _$CreateReviewBlocEventTearOff();

  _Enable toggleVariable(PostVariable variable) {
    return _Enable(
      variable,
    );
  }

  _Submit submit(BuildContext context) {
    return _Submit(
      context,
    );
  }

  _Suggestions suggestions(List<FacebookPlaceResult> suggestions) {
    return _Suggestions(
      suggestions,
    );
  }

  _Contest contest(Contest contest) {
    return _Contest(
      contest,
    );
  }

  _RemoveContest removeContest() {
    return const _RemoveContest();
  }

  _Mate mate(MealMate mate) {
    return _Mate(
      mate,
    );
  }

  _MatesFinished matesFinished(Set<MealMate> mate) {
    return _MatesFinished(
      mate,
    );
  }

  _TagUser taggedUsers(Set<MealMate> mate) {
    return _TagUser(
      mate,
    );
  }

  _Emojis emojis(Set<String> emojis) {
    return _Emojis(
      emojis,
    );
  }

  _Cuisines cuisines(Set<String> cuisines) {
    return _Cuisines(
      cuisines,
    );
  }

  _Attribute attribute(String attribute) {
    return _Attribute(
      attribute,
    );
  }

  _FBPlace fbPlace(FacebookPlaceResult fbPlace) {
    return _FBPlace(
      fbPlace,
    );
  }

  _BlackOwned blackOwned(Review_BlackOwnedStatus blackOwned) {
    return _BlackOwned(
      blackOwned,
    );
  }

  _BlackCharity blackCharity(BlackCharity blackCharity) {
    return _BlackCharity(
      blackCharity,
    );
  }

  _RemoveFbPlace removeFbPlace() {
    return const _RemoveFbPlace();
  }

  _BreakSeal breakSeal() {
    return const _BreakSeal();
  }

  _Reaction reaction(Reaction reaction) {
    return _Reaction(
      reaction,
    );
  }

  _DeliveryApp deliveryApp(Review_DeliveryApp app) {
    return _DeliveryApp(
      app,
    );
  }

  _RemoveDelivery removeDelivery() {
    return const _RemoveDelivery();
  }

  _AutoTags autoTags(Set<String> tags) {
    return _AutoTags(
      tags,
    );
  }
}

// ignore: unused_element
const $CreateReviewBlocEvent = _$CreateReviewBlocEventTearOff();

mixin _$CreateReviewBlocEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  });
}

abstract class $CreateReviewBlocEventCopyWith<$Res> {
  factory $CreateReviewBlocEventCopyWith(CreateReviewBlocEvent value,
          $Res Function(CreateReviewBlocEvent) then) =
      _$CreateReviewBlocEventCopyWithImpl<$Res>;
}

class _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements $CreateReviewBlocEventCopyWith<$Res> {
  _$CreateReviewBlocEventCopyWithImpl(this._value, this._then);

  final CreateReviewBlocEvent _value;
  // ignore: unused_field
  final $Res Function(CreateReviewBlocEvent) _then;
}

abstract class _$EnableCopyWith<$Res> {
  factory _$EnableCopyWith(_Enable value, $Res Function(_Enable) then) =
      __$EnableCopyWithImpl<$Res>;
  $Res call({PostVariable variable});
}

class __$EnableCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$EnableCopyWith<$Res> {
  __$EnableCopyWithImpl(_Enable _value, $Res Function(_Enable) _then)
      : super(_value, (v) => _then(v as _Enable));

  @override
  _Enable get _value => super._value as _Enable;

  @override
  $Res call({
    Object variable = freezed,
  }) {
    return _then(_Enable(
      variable == freezed ? _value.variable : variable as PostVariable,
    ));
  }
}

class _$_Enable with DiagnosticableTreeMixin implements _Enable {
  const _$_Enable(this.variable) : assert(variable != null);

  @override
  final PostVariable variable;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.toggleVariable(variable: $variable)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.toggleVariable'))
      ..add(DiagnosticsProperty('variable', variable));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Enable &&
            (identical(other.variable, variable) ||
                const DeepCollectionEquality()
                    .equals(other.variable, variable)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(variable);

  @override
  _$EnableCopyWith<_Enable> get copyWith =>
      __$EnableCopyWithImpl<_Enable>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return toggleVariable(variable);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (toggleVariable != null) {
      return toggleVariable(variable);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return toggleVariable(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (toggleVariable != null) {
      return toggleVariable(this);
    }
    return orElse();
  }
}

abstract class _Enable implements CreateReviewBlocEvent {
  const factory _Enable(PostVariable variable) = _$_Enable;

  PostVariable get variable;
  _$EnableCopyWith<_Enable> get copyWith;
}

abstract class _$SubmitCopyWith<$Res> {
  factory _$SubmitCopyWith(_Submit value, $Res Function(_Submit) then) =
      __$SubmitCopyWithImpl<$Res>;
  $Res call({BuildContext context});
}

class __$SubmitCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$SubmitCopyWith<$Res> {
  __$SubmitCopyWithImpl(_Submit _value, $Res Function(_Submit) _then)
      : super(_value, (v) => _then(v as _Submit));

  @override
  _Submit get _value => super._value as _Submit;

  @override
  $Res call({
    Object context = freezed,
  }) {
    return _then(_Submit(
      context == freezed ? _value.context : context as BuildContext,
    ));
  }
}

class _$_Submit with DiagnosticableTreeMixin implements _Submit {
  const _$_Submit(this.context) : assert(context != null);

  @override
  final BuildContext context;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.submit(context: $context)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.submit'))
      ..add(DiagnosticsProperty('context', context));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Submit &&
            (identical(other.context, context) ||
                const DeepCollectionEquality().equals(other.context, context)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(context);

  @override
  _$SubmitCopyWith<_Submit> get copyWith =>
      __$SubmitCopyWithImpl<_Submit>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return submit(context);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (submit != null) {
      return submit(context);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return submit(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (submit != null) {
      return submit(this);
    }
    return orElse();
  }
}

abstract class _Submit implements CreateReviewBlocEvent {
  const factory _Submit(BuildContext context) = _$_Submit;

  BuildContext get context;
  _$SubmitCopyWith<_Submit> get copyWith;
}

abstract class _$SuggestionsCopyWith<$Res> {
  factory _$SuggestionsCopyWith(
          _Suggestions value, $Res Function(_Suggestions) then) =
      __$SuggestionsCopyWithImpl<$Res>;
  $Res call({List<FacebookPlaceResult> suggestions});
}

class __$SuggestionsCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$SuggestionsCopyWith<$Res> {
  __$SuggestionsCopyWithImpl(
      _Suggestions _value, $Res Function(_Suggestions) _then)
      : super(_value, (v) => _then(v as _Suggestions));

  @override
  _Suggestions get _value => super._value as _Suggestions;

  @override
  $Res call({
    Object suggestions = freezed,
  }) {
    return _then(_Suggestions(
      suggestions == freezed
          ? _value.suggestions
          : suggestions as List<FacebookPlaceResult>,
    ));
  }
}

class _$_Suggestions with DiagnosticableTreeMixin implements _Suggestions {
  const _$_Suggestions(this.suggestions) : assert(suggestions != null);

  @override
  final List<FacebookPlaceResult> suggestions;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.suggestions(suggestions: $suggestions)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.suggestions'))
      ..add(DiagnosticsProperty('suggestions', suggestions));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Suggestions &&
            (identical(other.suggestions, suggestions) ||
                const DeepCollectionEquality()
                    .equals(other.suggestions, suggestions)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(suggestions);

  @override
  _$SuggestionsCopyWith<_Suggestions> get copyWith =>
      __$SuggestionsCopyWithImpl<_Suggestions>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return suggestions(this.suggestions);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (suggestions != null) {
      return suggestions(this.suggestions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return suggestions(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (suggestions != null) {
      return suggestions(this);
    }
    return orElse();
  }
}

abstract class _Suggestions implements CreateReviewBlocEvent {
  const factory _Suggestions(List<FacebookPlaceResult> suggestions) =
      _$_Suggestions;

  List<FacebookPlaceResult> get suggestions;
  _$SuggestionsCopyWith<_Suggestions> get copyWith;
}

abstract class _$ContestCopyWith<$Res> {
  factory _$ContestCopyWith(_Contest value, $Res Function(_Contest) then) =
      __$ContestCopyWithImpl<$Res>;
  $Res call({Contest contest});
}

class __$ContestCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$ContestCopyWith<$Res> {
  __$ContestCopyWithImpl(_Contest _value, $Res Function(_Contest) _then)
      : super(_value, (v) => _then(v as _Contest));

  @override
  _Contest get _value => super._value as _Contest;

  @override
  $Res call({
    Object contest = freezed,
  }) {
    return _then(_Contest(
      contest == freezed ? _value.contest : contest as Contest,
    ));
  }
}

class _$_Contest with DiagnosticableTreeMixin implements _Contest {
  const _$_Contest(this.contest) : assert(contest != null);

  @override
  final Contest contest;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.contest(contest: $contest)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.contest'))
      ..add(DiagnosticsProperty('contest', contest));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Contest &&
            (identical(other.contest, contest) ||
                const DeepCollectionEquality().equals(other.contest, contest)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(contest);

  @override
  _$ContestCopyWith<_Contest> get copyWith =>
      __$ContestCopyWithImpl<_Contest>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return contest(this.contest);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (contest != null) {
      return contest(this.contest);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return contest(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (contest != null) {
      return contest(this);
    }
    return orElse();
  }
}

abstract class _Contest implements CreateReviewBlocEvent {
  const factory _Contest(Contest contest) = _$_Contest;

  Contest get contest;
  _$ContestCopyWith<_Contest> get copyWith;
}

abstract class _$RemoveContestCopyWith<$Res> {
  factory _$RemoveContestCopyWith(
          _RemoveContest value, $Res Function(_RemoveContest) then) =
      __$RemoveContestCopyWithImpl<$Res>;
}

class __$RemoveContestCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$RemoveContestCopyWith<$Res> {
  __$RemoveContestCopyWithImpl(
      _RemoveContest _value, $Res Function(_RemoveContest) _then)
      : super(_value, (v) => _then(v as _RemoveContest));

  @override
  _RemoveContest get _value => super._value as _RemoveContest;
}

class _$_RemoveContest with DiagnosticableTreeMixin implements _RemoveContest {
  const _$_RemoveContest();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.removeContest()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.removeContest'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _RemoveContest);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return removeContest();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (removeContest != null) {
      return removeContest();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return removeContest(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (removeContest != null) {
      return removeContest(this);
    }
    return orElse();
  }
}

abstract class _RemoveContest implements CreateReviewBlocEvent {
  const factory _RemoveContest() = _$_RemoveContest;
}

abstract class _$MateCopyWith<$Res> {
  factory _$MateCopyWith(_Mate value, $Res Function(_Mate) then) =
      __$MateCopyWithImpl<$Res>;
  $Res call({MealMate mate});

  $MealMateCopyWith<$Res> get mate;
}

class __$MateCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$MateCopyWith<$Res> {
  __$MateCopyWithImpl(_Mate _value, $Res Function(_Mate) _then)
      : super(_value, (v) => _then(v as _Mate));

  @override
  _Mate get _value => super._value as _Mate;

  @override
  $Res call({
    Object mate = freezed,
  }) {
    return _then(_Mate(
      mate == freezed ? _value.mate : mate as MealMate,
    ));
  }

  @override
  $MealMateCopyWith<$Res> get mate {
    if (_value.mate == null) {
      return null;
    }
    return $MealMateCopyWith<$Res>(_value.mate, (value) {
      return _then(_value.copyWith(mate: value));
    });
  }
}

class _$_Mate with DiagnosticableTreeMixin implements _Mate {
  const _$_Mate(this.mate) : assert(mate != null);

  @override
  final MealMate mate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.mate(mate: $mate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.mate'))
      ..add(DiagnosticsProperty('mate', mate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Mate &&
            (identical(other.mate, mate) ||
                const DeepCollectionEquality().equals(other.mate, mate)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(mate);

  @override
  _$MateCopyWith<_Mate> get copyWith =>
      __$MateCopyWithImpl<_Mate>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return mate(this.mate);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (mate != null) {
      return mate(this.mate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return mate(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (mate != null) {
      return mate(this);
    }
    return orElse();
  }
}

abstract class _Mate implements CreateReviewBlocEvent {
  const factory _Mate(MealMate mate) = _$_Mate;

  MealMate get mate;
  _$MateCopyWith<_Mate> get copyWith;
}

abstract class _$MatesFinishedCopyWith<$Res> {
  factory _$MatesFinishedCopyWith(
          _MatesFinished value, $Res Function(_MatesFinished) then) =
      __$MatesFinishedCopyWithImpl<$Res>;
  $Res call({Set<MealMate> mate});
}

class __$MatesFinishedCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$MatesFinishedCopyWith<$Res> {
  __$MatesFinishedCopyWithImpl(
      _MatesFinished _value, $Res Function(_MatesFinished) _then)
      : super(_value, (v) => _then(v as _MatesFinished));

  @override
  _MatesFinished get _value => super._value as _MatesFinished;

  @override
  $Res call({
    Object mate = freezed,
  }) {
    return _then(_MatesFinished(
      mate == freezed ? _value.mate : mate as Set<MealMate>,
    ));
  }
}

class _$_MatesFinished with DiagnosticableTreeMixin implements _MatesFinished {
  const _$_MatesFinished(this.mate) : assert(mate != null);

  @override
  final Set<MealMate> mate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.matesFinished(mate: $mate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.matesFinished'))
      ..add(DiagnosticsProperty('mate', mate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MatesFinished &&
            (identical(other.mate, mate) ||
                const DeepCollectionEquality().equals(other.mate, mate)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(mate);

  @override
  _$MatesFinishedCopyWith<_MatesFinished> get copyWith =>
      __$MatesFinishedCopyWithImpl<_MatesFinished>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return matesFinished(this.mate);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (matesFinished != null) {
      return matesFinished(this.mate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return matesFinished(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (matesFinished != null) {
      return matesFinished(this);
    }
    return orElse();
  }
}

abstract class _MatesFinished implements CreateReviewBlocEvent {
  const factory _MatesFinished(Set<MealMate> mate) = _$_MatesFinished;

  Set<MealMate> get mate;
  _$MatesFinishedCopyWith<_MatesFinished> get copyWith;
}

abstract class _$TagUserCopyWith<$Res> {
  factory _$TagUserCopyWith(_TagUser value, $Res Function(_TagUser) then) =
      __$TagUserCopyWithImpl<$Res>;
  $Res call({Set<MealMate> mate});
}

class __$TagUserCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$TagUserCopyWith<$Res> {
  __$TagUserCopyWithImpl(_TagUser _value, $Res Function(_TagUser) _then)
      : super(_value, (v) => _then(v as _TagUser));

  @override
  _TagUser get _value => super._value as _TagUser;

  @override
  $Res call({
    Object mate = freezed,
  }) {
    return _then(_TagUser(
      mate == freezed ? _value.mate : mate as Set<MealMate>,
    ));
  }
}

class _$_TagUser with DiagnosticableTreeMixin implements _TagUser {
  const _$_TagUser(this.mate) : assert(mate != null);

  @override
  final Set<MealMate> mate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.taggedUsers(mate: $mate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.taggedUsers'))
      ..add(DiagnosticsProperty('mate', mate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TagUser &&
            (identical(other.mate, mate) ||
                const DeepCollectionEquality().equals(other.mate, mate)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(mate);

  @override
  _$TagUserCopyWith<_TagUser> get copyWith =>
      __$TagUserCopyWithImpl<_TagUser>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return taggedUsers(this.mate);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (taggedUsers != null) {
      return taggedUsers(this.mate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return taggedUsers(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (taggedUsers != null) {
      return taggedUsers(this);
    }
    return orElse();
  }
}

abstract class _TagUser implements CreateReviewBlocEvent {
  const factory _TagUser(Set<MealMate> mate) = _$_TagUser;

  Set<MealMate> get mate;
  _$TagUserCopyWith<_TagUser> get copyWith;
}

abstract class _$EmojisCopyWith<$Res> {
  factory _$EmojisCopyWith(_Emojis value, $Res Function(_Emojis) then) =
      __$EmojisCopyWithImpl<$Res>;
  $Res call({Set<String> emojis});
}

class __$EmojisCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$EmojisCopyWith<$Res> {
  __$EmojisCopyWithImpl(_Emojis _value, $Res Function(_Emojis) _then)
      : super(_value, (v) => _then(v as _Emojis));

  @override
  _Emojis get _value => super._value as _Emojis;

  @override
  $Res call({
    Object emojis = freezed,
  }) {
    return _then(_Emojis(
      emojis == freezed ? _value.emojis : emojis as Set<String>,
    ));
  }
}

class _$_Emojis with DiagnosticableTreeMixin implements _Emojis {
  const _$_Emojis(this.emojis) : assert(emojis != null);

  @override
  final Set<String> emojis;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.emojis(emojis: $emojis)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.emojis'))
      ..add(DiagnosticsProperty('emojis', emojis));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Emojis &&
            (identical(other.emojis, emojis) ||
                const DeepCollectionEquality().equals(other.emojis, emojis)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(emojis);

  @override
  _$EmojisCopyWith<_Emojis> get copyWith =>
      __$EmojisCopyWithImpl<_Emojis>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return emojis(this.emojis);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (emojis != null) {
      return emojis(this.emojis);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return emojis(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (emojis != null) {
      return emojis(this);
    }
    return orElse();
  }
}

abstract class _Emojis implements CreateReviewBlocEvent {
  const factory _Emojis(Set<String> emojis) = _$_Emojis;

  Set<String> get emojis;
  _$EmojisCopyWith<_Emojis> get copyWith;
}

abstract class _$CuisinesCopyWith<$Res> {
  factory _$CuisinesCopyWith(_Cuisines value, $Res Function(_Cuisines) then) =
      __$CuisinesCopyWithImpl<$Res>;
  $Res call({Set<String> cuisines});
}

class __$CuisinesCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$CuisinesCopyWith<$Res> {
  __$CuisinesCopyWithImpl(_Cuisines _value, $Res Function(_Cuisines) _then)
      : super(_value, (v) => _then(v as _Cuisines));

  @override
  _Cuisines get _value => super._value as _Cuisines;

  @override
  $Res call({
    Object cuisines = freezed,
  }) {
    return _then(_Cuisines(
      cuisines == freezed ? _value.cuisines : cuisines as Set<String>,
    ));
  }
}

class _$_Cuisines with DiagnosticableTreeMixin implements _Cuisines {
  const _$_Cuisines(this.cuisines) : assert(cuisines != null);

  @override
  final Set<String> cuisines;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.cuisines(cuisines: $cuisines)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.cuisines'))
      ..add(DiagnosticsProperty('cuisines', cuisines));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Cuisines &&
            (identical(other.cuisines, cuisines) ||
                const DeepCollectionEquality()
                    .equals(other.cuisines, cuisines)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(cuisines);

  @override
  _$CuisinesCopyWith<_Cuisines> get copyWith =>
      __$CuisinesCopyWithImpl<_Cuisines>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return cuisines(this.cuisines);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (cuisines != null) {
      return cuisines(this.cuisines);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return cuisines(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (cuisines != null) {
      return cuisines(this);
    }
    return orElse();
  }
}

abstract class _Cuisines implements CreateReviewBlocEvent {
  const factory _Cuisines(Set<String> cuisines) = _$_Cuisines;

  Set<String> get cuisines;
  _$CuisinesCopyWith<_Cuisines> get copyWith;
}

abstract class _$AttributeCopyWith<$Res> {
  factory _$AttributeCopyWith(
          _Attribute value, $Res Function(_Attribute) then) =
      __$AttributeCopyWithImpl<$Res>;
  $Res call({String attribute});
}

class __$AttributeCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$AttributeCopyWith<$Res> {
  __$AttributeCopyWithImpl(_Attribute _value, $Res Function(_Attribute) _then)
      : super(_value, (v) => _then(v as _Attribute));

  @override
  _Attribute get _value => super._value as _Attribute;

  @override
  $Res call({
    Object attribute = freezed,
  }) {
    return _then(_Attribute(
      attribute == freezed ? _value.attribute : attribute as String,
    ));
  }
}

class _$_Attribute with DiagnosticableTreeMixin implements _Attribute {
  const _$_Attribute(this.attribute) : assert(attribute != null);

  @override
  final String attribute;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.attribute(attribute: $attribute)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.attribute'))
      ..add(DiagnosticsProperty('attribute', attribute));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Attribute &&
            (identical(other.attribute, attribute) ||
                const DeepCollectionEquality()
                    .equals(other.attribute, attribute)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(attribute);

  @override
  _$AttributeCopyWith<_Attribute> get copyWith =>
      __$AttributeCopyWithImpl<_Attribute>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return attribute(this.attribute);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (attribute != null) {
      return attribute(this.attribute);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return attribute(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (attribute != null) {
      return attribute(this);
    }
    return orElse();
  }
}

abstract class _Attribute implements CreateReviewBlocEvent {
  const factory _Attribute(String attribute) = _$_Attribute;

  String get attribute;
  _$AttributeCopyWith<_Attribute> get copyWith;
}

abstract class _$FBPlaceCopyWith<$Res> {
  factory _$FBPlaceCopyWith(_FBPlace value, $Res Function(_FBPlace) then) =
      __$FBPlaceCopyWithImpl<$Res>;
  $Res call({FacebookPlaceResult fbPlace});
}

class __$FBPlaceCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$FBPlaceCopyWith<$Res> {
  __$FBPlaceCopyWithImpl(_FBPlace _value, $Res Function(_FBPlace) _then)
      : super(_value, (v) => _then(v as _FBPlace));

  @override
  _FBPlace get _value => super._value as _FBPlace;

  @override
  $Res call({
    Object fbPlace = freezed,
  }) {
    return _then(_FBPlace(
      fbPlace == freezed ? _value.fbPlace : fbPlace as FacebookPlaceResult,
    ));
  }
}

class _$_FBPlace with DiagnosticableTreeMixin implements _FBPlace {
  const _$_FBPlace(this.fbPlace) : assert(fbPlace != null);

  @override
  final FacebookPlaceResult fbPlace;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.fbPlace(fbPlace: $fbPlace)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.fbPlace'))
      ..add(DiagnosticsProperty('fbPlace', fbPlace));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FBPlace &&
            (identical(other.fbPlace, fbPlace) ||
                const DeepCollectionEquality().equals(other.fbPlace, fbPlace)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(fbPlace);

  @override
  _$FBPlaceCopyWith<_FBPlace> get copyWith =>
      __$FBPlaceCopyWithImpl<_FBPlace>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return fbPlace(this.fbPlace);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fbPlace != null) {
      return fbPlace(this.fbPlace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return fbPlace(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fbPlace != null) {
      return fbPlace(this);
    }
    return orElse();
  }
}

abstract class _FBPlace implements CreateReviewBlocEvent {
  const factory _FBPlace(FacebookPlaceResult fbPlace) = _$_FBPlace;

  FacebookPlaceResult get fbPlace;
  _$FBPlaceCopyWith<_FBPlace> get copyWith;
}

abstract class _$BlackOwnedCopyWith<$Res> {
  factory _$BlackOwnedCopyWith(
          _BlackOwned value, $Res Function(_BlackOwned) then) =
      __$BlackOwnedCopyWithImpl<$Res>;
  $Res call({Review_BlackOwnedStatus blackOwned});
}

class __$BlackOwnedCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$BlackOwnedCopyWith<$Res> {
  __$BlackOwnedCopyWithImpl(
      _BlackOwned _value, $Res Function(_BlackOwned) _then)
      : super(_value, (v) => _then(v as _BlackOwned));

  @override
  _BlackOwned get _value => super._value as _BlackOwned;

  @override
  $Res call({
    Object blackOwned = freezed,
  }) {
    return _then(_BlackOwned(
      blackOwned == freezed
          ? _value.blackOwned
          : blackOwned as Review_BlackOwnedStatus,
    ));
  }
}

class _$_BlackOwned with DiagnosticableTreeMixin implements _BlackOwned {
  const _$_BlackOwned(this.blackOwned) : assert(blackOwned != null);

  @override
  final Review_BlackOwnedStatus blackOwned;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.blackOwned(blackOwned: $blackOwned)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.blackOwned'))
      ..add(DiagnosticsProperty('blackOwned', blackOwned));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BlackOwned &&
            (identical(other.blackOwned, blackOwned) ||
                const DeepCollectionEquality()
                    .equals(other.blackOwned, blackOwned)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(blackOwned);

  @override
  _$BlackOwnedCopyWith<_BlackOwned> get copyWith =>
      __$BlackOwnedCopyWithImpl<_BlackOwned>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return blackOwned(this.blackOwned);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (blackOwned != null) {
      return blackOwned(this.blackOwned);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return blackOwned(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (blackOwned != null) {
      return blackOwned(this);
    }
    return orElse();
  }
}

abstract class _BlackOwned implements CreateReviewBlocEvent {
  const factory _BlackOwned(Review_BlackOwnedStatus blackOwned) = _$_BlackOwned;

  Review_BlackOwnedStatus get blackOwned;
  _$BlackOwnedCopyWith<_BlackOwned> get copyWith;
}

abstract class _$BlackCharityCopyWith<$Res> {
  factory _$BlackCharityCopyWith(
          _BlackCharity value, $Res Function(_BlackCharity) then) =
      __$BlackCharityCopyWithImpl<$Res>;
  $Res call({BlackCharity blackCharity});
}

class __$BlackCharityCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$BlackCharityCopyWith<$Res> {
  __$BlackCharityCopyWithImpl(
      _BlackCharity _value, $Res Function(_BlackCharity) _then)
      : super(_value, (v) => _then(v as _BlackCharity));

  @override
  _BlackCharity get _value => super._value as _BlackCharity;

  @override
  $Res call({
    Object blackCharity = freezed,
  }) {
    return _then(_BlackCharity(
      blackCharity == freezed
          ? _value.blackCharity
          : blackCharity as BlackCharity,
    ));
  }
}

class _$_BlackCharity with DiagnosticableTreeMixin implements _BlackCharity {
  const _$_BlackCharity(this.blackCharity) : assert(blackCharity != null);

  @override
  final BlackCharity blackCharity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.blackCharity(blackCharity: $blackCharity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.blackCharity'))
      ..add(DiagnosticsProperty('blackCharity', blackCharity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BlackCharity &&
            (identical(other.blackCharity, blackCharity) ||
                const DeepCollectionEquality()
                    .equals(other.blackCharity, blackCharity)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(blackCharity);

  @override
  _$BlackCharityCopyWith<_BlackCharity> get copyWith =>
      __$BlackCharityCopyWithImpl<_BlackCharity>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return blackCharity(this.blackCharity);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (blackCharity != null) {
      return blackCharity(this.blackCharity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return blackCharity(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (blackCharity != null) {
      return blackCharity(this);
    }
    return orElse();
  }
}

abstract class _BlackCharity implements CreateReviewBlocEvent {
  const factory _BlackCharity(BlackCharity blackCharity) = _$_BlackCharity;

  BlackCharity get blackCharity;
  _$BlackCharityCopyWith<_BlackCharity> get copyWith;
}

abstract class _$RemoveFbPlaceCopyWith<$Res> {
  factory _$RemoveFbPlaceCopyWith(
          _RemoveFbPlace value, $Res Function(_RemoveFbPlace) then) =
      __$RemoveFbPlaceCopyWithImpl<$Res>;
}

class __$RemoveFbPlaceCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$RemoveFbPlaceCopyWith<$Res> {
  __$RemoveFbPlaceCopyWithImpl(
      _RemoveFbPlace _value, $Res Function(_RemoveFbPlace) _then)
      : super(_value, (v) => _then(v as _RemoveFbPlace));

  @override
  _RemoveFbPlace get _value => super._value as _RemoveFbPlace;
}

class _$_RemoveFbPlace with DiagnosticableTreeMixin implements _RemoveFbPlace {
  const _$_RemoveFbPlace();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.removeFbPlace()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.removeFbPlace'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _RemoveFbPlace);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return removeFbPlace();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (removeFbPlace != null) {
      return removeFbPlace();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return removeFbPlace(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (removeFbPlace != null) {
      return removeFbPlace(this);
    }
    return orElse();
  }
}

abstract class _RemoveFbPlace implements CreateReviewBlocEvent {
  const factory _RemoveFbPlace() = _$_RemoveFbPlace;
}

abstract class _$BreakSealCopyWith<$Res> {
  factory _$BreakSealCopyWith(
          _BreakSeal value, $Res Function(_BreakSeal) then) =
      __$BreakSealCopyWithImpl<$Res>;
}

class __$BreakSealCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$BreakSealCopyWith<$Res> {
  __$BreakSealCopyWithImpl(_BreakSeal _value, $Res Function(_BreakSeal) _then)
      : super(_value, (v) => _then(v as _BreakSeal));

  @override
  _BreakSeal get _value => super._value as _BreakSeal;
}

class _$_BreakSeal with DiagnosticableTreeMixin implements _BreakSeal {
  const _$_BreakSeal();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.breakSeal()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.breakSeal'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _BreakSeal);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return breakSeal();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (breakSeal != null) {
      return breakSeal();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return breakSeal(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (breakSeal != null) {
      return breakSeal(this);
    }
    return orElse();
  }
}

abstract class _BreakSeal implements CreateReviewBlocEvent {
  const factory _BreakSeal() = _$_BreakSeal;
}

abstract class _$ReactionCopyWith<$Res> {
  factory _$ReactionCopyWith(_Reaction value, $Res Function(_Reaction) then) =
      __$ReactionCopyWithImpl<$Res>;
  $Res call({Reaction reaction});
}

class __$ReactionCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$ReactionCopyWith<$Res> {
  __$ReactionCopyWithImpl(_Reaction _value, $Res Function(_Reaction) _then)
      : super(_value, (v) => _then(v as _Reaction));

  @override
  _Reaction get _value => super._value as _Reaction;

  @override
  $Res call({
    Object reaction = freezed,
  }) {
    return _then(_Reaction(
      reaction == freezed ? _value.reaction : reaction as Reaction,
    ));
  }
}

class _$_Reaction with DiagnosticableTreeMixin implements _Reaction {
  const _$_Reaction(this.reaction) : assert(reaction != null);

  @override
  final Reaction reaction;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.reaction(reaction: $reaction)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.reaction'))
      ..add(DiagnosticsProperty('reaction', reaction));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Reaction &&
            (identical(other.reaction, reaction) ||
                const DeepCollectionEquality()
                    .equals(other.reaction, reaction)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(reaction);

  @override
  _$ReactionCopyWith<_Reaction> get copyWith =>
      __$ReactionCopyWithImpl<_Reaction>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return reaction(this.reaction);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (reaction != null) {
      return reaction(this.reaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return reaction(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (reaction != null) {
      return reaction(this);
    }
    return orElse();
  }
}

abstract class _Reaction implements CreateReviewBlocEvent {
  const factory _Reaction(Reaction reaction) = _$_Reaction;

  Reaction get reaction;
  _$ReactionCopyWith<_Reaction> get copyWith;
}

abstract class _$DeliveryAppCopyWith<$Res> {
  factory _$DeliveryAppCopyWith(
          _DeliveryApp value, $Res Function(_DeliveryApp) then) =
      __$DeliveryAppCopyWithImpl<$Res>;
  $Res call({Review_DeliveryApp app});
}

class __$DeliveryAppCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$DeliveryAppCopyWith<$Res> {
  __$DeliveryAppCopyWithImpl(
      _DeliveryApp _value, $Res Function(_DeliveryApp) _then)
      : super(_value, (v) => _then(v as _DeliveryApp));

  @override
  _DeliveryApp get _value => super._value as _DeliveryApp;

  @override
  $Res call({
    Object app = freezed,
  }) {
    return _then(_DeliveryApp(
      app == freezed ? _value.app : app as Review_DeliveryApp,
    ));
  }
}

class _$_DeliveryApp with DiagnosticableTreeMixin implements _DeliveryApp {
  const _$_DeliveryApp(this.app) : assert(app != null);

  @override
  final Review_DeliveryApp app;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.deliveryApp(app: $app)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.deliveryApp'))
      ..add(DiagnosticsProperty('app', app));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DeliveryApp &&
            (identical(other.app, app) ||
                const DeepCollectionEquality().equals(other.app, app)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(app);

  @override
  _$DeliveryAppCopyWith<_DeliveryApp> get copyWith =>
      __$DeliveryAppCopyWithImpl<_DeliveryApp>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return deliveryApp(app);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (deliveryApp != null) {
      return deliveryApp(app);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return deliveryApp(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (deliveryApp != null) {
      return deliveryApp(this);
    }
    return orElse();
  }
}

abstract class _DeliveryApp implements CreateReviewBlocEvent {
  const factory _DeliveryApp(Review_DeliveryApp app) = _$_DeliveryApp;

  Review_DeliveryApp get app;
  _$DeliveryAppCopyWith<_DeliveryApp> get copyWith;
}

abstract class _$RemoveDeliveryCopyWith<$Res> {
  factory _$RemoveDeliveryCopyWith(
          _RemoveDelivery value, $Res Function(_RemoveDelivery) then) =
      __$RemoveDeliveryCopyWithImpl<$Res>;
}

class __$RemoveDeliveryCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$RemoveDeliveryCopyWith<$Res> {
  __$RemoveDeliveryCopyWithImpl(
      _RemoveDelivery _value, $Res Function(_RemoveDelivery) _then)
      : super(_value, (v) => _then(v as _RemoveDelivery));

  @override
  _RemoveDelivery get _value => super._value as _RemoveDelivery;
}

class _$_RemoveDelivery
    with DiagnosticableTreeMixin
    implements _RemoveDelivery {
  const _$_RemoveDelivery();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.removeDelivery()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'CreateReviewBlocEvent.removeDelivery'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _RemoveDelivery);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return removeDelivery();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (removeDelivery != null) {
      return removeDelivery();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return removeDelivery(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (removeDelivery != null) {
      return removeDelivery(this);
    }
    return orElse();
  }
}

abstract class _RemoveDelivery implements CreateReviewBlocEvent {
  const factory _RemoveDelivery() = _$_RemoveDelivery;
}

abstract class _$AutoTagsCopyWith<$Res> {
  factory _$AutoTagsCopyWith(_AutoTags value, $Res Function(_AutoTags) then) =
      __$AutoTagsCopyWithImpl<$Res>;
  $Res call({Set<String> tags});
}

class __$AutoTagsCopyWithImpl<$Res>
    extends _$CreateReviewBlocEventCopyWithImpl<$Res>
    implements _$AutoTagsCopyWith<$Res> {
  __$AutoTagsCopyWithImpl(_AutoTags _value, $Res Function(_AutoTags) _then)
      : super(_value, (v) => _then(v as _AutoTags));

  @override
  _AutoTags get _value => super._value as _AutoTags;

  @override
  $Res call({
    Object tags = freezed,
  }) {
    return _then(_AutoTags(
      tags == freezed ? _value.tags : tags as Set<String>,
    ));
  }
}

class _$_AutoTags with DiagnosticableTreeMixin implements _AutoTags {
  const _$_AutoTags(this.tags) : assert(tags != null);

  @override
  final Set<String> tags;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateReviewBlocEvent.autoTags(tags: $tags)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateReviewBlocEvent.autoTags'))
      ..add(DiagnosticsProperty('tags', tags));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AutoTags &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(tags);

  @override
  _$AutoTagsCopyWith<_AutoTags> get copyWith =>
      __$AutoTagsCopyWithImpl<_AutoTags>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result toggleVariable(PostVariable variable),
    @required Result submit(BuildContext context),
    @required Result suggestions(List<FacebookPlaceResult> suggestions),
    @required Result contest(Contest contest),
    @required Result removeContest(),
    @required Result mate(MealMate mate),
    @required Result matesFinished(Set<MealMate> mate),
    @required Result taggedUsers(Set<MealMate> mate),
    @required Result emojis(Set<String> emojis),
    @required Result cuisines(Set<String> cuisines),
    @required Result attribute(String attribute),
    @required Result fbPlace(FacebookPlaceResult fbPlace),
    @required Result blackOwned(Review_BlackOwnedStatus blackOwned),
    @required Result blackCharity(BlackCharity blackCharity),
    @required Result removeFbPlace(),
    @required Result breakSeal(),
    @required Result reaction(Reaction reaction),
    @required Result deliveryApp(Review_DeliveryApp app),
    @required Result removeDelivery(),
    @required Result autoTags(Set<String> tags),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return autoTags(tags);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result toggleVariable(PostVariable variable),
    Result submit(BuildContext context),
    Result suggestions(List<FacebookPlaceResult> suggestions),
    Result contest(Contest contest),
    Result removeContest(),
    Result mate(MealMate mate),
    Result matesFinished(Set<MealMate> mate),
    Result taggedUsers(Set<MealMate> mate),
    Result emojis(Set<String> emojis),
    Result cuisines(Set<String> cuisines),
    Result attribute(String attribute),
    Result fbPlace(FacebookPlaceResult fbPlace),
    Result blackOwned(Review_BlackOwnedStatus blackOwned),
    Result blackCharity(BlackCharity blackCharity),
    Result removeFbPlace(),
    Result breakSeal(),
    Result reaction(Reaction reaction),
    Result deliveryApp(Review_DeliveryApp app),
    Result removeDelivery(),
    Result autoTags(Set<String> tags),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (autoTags != null) {
      return autoTags(tags);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result toggleVariable(_Enable value),
    @required Result submit(_Submit value),
    @required Result suggestions(_Suggestions value),
    @required Result contest(_Contest value),
    @required Result removeContest(_RemoveContest value),
    @required Result mate(_Mate value),
    @required Result matesFinished(_MatesFinished value),
    @required Result taggedUsers(_TagUser value),
    @required Result emojis(_Emojis value),
    @required Result cuisines(_Cuisines value),
    @required Result attribute(_Attribute value),
    @required Result fbPlace(_FBPlace value),
    @required Result blackOwned(_BlackOwned value),
    @required Result blackCharity(_BlackCharity value),
    @required Result removeFbPlace(_RemoveFbPlace value),
    @required Result breakSeal(_BreakSeal value),
    @required Result reaction(_Reaction value),
    @required Result deliveryApp(_DeliveryApp value),
    @required Result removeDelivery(_RemoveDelivery value),
    @required Result autoTags(_AutoTags value),
  }) {
    assert(toggleVariable != null);
    assert(submit != null);
    assert(suggestions != null);
    assert(contest != null);
    assert(removeContest != null);
    assert(mate != null);
    assert(matesFinished != null);
    assert(taggedUsers != null);
    assert(emojis != null);
    assert(cuisines != null);
    assert(attribute != null);
    assert(fbPlace != null);
    assert(blackOwned != null);
    assert(blackCharity != null);
    assert(removeFbPlace != null);
    assert(breakSeal != null);
    assert(reaction != null);
    assert(deliveryApp != null);
    assert(removeDelivery != null);
    assert(autoTags != null);
    return autoTags(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result toggleVariable(_Enable value),
    Result submit(_Submit value),
    Result suggestions(_Suggestions value),
    Result contest(_Contest value),
    Result removeContest(_RemoveContest value),
    Result mate(_Mate value),
    Result matesFinished(_MatesFinished value),
    Result taggedUsers(_TagUser value),
    Result emojis(_Emojis value),
    Result cuisines(_Cuisines value),
    Result attribute(_Attribute value),
    Result fbPlace(_FBPlace value),
    Result blackOwned(_BlackOwned value),
    Result blackCharity(_BlackCharity value),
    Result removeFbPlace(_RemoveFbPlace value),
    Result breakSeal(_BreakSeal value),
    Result reaction(_Reaction value),
    Result deliveryApp(_DeliveryApp value),
    Result removeDelivery(_RemoveDelivery value),
    Result autoTags(_AutoTags value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (autoTags != null) {
      return autoTags(this);
    }
    return orElse();
  }
}

abstract class _AutoTags implements CreateReviewBlocEvent {
  const factory _AutoTags(Set<String> tags) = _$_AutoTags;

  Set<String> get tags;
  _$AutoTagsCopyWith<_AutoTags> get copyWith;
}
