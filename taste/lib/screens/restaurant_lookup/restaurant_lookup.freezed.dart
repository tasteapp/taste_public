// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'restaurant_lookup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$RestaurantChoiceTearOff {
  const _$RestaurantChoiceTearOff();

  _HomeCooked homeCooked() {
    return const _HomeCooked();
  }

  _Empty empty() {
    return const _Empty();
  }

  _Place place(FacebookPlaceResult fbPlace) {
    return _Place(
      fbPlace,
    );
  }
}

// ignore: unused_element
const $RestaurantChoice = _$RestaurantChoiceTearOff();

mixin _$RestaurantChoice {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result homeCooked(),
    @required Result empty(),
    @required Result place(FacebookPlaceResult fbPlace),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result homeCooked(),
    Result empty(),
    Result place(FacebookPlaceResult fbPlace),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result homeCooked(_HomeCooked value),
    @required Result empty(_Empty value),
    @required Result place(_Place value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result homeCooked(_HomeCooked value),
    Result empty(_Empty value),
    Result place(_Place value),
    @required Result orElse(),
  });
}

abstract class $RestaurantChoiceCopyWith<$Res> {
  factory $RestaurantChoiceCopyWith(
          RestaurantChoice value, $Res Function(RestaurantChoice) then) =
      _$RestaurantChoiceCopyWithImpl<$Res>;
}

class _$RestaurantChoiceCopyWithImpl<$Res>
    implements $RestaurantChoiceCopyWith<$Res> {
  _$RestaurantChoiceCopyWithImpl(this._value, this._then);

  final RestaurantChoice _value;
  // ignore: unused_field
  final $Res Function(RestaurantChoice) _then;
}

abstract class _$HomeCookedCopyWith<$Res> {
  factory _$HomeCookedCopyWith(
          _HomeCooked value, $Res Function(_HomeCooked) then) =
      __$HomeCookedCopyWithImpl<$Res>;
}

class __$HomeCookedCopyWithImpl<$Res>
    extends _$RestaurantChoiceCopyWithImpl<$Res>
    implements _$HomeCookedCopyWith<$Res> {
  __$HomeCookedCopyWithImpl(
      _HomeCooked _value, $Res Function(_HomeCooked) _then)
      : super(_value, (v) => _then(v as _HomeCooked));

  @override
  _HomeCooked get _value => super._value as _HomeCooked;
}

class _$_HomeCooked with DiagnosticableTreeMixin implements _HomeCooked {
  const _$_HomeCooked();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RestaurantChoice.homeCooked()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'RestaurantChoice.homeCooked'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _HomeCooked);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result homeCooked(),
    @required Result empty(),
    @required Result place(FacebookPlaceResult fbPlace),
  }) {
    assert(homeCooked != null);
    assert(empty != null);
    assert(place != null);
    return homeCooked();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result homeCooked(),
    Result empty(),
    Result place(FacebookPlaceResult fbPlace),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (homeCooked != null) {
      return homeCooked();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result homeCooked(_HomeCooked value),
    @required Result empty(_Empty value),
    @required Result place(_Place value),
  }) {
    assert(homeCooked != null);
    assert(empty != null);
    assert(place != null);
    return homeCooked(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result homeCooked(_HomeCooked value),
    Result empty(_Empty value),
    Result place(_Place value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (homeCooked != null) {
      return homeCooked(this);
    }
    return orElse();
  }
}

abstract class _HomeCooked implements RestaurantChoice {
  const factory _HomeCooked() = _$_HomeCooked;
}

abstract class _$EmptyCopyWith<$Res> {
  factory _$EmptyCopyWith(_Empty value, $Res Function(_Empty) then) =
      __$EmptyCopyWithImpl<$Res>;
}

class __$EmptyCopyWithImpl<$Res> extends _$RestaurantChoiceCopyWithImpl<$Res>
    implements _$EmptyCopyWith<$Res> {
  __$EmptyCopyWithImpl(_Empty _value, $Res Function(_Empty) _then)
      : super(_value, (v) => _then(v as _Empty));

  @override
  _Empty get _value => super._value as _Empty;
}

class _$_Empty with DiagnosticableTreeMixin implements _Empty {
  const _$_Empty();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RestaurantChoice.empty()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'RestaurantChoice.empty'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Empty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result homeCooked(),
    @required Result empty(),
    @required Result place(FacebookPlaceResult fbPlace),
  }) {
    assert(homeCooked != null);
    assert(empty != null);
    assert(place != null);
    return empty();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result homeCooked(),
    Result empty(),
    Result place(FacebookPlaceResult fbPlace),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result homeCooked(_HomeCooked value),
    @required Result empty(_Empty value),
    @required Result place(_Place value),
  }) {
    assert(homeCooked != null);
    assert(empty != null);
    assert(place != null);
    return empty(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result homeCooked(_HomeCooked value),
    Result empty(_Empty value),
    Result place(_Place value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class _Empty implements RestaurantChoice {
  const factory _Empty() = _$_Empty;
}

abstract class _$PlaceCopyWith<$Res> {
  factory _$PlaceCopyWith(_Place value, $Res Function(_Place) then) =
      __$PlaceCopyWithImpl<$Res>;
  $Res call({FacebookPlaceResult fbPlace});
}

class __$PlaceCopyWithImpl<$Res> extends _$RestaurantChoiceCopyWithImpl<$Res>
    implements _$PlaceCopyWith<$Res> {
  __$PlaceCopyWithImpl(_Place _value, $Res Function(_Place) _then)
      : super(_value, (v) => _then(v as _Place));

  @override
  _Place get _value => super._value as _Place;

  @override
  $Res call({
    Object fbPlace = freezed,
  }) {
    return _then(_Place(
      fbPlace == freezed ? _value.fbPlace : fbPlace as FacebookPlaceResult,
    ));
  }
}

class _$_Place with DiagnosticableTreeMixin implements _Place {
  const _$_Place(this.fbPlace) : assert(fbPlace != null);

  @override
  final FacebookPlaceResult fbPlace;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RestaurantChoice.place(fbPlace: $fbPlace)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RestaurantChoice.place'))
      ..add(DiagnosticsProperty('fbPlace', fbPlace));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Place &&
            (identical(other.fbPlace, fbPlace) ||
                const DeepCollectionEquality().equals(other.fbPlace, fbPlace)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(fbPlace);

  @override
  _$PlaceCopyWith<_Place> get copyWith =>
      __$PlaceCopyWithImpl<_Place>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result homeCooked(),
    @required Result empty(),
    @required Result place(FacebookPlaceResult fbPlace),
  }) {
    assert(homeCooked != null);
    assert(empty != null);
    assert(place != null);
    return place(fbPlace);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result homeCooked(),
    Result empty(),
    Result place(FacebookPlaceResult fbPlace),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (place != null) {
      return place(fbPlace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result homeCooked(_HomeCooked value),
    @required Result empty(_Empty value),
    @required Result place(_Place value),
  }) {
    assert(homeCooked != null);
    assert(empty != null);
    assert(place != null);
    return place(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result homeCooked(_HomeCooked value),
    Result empty(_Empty value),
    Result place(_Place value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (place != null) {
      return place(this);
    }
    return orElse();
  }
}

abstract class _Place implements RestaurantChoice {
  const factory _Place(FacebookPlaceResult fbPlace) = _$_Place;

  FacebookPlaceResult get fbPlace;
  _$PlaceCopyWith<_Place> get copyWith;
}
