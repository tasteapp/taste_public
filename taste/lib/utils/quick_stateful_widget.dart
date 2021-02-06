import 'package:deferrable/deferrable.dart';
import 'package:flutter/material.dart';

/// Convenience widget when state is very narrow in scope and it feels more
/// natural to have an `init` and `build` method inline.
class QuickStatefulWidget<T> extends StatefulWidget {
  const QuickStatefulWidget(
      {Key key, @required this.builder, @required this.initState})
      : super(key: key);
  final T Function(QuickStatefulWidgetState<T> state) initState;
  final Widget Function(BuildContext context, QuickStatefulWidgetState<T> state)
      builder;

  @override
  QuickStatefulWidgetState<T> createState() => QuickStatefulWidgetState();
}

class QuickStatefulWidgetState<T> extends State<QuickStatefulWidget<T>>
    with Deferrable {
  T t;
  @override
  void initState() {
    super.initState();
    t = widget.initState(this);
  }

  void quickSet(Function() fn) => isDisposed ? null : setState(fn);

  @override
  Widget build(BuildContext context) => widget.builder(context, this);
}
