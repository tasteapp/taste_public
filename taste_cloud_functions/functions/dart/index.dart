import 'package:node_interop/node.dart';
import 'package:node_interop/util.dart';
import 'package:taste_cloud_functions/taste_functions.dart';

void registerJs() {
  final jsFunctions = require('./js_functions/index.js');

  final keys = objectKeys(jsFunctions);
  for (var i = 0; i < keys.length; i++) {
    final key = keys[i];
    final fn = getProperty(jsFunctions, key);
    setExport(key, fn);
  }
}

void main() {
  require('source-map-support/register');
  CloudTransformProvider.initialize();
  registerTasteFunctions();
  registerJs();
}
