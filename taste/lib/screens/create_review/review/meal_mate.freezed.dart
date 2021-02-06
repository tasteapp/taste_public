// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'meal_mate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$MealMateTearOff {
  const _$MealMateTearOff();

  _SearchResult searchResult(SearchResult searchResult) {
    return _SearchResult(
      searchResult,
    );
  }

  _User user({@required TasteUser user, String profilePic}) {
    return _User(
      user: user,
      profilePic: profilePic,
    );
  }

  _ItemUser itemUser(DiscoverItem_User itemUser) {
    return _ItemUser(
      itemUser,
    );
  }
}

// ignore: unused_element
const $MealMate = _$MealMateTearOff();

mixin _$MealMate {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result searchResult(SearchResult searchResult),
    @required Result user(TasteUser user, String profilePic),
    @required Result itemUser(DiscoverItem_User itemUser),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result searchResult(SearchResult searchResult),
    Result user(TasteUser user, String profilePic),
    Result itemUser(DiscoverItem_User itemUser),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result searchResult(_SearchResult value),
    @required Result user(_User value),
    @required Result itemUser(_ItemUser value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result searchResult(_SearchResult value),
    Result user(_User value),
    Result itemUser(_ItemUser value),
    @required Result orElse(),
  });
}

abstract class $MealMateCopyWith<$Res> {
  factory $MealMateCopyWith(MealMate value, $Res Function(MealMate) then) =
      _$MealMateCopyWithImpl<$Res>;
}

class _$MealMateCopyWithImpl<$Res> implements $MealMateCopyWith<$Res> {
  _$MealMateCopyWithImpl(this._value, this._then);

  final MealMate _value;
  // ignore: unused_field
  final $Res Function(MealMate) _then;
}

abstract class _$SearchResultCopyWith<$Res> {
  factory _$SearchResultCopyWith(
          _SearchResult value, $Res Function(_SearchResult) then) =
      __$SearchResultCopyWithImpl<$Res>;
  $Res call({SearchResult searchResult});
}

class __$SearchResultCopyWithImpl<$Res> extends _$MealMateCopyWithImpl<$Res>
    implements _$SearchResultCopyWith<$Res> {
  __$SearchResultCopyWithImpl(
      _SearchResult _value, $Res Function(_SearchResult) _then)
      : super(_value, (v) => _then(v as _SearchResult));

  @override
  _SearchResult get _value => super._value as _SearchResult;

  @override
  $Res call({
    Object searchResult = freezed,
  }) {
    return _then(_SearchResult(
      searchResult == freezed
          ? _value.searchResult
          : searchResult as SearchResult,
    ));
  }
}

class _$_SearchResult extends _SearchResult {
  _$_SearchResult(this.searchResult)
      : assert(searchResult != null),
        super._();

  @override
  final SearchResult searchResult;

  bool _didusername = false;
  String _username;

  @override
  String get username {
    if (_didusername == false) {
      _didusername = true;
      _username = when(
        searchResult: (s) => s.username,
        user: (user, _) => user.username,
        itemUser: (user) => user.name,
      );
    }
    return _username;
  }

  bool _didname = false;
  String _name;

  @override
  String get name {
    if (_didname == false) {
      _didname = true;
      _name = when(
        searchResult: (s) => s.name,
        user: (user, _) => user.name,
        itemUser: (user) => user.name,
      );
    }
    return _name;
  }

  bool _didphoto = false;
  String _photo;

  @override
  String get photo {
    if (_didphoto == false) {
      _didphoto = true;
      _photo = when(
        searchResult: (s) => s.photo,
        user: (_, photo) => photo,
        itemUser: (user) => user.photo,
      );
    }
    return _photo;
  }

  bool _didref = false;
  DocumentReference _ref;

