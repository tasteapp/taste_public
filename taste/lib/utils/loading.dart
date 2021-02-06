import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

import 'extensions.dart';
import 'logging.dart';

final isLoadingProvider = ValueListenableProvider.value(value: _notifier);

class RootLoadingWidget extends StatelessWidget {
  const RootLoadingWidget({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
      fit: StackFit.expand,
      children: [
        child,
        _isLoading(context)
            ? AbsorbPointer(
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: _spinner(context) ?? const CircularProgressIndicator(),
                ),
              )
            : null
      ].withoutNulls);
}

Future<T> spinner<T>(Future<T> Function() fn,
    {Widget spinner, Function(dynamic error, StackTrace s) onError}) async {
  _notifier.value = _yes(spinner);
  //ignore: avoid_types_on_closure_parameters
  final t = await fn().catchError((e, StackTrace s) {
    unawaited(Crashlytics.instance.recordError(e, s));
    logger.e("Failed on Spinner", e, s);
    onError?.call(e, s);
  });
  _notifier.value = _no;
  return t;
}

/// Only shows if the top-level spinner is not showing
/// This prevents duplicate spinners from showing.
class DeferringSpinner extends StatelessWidget {
  const DeferringSpinner({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Visibility(
      visible: !_isLoading(context),
      child: const Center(child: CircularProgressIndicator()));
}

bool _isLoading(BuildContext context) => Provider.of<_Wrap>(context).loading;

class _Wrap {
  const _Wrap(this.loading, this.spinner);
  final bool loading;
  final Widget spinner;
}

Widget _spinner(BuildContext context) => Provider.of<_Wrap>(context).spinner;

_Wrap _yes([Widget spinner]) => _Wrap(true, spinner);
const _no = _Wrap(false, null);

final _notifier = ValueNotifier(_no);
