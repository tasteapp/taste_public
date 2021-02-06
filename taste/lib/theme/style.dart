import 'package:flutter/material.dart';
import 'package:taste/screens/logged_in/logged_in.dart';

final kTasteTheme = ThemeData(
  primaryColor: kPrimaryBackgroundColor,
  fontFamily: 'Quicksand',
);

const kTasteBrandColorLeft = Color(0xFF4E9C46);
const kTasteBrandColorRight = Color(0xFF16aa37);
const kTasteBrandColor = activeNavColor;
const kScaffoldBackgroundColor = Color(0xFFEFEFEF);

const kAppBarTitleStyle = TextStyle(
  fontSize: 18,
  fontFamily: "Quicksand",
  fontWeight: FontWeight.bold,
);

/// "Natural Color System" yellow.
/// https://en.wikipedia.org/wiki/Shades_of_yellow
const kTasteThumbUpDownColor = Color(0xFFFFD300);

const kPrimaryButtonColor = Color(0xFF97CD84);
const kPrimaryBackgroundColor = Color(0xFFFAFAFA);
const kSecondaryButtonColor = Color(0xFFEEA23E);

const kDarkGrey = Color(0xFF2F3542);

const kChipPadding = EdgeInsets.only(left: 10, top: 6, bottom: 6);
const kChipLabelPadding =
    EdgeInsets.only(left: 0, right: 20, top: 5, bottom: 5);
const kChipElevation = 0.0;
const kChipBackgroundColor = Color(0xFFD8D8D8);
const kChipActiveColor = Color(0xFFFFBB68);
const kChipTextColor = kDarkGrey;

class TasteChoiceChip extends StatelessWidget {
  const TasteChoiceChip({
    Key key,
    @required this.selected,
    @required this.text,
    @required this.onSelected,
    this.icon,
    this.padding,
  }) : super(key: key);

  final bool selected;
  final String text;
  final ValueChanged<bool> onSelected;
  final Widget icon;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      backgroundColor: kChipBackgroundColor,
      elevation: kChipElevation,
      padding: padding == null ? kChipPadding : null,
      labelPadding: padding ?? kChipLabelPadding,
      selected: selected,
      onSelected: onSelected,
      avatar: icon,
      selectedColor: kChipActiveColor,
      label: Text(text),
      labelStyle: const TextStyle(
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w600,
        color: kChipTextColor,
        fontSize: 14,
      ),
    );
  }
}

class TasteDialog extends StatelessWidget {
  const TasteDialog({
    Key key,
    this.title,
    this.content,
    this.buttons,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.scrollable = false,
  }) : super(key: key);

  final String title;
  final Widget content;
  final List<Widget> buttons;
  final EdgeInsetsGeometry contentPadding;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      scrollable: scrollable,
      title: title != null ? Text(title) : null,
      content: content,
      actions: buttons,
      contentPadding: contentPadding,
    );
  }
}

class TasteDialogButton extends StatelessWidget {
  const TasteDialogButton({
    Key key,
    @required this.text,
    this.color = kPrimaryButtonColor,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Color color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 18.0, color: color)),
    );
  }
}

class TasteMaterialPageRoute<T> extends MaterialPageRoute<T> {
  /// Construct a TasteMaterialPageRoute whose contents are defined by [builder].
  ///
  /// The values of [builder], [maintainState], and [fullScreenDialog] must not
  /// be null.
  TasteMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    this.transitionsTheme,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        assert(opaque),
        super(
            builder: builder,
            settings: settings,
            maintainState: maintainState,
            fullscreenDialog: fullscreenDialog);

  /// Controls the transition type of the route.
  final PageTransitionsTheme transitionsTheme;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final PageTransitionsTheme theme =
        transitionsTheme ?? Theme.of(context).pageTransitionsTheme;
    return theme.buildTransitions<T>(
        this, context, animation, secondaryAnimation, child);
  }
}
