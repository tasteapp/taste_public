import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/utils/utils.dart';

/// Request user action by showing a Snackbar with some message and an 'Open'
/// action button. If set, the request will be asked every `requestEvery`
/// duration. Returns whether the user action was displayed.
/// If the user opens the requested action, it'll be recorded and never
/// requested again.
Future<bool> requestUserAction({
  @required TasteUser user,
  @required String actionId,
  @required String requestMessage,
  @required Future<void> Function() openAction,
  String actionLabel = 'Open',
  Future<bool> Function() requestPredicate = alwaysTrue,
  Duration minDurationSinceAccountCreate = Duration.zero,
  Duration requestEvery = Duration.zero,
}) async {
  final prefs = await SharedPreferences.getInstance();

  final String openedActionKey = '${actionId}_seen';
  final hasOpenedAction = prefs.getBool(openedActionKey) ?? false;
  final String requestTimeKey = '${actionId}_request_time';
  final lastRequestTime =
      DateTime.fromMillisecondsSinceEpoch(prefs.getInt(requestTimeKey) ?? 0);
  final durationSinceLastRequest = DateTime.now().difference(lastRequestTime);
  final userCreateTime = user.createTime;

  final userCreateTimeSatisfied =
      DateTime.now().difference(userCreateTime) > minDurationSinceAccountCreate;
  final firstRequest = lastRequestTime.millisecondsSinceEpoch == 0;
  final isFirstAndOnlyRequest = requestEvery == Duration.zero && firstRequest;
  final isValidRepeatedRequest =
      durationSinceLastRequest >= requestEvery && requestEvery > Duration.zero;

  if ((await requestPredicate()) &&
      userCreateTimeSatisfied &&
      !hasOpenedAction &&
      (isFirstAndOnlyRequest || isValidRepeatedRequest)) {
    tasteSnackBar(SnackBar(
      content: Text(requestMessage),
      action: SnackBarAction(
        label: actionLabel,
        onPressed: () async {
          unawaited(prefs.setBool(openedActionKey, true));
          hideSnackBar();
          await openAction();
        },
      ),
      duration: const Duration(seconds: 12),
    ));
    unawaited(
        prefs.setInt(requestTimeKey, DateTime.now().millisecondsSinceEpoch));
    return true;
  }
  return false;
}
