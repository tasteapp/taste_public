import 'dart:math';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taste/app_config.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/utils.dart';

class AppsFlyerEvents {
  static const APP_OPENED = "af_app_opened";
  static const LOGIN = "af_login";
  static const SIGN_UP = "af_sign_up";
  static const SHARE = "af_share";
  static const INVITE = "af_invite";
}

class AppsflyerManager {
  AppsflyerManager._()
      : appsFlyer = AppsflyerSdk(AppsFlyerOptions(
            afDevKey: "APPSFLYER_DEV_KEY",
            showDebug: true,
            appId: "APPSFLYER_APP_ID"));

  Future initSdk() async {
    if (isDev) {
      return;
    }
    await appsFlyer.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true);
    appsFlyer.conversionDataStream.listen(registerConversion);
    unawaited(sendEvent(AppsFlyerEvents.APP_OPENED));
  }

  static AppsflyerManager _instance;
  static AppsflyerManager get instance => _instance ??= AppsflyerManager._();
  final AppsflyerSdk appsFlyer;

  void registerConversion(Map<dynamic, dynamic> data) {
    bool success = ((data['status'] ?? '') as String) == 'success';
    if (!success) {
      TAEvent.attribution_failure();
      return;
    }
    final payload = data['data'] as Map<dynamic, dynamic>;
    // Only take the first 100 characters of the event parameter value.
    final result = payload.withoutNulls.map(
      (key, value) => MapEntry(
          key as String,
          value.runtimeType == String
              ? (value as String).substring(
                  0,
                  min((value as String).length, 100),
                )
              : value),
    );
    TAEvent.attribution_success(result);
  }

  Future<bool> registerLogin(TasteUser user) async {
    final prefs = await SharedPreferences.getInstance();
    bool eventSuccess = true;
    if (!(prefs.getBool('sent_sign_up_event') ?? false) &&
        DateTime.now()
            .subtract(const Duration(minutes: 5))
            .isBefore(user.createdAt.toDate())) {
      unawaited(prefs.setBool('sent_sign_up_event', true));
      eventSuccess = await sendEvent(AppsFlyerEvents.SIGN_UP);
    }
    return eventSuccess && await sendEvent(AppsFlyerEvents.LOGIN);
  }

  Future<bool> sendEvent(String eventName,
      {Map<dynamic, dynamic> eventValues = const {}}) async {
    if (isDev) {
      return true;
    }
    bool result;
    try {
      result = await appsFlyer.trackEvent(eventName, eventValues);
    } on Exception catch (e) {
      print("Error tracking event: $e");
      result = false;
    }
    print("Result trackEvent: $result");
    return result;
  }
}
