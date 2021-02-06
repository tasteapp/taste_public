import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/onboarding/onboarding_provider.dart';
import 'package:taste/utils/extensions.dart';
import 'package:video_player/video_player.dart';

class OnboardingTabInfo {
  const OnboardingTabInfo({this.description, this.assetPath});
  final String description;
  final String assetPath;
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key key, @required this.info}) : super(key: key);

  final List<OnboardingTabInfo> info;

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool shrinkView = false;

  List<Widget> _buildPageIndicator() => List<Widget>.generate(
      widget.info.length,
      (i) => i == _currentPage ? _indicator(true) : _indicator(false)).toList();

  Widget _indicator(bool isActive) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        height: 8.0,
        width: isActive ? 24.0 : 16.0,
        decoration: BoxDecoration(
          color: isActive ? Colors.white : const Color(0xFF03360E),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.4, 0.7, 0.9],
                colors: [
                  Color(0xFF16AA37),
                  Color(0xFF0D7D26),
                  Color(0xFF036319),
                  Color(0xFF044713),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height -
                        (shrinkView ? 220 : 120),
                    child: PageView(
                        physics: const ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (page) =>
                            setState(() => _currentPage = page),
                        children: widget.info
                            .map((info) => OnboardingScreenPage(
                                description: info.description,
                                assetPath: info.assetPath,
                                shrinkView: shrinkView))
                            .toList()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          onPressed: stopOnboarding,
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            if (isNotLast) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                              return;
                            }
                            stopOnboarding();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isNotLast ? 'Next' : 'Get Started!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isNotLast ? 22.0 : 24.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              if (isNotLast)
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                )
                            ].withoutNulls,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void stopOnboarding() {
    setState(() => shrinkView = true);
    Provider.of<OnboardingProvider>(context, listen: false).stopOnboarding();
    Navigator.pop(context);
  }

  bool get isNotLast => _currentPage != widget.info.length - 1;
}

class OnboardingScreenPage extends StatelessWidget {
  const OnboardingScreenPage(
      {Key key, this.description, this.assetPath, this.shrinkView})
      : super(key: key);
  final String description;
  final String assetPath;
  final bool shrinkView;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              width: 315,
              child: Center(
                  child: AutoSizeText(
                description,
                minFontSize: 20.0,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              )),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Image.asset(
                assetPath,
                height: MediaQuery.of(context).size.height -
                    (shrinkView ? 280 : 210),
              ),
            ),
          ],
        ),
      );
}
