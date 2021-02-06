import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taste/components/nav/nav.dart';

void tasteSnackBar(Widget widget,
    {Duration duration, Function() action, String actionLabel}) {
  assert(!((action == null) ^ (actionLabel == null)));
  activeScaffold.showSnackBar(
    widget is SnackBar
        ? widget
        : SnackBar(
            content: widget,
            behavior: SnackBarBehavior.floating,
            duration: duration ?? const Duration(seconds: 7),
            action: action == null
                ? null
                : SnackBarAction(
                    label: actionLabel,
                    onPressed: action,
                  ),
          ),
  );
}

void snackBarString(String string,
    {int seconds, Function() action, String actionLabel}) {
  hideSnackBar();
  tasteSnackBar(Text(string),
      duration: seconds == null ? null : Duration(seconds: seconds),
      action: action,
      actionLabel: actionLabel);
}

void hideSnackBar() => activeScaffold.hideCurrentSnackBar();
