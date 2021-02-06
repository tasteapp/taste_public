import 'package:flutter/material.dart';
import 'package:taste/components/taste_brand.dart';
import 'package:taste/theme/style.dart';

class TasteLargeCircularProgressIndicator extends StatelessWidget {
  const TasteLargeCircularProgressIndicator({this.size = 55.0});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: const Alignment(0.0, 0.0),
            child: SizedBox(
                height: size,
                width: size,
                child: const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(kTasteBrandColorLeft)))),
        // Align(
        //   alignment: const Alignment(0.0, 0.0),
        //   child: Image.asset(
        //     'assets/ui/taste_logo.png',
        //     height: 35.0,
        //   ),
        // )
      ],
    );
  }
}
