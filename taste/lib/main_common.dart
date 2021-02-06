import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/appsflyer.dart';
import 'package:taste/utils/proto_transforms.dart';
import 'package:taste_protos/taste_protos.dart';
import 'package:timezone/data/latest_2015-2025.dart' as tz;

import 'app_config.dart';
import 'providers/global_setup.dart';
import 'taste_app.dart';

Future get mainCommon async {
  TasteTransformProvider.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  //ignore: unnecessary_statements
  myLocationStream;
  globalSetup();
  enableAllFeatureFlags |= isDev;
  tz.initializeTimeZones();
  await [
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    analytics.setAnalyticsCollectionEnabled(isDev || kReleaseMode),
    analytics.logAppOpen(),
    AppsflyerManager.instance.initSdk(),
  ].wait;
  Crashlytics.instance.enableInDevMode = false;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(const TasteApp());
}
