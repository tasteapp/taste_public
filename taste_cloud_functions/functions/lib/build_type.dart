import 'package:node_io/node_io.dart';

/// Controls whether code is built for testing/dev environment vs. prod.
enum BuildType {
  /// Use for releases.
  prod,

  /// Use for dev.
  dev,

  /// Use for testing.
  test,
}

const _envValue = String.fromEnvironment('env');

/// A const-reference to the build-type, as inferred from the build environment.
final buildType = BuildType.values.firstWhere((v) =>
    v.toString().split('.').last ==
    ((_envValue?.isEmpty ?? true)
        ? Platform.environment['NODE_TASTE_ENV']
        : _envValue));

T ifNotTest<T>(T Function() fn) => buildType.isTest ? null : fn();

extension BuildTypeExte on BuildType {
  bool get isTest => this == BuildType.test;
  bool get isDev => this == BuildType.dev;
  bool get isProd => this == BuildType.prod;
  bool get isNotTest => !isTest;
  bool get isNotDev => !isDev;
  bool get isNotProd => !isProd;
}
