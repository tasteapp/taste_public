import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/components/nav/nav.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste_protos/gen/analytics.pbenum.dart';

import 'utils.dart';

export 'package:taste_protos/gen/analytics.pbenum.dart';

final analytics = FirebaseAnalytics();
const kMaxParameterValueLength = 100;

enum TasteNavigatorType {
  base,
  logged_in,
}
// Must be getter, cannot share instances across multiple navigators.
List<NavigatorObserver> navigatorObservers(TasteNavigatorType type) => [
      HeroController(),
      FirebaseAnalyticsObserver(
          analytics: analytics,
          nameExtractor: (s) => s.name == '/'
              ? (type == TasteNavigatorType.logged_in
                  ? (currentTabPage?.name ?? '')
                  : TAPage.base_log_in_page.name)
              : s.name)
    ];

//ignore: avoid_void_async
void _tasteEvent(TAEvent event, [Map<String, dynamic> parameters]) async {
  final name = event.name;
  // https://firebase.google.com/docs/reference/cpp/group/event-names
  assert(name.length <= 40);
  parameters ??= {};
  parameters = parameters.mapValue((_, v) => v is bool ? v ? 1 : 0 : v)
    ..addAll({'user': (await FirebaseAuth.instance.currentUser())?.uid ?? ''})
    ..removeWhere((key, value) => value == null);

  // Validate parameters.
  for (final entry in parameters.entries) {
    String error;
    if (entry.value is String) {
      if ((entry.value as String).length > kMaxParameterValueLength) {
        error = 'parameter value for event $name/${entry.key} exceeded limit:'
            ' ${entry.value}';
      }
    } else if (entry.value is! num) {
      error = 'invalid parameter value for $name/${entry.key}: ${entry.value}';
    }
    if (error != null) {
      unawaited(Crashlytics.instance.recordError(error, null));
    }
  }

  return analytics.logEvent(name: name, parameters: parameters);
}

extension TAEventExt on TAEvent {
  void call([Map<String, dynamic> params]) => _tasteEvent(this, params);
}

extension TATabExtension on TATab {
  TAPage get page => const {
        TATab.discover_tab: TAPage.discover_root,
        TATab.food_finder_tab: TAPage.food_finder_root,
        TATab.create_tab: TAPage.create_root,
        TATab.map_tab: TAPage.map_root,
        TATab.profile_tab: TAPage.profile_root,
      }[this];
}

extension TAPageExt on TAPage {
  Future<T> call<T>({Widget widget, WidgetBuilder builder}) =>
      quickPush(this, builder ?? (_) => widget);
}
