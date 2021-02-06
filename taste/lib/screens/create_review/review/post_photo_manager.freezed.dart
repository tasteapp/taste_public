// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'post_photo_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$PostPhotoEventTearOff {
  const _$PostPhotoEventTearOff();

  _Edited edited(int index, File file) {
    return _Edited(
      index,
      file,
    );
  }

  _Deleted deleted(int index) {
    return _Deleted(
      index,
    );
  }

  _Reordered reordered(int to, int from) {
    return _Reordered(
      to,
      from,
    );
  }

  _Abort abort() {
    return const _Abort();
  }

  _Claim complete(DocumentReference reference) {
    return _Claim(
      reference,
    );
  }

  _Add add(List<File> addedFiles) {
    return _Add(
      addedFiles,
    );
  }
}

// ignore: unused_element
const $PostPhotoEvent = _$PostPhotoEventTearOff();

mixin _$PostPhotoEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result edited(int index, File file),
    @required Result deleted(int index),
    @required Result reordered(int to, int from),
    @required Result abort(),
    @required Result complete(DocumentReference reference),
    @required Result add(List<File> addedFiles),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result edited(int index, File file),
    Result deleted(int index),
    Result reordered(int to, int from),
    Result abort(),
    Result complete(DocumentReference reference),
    Result add(List<File> addedFiles),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result edited(_Edited value),
    @required Result deleted(_Deleted value),
    @required Result reordered(_Reordered value),
    @required Result abort(_Abort value),
    @required Result complete(_Claim value),
    @required Result add(_Add value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result edited(_Edited value),
    Result deleted(_Deleted value),
    Result reordered(_Reordered value),
    Result abort(_Abort value),
    Result complete(_Claim value),
    Result add(_Add value),
    @required Result orElse(),
  });
}

abstract class $PostPhotoEventCopyWith<$Res> {
  factory $PostPhotoEventCopyWith(
          PostPhotoEvent value, $Res Function(PostPhotoEvent) then) =
      _$PostPhotoEventCopyWithImpl<$Res>;
}

class _$PostPhotoEventCopyWithImpl<$Res>
    implements $PostPhotoEventCopyWith<$Res> {
  _$PostPhotoEventCopyWithImpl(this._value, this._then);

  final PostPhotoEvent _value;
  // ignore: unused_field
  final $Res Function(PostPhotoEvent) _then;
}

abstract class _$EditedCopyWith<$Res> {
  factory _$EditedCopyWith(_Edited value, $Res Function(_Edited) then) =
      __$EditedCopyWithImpl<$Res>;
  $Res call({int index, File file});
}

class __$EditedCopyWithImpl<$Res> extends _$PostPhotoEventCopyWithImpl<$Res>
    implements _$EditedCopyWith<$Res> {
  __$EditedCopyWithImpl(_Edited _value, $Res Function(_Edited) _then)
      : super(_value, (v) => _then(v as _Edited));

  @override
  _Edited get _value => super._value as _Edited;

  @override
  $Res call({
    Object index = freezed,
    Object file = freezed,
  }) {
    return _then(_Edited(
      index == freezed ? _value.index : index as int,
      file == freezed ? _value.file : file as File,
    ));
  }
}

class _$_Edited implements _Edited {
  const _$_Edited(this.index, this.file)
      : assert(index != null),
        assert(file != null);

  @override
  final int index;
  @override
  final File file;

