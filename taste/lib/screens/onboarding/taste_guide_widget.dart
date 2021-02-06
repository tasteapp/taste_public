import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:taste/screens/onboarding/onboarding_provider.dart';
import 'package:taste/screens/onboarding/tab_screens.dart';
import 'package:taste/theme/buttons.dart';
import 'package:taste/utils/utils.dart';
import 'package:tuple/tuple.dart';

class GuideWidget extends StatefulWidget {
  const GuideWidget({this.onboardingKey, this.size = 24.0});

  final String onboardingKey;
  final double size;

  @override
  GuideWidgetState createState() => GuideWidgetState();
}

class GuideWidgetState extends State<GuideWidget> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((duration) async {
      await Future.delayed(const Duration(seconds: 6));
      await FeatureDiscovery.clearPreferences(
          context, <String>{widget.onboardingKey});
      FeatureDiscovery.discoverFeatures(
          context, <String>{widget.onboardingKey});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DescribedFeatureOverlay(
        featureId: widget.onboardingKey,
        tapTarget: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Icon(Icons.info),
        ),
        tapTargetRadius: 30.0,
        backgroundColor: Colors.transparent,
        backgroundRadius: 2.0,
        targetColor: kTastePrimaryButtonOptions.color.withOpacity(0.6),
        textColor: Colors.white,
        onComplete: () async {
          unawaited(startOnboarding());
          return true;
        },
        barrierDismissible: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: IconButton(
            onPressed: startOnboarding,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.info),
          ),
        ),
      );

  Tuple2<TAPage, Widget> onboardingWidgetInfo() {
    switch (widget.onboardingKey) {
      case kDiscoverOnboardingKey:
        return Tuple2(
            TAPage.discover_onboarding_page, DiscoverOnboardingScreen());
      default:
        return const Tuple2(null, null);
    }
  }

  Future startOnboarding() async {
    await Future.delayed(const Duration(milliseconds: 10));
    Provider.of<OnboardingProvider>(context, listen: false)
        .startOnboarding(widget.onboardingKey);
    Tuple2<TAPage, Widget> widgetInfo = onboardingWidgetInfo();
    await FeatureDiscovery.clearPreferences(
        context, <String>{widget.onboardingKey});
    await quickPush(widgetInfo.item1, (context) => widgetInfo.item2);
  }
}
