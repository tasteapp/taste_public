# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: feature_flags.proto
"""Generated protocol buffer code."""
from google.protobuf.internal import enum_type_wrapper
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor.FileDescriptor(
  name='feature_flags.proto',
  package='feature_flags',
  syntax='proto3',
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_pb=b'\n\x13\x66\x65\x61ture_flags.proto\x12\rfeature_flags*:\n\x0b\x46\x65\x61tureFlag\x12\x1a\n\x16\x46\x45\x41TURE_FLAG_UNDEFINED\x10\x00\x12\x0f\n\x0b\x64\x61ily_tasty\x10\x01\x62\x06proto3'
)

_FEATUREFLAG = _descriptor.EnumDescriptor(
  name='FeatureFlag',
  full_name='feature_flags.FeatureFlag',
  filename=None,
  file=DESCRIPTOR,
  create_key=_descriptor._internal_create_key,
  values=[
    _descriptor.EnumValueDescriptor(
      name='FEATURE_FLAG_UNDEFINED', index=0, number=0,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='daily_tasty', index=1, number=1,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
  ],
  containing_type=None,
  serialized_options=None,
  serialized_start=38,
  serialized_end=96,
)
_sym_db.RegisterEnumDescriptor(_FEATUREFLAG)

FeatureFlag = enum_type_wrapper.EnumTypeWrapper(_FEATUREFLAG)
FEATURE_FLAG_UNDEFINED = 0
daily_tasty = 1


DESCRIPTOR.enum_types_by_name['FeatureFlag'] = _FEATUREFLAG
_sym_db.RegisterFileDescriptor(DESCRIPTOR)


# @@protoc_insertion_point(module_scope)