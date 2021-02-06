import 'package:collection/collection.dart';
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:taste_protos/gen/google/protobuf/timestamp.pb.dart' as $ts;

import 'extensions.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessage;

mixin TransformProvider {
  dynamic createReference(String path);
  dynamic createTimestamp(DateTime dateTime);
  dynamic createGeopoint({double latitude, double longitude});
  DateTime timestampDateTime(dynamic value);
  bool isReference(dynamic value);
  bool isTimestamp(dynamic value);
  bool isGeopoint(dynamic value);
  bool isSnapshot(dynamic value);
  dynamic referenceFromSnapshot(dynamic snapshot);
  dynamic get serverTimestamp;
  List<Handler> get additionalHandlers => [];
}

TransformProvider _provider;

TransformProvider registerTransformProvider(TransformProvider provider) =>
    _provider = provider;

typedef Matcher = bool Function(dynamic input);
typedef NextHandler = dynamic Function(dynamic input);
typedef Transformer = dynamic Function(dynamic input, NextHandler nextHandler);

class Handler {
  final Matcher matcher;
  final Transformer transformer;

  Handler(this.matcher, this.transformer);
}

final _mapHandler = Handler((value) => value is Map, (value, next) {
  return value.map<String, dynamic>((k, v) => MapEntry(k as String, next(v)));
});

final _listHandler = Handler(
    (value) => value is List, (value, next) => value.map(next).toList());
final _setHandler = Handler(
    (value) => value is Set, (value, next) => next((value as Set).toList()));

final _refHandler =
    Handler(_provider.isReference, (value, next) => {'path': value.path});

/// Converts the proto to Dart Proto3 format, then walks the output and converts
/// all Message keys from camelCase to proto_case, and applies [next] to all
/// values.
///
/// This overcomes the undesired decision by Dart to make Proto3 JSON keys not
/// the `proto_name`, but the `dartName`. With the following approach, we
/// inherit all the of the benefits of the standard Dart JSON serializer, while
/// overriding the silly Dart key choice.
final _protoHandler = Handler(
  (value) => value is $pb.GeneratedMessage,
  (value, next) {
    Map<String, dynamic> helper(
        Map<String, dynamic> map, $pb.BuilderInfo info) {
      return map.map((k, v) {
        final fieldInfo = info.byName[k];
        if (fieldInfo == null) {
          return MapEntry(k, v);
        }
        final key = fieldInfo.protoName;
        if (fieldInfo.subBuilder == null) {
          return MapEntry(key, v);
        }
        final nextInfo = fieldInfo.subBuilder().info_;
        if (fieldInfo.isRepeated) {
          return MapEntry(
              key, (v as List).map((vv) => helper(vv, nextInfo)).toList());
        }
        if (v is! Map<String, dynamic>) {
          return MapEntry(key, v);
        }
        return MapEntry(key, helper(v, nextInfo));
      });
    }

    final $pb.GeneratedMessage message = value;
    return next(helper(message.toProto3Json(), message.info_));
  },
);
final _snapshotHandler = Handler(_provider.isSnapshot,
    (value, next) => next(_provider.referenceFromSnapshot(value)));

final _identityHandler = Handler((value) => true, (v, _) => v);

dynamic _walk(dynamic value, List<Handler> handlers) {
  return handlers
      .firstWhere((h) => h.matcher(value), orElse: () => _identityHandler)
      .transformer(value, (v) => _walk(v, handlers));
}

final _pathToRefHandler = Handler(
    (v) =>
        v is Map<String, dynamic> &&
        SetEquality().equals(v.keys.toSet(), {'path'}),
    (v, _) => _provider.createReference(v['path']));

final _latLngToGeopointHandler = Handler(
    (v) =>
        v is Map<String, dynamic> &&
        SetEquality().equals(v.keys.toSet(), {'latitude', 'longitude'}),
    (v, _) => _provider.createGeopoint(
        latitude: v['latitude'], longitude: v['longitude']));
final _geopointHandler = Handler(_provider.isGeopoint,
    (v, _) => {'latitude': v.latitude, 'longitude': v.longitude});

final _fromProtoTimestampHandler = Handler(
  (v) {
    if (v is! String) {
      return false;
    }
    final date = DateTime.tryParse(v);
    return (date?.millisecondsSinceEpoch ?? -10) >= 0 && date.year <= 9999;
  },
  (v, _) => _provider.createTimestamp(DateTime.parse(v)),
);
final _toProtoTimestampHandler = Handler(
    (v) => v is DateTime || _provider.isTimestamp(v),
    (v, _) => $ts.Timestamp.fromDateTime(
            v is DateTime ? v : _provider.timestampDateTime(v))
        .toProto3Json());
final _serverTimestampHandler = Handler(
    (v) => v == _provider.serverTimestamp,
    (v, _) =>
        $ts.Timestamp.fromDateTime(DateTime.now().toUtc()).toProto3Json());

final _removeNullFieldsHandler = Handler(
  (v) => v is Map && v.values.any((v) => v == null),
  (v, next) => next(Map.from(v)..removeWhere((k, v) => v == null)),
);

