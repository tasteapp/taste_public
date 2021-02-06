import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/email_view.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/utils/analytics.dart';

final facebookLogin = FacebookLogin();
const kDefaultFBPermissions = ['email'];

enum LoginType {
  fb,
  apple,
  google,
  guest,
  email,
}

extension LoginTypeExtension on LoginType {
  String get key => toString().split('.').last;
  bool get canLink => _provider != null;
  Future link(FirebaseUser user) => _provider.link(user);
  Future login() => (_provider?.signIn ?? _signIns[this])();

  _Provider get _provider => _providers[this];
}

// IMPLEMENTATION BELOW

final _providers = {
  LoginType.fb: _Provider<Object>(
    () async => MapEntry(
        FacebookAuthProvider.getCredential(
            accessToken: (await facebookLogin.logIn(kDefaultFBPermissions))
                ?.accessToken
                ?.token),
        null),
    facebookLogin.logOut,
  ),
  LoginType.google: _Provider<Object>(
    () async {
      final auth = await (await _googleSignIn.signIn())?.authentication;
      return MapEntry(
          GoogleAuthProvider.getCredential(
              idToken: auth?.idToken, accessToken: auth?.accessToken),
          null);
    },
    _googleSignIn.signOut,
  ),
  LoginType.apple: _Provider<AppleIdCredential>(
    () async {
      final result = await AppleSignIn.performRequests([
        const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);
      if (result.status != AuthorizationStatus.authorized) {
        throw Exception('not authorized');
      }
      return MapEntry(
          _appleProvider.getCredential(
            idToken: String.fromCharCodes(result.credential.identityToken),
            accessToken:
                String.fromCharCodes(result.credential.authorizationCode),
          ),
          result.credential);
    },
    null,
    (user, result) => user.updateProfile(UserUpdateInfo()
      ..displayName =
          "${result.fullName.givenName} ${result.fullName.familyName}"),
  ),
};

final _signIns = {
  LoginType.guest: FirebaseAuth.instance.signInAnonymously,
  LoginType.email: () => TAPage.email_view(widget: EmailView(false)),
};

final _googleSignIn = GoogleSignIn();
const _appleProvider = OAuthProvider(providerId: "apple.com");

class _Provider<T> {
  const _Provider(this.compute, [this.logOut, this.onSignedIn]);
  final Future<MapEntry<AuthCredential, T>> Function() compute;
  final _LogOut logOut;
  final _OnSignIn<T> onSignedIn;
  Future<AuthResult> _do(
      Future<AuthResult> Function(AuthCredential creds) fn) async {
    await logOut?.call()?.catchError((_) => null);
    final _creds = await compute();
    final user = await fn(_creds.key);
    onSignedIn?.call(user?.user, _creds.value);
    return user;
  }

  Future<AuthResult> signIn() =>
      _do(FirebaseAuth.instance.signInWithCredential);
  Future<AuthResult> link(FirebaseUser user) async {
    final result = await _do(user.linkWithCredential);
    unawaited(_updateUserRecord(result?.user));
    return result;
  }
}

typedef _LogOut = Future Function();
typedef _OnSignIn<T> = Function(FirebaseUser user, T creds);

Future _updateUserRecord(FirebaseUser user) async {
  final firebasePhoto =
      user.providerData.map((e) => e.photoUrl).withoutEmpties.firstOrNull ?? '';
  final batch = Firestore.instance.batch();
  final tasteUser = await cachedLoggedInUser;
  final tastePhoto = tasteUser.profileImage() ?? '';
  batch.updateData(tasteUser.reference, {'guest_mode': false});
  if (firebasePhoto.isNotEmpty && tastePhoto.isEmpty) {
    batch.updateData(tasteUser.reference, {'photo_url': firebasePhoto});
  }
  return batch.commit();
}
