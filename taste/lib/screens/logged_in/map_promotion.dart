import 'dart:async';

import 'package:localstorage/localstorage.dart';
import 'package:rxdart/rxdart.dart';

const _key = 'active';
final _storage = LocalStorage('clicked-taste-map', null, {_key: true});

final mapPromotionActiveStream = _storage.stream
    .map((event) => event[_key] as bool)
    .shareValueSeeded(false)
      ..listen((_) {});

Future completeMapPromotion() => _storage.setItem(_key, false);
