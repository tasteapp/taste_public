// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$ReviewPageInputTearOff {
  const _$ReviewPageInputTearOff();

  _Review review(Review review) {
    return _Review(
      review,
    );
  }

  _DiscoverItem discoverItem(DiscoverItem item) {
    return _DiscoverItem(
      item,
    );
  }

  _ReviewReference reviewReference(DocumentReference reference) {
    return _ReviewReference(
      reference,
    );
  }
}

// ignore: unused_element
const $ReviewPageInput = _$ReviewPageInputTearOff();

mixin _$ReviewPageInput {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result review(Review review),
    @required Result discoverItem(DiscoverItem item),
    @required Result reviewReference(DocumentReference reference),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result review(Review review),
    Result discoverItem(DiscoverItem item),
    Result reviewReference(DocumentReference reference),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result review(_Review value),
    @required Result discoverItem(_DiscoverItem value),
    @required Result reviewReference(_ReviewReference value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result review(_Review value),
    Result discoverItem(_DiscoverItem value),
    Result reviewReference(_ReviewReference value),
    @required Result orElse(),
  });
}

abstract class $ReviewPageInputCopyWith<$Res> {
  factory $ReviewPageInputCopyWith(
          ReviewPageInput value, $Res Function(ReviewPageInput) then) =
      _$ReviewPageInputCopyWithImpl<$Res>;
}

class _$ReviewPageInputCopyWithImpl<$Res>
    implements $ReviewPageInputCopyWith<$Res> {
  _$ReviewPageInputCopyWithImpl(this._value, this._then);

  final ReviewPageInput _value;
  // ignore: unused_field
  final $Res Function(ReviewPageInput) _then;
}

abstract class _$ReviewCopyWith<$Res> {
  factory _$ReviewCopyWith(_Review value, $Res Function(_Review) then) =
      __$ReviewCopyWithImpl<$Res>;
  $Res call({Review review});
}

class __$ReviewCopyWithImpl<$Res> extends _$ReviewPageInputCopyWithImpl<$Res>
    implements _$ReviewCopyWith<$Res> {
  __$ReviewCopyWithImpl(_Review _value, $Res Function(_Review) _then)
      : super(_value, (v) => _then(v as _Review));

  @override
  _Review get _value => super._value as _Review;

  @override
  $Res call({
    Object review = freezed,
  }) {
    return _then(_Review(
      review == freezed ? _value.review : review as Review,
    ));
  }
}

class _$_Review with DiagnosticableTreeMixin implements _Review {
  const _$_Review(this.review) : assert(review != null);

