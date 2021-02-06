// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'firebase_user_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$TasteFirebaseUserTearOff {
  const _$TasteFirebaseUserTearOff();

  _User user(FirebaseUser user) {
    return _User(
      user,
    );
  }

  _Never neverLoggedIn() {
    return _Never();
  }

  _LoggedOut loggedOut() {
    return _LoggedOut();
  }

  _Initial initial() {
    return _Initial();
  }
}

// ignore: unused_element
const $TasteFirebaseUser = _$TasteFirebaseUserTearOff();

mixin _$TasteFirebaseUser {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result user(FirebaseUser user),
    @required Result neverLoggedIn(),
    @required Result loggedOut(),
    @required Result initial(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result user(FirebaseUser user),
    Result neverLoggedIn(),
    Result loggedOut(),
    Result initial(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result user(_User value),
    @required Result neverLoggedIn(_Never value),
    @required Result loggedOut(_LoggedOut value),
    @required Result initial(_Initial value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result user(_User value),
    Result neverLoggedIn(_Never value),
    Result loggedOut(_LoggedOut value),
    Result initial(_Initial value),
    @required Result orElse(),
  });
}

abstract class $TasteFirebaseUserCopyWith<$Res> {
  factory $TasteFirebaseUserCopyWith(
          TasteFirebaseUser value, $Res Function(TasteFirebaseUser) then) =
      _$TasteFirebaseUserCopyWithImpl<$Res>;
}

class _$TasteFirebaseUserCopyWithImpl<$Res>
    implements $TasteFirebaseUserCopyWith<$Res> {
  _$TasteFirebaseUserCopyWithImpl(this._value, this._then);

  final TasteFirebaseUser _value;
  // ignore: unused_field
  final $Res Function(TasteFirebaseUser) _then;
}

abstract class _$UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  $Res call({FirebaseUser user});
}

class __$UserCopyWithImpl<$Res> extends _$TasteFirebaseUserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object user = freezed,
  }) {
    return _then(_User(
      user == freezed ? _value.user : user as FirebaseUser,
    ));
  }
}

class _$_User implements _User {
  _$_User(this.user) : assert(user != null);

  @override
  final FirebaseUser user;

