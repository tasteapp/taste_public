import 'package:taste_cloud_functions/taste_functions.dart';

final fnRegistry = BiMap<Object, String>();

void registerFunction(String name, Object tasteFn, Object cloudFn) {
  functions[name] = cloudFn;
  fnRegistry[tasteFn] = name;
}

String tasteFnName(Object tasteFn) => fnRegistry[tasteFn];
dynamic tasteFnByName(String name) => fnRegistry.inverse[name];
