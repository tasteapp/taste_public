import 'package:flutter/material.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/logging.dart';
import 'package:taste_protos/taste_protos.dart' show Reaction;

enum CountValue {
  up,
  down,
  love,
  trophy,
}

extension ReactionExtension on Reaction {
  CountValue get baseReaction => CountValue.values.firstWhere(
      (element) => element.toString().split('.').last == name,
      orElse: () => null);
}

extension ExtEnum on CountValue {
  Widget icon({double size = 25}) {
    final icon = {
      CountValue.up: Image.asset(
        'assets/ui/thumbs_up.png',
        height: size * 0.9,
        width: size * 0.9,
      ),
      CountValue.down: Image.asset(
        'assets/ui/thumbs_down.png',
        height: size * 0.9,
        width: size * 0.9,
      ),
      CountValue.love: Icon(
        Icons.favorite_border,
        size: size,
        color: const Color(0xFF97CD84),
      ),
      CountValue.trophy: Icon(
        Icons.stars,
        color: kTasteThumbUpDownColor,
        size: size,
      )
    }[this];
    if (icon != null) {
      return icon;
    }
    logger.w('Unexpected reaction in review: $this');
    return Icon(
      Icons.error,
      color: Colors.grey,
      size: size,
    );
  }
}
