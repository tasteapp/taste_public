import 'package:flutter/foundation.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final onboardingProvider =
    ChangeNotifierProvider.value(value: OnboardingProvider());

const kDiscoverOnboardingKey = 'discover_onboarding';
const kSearchOnboardingKey = 'search_onboarding';
const kPostingOnboardingKey = 'posting_onboarding';
const kMapOnboardingKey = 'map_onboarding';
const kProfileOnboardingKey = 'profile_onboarding';

const kOnboardingKeys = [
  kDiscoverOnboardingKey,
  kSearchOnboardingKey,
  kPostingOnboardingKey,
  kMapOnboardingKey,
  kProfileOnboardingKey
];

class OnboardingProvider extends ChangeNotifier {
  OnboardingProvider() {
    setup();
  }

  bool isOnboarding = false;
  Map<String, bool> onboardingStatus = {};

  Future setup() async {
    final preferences = await SharedPreferences.getInstance();
    kOnboardingKeys.forEach((key) => onboardingStatus[key] =
        preferences.containsKey(key) && preferences.getBool(key));
    notifyListeners();
  }

  bool getStatus(String key) =>
      onboardingStatus[kDiscoverOnboardingKey] ?? true;

  void startOnboarding(String key) {
    isOnboarding = true;
    onboardingStatus[key] = true;
    unawaited(markAsOnboarded(key));
    notifyListeners();
  }

  void stopOnboarding() {
    isOnboarding = false;
    notifyListeners();
  }

  Future markAsOnboarded(String key) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, true);
  }
}