  @override
  DocumentReference get ref {
    if (_didref == false) {
      _didref = true;
      _ref = when(
        searchResult: (s) => s.reference,
        user: (user, _) => user.reference,
        itemUser: (user) => user.reference.ref,
      );
    }
    return _ref;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SearchResult &&
            (identical(other.searchResult, searchResult) ||
                const DeepCollectionEquality()
                    .equals(other.searchResult, searchResult)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(searchResult);

  @override
  _$SearchResultCopyWith<_SearchResult> get copyWith =>
      __$SearchResultCopyWithImpl<_SearchResult>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result searchResult(SearchResult searchResult),
    @required Result user(TasteUser user, String profilePic),
    @required Result itemUser(DiscoverItem_User itemUser),
  }) {
    assert(searchResult != null);
    assert(user != null);
    assert(itemUser != null);
    return searchResult(this.searchResult);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result searchResult(SearchResult searchResult),
    Result user(TasteUser user, String profilePic),
    Result itemUser(DiscoverItem_User itemUser),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (searchResult != null) {
      return searchResult(this.searchResult);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result searchResult(_SearchResult value),
    @required Result user(_User value),
    @required Result itemUser(_ItemUser value),
  }) {
    assert(searchResult != null);
    assert(user != null);
    assert(itemUser != null);
    return searchResult(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result searchResult(_SearchResult value),
    Result user(_User value),
    Result itemUser(_ItemUser value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (searchResult != null) {
      return searchResult(this);
    }
    return orElse();
  }
}

abstract class _SearchResult extends MealMate {
  _SearchResult._() : super._();
  factory _SearchResult(SearchResult searchResult) = _$_SearchResult;

  SearchResult get searchResult;
  _$SearchResultCopyWith<_SearchResult> get copyWith;
}

abstract class _$UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  $Res call({TasteUser user, String profilePic});
}

class __$UserCopyWithImpl<$Res> extends _$MealMateCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object user = freezed,
    Object profilePic = freezed,
  }) {
    return _then(_User(
      user: user == freezed ? _value.user : user as TasteUser,
      profilePic:
          profilePic == freezed ? _value.profilePic : profilePic as String,
    ));
  }
}

class _$_User extends _User {
  _$_User({@required this.user, this.profilePic})
      : assert(user != null),
        super._();

  @override
  final TasteUser user;
  @override
  final String profilePic;

  bool _didusername = false;
  String _username;

  @override
  String get username {
    if (_didusername == false) {
      _didusername = true;
      _username = when(
        searchResult: (s) => s.username,
        user: (user, _) => user.username,
        itemUser: (user) => user.name,
      );
    }
    return _username;
  }

  bool _didname = false;
  String _name;

  @override
  String get name {
    if (_didname == false) {
      _didname = true;
      _name = when(
        searchResult: (s) => s.name,
        user: (user, _) => user.name,
        itemUser: (user) => user.name,
      );
    }
    return _name;
  }

  bool _didphoto = false;
  String _photo;

  @override
  String get photo {
    if (_didphoto == false) {
      _didphoto = true;
      _photo = when(
        searchResult: (s) => s.photo,
        user: (_, photo) => photo,
        itemUser: (user) => user.photo,
      );
    }
    return _photo;
  }

  bool _didref = false;
  DocumentReference _ref;

