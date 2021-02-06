import 'package:flutter/material.dart';
import 'package:taste/screens/onboarding/onboarding_screen.dart';

class DiscoverOnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const OnboardingScreen(info: [
        OnboardingTabInfo(
            description:
                "See your friend\'s latest posts and the tastiest new meals!",
            assetPath: "assets/onboarding/friends_latest.gif"),
        OnboardingTabInfo(
            description:
                "Switch between nearby, recent, or most popular posts on Taste.",
            assetPath: "assets/onboarding/nearby_recent_popular.gif"),
        OnboardingTabInfo(
            description: "Like, bookark, comment, or check out a recipe.",
            assetPath: "assets/onboarding/like_bookmark_recipe.gif"),
        OnboardingTabInfo(
            description: "Swipe between posts!",
            assetPath: "assets/onboarding/swipe_discover_posts.gif"),
      ]);
}

// TODO: create one for Search, Posting, Map, and Profile.
