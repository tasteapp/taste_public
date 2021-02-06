import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef ExpandBuilder = Widget Function(
    BuildContext context, bool isExpanded, VoidCallback toggler);

class ExpandWidget extends StatefulWidget {
  const ExpandWidget({@required this.builder, Key key}) : super(key: key);
  final ExpandBuilder builder;
  @override
  _ExpandWidgetState createState() => _ExpandWidgetState();
}

class _ExpandWidgetState extends State<ExpandWidget> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) => widget.builder(
      context, expanded, () => setState(() => expanded = !expanded));
}

class _ExpandableState extends ChangeNotifier {
  _ExpandableState(this._expanded);

  bool _expanded;
  bool get expanded => _expanded;
  set expanded(bool newValue) {
    _expanded = newValue;
    notifyListeners();
  }

  void toggle() {
    expanded = !expanded;
  }
}

class ExpandableProvider extends StatelessWidget {
  const ExpandableProvider({Key key, @required this.child}) : super(key: key);
  final Widget child;

  static void toggle(BuildContext context) =>
      context.read<_ExpandableState>().toggle();
  static void expand(BuildContext context) =>
      context.read<_ExpandableState>().expanded = true;
  static void setExpanded(BuildContext context, bool expanded) =>
      context.read<_ExpandableState>().expanded = expanded;

  static bool of(BuildContext context, {bool listen = true}) =>
      Provider.of<_ExpandableState>(context, listen: listen ?? true).expanded;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<_ExpandableState>(
        create: (_) => _ExpandableState(false),
        child: child,
      );
}
