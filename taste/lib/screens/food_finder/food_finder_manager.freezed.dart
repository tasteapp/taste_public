// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'food_finder_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$FoodFinderEventTearOff {
  const _$FoodFinderEventTearOff();

  _SetQueryResults setQueryResults(RestoQueryResults results) {
    return _SetQueryResults(
      results,
    );
  }

  _SetCurrentRestos setCurrentRestos(List<AlgoliaRestaurant> restos) {
    return _SetCurrentRestos(
      restos,
    );
  }

  _SetCurrentIndex setCurrentIndex(int newIndex) {
    return _SetCurrentIndex(
      newIndex,
    );
  }

  _SetMaybeList setMaybeList(List<AlgoliaRestaurant> newMaybeList) {
    return _SetMaybeList(
      newMaybeList,
    );
  }

  _AddToMaybeList addToMaybeList(List<CoverPhoto> coverPhotos) {
    return _AddToMaybeList(
      coverPhotos,
    );
  }

  _RemoveFromMaybeList removeFromMaybeList(AlgoliaRestaurant resto) {
    return _RemoveFromMaybeList(
      resto,
    );
  }

  _ClearMaybeList clearMaybeList() {
    return const _ClearMaybeList();
  }

  _SetNoList setNoList(Set<AlgoliaRestaurant> newNoList) {
    return _SetNoList(
      newNoList,
    );
  }

  _AddToNoList addToNoList(List<CoverPhoto> coverPhotos) {
    return _AddToNoList(
      coverPhotos,
    );
  }

  _SetLocation setLocation(LocationInfo location) {
    return _SetLocation(
      location,
    );
  }

  _SetFilters setFilters(FoodFilters newFilters) {
    return _SetFilters(
      newFilters,
    );
  }

  _SetIsLoading setIsLoading(bool isLoading) {
    return _SetIsLoading(
      isLoading,
    );
  }

  _SetActiveDiscoverItem setActiveDiscoverItem(
      DocumentReference restoReference, int newActiveDiscoverItem) {
    return _SetActiveDiscoverItem(
      restoReference,
      newActiveDiscoverItem,
    );
  }

  _ToggleShowMap toggleShowMap() {
    return const _ToggleShowMap();
  }
}

// ignore: unused_element
const $FoodFinderEvent = _$FoodFinderEventTearOff();

mixin _$FoodFinderEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  });
}

abstract class $FoodFinderEventCopyWith<$Res> {
  factory $FoodFinderEventCopyWith(
          FoodFinderEvent value, $Res Function(FoodFinderEvent) then) =
      _$FoodFinderEventCopyWithImpl<$Res>;
}

class _$FoodFinderEventCopyWithImpl<$Res>
    implements $FoodFinderEventCopyWith<$Res> {
  _$FoodFinderEventCopyWithImpl(this._value, this._then);

  final FoodFinderEvent _value;
  // ignore: unused_field
  final $Res Function(FoodFinderEvent) _then;
}

abstract class _$SetQueryResultsCopyWith<$Res> {
  factory _$SetQueryResultsCopyWith(
          _SetQueryResults value, $Res Function(_SetQueryResults) then) =
      __$SetQueryResultsCopyWithImpl<$Res>;
  $Res call({RestoQueryResults results});
}

class __$SetQueryResultsCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$SetQueryResultsCopyWith<$Res> {
  __$SetQueryResultsCopyWithImpl(
      _SetQueryResults _value, $Res Function(_SetQueryResults) _then)
      : super(_value, (v) => _then(v as _SetQueryResults));

  @override
  _SetQueryResults get _value => super._value as _SetQueryResults;

  @override
  $Res call({
    Object results = freezed,
  }) {
    return _then(_SetQueryResults(
      results == freezed ? _value.results : results as RestoQueryResults,
    ));
  }
}

class _$_SetQueryResults
    with DiagnosticableTreeMixin
    implements _SetQueryResults {
  const _$_SetQueryResults(this.results) : assert(results != null);

  @override
  final RestoQueryResults results;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.setQueryResults(results: $results)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.setQueryResults'))
      ..add(DiagnosticsProperty('results', results));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SetQueryResults &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(results);

  @override
  _$SetQueryResultsCopyWith<_SetQueryResults> get copyWith =>
      __$SetQueryResultsCopyWithImpl<_SetQueryResults>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setQueryResults(results);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setQueryResults != null) {
      return setQueryResults(results);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setQueryResults(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setQueryResults != null) {
      return setQueryResults(this);
    }
    return orElse();
  }
}

abstract class _SetQueryResults implements FoodFinderEvent {
  const factory _SetQueryResults(RestoQueryResults results) =
      _$_SetQueryResults;

  RestoQueryResults get results;
  _$SetQueryResultsCopyWith<_SetQueryResults> get copyWith;
}

abstract class _$SetCurrentRestosCopyWith<$Res> {
  factory _$SetCurrentRestosCopyWith(
          _SetCurrentRestos value, $Res Function(_SetCurrentRestos) then) =
      __$SetCurrentRestosCopyWithImpl<$Res>;
  $Res call({List<AlgoliaRestaurant> restos});
}

class __$SetCurrentRestosCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$SetCurrentRestosCopyWith<$Res> {
  __$SetCurrentRestosCopyWithImpl(
      _SetCurrentRestos _value, $Res Function(_SetCurrentRestos) _then)
      : super(_value, (v) => _then(v as _SetCurrentRestos));

  @override
  _SetCurrentRestos get _value => super._value as _SetCurrentRestos;

  @override
  $Res call({
    Object restos = freezed,
  }) {
    return _then(_SetCurrentRestos(
      restos == freezed ? _value.restos : restos as List<AlgoliaRestaurant>,
    ));
  }
}

