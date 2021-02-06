import 'dart:convert';
import 'dart:js_util';

import 'package:crypto/crypto.dart' as crypto;
import 'package:node_interop/js.dart';
import 'package:node_interop/node.dart';
import 'package:node_interop/util.dart';

import 'src/bindings.dart';

mixin Mailchimp {
  Future call(MailchimpCall call);
  Future batch(Iterable<MailchimpCall> call);

  static Mailchimp forKey(String key) => _Impl(key);
  static Mailchimp fake(Function(MailchimpCall call) handler) => _Fake(handler);
}

/// Location
class LatLng {
  /// Default constructor
  const LatLng(this.lat, this.lng);

  /// Latitude
  final double lat;

  /// Longitude
  final double lng;

  Map<String, double> get _json => {
        'latitude': lat,
        'longitude': lng,
      };
}

/// Known merge fields.
enum MergeField {
  /// First name
  FNAME,

  /// Last name
  LNAME,

  /// Email
  EMAIL,

  /// Phone
  PHONE,

  /// Address
  ADDRESS,
}

MailchimpCall deleteMember(String audience, String email) =>
    MailchimpCall(Method.delete, '/lists/$audience/members/${email.md5}');
MailchimpCall putMember(String audience, String email,
        {Status status = Status.subscribed,
        String firstName,
        String lastName,
        LatLng location,
        Map<String, String> otherMergeFields = const {}}) =>
    MailchimpCall(Method.put, '/lists/$audience/members/${email.md5}').withArgs(
      {
        'email_address': email,
        'status': status.enumName,
        'location': location?._json,
        'merge_fields': {
          MergeField.FNAME.enumName: firstName,
          MergeField.LNAME.enumName: lastName,
          ...otherMergeFields,
        }
      }.withoutEmpties,
    );
MailchimpCall addMember(String audience, String email,
        {Status status = Status.subscribed,
        Set<String> tags = const {},
        String firstName,
        String lastName,
        LatLng location,
        Map<String, String> otherMergeFields = const {}}) =>
    MailchimpCall(Method.post, '/lists/$audience/members').withArgs(
      {
        'email_address': email,
        'status': status.enumName,
        'tags': tags.toList(),
        'location': location?._json,
        'merge_fields': {
          MergeField.FNAME.enumName: firstName,
          MergeField.LNAME.enumName: lastName,
          ...otherMergeFields,
        }
      }.withoutEmpties,
    );

MailchimpCall updateTags(String audience, String email,
        {Set<String> add = const {}, Set<String> remove = const {}}) =>
    MailchimpCall(Method.post, '/lists/$audience/members/${email.md5}/tags')
        .withArgs({
      'tags': [
        ...add.map((t) => {'name': t, 'status': _TagStatus.active.enumName}),
        ...remove
            .map((t) => {'name': t, 'status': _TagStatus.inactive.enumName}),
      ],
    });

enum Status { subscribed }

class MailchimpCall {
  MailchimpCall(this.method, this.path, [this.args = const {}]);
  final Method method;
  final String path;
  final Map<String, dynamic> args;
  MailchimpCall withArgs(Map<String, dynamic> args) =>
      MailchimpCall(method, path, args);
  dynamic get _js =>
      jsify({'method': method.enumName, 'path': path, 'body': args});
  Future call(Mailchimp m) => m(this);
}

enum Method { put, post, get, patch, delete }

extension on Object {
  String get enumName => toString().split('.').last;
}

extension on String {
  String get md5 => crypto.md5.convert(utf8.encode(toLowerCase())).toString();
}

enum _TagStatus { active, inactive }

class _Fake with Mailchimp {
  final Function(MailchimpCall call) handleCall;

  _Fake(this.handleCall);
  @override
  Future batch(Iterable<MailchimpCall> call) async => call.forEach(handleCall);

  @override
  Future call(MailchimpCall call) async => handleCall(call);
}

extension on Promise {
  Future get wrapPromise async => dartify(await promiseToFuture(this));
}

extension<T> on Iterable<T> {
  List<S> lMap<S>(S Function(T t) fn) => map(fn).toList();
}

class _Impl with Mailchimp {
  _Impl(String key)
      : _native = callConstructor(_constructor, [key]) as JsMailchimp;
  final JsMailchimp _native;
  @override
  Future batch(Iterable<MailchimpCall> calls) =>
      _native.batch(calls.lMap((c) => c._js)).wrapPromise;
  @override
  Future call(MailchimpCall call) async =>
      <Method, Promise Function(MailchimpCall call)>{
        Method.post: (c) => _native.post(c.path, jsify(c.args)),
        Method.put: (c) => _native.put(c.path, jsify(c.args)),
        Method.get: (c) => _native.get(c.path),
        Method.delete: (c) => _native.delete(c.path),
      }[call.method]
          ?.call(call)
          ?.wrapPromise;
}

extension on Map<String, dynamic> {
  Map<String, dynamic> get withoutEmpties {
    final result = <String, dynamic>{};
    for (final e in entries) {
      if (e.key?.isEmpty ?? true) {
        continue;
      }
      if (e.value == null) {
        continue;
      }
      if ((e.value is String) && (e.value?.isEmpty as bool ?? true)) {
        continue;
      }
      if (e.value is Map) {
        final m = Map<String, dynamic>.from(e.value as Map).withoutEmpties;
        if (m.isEmpty) {
          continue;
        }
        result[e.key] = m;
        continue;
      }
      result[e.key] = e.value;
    }
    return result;
  }
}

final _constructor = require('mailchimp-api-v3');
