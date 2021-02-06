import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taste/components/taste_brand.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/utils.dart';
import 'package:vector_math/vector_math_64.dart';

const double kIntroImageWidth = 340;
const kAnimationDuration = Duration(milliseconds: 400);
const kAnimationCurve = Curves.easeOut;
const kNumTabs = 2;

class IntroTabs extends StatefulWidget {
  @override
  _IntroTabsState createState() => _IntroTabsState();
}

// Needs to be stateful for pages w/ dotted indicator.
class _IntroTabsState extends State<IntroTabs> {
  final PreloadPageController controller = PreloadPageController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (controller.page >= kNumTabs - 1) {
                controller.jumpToPage(0);
                return;
              }
              controller.nextPage(
                duration: kAnimationDuration,
                curve: kAnimationCurve,
              );
            });
          },
          child: PreloadPageView(
            scrollDirection: Axis.horizontal,
            controller: controller,
            children: [
              Container(),
              Container(),
              Container(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: IntroView(pageController: controller),
        ),
        Align(
          alignment: const Alignment(0.0, 0.9),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SmoothPageIndicator(
              effect: ColorTransitionEffect(
                dotHeight: 10,
                dotWidth: 10,
                radius: 5,
                activeDotColor: kDarkGrey,
                dotColor: kDarkGrey.withOpacity(0.3),
                spacing: 16.0,
              ),
              controller: controller,
              count: 2,
            ),
          ),
        ),
        AnimatedBackgroundObject(
          assetPath: 'assets/ui/log_in_green_bean.png',
          pageController: controller,
          translations: _greenTranslations,
          rotations: _greenRotations,
          imageSize: _greenSize,
        ),
        AnimatedBackgroundObject(
          assetPath: 'assets/ui/log_in_yellow_bean_right.png',
          pageController: controller,
          translations: _yellowTranslations,
          rotations: _yellowRotations,
          imageSize: _yellowSize,
        ),
      ],
    );
  }
}

// z-values ignored. Axis values multiplied by screen extent on axis.
const _greenTranslations = <List<double>>[
  [-0.66, -0.15, 0],
  [-0.66, -0.15, 0],
  [-0.5, -0.25, 0],
];
const _greenRotations = <List<double>>[
  [0, 0, -1.5 * pi / 6],
  [0, 0, 0],
  [0, 0, .8 * pi / 6],
];
const _greenSize = Size(398, 521);

const _yellowTranslations = <List<double>>[
  [0.76, 0.15, 0],
  [0.76, 0.15, 0],
  [0.58, 0.1, 0],
];
const _yellowRotations = <List<double>>[
  [0, 0, -1.5 * pi / 6],
  [0, 0, 0],
  [0, 0, .8 * pi / 6],
];
const _yellowSize = Size(398, 521);

class AnimatedBackgroundObject extends StatelessWidget {
  const AnimatedBackgroundObject({
    Key key,
    this.pageController,
    this.assetPath,
    this.width,
    this.height,
    this.translations,
    this.rotations,
    this.scales,
    this.imageSize,
  }) : super(key: key);

  final PreloadPageController pageController;
  final String assetPath;
  final double width;
  final double height;
  final List<List<double>> translations;
  final List<List<double>> rotations;
  final List<List<double>> scales;
  final Size imageSize;

  @override
  Widget build(BuildContext context) {
    final pageIndex = pageController.page?.round() ?? 0;
    final size = MediaQuery.of(context).size;
    final transformMatrix = Matrix4.identity()
      ..translate(
        translations[pageIndex][0] * size.width,
        translations[pageIndex][1] * size.height,
        // translations[pageIndex][2],
      )
      // Translate to origin and then back so that rotations are about center of
      // image.
      ..translate(imageSize.width / 2, imageSize.height / 2, 0)
      ..rotateX(rotations[pageIndex][0])
      ..rotateY(rotations[pageIndex][1])
      // ..rotateZ(rotations[pageIndex][2])
      ..translate(-imageSize.width / 2, -imageSize.height / 2, 0);
    return IgnorePointer(
      child: AnimatedContainer(
        duration: kAnimationDuration,
        curve: kAnimationCurve,
        transform: transformMatrix,
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
          width: size.width * 398 / 414,
        ),
      ),
    );
  }
}

class IntroView extends StatefulWidget {
  const IntroView({Key key, this.pageController}) : super(key: key);

  final PreloadPageController pageController;

  @override
  _IntroViewState createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final pageIndices = () {
    final result = [0, 1, 2]; //..shuffle();
    // Emit an event based on which tab was shown first to the user.
    [
      // TAEvent.intro_tabs_share_your_taste,
      TAEvent.intro_tabs_discover_new_food,
      TAEvent.intro_tabs_remember_your_eats,
    ][result.first]();
    return result;
  }();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentPage = widget.pageController.page?.round() ?? 0;
    return Column(
      children: [
        SizedBox(height: size.height * 0.1),
        TasteBrand(showText: false, size: size.height < 300 ? 33 : 38),
        SizedBox(height: size.height * 0.03),
        Expanded(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              IntroContent(
                visible: currentPage == pageIndices[0],
                title: 'Discover Amazing Food',
                subtitle: 'We will give you the best recommendations based on '
                    'what you like. The more you use the app the better our '
                    'recommendations get!',
                imageAssetPath: 'assets/ui/log_in_asset_page_2.png',
              ),
              IntroContent(
                visible: currentPage == pageIndices[1],
                title: 'Remember Your Eats',
                subtitle: 'Keep all of your food memories in one place, from '
                    'home-cooked masterpieces to dining discoveries!',
                imageAssetPath: 'assets/ui/log_in_asset_page_3.png',
              ),
              // IntroContent(
              //   visible: currentPage == pageIndices[2],
              //   title: 'Share Your Taste',
              //   subtitle: 'Finally, an app for all your food photos!',
              //   imageAssetPath: 'assets/ui/log_in_asset_page_1.png',
              // ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.08),
      ],
    );
  }
}

const _tasteTextColor = Color(0xFF88C77D);

class IntroContent extends StatelessWidget {
  const IntroContent({
    Key key,
    this.visible,
    this.title,
    this.subtitle,
    this.imageAssetPath,
  }) : super(key: key);

  final bool visible;
  final String title;
  final String subtitle;
  final String imageAssetPath;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = TextStyle(
      fontFamily: 'Quicksand',
      fontSize: size.height < 600 ? 28 : 32,
      fontWeight: FontWeight.bold,
      color: kDarkGrey,
    );
    return AnimatedOpacity(
      curve: kAnimationCurve,
      duration: kAnimationDuration,
      opacity: visible ? 1 : 0,
      child: Column(
        children: [
          // Special case to highlight "Taste" on first page.
          title != 'Share Your Taste'
              ? Text(
                  title,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                )
              : RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    // set the default style for the children TextSpans
                    style: titleStyle,
                    children: const [
                      TextSpan(
                        text: 'Share Your ',
                      ),
                      TextSpan(
                        text: 'Taste',
                        style: TextStyle(color: _tasteTextColor),
                      ),
                    ],
                  ),
                ),
          const SizedBox(height: 15),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 65,
              maxWidth: size.width * 0.75,
            ),
            child: AutoSizeText(
              subtitle,
              style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ),
          Expanded(
            child: IgnorePointer(
              child: Image.asset(
                imageAssetPath,
                fit: BoxFit.contain,
                width: size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
