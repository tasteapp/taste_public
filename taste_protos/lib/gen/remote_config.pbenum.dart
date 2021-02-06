///
//  Generated code. Do not modify.
//  source: remote_config.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Experiment extends $pb.ProtobufEnum {
  static const Experiment experiment_undefined = Experiment._(0, 'experiment_undefined');
  static const Experiment starting_tab_experiment = Experiment._(1, 'starting_tab_experiment');
  static const Experiment taste_logo_experiment = Experiment._(2, 'taste_logo_experiment');
  static const Experiment taste_hidden_experiment = Experiment._(3, 'taste_hidden_experiment');

  static const $core.List<Experiment> values = <Experiment> [
    experiment_undefined,
    starting_tab_experiment,
    taste_logo_experiment,
    taste_hidden_experiment,
  ];

  static final $core.Map<$core.int, Experiment> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Experiment valueOf($core.int value) => _byValue[value];

  const Experiment._($core.int v, $core.String n) : super(v, n);
}

