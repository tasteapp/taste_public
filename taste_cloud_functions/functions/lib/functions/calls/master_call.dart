import 'package:taste_cloud_functions/taste_functions.dart';

final TransactionFn tasteCall = (_) async {};

void register() {
  // TODO(team): deprecated, remove soon.
  registerCallFn(tasteCall, 'tasteCall');
}