class _$_SetCurrentRestos
    with DiagnosticableTreeMixin
    implements _SetCurrentRestos {
  const _$_SetCurrentRestos(this.restos) : assert(restos != null);

  @override
  final List<AlgoliaRestaurant> restos;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.setCurrentRestos(restos: $restos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.setCurrentRestos'))
      ..add(DiagnosticsProperty('restos', restos));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SetCurrentRestos &&
            (identical(other.restos, restos) ||
                const DeepCollectionEquality().equals(other.restos, restos)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(restos);

  @override
  _$SetCurrentRestosCopyWith<_SetCurrentRestos> get copyWith =>
      __$SetCurrentRestosCopyWithImpl<_SetCurrentRestos>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setCurrentRestos(restos);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setCurrentRestos != null) {
      return setCurrentRestos(restos);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setCurrentRestos(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setCurrentRestos != null) {
      return setCurrentRestos(this);
    }
    return orElse();
  }
}

abstract class _SetCurrentRestos implements FoodFinderEvent {
  const factory _SetCurrentRestos(List<AlgoliaRestaurant> restos) =
      _$_SetCurrentRestos;

  List<AlgoliaRestaurant> get restos;
  _$SetCurrentRestosCopyWith<_SetCurrentRestos> get copyWith;
}

abstract class _$SetCurrentIndexCopyWith<$Res> {
  factory _$SetCurrentIndexCopyWith(
          _SetCurrentIndex value, $Res Function(_SetCurrentIndex) then) =
      __$SetCurrentIndexCopyWithImpl<$Res>;
  $Res call({int newIndex});
}

class __$SetCurrentIndexCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$SetCurrentIndexCopyWith<$Res> {
  __$SetCurrentIndexCopyWithImpl(
      _SetCurrentIndex _value, $Res Function(_SetCurrentIndex) _then)
      : super(_value, (v) => _then(v as _SetCurrentIndex));

  @override
  _SetCurrentIndex get _value => super._value as _SetCurrentIndex;

  @override
  $Res call({
    Object newIndex = freezed,
  }) {
    return _then(_SetCurrentIndex(
      newIndex == freezed ? _value.newIndex : newIndex as int,
    ));
  }
}

class _$_SetCurrentIndex
    with DiagnosticableTreeMixin
    implements _SetCurrentIndex {
  const _$_SetCurrentIndex(this.newIndex) : assert(newIndex != null);

  @override
  final int newIndex;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.setCurrentIndex(newIndex: $newIndex)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.setCurrentIndex'))
      ..add(DiagnosticsProperty('newIndex', newIndex));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SetCurrentIndex &&
            (identical(other.newIndex, newIndex) ||
                const DeepCollectionEquality()
                    .equals(other.newIndex, newIndex)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(newIndex);

  @override
  _$SetCurrentIndexCopyWith<_SetCurrentIndex> get copyWith =>
      __$SetCurrentIndexCopyWithImpl<_SetCurrentIndex>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setCurrentIndex(newIndex);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setCurrentIndex != null) {
      return setCurrentIndex(newIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setCurrentIndex(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setCurrentIndex != null) {
      return setCurrentIndex(this);
    }
    return orElse();
  }
}

abstract class _SetCurrentIndex implements FoodFinderEvent {
  const factory _SetCurrentIndex(int newIndex) = _$_SetCurrentIndex;

  int get newIndex;
  _$SetCurrentIndexCopyWith<_SetCurrentIndex> get copyWith;
}

abstract class _$SetMaybeListCopyWith<$Res> {
  factory _$SetMaybeListCopyWith(
          _SetMaybeList value, $Res Function(_SetMaybeList) then) =
      __$SetMaybeListCopyWithImpl<$Res>;
  $Res call({List<AlgoliaRestaurant> newMaybeList});
}

class __$SetMaybeListCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$SetMaybeListCopyWith<$Res> {
  __$SetMaybeListCopyWithImpl(
      _SetMaybeList _value, $Res Function(_SetMaybeList) _then)
      : super(_value, (v) => _then(v as _SetMaybeList));

  @override
  _SetMaybeList get _value => super._value as _SetMaybeList;

  @override
  $Res call({
    Object newMaybeList = freezed,
  }) {
    return _then(_SetMaybeList(
      newMaybeList == freezed
          ? _value.newMaybeList
          : newMaybeList as List<AlgoliaRestaurant>,
    ));
  }
}

class _$_SetMaybeList with DiagnosticableTreeMixin implements _SetMaybeList {
  const _$_SetMaybeList(this.newMaybeList) : assert(newMaybeList != null);

  @override
  final List<AlgoliaRestaurant> newMaybeList;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.setMaybeList(newMaybeList: $newMaybeList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.setMaybeList'))
      ..add(DiagnosticsProperty('newMaybeList', newMaybeList));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SetMaybeList &&
            (identical(other.newMaybeList, newMaybeList) ||
                const DeepCollectionEquality()
                    .equals(other.newMaybeList, newMaybeList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(newMaybeList);

  @override
  _$SetMaybeListCopyWith<_SetMaybeList> get copyWith =>
      __$SetMaybeListCopyWithImpl<_SetMaybeList>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setMaybeList(newMaybeList);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setMaybeList != null) {
      return setMaybeList(newMaybeList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setMaybeList(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setMaybeList != null) {
      return setMaybeList(this);
    }
    return orElse();
  }
}

abstract class _SetMaybeList implements FoodFinderEvent {
  const factory _SetMaybeList(List<AlgoliaRestaurant> newMaybeList) =
      _$_SetMaybeList;

  List<AlgoliaRestaurant> get newMaybeList;
  _$SetMaybeListCopyWith<_SetMaybeList> get copyWith;
}

abstract class _$AddToMaybeListCopyWith<$Res> {
  factory _$AddToMaybeListCopyWith(
          _AddToMaybeList value, $Res Function(_AddToMaybeList) then) =
      __$AddToMaybeListCopyWithImpl<$Res>;
  $Res call({List<CoverPhoto> coverPhotos});
}

class __$AddToMaybeListCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$AddToMaybeListCopyWith<$Res> {
  __$AddToMaybeListCopyWithImpl(
      _AddToMaybeList _value, $Res Function(_AddToMaybeList) _then)
      : super(_value, (v) => _then(v as _AddToMaybeList));

  @override
  _AddToMaybeList get _value => super._value as _AddToMaybeList;

  @override
  $Res call({
    Object coverPhotos = freezed,
  }) {
    return _then(_AddToMaybeList(
      coverPhotos == freezed
          ? _value.coverPhotos
          : coverPhotos as List<CoverPhoto>,
    ));
  }
}

class _$_AddToMaybeList
    with DiagnosticableTreeMixin
    implements _AddToMaybeList {
  const _$_AddToMaybeList(this.coverPhotos) : assert(coverPhotos != null);

  @override
  final List<CoverPhoto> coverPhotos;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.addToMaybeList(coverPhotos: $coverPhotos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.addToMaybeList'))
      ..add(DiagnosticsProperty('coverPhotos', coverPhotos));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AddToMaybeList &&
            (identical(other.coverPhotos, coverPhotos) ||
                const DeepCollectionEquality()
                    .equals(other.coverPhotos, coverPhotos)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(coverPhotos);

  @override
  _$AddToMaybeListCopyWith<_AddToMaybeList> get copyWith =>
      __$AddToMaybeListCopyWithImpl<_AddToMaybeList>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return addToMaybeList(coverPhotos);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (addToMaybeList != null) {
      return addToMaybeList(coverPhotos);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return addToMaybeList(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (addToMaybeList != null) {
      return addToMaybeList(this);
    }
    return orElse();
  }
}

abstract class _AddToMaybeList implements FoodFinderEvent {
  const factory _AddToMaybeList(List<CoverPhoto> coverPhotos) =
      _$_AddToMaybeList;

  List<CoverPhoto> get coverPhotos;
  _$AddToMaybeListCopyWith<_AddToMaybeList> get copyWith;
}

abstract class _$RemoveFromMaybeListCopyWith<$Res> {
  factory _$RemoveFromMaybeListCopyWith(_RemoveFromMaybeList value,
          $Res Function(_RemoveFromMaybeList) then) =
      __$RemoveFromMaybeListCopyWithImpl<$Res>;
  $Res call({AlgoliaRestaurant resto});
}

class __$RemoveFromMaybeListCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$RemoveFromMaybeListCopyWith<$Res> {
  __$RemoveFromMaybeListCopyWithImpl(
      _RemoveFromMaybeList _value, $Res Function(_RemoveFromMaybeList) _then)
      : super(_value, (v) => _then(v as _RemoveFromMaybeList));

  @override
  _RemoveFromMaybeList get _value => super._value as _RemoveFromMaybeList;

  @override
  $Res call({
    Object resto = freezed,
  }) {
    return _then(_RemoveFromMaybeList(
      resto == freezed ? _value.resto : resto as AlgoliaRestaurant,
    ));
  }
}

class _$_RemoveFromMaybeList
    with DiagnosticableTreeMixin
    implements _RemoveFromMaybeList {
  const _$_RemoveFromMaybeList(this.resto) : assert(resto != null);

  @override
  final AlgoliaRestaurant resto;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.removeFromMaybeList(resto: $resto)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.removeFromMaybeList'))
      ..add(DiagnosticsProperty('resto', resto));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RemoveFromMaybeList &&
            (identical(other.resto, resto) ||
                const DeepCollectionEquality().equals(other.resto, resto)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(resto);

  @override
  _$RemoveFromMaybeListCopyWith<_RemoveFromMaybeList> get copyWith =>
      __$RemoveFromMaybeListCopyWithImpl<_RemoveFromMaybeList>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return removeFromMaybeList(resto);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (removeFromMaybeList != null) {
      return removeFromMaybeList(resto);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return removeFromMaybeList(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (removeFromMaybeList != null) {
      return removeFromMaybeList(this);
    }
    return orElse();
  }
}

abstract class _RemoveFromMaybeList implements FoodFinderEvent {
  const factory _RemoveFromMaybeList(AlgoliaRestaurant resto) =
      _$_RemoveFromMaybeList;

  AlgoliaRestaurant get resto;
  _$RemoveFromMaybeListCopyWith<_RemoveFromMaybeList> get copyWith;
}

abstract class _$ClearMaybeListCopyWith<$Res> {
  factory _$ClearMaybeListCopyWith(
          _ClearMaybeList value, $Res Function(_ClearMaybeList) then) =
      __$ClearMaybeListCopyWithImpl<$Res>;
}

class __$ClearMaybeListCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$ClearMaybeListCopyWith<$Res> {
  __$ClearMaybeListCopyWithImpl(
      _ClearMaybeList _value, $Res Function(_ClearMaybeList) _then)
      : super(_value, (v) => _then(v as _ClearMaybeList));

  @override
  _ClearMaybeList get _value => super._value as _ClearMaybeList;
}

class _$_ClearMaybeList
    with DiagnosticableTreeMixin
    implements _ClearMaybeList {
  const _$_ClearMaybeList();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.clearMaybeList()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.clearMaybeList'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _ClearMaybeList);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return clearMaybeList();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (clearMaybeList != null) {
      return clearMaybeList();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return clearMaybeList(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (clearMaybeList != null) {
      return clearMaybeList(this);
    }
    return orElse();
  }
}

abstract class _ClearMaybeList implements FoodFinderEvent {
  const factory _ClearMaybeList() = _$_ClearMaybeList;
}

abstract class _$SetNoListCopyWith<$Res> {
  factory _$SetNoListCopyWith(
          _SetNoList value, $Res Function(_SetNoList) then) =
      __$SetNoListCopyWithImpl<$Res>;
  $Res call({Set<AlgoliaRestaurant> newNoList});
}

class __$SetNoListCopyWithImpl<$Res> extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$SetNoListCopyWith<$Res> {
  __$SetNoListCopyWithImpl(_SetNoList _value, $Res Function(_SetNoList) _then)
      : super(_value, (v) => _then(v as _SetNoList));

  @override
  _SetNoList get _value => super._value as _SetNoList;

  @override
  $Res call({
    Object newNoList = freezed,
  }) {
    return _then(_SetNoList(
      newNoList == freezed
          ? _value.newNoList
          : newNoList as Set<AlgoliaRestaurant>,
    ));
  }
}

class _$_SetNoList with DiagnosticableTreeMixin implements _SetNoList {
  const _$_SetNoList(this.newNoList) : assert(newNoList != null);

  @override
  final Set<AlgoliaRestaurant> newNoList;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.setNoList(newNoList: $newNoList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.setNoList'))
      ..add(DiagnosticsProperty('newNoList', newNoList));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SetNoList &&
            (identical(other.newNoList, newNoList) ||
                const DeepCollectionEquality()
                    .equals(other.newNoList, newNoList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(newNoList);

  @override
  _$SetNoListCopyWith<_SetNoList> get copyWith =>
      __$SetNoListCopyWithImpl<_SetNoList>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setNoList(newNoList);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setNoList != null) {
      return setNoList(newNoList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setNoList(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setNoList != null) {
      return setNoList(this);
    }
    return orElse();
  }
}

abstract class _SetNoList implements FoodFinderEvent {
  const factory _SetNoList(Set<AlgoliaRestaurant> newNoList) = _$_SetNoList;

  Set<AlgoliaRestaurant> get newNoList;
  _$SetNoListCopyWith<_SetNoList> get copyWith;
}

abstract class _$AddToNoListCopyWith<$Res> {
  factory _$AddToNoListCopyWith(
          _AddToNoList value, $Res Function(_AddToNoList) then) =
      __$AddToNoListCopyWithImpl<$Res>;
  $Res call({List<CoverPhoto> coverPhotos});
}

class __$AddToNoListCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$AddToNoListCopyWith<$Res> {
  __$AddToNoListCopyWithImpl(
      _AddToNoList _value, $Res Function(_AddToNoList) _then)
      : super(_value, (v) => _then(v as _AddToNoList));

  @override
  _AddToNoList get _value => super._value as _AddToNoList;

  @override
  $Res call({
    Object coverPhotos = freezed,
  }) {
    return _then(_AddToNoList(
      coverPhotos == freezed
          ? _value.coverPhotos
          : coverPhotos as List<CoverPhoto>,
    ));
  }
}

class _$_AddToNoList with DiagnosticableTreeMixin implements _AddToNoList {
  const _$_AddToNoList(this.coverPhotos) : assert(coverPhotos != null);

  @override
  final List<CoverPhoto> coverPhotos;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.addToNoList(coverPhotos: $coverPhotos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.addToNoList'))
      ..add(DiagnosticsProperty('coverPhotos', coverPhotos));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AddToNoList &&
            (identical(other.coverPhotos, coverPhotos) ||
                const DeepCollectionEquality()
                    .equals(other.coverPhotos, coverPhotos)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(coverPhotos);

  @override
  _$AddToNoListCopyWith<_AddToNoList> get copyWith =>
      __$AddToNoListCopyWithImpl<_AddToNoList>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return addToNoList(coverPhotos);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (addToNoList != null) {
      return addToNoList(coverPhotos);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return addToNoList(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (addToNoList != null) {
      return addToNoList(this);
    }
    return orElse();
  }
}

abstract class _AddToNoList implements FoodFinderEvent {
  const factory _AddToNoList(List<CoverPhoto> coverPhotos) = _$_AddToNoList;

  List<CoverPhoto> get coverPhotos;
  _$AddToNoListCopyWith<_AddToNoList> get copyWith;
}

abstract class _$SetLocationCopyWith<$Res> {
  factory _$SetLocationCopyWith(
          _SetLocation value, $Res Function(_SetLocation) then) =
      __$SetLocationCopyWithImpl<$Res>;
  $Res call({LocationInfo location});
}

class __$SetLocationCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$SetLocationCopyWith<$Res> {
  __$SetLocationCopyWithImpl(
      _SetLocation _value, $Res Function(_SetLocation) _then)
      : super(_value, (v) => _then(v as _SetLocation));

  @override
  _SetLocation get _value => super._value as _SetLocation;

  @override
  $Res call({
    Object location = freezed,
  }) {
    return _then(_SetLocation(
      location == freezed ? _value.location : location as LocationInfo,
    ));
  }
}

class _$_SetLocation with DiagnosticableTreeMixin implements _SetLocation {
  const _$_SetLocation(this.location) : assert(location != null);

  @override
  final LocationInfo location;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.setLocation(location: $location)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.setLocation'))
      ..add(DiagnosticsProperty('location', location));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SetLocation &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(location);

  @override
  _$SetLocationCopyWith<_SetLocation> get copyWith =>
      __$SetLocationCopyWithImpl<_SetLocation>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setLocation(location);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setLocation != null) {
      return setLocation(location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setLocation(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setLocation != null) {
      return setLocation(this);
    }
    return orElse();
  }
}

abstract class _SetLocation implements FoodFinderEvent {
  const factory _SetLocation(LocationInfo location) = _$_SetLocation;

  LocationInfo get location;
  _$SetLocationCopyWith<_SetLocation> get copyWith;
}

abstract class _$SetFiltersCopyWith<$Res> {
  factory _$SetFiltersCopyWith(
          _SetFilters value, $Res Function(_SetFilters) then) =
      __$SetFiltersCopyWithImpl<$Res>;
  $Res call({FoodFilters newFilters});
}

class __$SetFiltersCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$SetFiltersCopyWith<$Res> {
  __$SetFiltersCopyWithImpl(
      _SetFilters _value, $Res Function(_SetFilters) _then)
      : super(_value, (v) => _then(v as _SetFilters));

  @override
  _SetFilters get _value => super._value as _SetFilters;

  @override
  $Res call({
    Object newFilters = freezed,
  }) {
    return _then(_SetFilters(
      newFilters == freezed ? _value.newFilters : newFilters as FoodFilters,
    ));
  }
}

class _$_SetFilters with DiagnosticableTreeMixin implements _SetFilters {
  const _$_SetFilters(this.newFilters) : assert(newFilters != null);

  @override
  final FoodFilters newFilters;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.setFilters(newFilters: $newFilters)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.setFilters'))
      ..add(DiagnosticsProperty('newFilters', newFilters));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SetFilters &&
            (identical(other.newFilters, newFilters) ||
                const DeepCollectionEquality()
                    .equals(other.newFilters, newFilters)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(newFilters);

  @override
  _$SetFiltersCopyWith<_SetFilters> get copyWith =>
      __$SetFiltersCopyWithImpl<_SetFilters>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setFilters(newFilters);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setFilters != null) {
      return setFilters(newFilters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setFilters(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setFilters != null) {
      return setFilters(this);
    }
    return orElse();
  }
}

abstract class _SetFilters implements FoodFinderEvent {
  const factory _SetFilters(FoodFilters newFilters) = _$_SetFilters;

  FoodFilters get newFilters;
  _$SetFiltersCopyWith<_SetFilters> get copyWith;
}

abstract class _$SetIsLoadingCopyWith<$Res> {
  factory _$SetIsLoadingCopyWith(
          _SetIsLoading value, $Res Function(_SetIsLoading) then) =
      __$SetIsLoadingCopyWithImpl<$Res>;
  $Res call({bool isLoading});
}

class __$SetIsLoadingCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$SetIsLoadingCopyWith<$Res> {
  __$SetIsLoadingCopyWithImpl(
      _SetIsLoading _value, $Res Function(_SetIsLoading) _then)
      : super(_value, (v) => _then(v as _SetIsLoading));

  @override
  _SetIsLoading get _value => super._value as _SetIsLoading;

  @override
  $Res call({
    Object isLoading = freezed,
  }) {
    return _then(_SetIsLoading(
      isLoading == freezed ? _value.isLoading : isLoading as bool,
    ));
  }
}

class _$_SetIsLoading with DiagnosticableTreeMixin implements _SetIsLoading {
  const _$_SetIsLoading(this.isLoading) : assert(isLoading != null);

  @override
  final bool isLoading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.setIsLoading(isLoading: $isLoading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.setIsLoading'))
      ..add(DiagnosticsProperty('isLoading', isLoading));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SetIsLoading &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(isLoading);

  @override
  _$SetIsLoadingCopyWith<_SetIsLoading> get copyWith =>
      __$SetIsLoadingCopyWithImpl<_SetIsLoading>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setIsLoading(isLoading);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setIsLoading != null) {
      return setIsLoading(isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setIsLoading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setIsLoading != null) {
      return setIsLoading(this);
    }
    return orElse();
  }
}

abstract class _SetIsLoading implements FoodFinderEvent {
  const factory _SetIsLoading(bool isLoading) = _$_SetIsLoading;

  bool get isLoading;
  _$SetIsLoadingCopyWith<_SetIsLoading> get copyWith;
}

abstract class _$SetActiveDiscoverItemCopyWith<$Res> {
  factory _$SetActiveDiscoverItemCopyWith(_SetActiveDiscoverItem value,
          $Res Function(_SetActiveDiscoverItem) then) =
      __$SetActiveDiscoverItemCopyWithImpl<$Res>;
  $Res call({DocumentReference restoReference, int newActiveDiscoverItem});
}

class __$SetActiveDiscoverItemCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$SetActiveDiscoverItemCopyWith<$Res> {
  __$SetActiveDiscoverItemCopyWithImpl(_SetActiveDiscoverItem _value,
      $Res Function(_SetActiveDiscoverItem) _then)
      : super(_value, (v) => _then(v as _SetActiveDiscoverItem));

  @override
  _SetActiveDiscoverItem get _value => super._value as _SetActiveDiscoverItem;

  @override
  $Res call({
    Object restoReference = freezed,
    Object newActiveDiscoverItem = freezed,
  }) {
    return _then(_SetActiveDiscoverItem(
      restoReference == freezed
          ? _value.restoReference
          : restoReference as DocumentReference,
      newActiveDiscoverItem == freezed
          ? _value.newActiveDiscoverItem
          : newActiveDiscoverItem as int,
    ));
  }
}

class _$_SetActiveDiscoverItem
    with DiagnosticableTreeMixin
    implements _SetActiveDiscoverItem {
  const _$_SetActiveDiscoverItem(
      this.restoReference, this.newActiveDiscoverItem)
      : assert(restoReference != null),
        assert(newActiveDiscoverItem != null);

  @override
  final DocumentReference restoReference;
  @override
  final int newActiveDiscoverItem;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.setActiveDiscoverItem(restoReference: $restoReference, newActiveDiscoverItem: $newActiveDiscoverItem)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'FoodFinderEvent.setActiveDiscoverItem'))
      ..add(DiagnosticsProperty('restoReference', restoReference))
      ..add(
          DiagnosticsProperty('newActiveDiscoverItem', newActiveDiscoverItem));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SetActiveDiscoverItem &&
            (identical(other.restoReference, restoReference) ||
                const DeepCollectionEquality()
                    .equals(other.restoReference, restoReference)) &&
            (identical(other.newActiveDiscoverItem, newActiveDiscoverItem) ||
                const DeepCollectionEquality().equals(
                    other.newActiveDiscoverItem, newActiveDiscoverItem)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(restoReference) ^
      const DeepCollectionEquality().hash(newActiveDiscoverItem);

  @override
  _$SetActiveDiscoverItemCopyWith<_SetActiveDiscoverItem> get copyWith =>
      __$SetActiveDiscoverItemCopyWithImpl<_SetActiveDiscoverItem>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setActiveDiscoverItem(restoReference, newActiveDiscoverItem);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setActiveDiscoverItem != null) {
      return setActiveDiscoverItem(restoReference, newActiveDiscoverItem);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return setActiveDiscoverItem(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setActiveDiscoverItem != null) {
      return setActiveDiscoverItem(this);
    }
    return orElse();
  }
}

abstract class _SetActiveDiscoverItem implements FoodFinderEvent {
  const factory _SetActiveDiscoverItem(
          DocumentReference restoReference, int newActiveDiscoverItem) =
      _$_SetActiveDiscoverItem;

  DocumentReference get restoReference;
  int get newActiveDiscoverItem;
  _$SetActiveDiscoverItemCopyWith<_SetActiveDiscoverItem> get copyWith;
}

abstract class _$ToggleShowMapCopyWith<$Res> {
  factory _$ToggleShowMapCopyWith(
          _ToggleShowMap value, $Res Function(_ToggleShowMap) then) =
      __$ToggleShowMapCopyWithImpl<$Res>;
}

class __$ToggleShowMapCopyWithImpl<$Res>
    extends _$FoodFinderEventCopyWithImpl<$Res>
    implements _$ToggleShowMapCopyWith<$Res> {
  __$ToggleShowMapCopyWithImpl(
      _ToggleShowMap _value, $Res Function(_ToggleShowMap) _then)
      : super(_value, (v) => _then(v as _ToggleShowMap));

  @override
  _ToggleShowMap get _value => super._value as _ToggleShowMap;
}

class _$_ToggleShowMap with DiagnosticableTreeMixin implements _ToggleShowMap {
  const _$_ToggleShowMap();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodFinderEvent.toggleShowMap()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderEvent.toggleShowMap'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _ToggleShowMap);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result setQueryResults(RestoQueryResults results),
    @required Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    @required Result setCurrentIndex(int newIndex),
    @required Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    @required Result addToMaybeList(List<CoverPhoto> coverPhotos),
    @required Result removeFromMaybeList(AlgoliaRestaurant resto),
    @required Result clearMaybeList(),
    @required Result setNoList(Set<AlgoliaRestaurant> newNoList),
    @required Result addToNoList(List<CoverPhoto> coverPhotos),
    @required Result setLocation(LocationInfo location),
    @required Result setFilters(FoodFilters newFilters),
    @required Result setIsLoading(bool isLoading),
    @required
        Result setActiveDiscoverItem(
            DocumentReference restoReference, int newActiveDiscoverItem),
    @required Result toggleShowMap(),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return toggleShowMap();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result setQueryResults(RestoQueryResults results),
    Result setCurrentRestos(List<AlgoliaRestaurant> restos),
    Result setCurrentIndex(int newIndex),
    Result setMaybeList(List<AlgoliaRestaurant> newMaybeList),
    Result addToMaybeList(List<CoverPhoto> coverPhotos),
    Result removeFromMaybeList(AlgoliaRestaurant resto),
    Result clearMaybeList(),
    Result setNoList(Set<AlgoliaRestaurant> newNoList),
    Result addToNoList(List<CoverPhoto> coverPhotos),
    Result setLocation(LocationInfo location),
    Result setFilters(FoodFilters newFilters),
    Result setIsLoading(bool isLoading),
    Result setActiveDiscoverItem(
        DocumentReference restoReference, int newActiveDiscoverItem),
    Result toggleShowMap(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (toggleShowMap != null) {
      return toggleShowMap();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result setQueryResults(_SetQueryResults value),
    @required Result setCurrentRestos(_SetCurrentRestos value),
    @required Result setCurrentIndex(_SetCurrentIndex value),
    @required Result setMaybeList(_SetMaybeList value),
    @required Result addToMaybeList(_AddToMaybeList value),
    @required Result removeFromMaybeList(_RemoveFromMaybeList value),
    @required Result clearMaybeList(_ClearMaybeList value),
    @required Result setNoList(_SetNoList value),
    @required Result addToNoList(_AddToNoList value),
    @required Result setLocation(_SetLocation value),
    @required Result setFilters(_SetFilters value),
    @required Result setIsLoading(_SetIsLoading value),
    @required Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    @required Result toggleShowMap(_ToggleShowMap value),
  }) {
    assert(setQueryResults != null);
    assert(setCurrentRestos != null);
    assert(setCurrentIndex != null);
    assert(setMaybeList != null);
    assert(addToMaybeList != null);
    assert(removeFromMaybeList != null);
    assert(clearMaybeList != null);
    assert(setNoList != null);
    assert(addToNoList != null);
    assert(setLocation != null);
    assert(setFilters != null);
    assert(setIsLoading != null);
    assert(setActiveDiscoverItem != null);
    assert(toggleShowMap != null);
    return toggleShowMap(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result setQueryResults(_SetQueryResults value),
    Result setCurrentRestos(_SetCurrentRestos value),
    Result setCurrentIndex(_SetCurrentIndex value),
    Result setMaybeList(_SetMaybeList value),
    Result addToMaybeList(_AddToMaybeList value),
    Result removeFromMaybeList(_RemoveFromMaybeList value),
    Result clearMaybeList(_ClearMaybeList value),
    Result setNoList(_SetNoList value),
    Result addToNoList(_AddToNoList value),
    Result setLocation(_SetLocation value),
    Result setFilters(_SetFilters value),
    Result setIsLoading(_SetIsLoading value),
    Result setActiveDiscoverItem(_SetActiveDiscoverItem value),
    Result toggleShowMap(_ToggleShowMap value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (toggleShowMap != null) {
      return toggleShowMap(this);
    }
    return orElse();
  }
}

abstract class _ToggleShowMap implements FoodFinderEvent {
  const factory _ToggleShowMap() = _$_ToggleShowMap;
}

class _$FoodFinderStateTearOff {
  const _$FoodFinderStateTearOff();

  _Create call(
      {Set<AlgoliaRestaurant> allRestos,
      List<AlgoliaRestaurant> currentRestos,
      int currentIndex,
      double queriedRadius,
      List<AlgoliaRestaurant> maybeList,
      Set<AlgoliaRestaurant> noList,
      LocationInfo location,
      FoodFilters filters,
      bool isLoading,
      Map<DocumentReference, int> activeDiscoverItemMap,
      String sessionId,
      bool showMap}) {
    return _Create(
      allRestos: allRestos,
      currentRestos: currentRestos,
      currentIndex: currentIndex,
      queriedRadius: queriedRadius,
      maybeList: maybeList,
      noList: noList,
      location: location,
      filters: filters,
      isLoading: isLoading,
      activeDiscoverItemMap: activeDiscoverItemMap,
      sessionId: sessionId,
      showMap: showMap,
    );
  }
}

// ignore: unused_element
const $FoodFinderState = _$FoodFinderStateTearOff();

mixin _$FoodFinderState {
  Set<AlgoliaRestaurant> get allRestos;
  List<AlgoliaRestaurant> get currentRestos;
  int get currentIndex;
  double get queriedRadius;
  List<AlgoliaRestaurant> get maybeList;
  Set<AlgoliaRestaurant> get noList;
  LocationInfo get location;
  FoodFilters get filters;
  bool get isLoading;
  Map<DocumentReference, int> get activeDiscoverItemMap;
  String get sessionId;
  bool get showMap;

  $FoodFinderStateCopyWith<FoodFinderState> get copyWith;
}

abstract class $FoodFinderStateCopyWith<$Res> {
  factory $FoodFinderStateCopyWith(
          FoodFinderState value, $Res Function(FoodFinderState) then) =
      _$FoodFinderStateCopyWithImpl<$Res>;
  $Res call(
      {Set<AlgoliaRestaurant> allRestos,
      List<AlgoliaRestaurant> currentRestos,
      int currentIndex,
      double queriedRadius,
      List<AlgoliaRestaurant> maybeList,
      Set<AlgoliaRestaurant> noList,
      LocationInfo location,
      FoodFilters filters,
      bool isLoading,
      Map<DocumentReference, int> activeDiscoverItemMap,
      String sessionId,
      bool showMap});
}

class _$FoodFinderStateCopyWithImpl<$Res>
    implements $FoodFinderStateCopyWith<$Res> {
  _$FoodFinderStateCopyWithImpl(this._value, this._then);

  final FoodFinderState _value;
  // ignore: unused_field
  final $Res Function(FoodFinderState) _then;

  @override
  $Res call({
    Object allRestos = freezed,
    Object currentRestos = freezed,
    Object currentIndex = freezed,
    Object queriedRadius = freezed,
    Object maybeList = freezed,
    Object noList = freezed,
    Object location = freezed,
    Object filters = freezed,
    Object isLoading = freezed,
    Object activeDiscoverItemMap = freezed,
    Object sessionId = freezed,
    Object showMap = freezed,
  }) {
    return _then(_value.copyWith(
      allRestos: allRestos == freezed
          ? _value.allRestos
          : allRestos as Set<AlgoliaRestaurant>,
      currentRestos: currentRestos == freezed
          ? _value.currentRestos
          : currentRestos as List<AlgoliaRestaurant>,
      currentIndex:
          currentIndex == freezed ? _value.currentIndex : currentIndex as int,
      queriedRadius: queriedRadius == freezed
          ? _value.queriedRadius
          : queriedRadius as double,
      maybeList: maybeList == freezed
          ? _value.maybeList
          : maybeList as List<AlgoliaRestaurant>,
      noList:
          noList == freezed ? _value.noList : noList as Set<AlgoliaRestaurant>,
      location:
          location == freezed ? _value.location : location as LocationInfo,
      filters: filters == freezed ? _value.filters : filters as FoodFilters,
      isLoading: isLoading == freezed ? _value.isLoading : isLoading as bool,
      activeDiscoverItemMap: activeDiscoverItemMap == freezed
          ? _value.activeDiscoverItemMap
          : activeDiscoverItemMap as Map<DocumentReference, int>,
      sessionId: sessionId == freezed ? _value.sessionId : sessionId as String,
      showMap: showMap == freezed ? _value.showMap : showMap as bool,
    ));
  }
}

abstract class _$CreateCopyWith<$Res>
    implements $FoodFinderStateCopyWith<$Res> {
  factory _$CreateCopyWith(_Create value, $Res Function(_Create) then) =
      __$CreateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Set<AlgoliaRestaurant> allRestos,
      List<AlgoliaRestaurant> currentRestos,
      int currentIndex,
      double queriedRadius,
      List<AlgoliaRestaurant> maybeList,
      Set<AlgoliaRestaurant> noList,
      LocationInfo location,
      FoodFilters filters,
      bool isLoading,
      Map<DocumentReference, int> activeDiscoverItemMap,
      String sessionId,
      bool showMap});
}

class __$CreateCopyWithImpl<$Res> extends _$FoodFinderStateCopyWithImpl<$Res>
    implements _$CreateCopyWith<$Res> {
  __$CreateCopyWithImpl(_Create _value, $Res Function(_Create) _then)
      : super(_value, (v) => _then(v as _Create));

  @override
  _Create get _value => super._value as _Create;

  @override
  $Res call({
    Object allRestos = freezed,
    Object currentRestos = freezed,
    Object currentIndex = freezed,
    Object queriedRadius = freezed,
    Object maybeList = freezed,
    Object noList = freezed,
    Object location = freezed,
    Object filters = freezed,
    Object isLoading = freezed,
    Object activeDiscoverItemMap = freezed,
    Object sessionId = freezed,
    Object showMap = freezed,
  }) {
    return _then(_Create(
      allRestos: allRestos == freezed
          ? _value.allRestos
          : allRestos as Set<AlgoliaRestaurant>,
      currentRestos: currentRestos == freezed
          ? _value.currentRestos
          : currentRestos as List<AlgoliaRestaurant>,
      currentIndex:
          currentIndex == freezed ? _value.currentIndex : currentIndex as int,
      queriedRadius: queriedRadius == freezed
          ? _value.queriedRadius
          : queriedRadius as double,
      maybeList: maybeList == freezed
          ? _value.maybeList
          : maybeList as List<AlgoliaRestaurant>,
      noList:
          noList == freezed ? _value.noList : noList as Set<AlgoliaRestaurant>,
      location:
          location == freezed ? _value.location : location as LocationInfo,
      filters: filters == freezed ? _value.filters : filters as FoodFilters,
      isLoading: isLoading == freezed ? _value.isLoading : isLoading as bool,
      activeDiscoverItemMap: activeDiscoverItemMap == freezed
          ? _value.activeDiscoverItemMap
          : activeDiscoverItemMap as Map<DocumentReference, int>,
      sessionId: sessionId == freezed ? _value.sessionId : sessionId as String,
      showMap: showMap == freezed ? _value.showMap : showMap as bool,
    ));
  }
}

class _$_Create extends _Create with DiagnosticableTreeMixin {
  _$_Create(
      {this.allRestos,
      this.currentRestos,
      this.currentIndex,
      this.queriedRadius,
      this.maybeList,
      this.noList,
      this.location,
      this.filters,
      this.isLoading,
      this.activeDiscoverItemMap,
      this.sessionId,
      this.showMap})
      : super._();

  @override
  final Set<AlgoliaRestaurant> allRestos;
  @override
  final List<AlgoliaRestaurant> currentRestos;
  @override
  final int currentIndex;
  @override
  final double queriedRadius;
  @override
  final List<AlgoliaRestaurant> maybeList;
  @override
  final Set<AlgoliaRestaurant> noList;
  @override
  final LocationInfo location;
  @override
  final FoodFilters filters;
  @override
  final bool isLoading;
  @override
  final Map<DocumentReference, int> activeDiscoverItemMap;
  @override
  final String sessionId;
  @override
  final bool showMap;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodFinderState'))
      ..add(DiagnosticsProperty('allRestos', allRestos))
      ..add(DiagnosticsProperty('currentRestos', currentRestos))
      ..add(DiagnosticsProperty('currentIndex', currentIndex))
      ..add(DiagnosticsProperty('queriedRadius', queriedRadius))
      ..add(DiagnosticsProperty('maybeList', maybeList))
      ..add(DiagnosticsProperty('noList', noList))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('filters', filters))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('activeDiscoverItemMap', activeDiscoverItemMap))
      ..add(DiagnosticsProperty('sessionId', sessionId))
      ..add(DiagnosticsProperty('showMap', showMap));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Create &&
            (identical(other.allRestos, allRestos) ||
                const DeepCollectionEquality()
                    .equals(other.allRestos, allRestos)) &&
            (identical(other.currentRestos, currentRestos) ||
                const DeepCollectionEquality()
                    .equals(other.currentRestos, currentRestos)) &&
            (identical(other.currentIndex, currentIndex) ||
                const DeepCollectionEquality()
                    .equals(other.currentIndex, currentIndex)) &&
            (identical(other.queriedRadius, queriedRadius) ||
                const DeepCollectionEquality()
                    .equals(other.queriedRadius, queriedRadius)) &&
            (identical(other.maybeList, maybeList) ||
                const DeepCollectionEquality()
                    .equals(other.maybeList, maybeList)) &&
            (identical(other.noList, noList) ||
                const DeepCollectionEquality().equals(other.noList, noList)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.filters, filters) ||
                const DeepCollectionEquality()
                    .equals(other.filters, filters)) &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.activeDiscoverItemMap, activeDiscoverItemMap) ||
                const DeepCollectionEquality().equals(
                    other.activeDiscoverItemMap, activeDiscoverItemMap)) &&
            (identical(other.sessionId, sessionId) ||
                const DeepCollectionEquality()
                    .equals(other.sessionId, sessionId)) &&
            (identical(other.showMap, showMap) ||
                const DeepCollectionEquality().equals(other.showMap, showMap)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(allRestos) ^
      const DeepCollectionEquality().hash(currentRestos) ^
      const DeepCollectionEquality().hash(currentIndex) ^
      const DeepCollectionEquality().hash(queriedRadius) ^
      const DeepCollectionEquality().hash(maybeList) ^
      const DeepCollectionEquality().hash(noList) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(filters) ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(activeDiscoverItemMap) ^
      const DeepCollectionEquality().hash(sessionId) ^
      const DeepCollectionEquality().hash(showMap);

  @override
  _$CreateCopyWith<_Create> get copyWith =>
      __$CreateCopyWithImpl<_Create>(this, _$identity);
}

abstract class _Create extends FoodFinderState {
  _Create._() : super._();
  factory _Create(
      {Set<AlgoliaRestaurant> allRestos,
      List<AlgoliaRestaurant> currentRestos,
      int currentIndex,
      double queriedRadius,
      List<AlgoliaRestaurant> maybeList,
      Set<AlgoliaRestaurant> noList,
      LocationInfo location,
      FoodFilters filters,
      bool isLoading,
      Map<DocumentReference, int> activeDiscoverItemMap,
      String sessionId,
      bool showMap}) = _$_Create;

  @override
  Set<AlgoliaRestaurant> get allRestos;
  @override
  List<AlgoliaRestaurant> get currentRestos;
  @override
  int get currentIndex;
  @override
  double get queriedRadius;
  @override
  List<AlgoliaRestaurant> get maybeList;
  @override
  Set<AlgoliaRestaurant> get noList;
  @override
  LocationInfo get location;
  @override
  FoodFilters get filters;
  @override
  bool get isLoading;
  @override
  Map<DocumentReference, int> get activeDiscoverItemMap;
  @override
  String get sessionId;
  @override
  bool get showMap;
  @override
  _$CreateCopyWith<_Create> get copyWith;
}
