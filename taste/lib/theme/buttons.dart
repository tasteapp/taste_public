import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/theme/style.dart';

part 'buttons.freezed.dart';

@freezed
abstract class TasteButtonOptions with _$TasteButtonOptions {
  const factory TasteButtonOptions({
    double elevation,
    double height,
    double width,
    EdgeInsetsGeometry padding,
    Color color,
    Color textColor,
    Color disabledColor,
    Color disabledTextColor,
    Color splashColor,
    FontWeight fontWeight,
    double fontSize,
    double iconSize,
    EdgeInsetsGeometry iconPadding,
    BorderSide borderSide,
  }) = _TasteButtonOptions;
}

const kDefaultButtonOptions = TasteButtonOptions(
  fontWeight: FontWeight.bold,
  iconSize: 18,
  iconPadding: EdgeInsets.zero,
);

final kTastePrimaryButtonOptions = kDefaultButtonOptions.copyWith(
  color: kPrimaryButtonColor,
  textColor: Colors.white,
  disabledTextColor: Colors.grey,
  height: 32.0,
);

final kTasteSecondaryButtonOptions = kTastePrimaryButtonOptions.copyWith(
  color: kSecondaryButtonColor,
  textColor: const Color(0xFF3A3B41),
);

final kSimpleButtonOptions = kDefaultButtonOptions.copyWith(
  color: Colors.white,
  textColor: const Color(0xFF3A3B41),
  borderSide: const BorderSide(color: Color(0xD8D8D8D8), width: 2.0),
  elevation: 0,
);

class TasteButton extends StatelessWidget {
  const TasteButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.iconData,
    @required this.options,
  }) : super(key: key);

  final String text;
  final IconData iconData;
  final VoidCallback onPressed;
  final TasteButtonOptions options;

  @override
  Widget build(BuildContext context) {
    final textWidget = AutoSizeText(text,
        style: TextStyle(
          color: options.textColor,
          fontWeight: options.fontWeight,
          fontFamily: 'Quicksand',
          fontSize: options.fontSize,
        ),
        maxLines: 1);
    if (iconData != null) {
      return Container(
        height: options.height,
        width: options.width,
        child: RaisedButton.icon(
          icon: Padding(
            padding: options.iconPadding ?? EdgeInsets.zero,
            child: Icon(
              iconData,
              size: options.iconSize,
              color: options.textColor,
            ),
          ),
          label: textWidget,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
            side: options.borderSide ?? BorderSide.none,
          ),
          color: options.color,
          colorBrightness: Brightness.light,
          textColor: options.textColor,
          disabledColor: options.disabledColor,
          disabledTextColor: options.disabledTextColor,
          elevation: options.elevation,
          splashColor: options.splashColor,
        ),
      );
    }
    return Container(
      height: options.height,
      width: options.width,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
          side: options.borderSide ?? BorderSide.none,
        ),
        color: options.color,
        textColor: options.textColor,
        disabledColor: options.disabledColor,
        disabledTextColor: options.disabledTextColor,
        padding: options.padding,
        elevation: options.elevation,
        child: textWidget,
      ),
    );
  }
}
