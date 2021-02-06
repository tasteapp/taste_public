@JS()
library mailchimp;

import 'package:js/js.dart';
import 'package:node_interop/node.dart';

@JS()
@anonymous
abstract class JsMailchimp {
  external Promise batch(List l);
  external Promise get(String s);
  external Promise delete(String s);
  external Promise post(String s, Object args);
  external Promise put(String s, Object args);
}
