import 'package:taste_cloud_functions/taste_functions.dart';

class Environment {
  final BuildType buildType;
  final String id;
  final String apiKey;
  Algolia get init => Algolia.init(apiKey: apiKey, applicationId: id);

  Environment(this.buildType, this.id, this.apiKey);
}

final environments = [
  Environment(BuildType.dev, 'DEV_PROJECT_ID', 'API_KEY_DEV'),
  Environment(BuildType.test, 'TEST_PROJECT_ID', 'API_KEY_TEST'),
  Environment(BuildType.prod, 'PROD_PROJECT_ID', 'API_KEY_PROD'),
].asMap().map((_, v) => MapEntry(v.buildType, v));
