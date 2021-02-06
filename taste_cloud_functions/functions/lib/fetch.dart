import 'package:node_interop/node.dart';
import 'package:node_interop/util.dart';

final _fetch = require('node-fetch');
final _formData = require('form-data');
Future<Map<String, dynamic>> postJson(
    String url, Map<String, String> body) async {
  final form = callConstructor(_formData, []);
  body.forEach((k, v) => callMethod(form, 'append', [k, v]));
  return dartify(await promiseToFuture(callMethod(
      await promiseToFuture(_fetch(
          url,
          jsify({
            'method': 'POST',
            'body': form,
          })) as Promise),
      'json',
      []) as Promise));
}