final _protoEnumHandler = Handler((v) => v is $pb.ProtobufEnum, (v, _) {
  final $pb.ProtobufEnum value = v;
  return value.value == 0 ? null : value.name;
});

final _toHandlers = [
  _protoEnumHandler,
  _fromProtoTimestampHandler,
  _protoHandler,
  _snapshotHandler,
  _latLngToGeopointHandler,
  _pathToRefHandler,
  _mapHandler,
  _listHandler,
  _setHandler,
];

final _fromHandlers = [
  _protoEnumHandler,
  _toProtoTimestampHandler,
  _serverTimestampHandler,
  _protoHandler,
  _geopointHandler,
  _refHandler,
  _snapshotHandler,
  _removeNullFieldsHandler,
  _mapHandler,
  _listHandler,
  _setHandler,
];

final _toDocumentTransform = (v) =>
    _walk(v, List.from(_provider.additionalHandlers)..addAll(_toHandlers));
final _fromDocumentTransform = (v) =>
    _walk(v, List.from(_provider.additionalHandlers)..addAll(_fromHandlers));

class ProtoTransforms {
  static dynamic toCallFnOutput(dynamic message) =>
      _fromDocumentTransform(message);

  static Map<String, dynamic> toMap(dynamic message) =>
      _toDocumentTransform(message);

  static T fromMap<T extends $pb.GeneratedMessage>(T message, Map map) =>
      (message
            ..mergeFromProto3Json(_fromDocumentTransform(map),
                ignoreUnknownFields: true))
          .clone();

  /// Ensures [map] serializes to [proto], then converts back to [DocumentData].
  /// [explicitEmpties] will make sure that any default-empty values in the
  /// input [map] will be present in the output map, and not erased due to
  /// implicit emptiness.
  static Map<String, dynamic> ensureAsMap<T extends $pb.GeneratedMessage>(
          T proto, Map<String, dynamic> map,
          {bool explicitEmpties = false, bool explicitNulls = false}) =>
      _explicitEmpties(toMap(fromMap(proto, map)),
          explicitEmpties ? map : <String, dynamic>{},
          explicitNulls: explicitNulls);
}

T nullifyEnum<T extends $pb.ProtobufEnum>(T value) =>
    (value?.value ?? 0) == 0 ? null : value;

T enumFromString<T extends $pb.ProtobufEnum>(String string, List<T> values,
        {T orElse, bool orNull = false}) =>
    (string?.isEmpty ?? true)
        ? values.firstWhere((r) => r.value == 0)
        : values.firstWhere((r) => r.name == string, orElse: () {
            if (orNull) {
              return null;
            }
            if (orElse != null) {
              return orElse;
            }
            throw Exception('Could not find $T enum value for $string $values');
          });

Map<String, dynamic> _explicitEmpties(
    Map<String, dynamic> full, Map<String, dynamic> empties,
    {bool explicitNulls}) {
  explicitNulls ??= false;

  /// Returns a flattened verson of [m], where all leaf node values are keyed
  /// by their "path", which is an iterable of either String key or int list
  /// index.
  ///
  /// An empty list will resolve as a leaf node.
  Map<Iterable<dynamic>, dynamic> _flattenMap(Map<String, dynamic> m) {
    Iterable<MapEntry<Iterable<dynamic>, dynamic>> helper(
            Iterable<dynamic> p, dynamic v) =>
        ((v is! Map && v is! List) || v.isEmpty)
            ? [MapEntry(p, v)]
            : (v is Map ? v : v.asMap())
                .entries
                .expand<MapEntry<Iterable<dynamic>, dynamic>>(
                    (e) => helper(p.followedBy([e.key]), e.value));

    return m.entries
        .expand((e) => helper([e.key], e.value))
        .where((e) {
          /// Only keep leaf nodes which represent empty values which would be
          /// removed as default values in the default proto-rep.
          /// We keep them so we can merge them back into [full] in the next
          /// step.
          final v = e.value;
          if (v == null) {
            return explicitNulls;
          }
          if (v is Iterable || v is String) {
            return v.isEmpty;
          }
          if (v is num) {
            return v == 0;
          }
          if (v is $pb.ProtobufEnum) {
            return v.value == 0;
          }
          return false;
        })
        .toList()
        .asMap()
        .map((_, value) =>
            MapEntry(value.key, _toDocumentTransform(value.value)));
  }

  final copy = Map.from(full);
  _flattenMap(empties).forEach((key, value) {
    dynamic m = copy;
    key.pair.forEach((pair) {
      /// Construct all intermediate path values on the way up to the leaf
      /// [value]. Then we merge in the [value] from [empties] into [full].
      ///
      /// The complexity below comes from not knowing whether to create default
      /// empty lists or empty maps.
      if (pair.a is String) {
        if (pair.b is String) {
          m = m.putIfAbsent(pair.a, () => {});
        } else {
          m = m.putIfAbsent(pair.a, () => []);
        }
      } else {
        final l = m as List;
        final i = pair.a as int;
        assert(l.length > i);
        if (pair.b is String) {
          l[i] ??= {};
        } else {
          l[i] ??= [];
        }
        m = l[i];
      }
    });
    m[key.last] = value;
  });
  return Map.from(copy);
}
