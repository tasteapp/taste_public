import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_config.dart';

class _Wrap {
  const _Wrap(this.value);
  final bool value;
}

final _tasteDebugMode = ValueNotifier(const _Wrap(false));
bool tasteDebugMode(BuildContext context) =>
    !isProd && Provider.of<_Wrap>(context).value;
final tasteDebugModeProvider = isProd
    ? Provider.value(value: const _Wrap(false))
    : ValueListenableProvider.value(value: _tasteDebugMode);
void toggleTasteDebugMode() =>
    _tasteDebugMode.value = _Wrap(!_tasteDebugMode.value.value);