  @override
  String toString() {
    return 'TasteFirebaseUser.user(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);

  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result user(FirebaseUser user),
    @required Result neverLoggedIn(),
    @required Result loggedOut(),
    @required Result initial(),
  }) {
    assert(user != null);
    assert(neverLoggedIn != null);
    assert(loggedOut != null);
    assert(initial != null);
    return user(this.user);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result user(FirebaseUser user),
    Result neverLoggedIn(),
    Result loggedOut(),
    Result initial(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (user != null) {
      return user(this.user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result user(_User value),
    @required Result neverLoggedIn(_Never value),
    @required Result loggedOut(_LoggedOut value),
    @required Result initial(_Initial value),
  }) {
    assert(user != null);
    assert(neverLoggedIn != null);
    assert(loggedOut != null);
    assert(initial != null);
    return user(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result user(_User value),
    Result neverLoggedIn(_Never value),
    Result loggedOut(_LoggedOut value),
    Result initial(_Initial value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (user != null) {
      return user(this);
    }
    return orElse();
  }
}

abstract class _User implements TasteFirebaseUser {
  factory _User(FirebaseUser user) = _$_User;

  FirebaseUser get user;
  _$UserCopyWith<_User> get copyWith;
}

abstract class _$NeverCopyWith<$Res> {
  factory _$NeverCopyWith(_Never value, $Res Function(_Never) then) =
      __$NeverCopyWithImpl<$Res>;
}

class __$NeverCopyWithImpl<$Res> extends _$TasteFirebaseUserCopyWithImpl<$Res>
    implements _$NeverCopyWith<$Res> {
  __$NeverCopyWithImpl(_Never _value, $Res Function(_Never) _then)
      : super(_value, (v) => _then(v as _Never));

  @override
  _Never get _value => super._value as _Never;
}

class _$_Never implements _Never {
  _$_Never();

  @override
  String toString() {
    return 'TasteFirebaseUser.neverLoggedIn()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Never);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result user(FirebaseUser user),
    @required Result neverLoggedIn(),
    @required Result loggedOut(),
    @required Result initial(),
  }) {
    assert(user != null);
    assert(neverLoggedIn != null);
    assert(loggedOut != null);
    assert(initial != null);
    return neverLoggedIn();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result user(FirebaseUser user),
    Result neverLoggedIn(),
    Result loggedOut(),
    Result initial(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (neverLoggedIn != null) {
      return neverLoggedIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result user(_User value),
    @required Result neverLoggedIn(_Never value),
    @required Result loggedOut(_LoggedOut value),
    @required Result initial(_Initial value),
  }) {
    assert(user != null);
    assert(neverLoggedIn != null);
    assert(loggedOut != null);
    assert(initial != null);
    return neverLoggedIn(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result user(_User value),
    Result neverLoggedIn(_Never value),
    Result loggedOut(_LoggedOut value),
    Result initial(_Initial value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (neverLoggedIn != null) {
      return neverLoggedIn(this);
    }
    return orElse();
  }
}

abstract class _Never implements TasteFirebaseUser {
  factory _Never() = _$_Never;
}

abstract class _$LoggedOutCopyWith<$Res> {
  factory _$LoggedOutCopyWith(
          _LoggedOut value, $Res Function(_LoggedOut) then) =
      __$LoggedOutCopyWithImpl<$Res>;
}

class __$LoggedOutCopyWithImpl<$Res>
    extends _$TasteFirebaseUserCopyWithImpl<$Res>
    implements _$LoggedOutCopyWith<$Res> {
  __$LoggedOutCopyWithImpl(_LoggedOut _value, $Res Function(_LoggedOut) _then)
      : super(_value, (v) => _then(v as _LoggedOut));

  @override
  _LoggedOut get _value => super._value as _LoggedOut;
}

class _$_LoggedOut implements _LoggedOut {
  _$_LoggedOut();

  @override
  String toString() {
    return 'TasteFirebaseUser.loggedOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _LoggedOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result user(FirebaseUser user),
    @required Result neverLoggedIn(),
    @required Result loggedOut(),
    @required Result initial(),
  }) {
    assert(user != null);
    assert(neverLoggedIn != null);
    assert(loggedOut != null);
    assert(initial != null);
    return loggedOut();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result user(FirebaseUser user),
    Result neverLoggedIn(),
    Result loggedOut(),
    Result initial(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loggedOut != null) {
      return loggedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result user(_User value),
    @required Result neverLoggedIn(_Never value),
    @required Result loggedOut(_LoggedOut value),
    @required Result initial(_Initial value),
  }) {
    assert(user != null);
    assert(neverLoggedIn != null);
    assert(loggedOut != null);
    assert(initial != null);
    return loggedOut(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result user(_User value),
    Result neverLoggedIn(_Never value),
    Result loggedOut(_LoggedOut value),
    Result initial(_Initial value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loggedOut != null) {
      return loggedOut(this);
    }
    return orElse();
  }
}

abstract class _LoggedOut implements TasteFirebaseUser {
  factory _LoggedOut() = _$_LoggedOut;
}

abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

class __$InitialCopyWithImpl<$Res> extends _$TasteFirebaseUserCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

class _$_Initial implements _Initial {
  _$_Initial();

  @override
  String toString() {
    return 'TasteFirebaseUser.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result user(FirebaseUser user),
    @required Result neverLoggedIn(),
    @required Result loggedOut(),
    @required Result initial(),
  }) {
    assert(user != null);
    assert(neverLoggedIn != null);
    assert(loggedOut != null);
    assert(initial != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result user(FirebaseUser user),
    Result neverLoggedIn(),
    Result loggedOut(),
    Result initial(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result user(_User value),
    @required Result neverLoggedIn(_Never value),
    @required Result loggedOut(_LoggedOut value),
    @required Result initial(_Initial value),
  }) {
    assert(user != null);
    assert(neverLoggedIn != null);
    assert(loggedOut != null);
    assert(initial != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result user(_User value),
    Result neverLoggedIn(_Never value),
    Result loggedOut(_LoggedOut value),
    Result initial(_Initial value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements TasteFirebaseUser {
  factory _Initial() = _$_Initial;
}
