import 'package:flutter/material.dart';
import 'package:taste/theme/style.dart';

import '../app_config.dart';

class TasteBrand extends StatelessWidget {
  const TasteBrand({
    this.showLogo = true,
    this.size = 45,
    this.showText = true,
  })  : assert(showLogo != null || showText != null),
        assert(size != null);
  final bool showLogo;
  final double size;
  final bool showText;

  @override
  Widget build(BuildContext context) =>
      Row(mainAxisSize: MainAxisSize.min, children: [
        Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Image.asset(
              'assets/ui/taste_logo_with_text.png',
              height: size * 1.4,
            )),
      ]);
}
