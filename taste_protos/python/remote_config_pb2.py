# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: remote_config.proto
"""Generated protocol buffer code."""
from google.protobuf.internal import enum_type_wrapper
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor.FileDescriptor(
  name='remote_config.proto',
  package='remote_config',
  syntax='proto3',
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_pb=b'\n\x13remote_config.proto\x12\rremote_config\"\xc5\x01\n\x13SupportedVersionsV2\x12X\n\x14version_is_supported\x18\x01 \x03(\x0b\x32:.remote_config.SupportedVersionsV2.VersionIsSupportedEntry\x12\x19\n\x11\x66orbid_by_default\x18\x02 \x01(\x08\x1a\x39\n\x17VersionIsSupportedEntry\x12\x0b\n\x03key\x18\x01 \x01(\t\x12\r\n\x05value\x18\x02 \x01(\x08:\x02\x38\x01\"z\n\x1bSupportedVersionsVersioning\x12\x1a\n\x12supported_versions\x18\x01 \x01(\t\x12 \n\x18\x61llow_undefined_versions\x18\x02 \x01(\t\x12\x1d\n\x15supported_versions_v2\x18\x03 \x01(\t*^\n\nExperiment\x12\x18\n\x14\x65xperiment_undefined\x10\x00\x12\x1b\n\x17starting_tab_experiment\x10\x01\x12\x19\n\x15taste_logo_experiment\x10\x02\x62\x06proto3'
)

_EXPERIMENT = _descriptor.EnumDescriptor(
  name='Experiment',
  full_name='remote_config.Experiment',
  filename=None,
  file=DESCRIPTOR,
  create_key=_descriptor._internal_create_key,
  values=[
    _descriptor.EnumValueDescriptor(
      name='experiment_undefined', index=0, number=0,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='starting_tab_experiment', index=1, number=1,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
    _descriptor.EnumValueDescriptor(
      name='taste_logo_experiment', index=2, number=2,
      serialized_options=None,
      type=None,
      create_key=_descriptor._internal_create_key),
  ],
  containing_type=None,
  serialized_options=None,
  serialized_start=362,
  serialized_end=456,
)
_sym_db.RegisterEnumDescriptor(_EXPERIMENT)

Experiment = enum_type_wrapper.EnumTypeWrapper(_EXPERIMENT)
experiment_undefined = 0
starting_tab_experiment = 1
taste_logo_experiment = 2



_SUPPORTEDVERSIONSV2_VERSIONISSUPPORTEDENTRY = _descriptor.Descriptor(
  name='VersionIsSupportedEntry',
  full_name='remote_config.SupportedVersionsV2.VersionIsSupportedEntry',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='key', full_name='remote_config.SupportedVersionsV2.VersionIsSupportedEntry.key', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='value', full_name='remote_config.SupportedVersionsV2.VersionIsSupportedEntry.value', index=1,
      number=2, type=8, cpp_type=7, label=1,
      has_default_value=False, default_value=False,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=b'8\001',
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=179,
  serialized_end=236,
)

_SUPPORTEDVERSIONSV2 = _descriptor.Descriptor(
  name='SupportedVersionsV2',
  full_name='remote_config.SupportedVersionsV2',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='version_is_supported', full_name='remote_config.SupportedVersionsV2.version_is_supported', index=0,
      number=1, type=11, cpp_type=10, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='forbid_by_default', full_name='remote_config.SupportedVersionsV2.forbid_by_default', index=1,
      number=2, type=8, cpp_type=7, label=1,
      has_default_value=False, default_value=False,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[_SUPPORTEDVERSIONSV2_VERSIONISSUPPORTEDENTRY, ],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=39,
  serialized_end=236,
)


_SUPPORTEDVERSIONSVERSIONING = _descriptor.Descriptor(
  name='SupportedVersionsVersioning',
  full_name='remote_config.SupportedVersionsVersioning',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='supported_versions', full_name='remote_config.SupportedVersionsVersioning.supported_versions', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='allow_undefined_versions', full_name='remote_config.SupportedVersionsVersioning.allow_undefined_versions', index=1,
      number=2, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='supported_versions_v2', full_name='remote_config.SupportedVersionsVersioning.supported_versions_v2', index=2,
      number=3, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=238,
  serialized_end=360,
)

_SUPPORTEDVERSIONSV2_VERSIONISSUPPORTEDENTRY.containing_type = _SUPPORTEDVERSIONSV2
_SUPPORTEDVERSIONSV2.fields_by_name['version_is_supported'].message_type = _SUPPORTEDVERSIONSV2_VERSIONISSUPPORTEDENTRY
DESCRIPTOR.message_types_by_name['SupportedVersionsV2'] = _SUPPORTEDVERSIONSV2
DESCRIPTOR.message_types_by_name['SupportedVersionsVersioning'] = _SUPPORTEDVERSIONSVERSIONING
DESCRIPTOR.enum_types_by_name['Experiment'] = _EXPERIMENT
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

SupportedVersionsV2 = _reflection.GeneratedProtocolMessageType('SupportedVersionsV2', (_message.Message,), {

  'VersionIsSupportedEntry' : _reflection.GeneratedProtocolMessageType('VersionIsSupportedEntry', (_message.Message,), {
    'DESCRIPTOR' : _SUPPORTEDVERSIONSV2_VERSIONISSUPPORTEDENTRY,
    '__module__' : 'remote_config_pb2'
    # @@protoc_insertion_point(class_scope:remote_config.SupportedVersionsV2.VersionIsSupportedEntry)
    })
  ,
  'DESCRIPTOR' : _SUPPORTEDVERSIONSV2,
  '__module__' : 'remote_config_pb2'
  # @@protoc_insertion_point(class_scope:remote_config.SupportedVersionsV2)
  })
_sym_db.RegisterMessage(SupportedVersionsV2)
_sym_db.RegisterMessage(SupportedVersionsV2.VersionIsSupportedEntry)

SupportedVersionsVersioning = _reflection.GeneratedProtocolMessageType('SupportedVersionsVersioning', (_message.Message,), {
  'DESCRIPTOR' : _SUPPORTEDVERSIONSVERSIONING,
  '__module__' : 'remote_config_pb2'
  # @@protoc_insertion_point(class_scope:remote_config.SupportedVersionsVersioning)
  })
_sym_db.RegisterMessage(SupportedVersionsVersioning)


_SUPPORTEDVERSIONSV2_VERSIONISSUPPORTEDENTRY._options = None
# @@protoc_insertion_point(module_scope)
