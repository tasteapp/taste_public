import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/components/taste_brand.dart';

class NotSupportedPage extends StatelessWidget {
  const NotSupportedPage();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TasteBrand(size: 38),
          const SizedBox(height: 40),
          Icon(
            Icons.warning,
            color: Colors.orange[300],
            size: 36.0,
          ),
          const Padding(
            padding: EdgeInsets.all(26.0),
            child: AutoSizeText(
              "Things are moving very fast around here!\n\n"
              "Please update the app to continue using Taste, and thanks for "
              "your understanding while getting Taste off the ground!",
              maxFontSize: 36,
              minFontSize: 16,
              maxLines: 7,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