  @override
  final Review review;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReviewPageInput.review(review: $review)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReviewPageInput.review'))
      ..add(DiagnosticsProperty('review', review));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Review &&
            (identical(other.review, review) ||
                const DeepCollectionEquality().equals(other.review, review)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(review);

  @override
  _$ReviewCopyWith<_Review> get copyWith =>
      __$ReviewCopyWithImpl<_Review>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result review(Review review),
    @required Result discoverItem(DiscoverItem item),
    @required Result reviewReference(DocumentReference reference),
  }) {
    assert(review != null);
    assert(discoverItem != null);
    assert(reviewReference != null);
    return review(this.review);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result review(Review review),
    Result discoverItem(DiscoverItem item),
    Result reviewReference(DocumentReference reference),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (review != null) {
      return review(this.review);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result review(_Review value),
    @required Result discoverItem(_DiscoverItem value),
    @required Result reviewReference(_ReviewReference value),
  }) {
    assert(review != null);
    assert(discoverItem != null);
    assert(reviewReference != null);
    return review(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result review(_Review value),
    Result discoverItem(_DiscoverItem value),
    Result reviewReference(_ReviewReference value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (review != null) {
      return review(this);
    }
    return orElse();
  }
}

abstract class _Review implements ReviewPageInput {
  const factory _Review(Review review) = _$_Review;

  Review get review;
  _$ReviewCopyWith<_Review> get copyWith;
}

abstract class _$DiscoverItemCopyWith<$Res> {
  factory _$DiscoverItemCopyWith(
          _DiscoverItem value, $Res Function(_DiscoverItem) then) =
      __$DiscoverItemCopyWithImpl<$Res>;
  $Res call({DiscoverItem item});
}

class __$DiscoverItemCopyWithImpl<$Res>
    extends _$ReviewPageInputCopyWithImpl<$Res>
    implements _$DiscoverItemCopyWith<$Res> {
  __$DiscoverItemCopyWithImpl(
      _DiscoverItem _value, $Res Function(_DiscoverItem) _then)
      : super(_value, (v) => _then(v as _DiscoverItem));

  @override
  _DiscoverItem get _value => super._value as _DiscoverItem;

  @override
  $Res call({
    Object item = freezed,
  }) {
    return _then(_DiscoverItem(
      item == freezed ? _value.item : item as DiscoverItem,
    ));
  }
}

class _$_DiscoverItem with DiagnosticableTreeMixin implements _DiscoverItem {
  const _$_DiscoverItem(this.item) : assert(item != null);

  @override
  final DiscoverItem item;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReviewPageInput.discoverItem(item: $item)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReviewPageInput.discoverItem'))
      ..add(DiagnosticsProperty('item', item));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DiscoverItem &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(item);

  @override
  _$DiscoverItemCopyWith<_DiscoverItem> get copyWith =>
      __$DiscoverItemCopyWithImpl<_DiscoverItem>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result review(Review review),
    @required Result discoverItem(DiscoverItem item),
    @required Result reviewReference(DocumentReference reference),
  }) {
    assert(review != null);
    assert(discoverItem != null);
    assert(reviewReference != null);
    return discoverItem(item);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result review(Review review),
    Result discoverItem(DiscoverItem item),
    Result reviewReference(DocumentReference reference),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (discoverItem != null) {
      return discoverItem(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result review(_Review value),
    @required Result discoverItem(_DiscoverItem value),
    @required Result reviewReference(_ReviewReference value),
  }) {
    assert(review != null);
    assert(discoverItem != null);
    assert(reviewReference != null);
    return discoverItem(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result review(_Review value),
    Result discoverItem(_DiscoverItem value),
    Result reviewReference(_ReviewReference value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (discoverItem != null) {
      return discoverItem(this);
    }
    return orElse();
  }
}

abstract class _DiscoverItem implements ReviewPageInput {
  const factory _DiscoverItem(DiscoverItem item) = _$_DiscoverItem;

  DiscoverItem get item;
  _$DiscoverItemCopyWith<_DiscoverItem> get copyWith;
}

abstract class _$ReviewReferenceCopyWith<$Res> {
  factory _$ReviewReferenceCopyWith(
          _ReviewReference value, $Res Function(_ReviewReference) then) =
      __$ReviewReferenceCopyWithImpl<$Res>;
  $Res call({DocumentReference reference});
}

class __$ReviewReferenceCopyWithImpl<$Res>
    extends _$ReviewPageInputCopyWithImpl<$Res>
    implements _$ReviewReferenceCopyWith<$Res> {
  __$ReviewReferenceCopyWithImpl(
      _ReviewReference _value, $Res Function(_ReviewReference) _then)
      : super(_value, (v) => _then(v as _ReviewReference));

  @override
  _ReviewReference get _value => super._value as _ReviewReference;

  @override
  $Res call({
    Object reference = freezed,
  }) {
    return _then(_ReviewReference(
      reference == freezed ? _value.reference : reference as DocumentReference,
    ));
  }
}

class _$_ReviewReference
    with DiagnosticableTreeMixin
    implements _ReviewReference {
  const _$_ReviewReference(this.reference) : assert(reference != null);

  @override
  final DocumentReference reference;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReviewPageInput.reviewReference(reference: $reference)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReviewPageInput.reviewReference'))
      ..add(DiagnosticsProperty('reference', reference));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ReviewReference &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality()
                    .equals(other.reference, reference)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(reference);

  @override
  _$ReviewReferenceCopyWith<_ReviewReference> get copyWith =>
      __$ReviewReferenceCopyWithImpl<_ReviewReference>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result review(Review review),
    @required Result discoverItem(DiscoverItem item),
    @required Result reviewReference(DocumentReference reference),
  }) {
    assert(review != null);
    assert(discoverItem != null);
    assert(reviewReference != null);
    return reviewReference(reference);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result review(Review review),
    Result discoverItem(DiscoverItem item),
    Result reviewReference(DocumentReference reference),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (reviewReference != null) {
      return reviewReference(reference);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result review(_Review value),
    @required Result discoverItem(_DiscoverItem value),
    @required Result reviewReference(_ReviewReference value),
  }) {
    assert(review != null);
    assert(discoverItem != null);
    assert(reviewReference != null);
    return reviewReference(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result review(_Review value),
    Result discoverItem(_DiscoverItem value),
    Result reviewReference(_ReviewReference value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (reviewReference != null) {
      return reviewReference(this);
    }
    return orElse();
  }
}

abstract class _ReviewReference implements ReviewPageInput {
  const factory _ReviewReference(DocumentReference reference) =
      _$_ReviewReference;

  DocumentReference get reference;
  _$ReviewReferenceCopyWith<_ReviewReference> get copyWith;
}
