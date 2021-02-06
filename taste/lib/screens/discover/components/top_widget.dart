import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataHolder<T> extends StatelessWidget {
  const DataHolder({this.data, this.child});
  final T data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider.value(value: data, child: child);
  }
}

abstract class DataRequester<T> extends StatelessWidget {
  const DataRequester({Key key}) : super(key: key);
  Widget dataBuild(BuildContext context, T data);

  @override
  Widget build(BuildContext context) =>
      dataBuild(context, Provider.of(context, listen: true));
}
