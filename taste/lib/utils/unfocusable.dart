import 'package:flutter/widgets.dart';

class Unfocusable extends StatelessWidget {
  const Unfocusable({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => keyboardUnfocus(context),
      child: child,
    );
  }
}

// Hide keyboard:
// https://stackoverflow.com/questions/51652897/how-to-hide-soft-input-keyboard-on-flutter-after-clicking-outside-textfield-anyw
void keyboardUnfocus(BuildContext context) => FocusScope.of(context).unfocus();
