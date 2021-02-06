import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ValueStreamBuilder<T> extends StatefulWidget {
  const ValueStreamBuilder(
      {Key key, @required this.stream, @required this.builder})
      : super(key: key);
  final ValueStream<T> stream;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot)
      builder;

  @override
  _ValueStreamBuilderState<T> createState() => _ValueStreamBuilderState();
}

class _ValueStreamBuilderState<T> extends State<ValueStreamBuilder<T>> {
  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: widget.stream,
      initialData: widget.stream.value,
      builder: widget.builder);
}
