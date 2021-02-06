import 'package:flutter/material.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/badge.dart';
import 'package:taste/utils/utils.dart';

import 'character_level_page.dart';

class CharacterLevelDialog extends StatelessWidget {
  const CharacterLevelDialog({Key key, @required this.spirit})
      : super(key: key);
  final FoodSpirit spirit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToLevelPage(context),
      child: Dialog(
        insetAnimationDuration: const Duration(seconds: 1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "You unlocked a new Taste Food Spirit: ${spirit.name}!",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Builder(
                  builder: (context) => FoodSpiritIcon(
                        spirit: spirit,
                        alignment: Alignment.bottomCenter,
                        size: MediaQuery.of(context).size.shortestSide * 0.5,
                      )),
            ],
          ),
        ),
      ),
    );
  }

  Future goToLevelPage(BuildContext context) async {
    final user = await cachedLoggedInUser;
    Navigator.pop(context);
    await quickPush(
        TAPage.user_level_page, (context) => CharacterLevelPage(user: user));
  }
}
