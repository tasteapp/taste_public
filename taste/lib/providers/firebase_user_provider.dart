import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/utils/analytics.dart';

import '../utils/extensions.dart';

part 'firebase_user_provider.freezed.dart';

@freezed
abstract class TasteFirebaseUser implements _$TasteFirebaseUser {
  factory TasteFirebaseUser.user(FirebaseUser user) = _User;
  factory TasteFirebaseUser.neverLoggedIn() = _Never;
  factory TasteFirebaseUser.loggedOut() = _LoggedOut;
  factory TasteFirebaseUser.initial() = _Initial;
}

extension TasteFirebaseUserExt on TasteFirebaseUser {
  bool get loggedIn => maybeMap(user: (_) => true, orElse: () => false);
}

extension TasteFirebaseUserStreamExt on ValueStream<TasteFirebaseUser> {
  Future get waitForLogin async => firstWhere((x) => x.loggedIn);
}

final tasteFirebaseUser = FirebaseAuth.instance.onAuthStateChanged
    .doOnError((e, s) => Crashlytics.instance.recordError(e, s as StackTrace))
    .map((user) => user != null
        ? TasteFirebaseUser.user(user)
        : TasteFirebaseUser.loggedOut())
    .sideEffect((u) => u.maybeWhen(
          user: (u) => analytics.logLogin(
              loginMethod:
                  u?.providerData?.lastOrNull?.providerId ?? 'unknown'),
          orElse: () => null,
        ))
    .shareValueSeeded(TasteFirebaseUser.initial());
