import 'package:taste_cloud_functions/taste_functions.dart';

/// `Status` is a return-type for a specific request.
///
/// If the request was successful, then `Status` holds the return-value in
/// `value`.
///
/// Otherwise, it returns a `reason` for the failure.
///
/// As return-values must be json-serializable, `toMap` must be called to create
/// returnable type to the client.
///
/// Some conveniences are also provided, including converting `reference` types
/// into a well-known `map` of `{reference: "reference-string"}`, as well as
/// making sure `Status` values are not double-wrapped via `wrap`.
class Status<T> {
  final String _reason;
  final T _value;
  Status._(this._value, this._reason);
  factory Status.value(T value) => Status<T>._(value, null);
  static final Status<String> ok = Status.value('');
  factory Status.fail(String reason) => Status._(null, reason);
  bool get isSuccess => _reason == null;
  String get reason => isSuccess ? null : _reason;
  T get value => isSuccess ? _value : null;
  Map<String, dynamic> get toMap =>
      {'success': isSuccess, 'reason': reason, 'value': mapifyValue};

  dynamic get mapifyValue => mapify(value);

  static dynamic mapify<T>(T value) {
    if (value is DocumentReference) {
      return {'reference': value.path};
    }
    if (value is TasteResponse) {
      return mapify<GeneratedMessage>(value.proto);
    }
    if (value is GeneratedMessage) {
      return mapify<Map>(value.asJson);
    }
    if (value is Map) {
      return value.map((k, v) => MapEntry(k, mapify(v)));
    }
    if (value is Iterable) {
      return value.map(mapify).toList();
    }
    return value;
  }

  static Status<dynamic> wrap(dynamic p) {
    if (p is Status) {
      return p;
    }
    return Status.value(p);
  }

  /// Returns a `Status` object indicating a failure.
  factory Status.fromCloudFnException(CloudFnException e) =>
      Status.fail(e.message);
}
