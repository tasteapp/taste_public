import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/collection.dart';
import 'package:taste/utils/extensions.dart';

/// Caches values [V] on [K] computed using [compute].
/// Expires value either by LRU [maxSize] or [expire] [Duration].
/// Returns value as [ValueNotifier] if computation is async.
mixin TasteFutureCache<K, V> {
  /// Returns cached or computed value for [k].
  /// [ValueNotifier] is used instead of [Future] to make the state queryable.
  ValueNotifier<V> find(K k);
}

/// Standard implementation of [TasteFutureCache].
TasteFutureCache<K, V> tasteFutureCache<K, V>(FutureOr<V> Function(K k) compute,
        {int maxSize = 500, Duration expire = const Duration(days: 1)}) =>
    _TasteFutureCache<K, V>(LruMap(maximumSize: maxSize), compute, expire);

class _TasteFutureCache<K, V> with TasteFutureCache<K, V> {
  _TasteFutureCache(this._cache, this._compute, this._expire);
  final LruMap<K, ZipTuple<ValueNotifier<V>, DateTime>> _cache;
  final FutureOr<V> Function(K k) _compute;
  final Duration _expire;
  @override
  ValueNotifier<V> find(K k) {
    final now = DateTime.now();
    if (_cache.containsKey(k)) {
      final v = _cache[k];
      if (v.b + _expire < now) {
        _cache.remove(k);
        return find(k);
      }
      return v.a;
    }
    return _cache.putIfAbsent(k, () {
      final notifier = ValueNotifier<V>(null);
      () async {
        notifier.value = await _compute(k);
      }();
      return notifier.tupled(now);
    }).a;
  }
}