  @override
  DocumentReference get ref {
    if (_didref == false) {
      _didref = true;
      _ref = when(
        searchResult: (s) => s.reference,
        user: (user, _) => user.reference,
        itemUser: (user) => user.reference.ref,
      );
    }
    return _ref;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.profilePic, profilePic) ||
                const DeepCollectionEquality()
                    .equals(other.profilePic, profilePic)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(profilePic);

  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result searchResult(SearchResult searchResult),
    @required Result user(TasteUser user, String profilePic),
    @required Result itemUser(DiscoverItem_User itemUser),
  }) {
    assert(searchResult != null);
    assert(user != null);
    assert(itemUser != null);
    return user(this.user, profilePic);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result searchResult(SearchResult searchResult),
    Result user(TasteUser user, String profilePic),
    Result itemUser(DiscoverItem_User itemUser),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (user != null) {
      return user(this.user, profilePic);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result searchResult(_SearchResult value),
    @required Result user(_User value),
    @required Result itemUser(_ItemUser value),
  }) {
    assert(searchResult != null);
    assert(user != null);
    assert(itemUser != null);
    return user(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result searchResult(_SearchResult value),
    Result user(_User value),
    Result itemUser(_ItemUser value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (user != null) {
      return user(this);
    }
    return orElse();
  }
}

abstract class _User extends MealMate {
  _User._() : super._();
  factory _User({@required TasteUser user, String profilePic}) = _$_User;

  TasteUser get user;
  String get profilePic;
  _$UserCopyWith<_User> get copyWith;
}

abstract class _$ItemUserCopyWith<$Res> {
  factory _$ItemUserCopyWith(_ItemUser value, $Res Function(_ItemUser) then) =
      __$ItemUserCopyWithImpl<$Res>;
  $Res call({DiscoverItem_User itemUser});
}

class __$ItemUserCopyWithImpl<$Res> extends _$MealMateCopyWithImpl<$Res>
    implements _$ItemUserCopyWith<$Res> {
  __$ItemUserCopyWithImpl(_ItemUser _value, $Res Function(_ItemUser) _then)
      : super(_value, (v) => _then(v as _ItemUser));

  @override
  _ItemUser get _value => super._value as _ItemUser;

  @override
  $Res call({
    Object itemUser = freezed,
  }) {
    return _then(_ItemUser(
      itemUser == freezed ? _value.itemUser : itemUser as DiscoverItem_User,
    ));
  }
}

class _$_ItemUser extends _ItemUser {
  _$_ItemUser(this.itemUser)
      : assert(itemUser != null),
        super._();

  @override
  final DiscoverItem_User itemUser;

  bool _didusername = false;
  String _username;

  @override
  String get username {
    if (_didusername == false) {
      _didusername = true;
      _username = when(
        searchResult: (s) => s.username,
        user: (user, _) => user.username,
        itemUser: (user) => user.name,
      );
    }
    return _username;
  }

  bool _didname = false;
  String _name;

  @override
  String get name {
    if (_didname == false) {
      _didname = true;
      _name = when(
        searchResult: (s) => s.name,
        user: (user, _) => user.name,
        itemUser: (user) => user.name,
      );
    }
    return _name;
  }

  bool _didphoto = false;
  String _photo;

  @override
  String get photo {
    if (_didphoto == false) {
      _didphoto = true;
      _photo = when(
        searchResult: (s) => s.photo,
        user: (_, photo) => photo,
        itemUser: (user) => user.photo,
      );
    }
    return _photo;
  }

  bool _didref = false;
  DocumentReference _ref;

  @override
  DocumentReference get ref {
    if (_didref == false) {
      _didref = true;
      _ref = when(
        searchResult: (s) => s.reference,
        user: (user, _) => user.reference,
        itemUser: (user) => user.reference.ref,
      );
    }
    return _ref;
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ItemUser &&
            (identical(other.itemUser, itemUser) ||
                const DeepCollectionEquality()
                    .equals(other.itemUser, itemUser)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(itemUser);

  @override
  _$ItemUserCopyWith<_ItemUser> get copyWith =>
      __$ItemUserCopyWithImpl<_ItemUser>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result searchResult(SearchResult searchResult),
    @required Result user(TasteUser user, String profilePic),
    @required Result itemUser(DiscoverItem_User itemUser),
  }) {
    assert(searchResult != null);
    assert(user != null);
    assert(itemUser != null);
    return itemUser(this.itemUser);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result searchResult(SearchResult searchResult),
    Result user(TasteUser user, String profilePic),
    Result itemUser(DiscoverItem_User itemUser),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (itemUser != null) {
      return itemUser(this.itemUser);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result searchResult(_SearchResult value),
    @required Result user(_User value),
    @required Result itemUser(_ItemUser value),
  }) {
    assert(searchResult != null);
    assert(user != null);
    assert(itemUser != null);
    return itemUser(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result searchResult(_SearchResult value),
    Result user(_User value),
    Result itemUser(_ItemUser value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (itemUser != null) {
      return itemUser(this);
    }
    return orElse();
  }
}

abstract class _ItemUser extends MealMate {
  _ItemUser._() : super._();
  factory _ItemUser(DiscoverItem_User itemUser) = _$_ItemUser;

  DiscoverItem_User get itemUser;
  _$ItemUserCopyWith<_ItemUser> get copyWith;
}
