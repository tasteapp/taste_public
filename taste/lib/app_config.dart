import 'package:taste/algolia/config.dart';

bool isDev;

AlgoliaConfig get algoliaConfig => isDev ? devConfig : prodConfig;

bool get isProd => !isDev;
String get googleApiKey => isDev
    ? 'DEV_GOOGLE_API_KEY'
    : 'PRODUCTION_GOOGLE_API_KEY';
