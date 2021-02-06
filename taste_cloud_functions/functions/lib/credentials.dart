import 'package:taste_cloud_functions/taste_functions.dart';

Map<String, String> buildTypeCredentialsMap() {
  switch (buildType) {
    case BuildType.test:
      return null;
    case BuildType.prod:
      return {}; // Add prod Firebase credentials as map
    case BuildType.dev:
      return {}; // Add dev Firebase credentials as map
  }
  return null;
}
