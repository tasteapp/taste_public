import 'package:expire_cache/expire_cache.dart';

final _cache = ExpireCache<Object, String>(
    sizeLimit: 200, expireDuration: const Duration(days: 1));

final persistFormField = _cache.set;
final getPersistedFormField = _cache.get;