  @override
  String toString() {
    return 'PostPhotoEvent.edited(index: $index, file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Edited &&
            (identical(other.index, index) ||
                const DeepCollectionEquality().equals(other.index, index)) &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(index) ^
      const DeepCollectionEquality().hash(file);

  @override
  _$EditedCopyWith<_Edited> get copyWith =>
      __$EditedCopyWithImpl<_Edited>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result edited(int index, File file),
    @required Result deleted(int index),
    @required Result reordered(int to, int from),
    @required Result abort(),
    @required Result complete(DocumentReference reference),
    @required Result add(List<File> addedFiles),
  }) {
    assert(edited != null);
    assert(deleted != null);
    assert(reordered != null);
    assert(abort != null);
    assert(complete != null);
    assert(add != null);
    return edited(index, file);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result edited(int index, File file),
    Result deleted(int index),
    Result reordered(int to, int from),
    Result abort(),
    Result complete(DocumentReference reference),
    Result add(List<File> addedFiles),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (edited != null) {
      return edited(index, file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result edited(_Edited value),
    @required Result deleted(_Deleted value),
    @required Result reordered(_Reordered value),
    @required Result abort(_Abort value),
    @required Result complete(_Claim value),
    @required Result add(_Add value),
  }) {
    assert(edited != null);
    assert(deleted != null);
    assert(reordered != null);
    assert(abort != null);
    assert(complete != null);
    assert(add != null);
    return edited(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result edited(_Edited value),
    Result deleted(_Deleted value),
    Result reordered(_Reordered value),
    Result abort(_Abort value),
    Result complete(_Claim value),
    Result add(_Add value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (edited != null) {
      return edited(this);
    }
    return orElse();
  }
}

abstract class _Edited implements PostPhotoEvent {
  const factory _Edited(int index, File file) = _$_Edited;

  int get index;
  File get file;
  _$EditedCopyWith<_Edited> get copyWith;
}

abstract class _$DeletedCopyWith<$Res> {
  factory _$DeletedCopyWith(_Deleted value, $Res Function(_Deleted) then) =
      __$DeletedCopyWithImpl<$Res>;
  $Res call({int index});
}

class __$DeletedCopyWithImpl<$Res> extends _$PostPhotoEventCopyWithImpl<$Res>
    implements _$DeletedCopyWith<$Res> {
  __$DeletedCopyWithImpl(_Deleted _value, $Res Function(_Deleted) _then)
      : super(_value, (v) => _then(v as _Deleted));

  @override
  _Deleted get _value => super._value as _Deleted;

  @override
  $Res call({
    Object index = freezed,
  }) {
    return _then(_Deleted(
      index == freezed ? _value.index : index as int,
    ));
  }
}

class _$_Deleted implements _Deleted {
  const _$_Deleted(this.index) : assert(index != null);

  @override
  final int index;

  @override
  String toString() {
    return 'PostPhotoEvent.deleted(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Deleted &&
            (identical(other.index, index) ||
                const DeepCollectionEquality().equals(other.index, index)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(index);

  @override
  _$DeletedCopyWith<_Deleted> get copyWith =>
      __$DeletedCopyWithImpl<_Deleted>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result edited(int index, File file),
    @required Result deleted(int index),
    @required Result reordered(int to, int from),
    @required Result abort(),
    @required Result complete(DocumentReference reference),
    @required Result add(List<File> addedFiles),
  }) {
    assert(edited != null);
    assert(deleted != null);
    assert(reordered != null);
    assert(abort != null);
    assert(complete != null);
    assert(add != null);
    return deleted(index);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result edited(int index, File file),
    Result deleted(int index),
    Result reordered(int to, int from),
    Result abort(),
    Result complete(DocumentReference reference),
    Result add(List<File> addedFiles),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (deleted != null) {
      return deleted(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result edited(_Edited value),
    @required Result deleted(_Deleted value),
    @required Result reordered(_Reordered value),
    @required Result abort(_Abort value),
    @required Result complete(_Claim value),
    @required Result add(_Add value),
  }) {
    assert(edited != null);
    assert(deleted != null);
    assert(reordered != null);
    assert(abort != null);
    assert(complete != null);
    assert(add != null);
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result edited(_Edited value),
    Result deleted(_Deleted value),
    Result reordered(_Reordered value),
    Result abort(_Abort value),
    Result complete(_Claim value),
    Result add(_Add value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }
}

abstract class _Deleted implements PostPhotoEvent {
  const factory _Deleted(int index) = _$_Deleted;

  int get index;
  _$DeletedCopyWith<_Deleted> get copyWith;
}

abstract class _$ReorderedCopyWith<$Res> {
  factory _$ReorderedCopyWith(
          _Reordered value, $Res Function(_Reordered) then) =
      __$ReorderedCopyWithImpl<$Res>;
  $Res call({int to, int from});
}

class __$ReorderedCopyWithImpl<$Res> extends _$PostPhotoEventCopyWithImpl<$Res>
    implements _$ReorderedCopyWith<$Res> {
  __$ReorderedCopyWithImpl(_Reordered _value, $Res Function(_Reordered) _then)
      : super(_value, (v) => _then(v as _Reordered));

  @override
  _Reordered get _value => super._value as _Reordered;

  @override
  $Res call({
    Object to = freezed,
    Object from = freezed,
  }) {
    return _then(_Reordered(
      to == freezed ? _value.to : to as int,
      from == freezed ? _value.from : from as int,
    ));
  }
}

class _$_Reordered implements _Reordered {
  const _$_Reordered(this.to, this.from)
      : assert(to != null),
        assert(from != null);

  @override
  final int to;
  @override
  final int from;

  @override
  String toString() {
    return 'PostPhotoEvent.reordered(to: $to, from: $from)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Reordered &&
            (identical(other.to, to) ||
                const DeepCollectionEquality().equals(other.to, to)) &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(to) ^
      const DeepCollectionEquality().hash(from);

  @override
  _$ReorderedCopyWith<_Reordered> get copyWith =>
      __$ReorderedCopyWithImpl<_Reordered>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result edited(int index, File file),
    @required Result deleted(int index),
    @required Result reordered(int to, int from),
    @required Result abort(),
    @required Result complete(DocumentReference reference),
    @required Result add(List<File> addedFiles),
  }) {
    assert(edited != null);
    assert(deleted != null);
    assert(reordered != null);
    assert(abort != null);
    assert(complete != null);
    assert(add != null);
    return reordered(to, from);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result edited(int index, File file),
    Result deleted(int index),
    Result reordered(int to, int from),
    Result abort(),
    Result complete(DocumentReference reference),
    Result add(List<File> addedFiles),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (reordered != null) {
      return reordered(to, from);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result edited(_Edited value),
    @required Result deleted(_Deleted value),
    @required Result reordered(_Reordered value),
    @required Result abort(_Abort value),
    @required Result complete(_Claim value),
    @required Result add(_Add value),
  }) {
    assert(edited != null);
    assert(deleted != null);
    assert(reordered != null);
    assert(abort != null);
    assert(complete != null);
    assert(add != null);
    return reordered(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result edited(_Edited value),
    Result deleted(_Deleted value),
    Result reordered(_Reordered value),
    Result abort(_Abort value),
    Result complete(_Claim value),
    Result add(_Add value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (reordered != null) {
      return reordered(this);
    }
    return orElse();
  }
}

abstract class _Reordered implements PostPhotoEvent {
  const factory _Reordered(int to, int from) = _$_Reordered;

  int get to;
  int get from;
  _$ReorderedCopyWith<_Reordered> get copyWith;
}

abstract class _$AbortCopyWith<$Res> {
  factory _$AbortCopyWith(_Abort value, $Res Function(_Abort) then) =
      __$AbortCopyWithImpl<$Res>;
}

class __$AbortCopyWithImpl<$Res> extends _$PostPhotoEventCopyWithImpl<$Res>
    implements _$AbortCopyWith<$Res> {
  __$AbortCopyWithImpl(_Abort _value, $Res Function(_Abort) _then)
      : super(_value, (v) => _then(v as _Abort));

  @override
  _Abort get _value => super._value as _Abort;
}

class _$_Abort implements _Abort {
  const _$_Abort();

  @override
  String toString() {
    return 'PostPhotoEvent.abort()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Abort);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result edited(int index, File file),
    @required Result deleted(int index),
    @required Result reordered(int to, int from),
    @required Result abort(),
    @required Result complete(DocumentReference reference),
    @required Result add(List<File> addedFiles),
  }) {
    assert(edited != null);
    assert(deleted != null);
    assert(reordered != null);
    assert(abort != null);
    assert(complete != null);
    assert(add != null);
    return abort();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result edited(int index, File file),
    Result deleted(int index),
    Result reordered(int to, int from),
    Result abort(),
    Result complete(DocumentReference reference),
    Result add(List<File> addedFiles),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (abort != null) {
      return abort();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result edited(_Edited value),
    @required Result deleted(_Deleted value),
    @required Result reordered(_Reordered value),
    @required Result abort(_Abort value),
    @required Result complete(_Claim value),
    @required Result add(_Add value),
  }) {
    assert(edited != null);
    assert(deleted != null);
    assert(reordered != null);
    assert(abort != null);
    assert(complete != null);
    assert(add != null);
    return abort(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result edited(_Edited value),
    Result deleted(_Deleted value),
    Result reordered(_Reordered value),
    Result abort(_Abort value),
    Result complete(_Claim value),
    Result add(_Add value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (abort != null) {
      return abort(this);
    }
    return orElse();
  }
}

abstract class _Abort implements PostPhotoEvent {
  const factory _Abort() = _$_Abort;
}

abstract class _$ClaimCopyWith<$Res> {
  factory _$ClaimCopyWith(_Claim value, $Res Function(_Claim) then) =
      __$ClaimCopyWithImpl<$Res>;
  $Res call({DocumentReference reference});
}

class __$ClaimCopyWithImpl<$Res> extends _$PostPhotoEventCopyWithImpl<$Res>
    implements _$ClaimCopyWith<$Res> {
  __$ClaimCopyWithImpl(_Claim _value, $Res Function(_Claim) _then)
      : super(_value, (v) => _then(v as _Claim));

  @override
  _Claim get _value => super._value as _Claim;

  @override
  $Res call({
    Object reference = freezed,
  }) {
    return _then(_Claim(
      reference == freezed ? _value.reference : reference as DocumentReference,
    ));
  }
}

class _$_Claim implements _Claim {
  const _$_Claim(this.reference) : assert(reference != null);

  @override
  final DocumentReference reference;

  @override
  String toString() {
    return 'PostPhotoEvent.complete(reference: $reference)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Claim &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality()
                    .equals(other.reference, reference)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(reference);

  @override
  _$ClaimCopyWith<_Claim> get copyWith =>
      __$ClaimCopyWithImpl<_Claim>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result edited(int index, File file),
    @required Result deleted(int index),
    @required Result reordered(int to, int from),
    @required Result abort(),
    @required Result complete(DocumentReference reference),
    @required Result add(List<File> addedFiles),
  }) {
    assert(edited != null);
    assert(deleted != null);
    assert(reordered != null);
    assert(abort != null);
    assert(complete != null);
    assert(add != null);
    return complete(reference);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result edited(int index, File file),
    Result deleted(int index),
    Result reordered(int to, int from),
    Result abort(),
    Result complete(DocumentReference reference),
    Result add(List<File> addedFiles),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (complete != null) {
      return complete(reference);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result edited(_Edited value),
    @required Result deleted(_Deleted value),
    @required Result reordered(_Reordered value),
    @required Result abort(_Abort value),
    @required Result complete(_Claim value),
    @required Result add(_Add value),
  }) {
    assert(edited != null);
    assert(deleted != null);
    assert(reordered != null);
    assert(abort != null);
    assert(complete != null);
    assert(add != null);
    return complete(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result edited(_Edited value),
    Result deleted(_Deleted value),
    Result reordered(_Reordered value),
    Result abort(_Abort value),
    Result complete(_Claim value),
    Result add(_Add value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (complete != null) {
      return complete(this);
    }
    return orElse();
  }
}

abstract class _Claim implements PostPhotoEvent {
  const factory _Claim(DocumentReference reference) = _$_Claim;

  DocumentReference get reference;
  _$ClaimCopyWith<_Claim> get copyWith;
}

abstract class _$AddCopyWith<$Res> {
  factory _$AddCopyWith(_Add value, $Res Function(_Add) then) =
      __$AddCopyWithImpl<$Res>;
  $Res call({List<File> addedFiles});
}

class __$AddCopyWithImpl<$Res> extends _$PostPhotoEventCopyWithImpl<$Res>
    implements _$AddCopyWith<$Res> {
  __$AddCopyWithImpl(_Add _value, $Res Function(_Add) _then)
      : super(_value, (v) => _then(v as _Add));

  @override
  _Add get _value => super._value as _Add;

  @override
  $Res call({
    Object addedFiles = freezed,
  }) {
    return _then(_Add(
      addedFiles == freezed ? _value.addedFiles : addedFiles as List<File>,
    ));
  }
}

class _$_Add implements _Add {
  const _$_Add(this.addedFiles) : assert(addedFiles != null);

  @override
  final List<File> addedFiles;

  @override
  String toString() {
    return 'PostPhotoEvent.add(addedFiles: $addedFiles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Add &&
            (identical(other.addedFiles, addedFiles) ||
                const DeepCollectionEquality()
                    .equals(other.addedFiles, addedFiles)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(addedFiles);

  @override
  _$AddCopyWith<_Add> get copyWith =>
      __$AddCopyWithImpl<_Add>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result edited(int index, File file),
    @required Result deleted(int index),
    @required Result reordered(int to, int from),
    @required Result abort(),
    @required Result complete(DocumentReference reference),
    @required Result add(List<File> addedFiles),
  }) {
    assert(edited != null);
    assert(deleted != null);
    assert(reordered != null);
    assert(abort != null);
    assert(complete != null);
    assert(add != null);
    return add(addedFiles);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result edited(int index, File file),
    Result deleted(int index),
    Result reordered(int to, int from),
    Result abort(),
    Result complete(DocumentReference reference),
    Result add(List<File> addedFiles),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (add != null) {
      return add(addedFiles);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result edited(_Edited value),
    @required Result deleted(_Deleted value),
    @required Result reordered(_Reordered value),
    @required Result abort(_Abort value),
    @required Result complete(_Claim value),
    @required Result add(_Add value),
  }) {
    assert(edited != null);
    assert(deleted != null);
    assert(reordered != null);
    assert(abort != null);
    assert(complete != null);
    assert(add != null);
    return add(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result edited(_Edited value),
    Result deleted(_Deleted value),
    Result reordered(_Reordered value),
    Result abort(_Abort value),
    Result complete(_Claim value),
    Result add(_Add value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class _Add implements PostPhotoEvent {
  const factory _Add(List<File> addedFiles) = _$_Add;

  List<File> get addedFiles;
  _$AddCopyWith<_Add> get copyWith;
}
