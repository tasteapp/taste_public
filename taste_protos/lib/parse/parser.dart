import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:protobuf/protobuf.dart';

import '../taste_protos.dart';

part 'parser.freezed.dart';

@freezed
abstract class Field with _$Field {
  factory Field.timestamp() = _Timestamp;
  factory Field.reference() = _Reference;
  factory Field.geoPoint() = _Geopoint;
  factory Field.integer() = _Int;
  factory Field.string() = _String;
  factory Field.float() = _Float;
  factory Field.boolean() = _Bool;
  factory Field.enumeration(List<String> values) = _Enum;
  factory Field.list(Field field) = _List;
  factory Field.message(Map<String, Field> fields) = _Message;
  factory Field.struct() = _Struct;
}

Map<String, Field> parse(CollectionType t) => t.proto.info_.fields;

extension on BuilderInfo {
  Map<String, Field> get fields =>
      byName.map((_, v) => MapEntry(v.protoName, v.field));
}

final scalars = {
  PbFieldType.OE: $Field.string(),
  PbFieldType.OS: $Field.string(),
  PbFieldType.O3: $Field.integer(),
  PbFieldType.O6: $Field.integer(),
  PbFieldType.OF: $Field.float(),
  PbFieldType.OD: $Field.float(),
  PbFieldType.OB: $Field.boolean(),
  PbFieldType.QE: $Field.string(),
  PbFieldType.QS: $Field.string(),
  PbFieldType.Q3: $Field.integer(),
  PbFieldType.Q6: $Field.integer(),
  PbFieldType.QF: $Field.float(),
  PbFieldType.QD: $Field.float(),
  PbFieldType.QB: $Field.boolean(),
  PbFieldType.PE: $Field.string(),
  PbFieldType.PS: $Field.string(),
  PbFieldType.P3: $Field.integer(),
  PbFieldType.P6: $Field.integer(),
  PbFieldType.PF: $Field.float(),
  PbFieldType.PD: $Field.float(),
  PbFieldType.PB: $Field.boolean(),
};

extension on FieldInfo {
  bool get isTimestamp => subBuilder?.call() is Timestamp;
  bool get isRef => subBuilder?.call() is DocumentReferenceProto;
  bool get isLatLng => subBuilder?.call() is LatLng;
  bool get isStruct => subBuilder?.call() is Struct;

  Field get field => _field();
  Field _field([bool skipRepeated = false]) {
    if (isTimestamp) {
      return Field.timestamp();
    }
    if (isRef) {
      return Field.reference();
    }
    if (isLatLng) {
      return Field.geoPoint();
    }
    if (isStruct) {
      return Field.struct();
    }
    if (!skipRepeated && isRepeated) {
      return Field.list(_field(true));
    }
    if (isGroupOrMessage) {
      return Field.message(subBuilder().info_.fields);
    }
    if (isEnum) {
      return Field.enumeration(enumValues.listMap((t) => t.name));
    }
    return scalars[type];
  }
}
