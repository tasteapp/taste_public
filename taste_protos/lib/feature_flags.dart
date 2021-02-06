import 'gen/feature_flags.pbenum.dart' show FeatureFlag;
export 'gen/feature_flags.pbenum.dart' show FeatureFlag;

const Set<FeatureFlag> _enabledFeatures = {FeatureFlag.daily_tasty};

var enableAllFeatureFlags = false;

extension FeatureFlagExtension on FeatureFlag {
  bool get isEnabled =>
      enableAllFeatureFlags || _enabledFeatures.contains(this);
}
