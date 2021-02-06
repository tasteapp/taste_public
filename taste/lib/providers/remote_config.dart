import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';
import 'package:provider/provider.dart';
import 'package:taste/screens/log_in/components/not_supported_page.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/logging.dart';
import 'package:taste_protos/taste_protos.dart';

import '../app_config.dart';

const configVersion = 'supported_versions_v2';
final configProto = SupportedVersionsV2();

final Future<RemoteConfig> _config = RemoteConfig.instance.then((config) {
  config
      .setConfigSettings(RemoteConfigSettings(debugMode: kDebugMode || isDev));
  return config;
});
Future<RemoteConfig> get _refreshedConfig async {
  final config = await _config;
  await config.fetch(expiration: 0.seconds);
  await config.activateFetched();
  return config;
}

Future<bool> isVersionSupported() async {
  final version = (await GetVersion.projectVersion).replaceAll('-dev', '');
  final config = await _refreshedConfig;
  final proto = Map<String, dynamic>.from(
          jsonDecode(config.getString(configVersion) ?? "{}") as Map)
      .asProto(configProto);
  final isSupported =
      proto.versionIsSupported[version] ?? !proto.forbidByDefault;
  TAEvent.remote_config({
    'version': version,
    'is_supported': isSupported,
    'forbid_by_default': proto.forbidByDefault,
  });
  return isSupported;
}

class _StaticConfig {
  _StaticConfig() {
    setup();
  }
  RemoteConfig config;

  Future setup() async {
    config = await _config;
  }
}

final _staticConfig = _StaticConfig();

extension ExperimentExtension on Experiment {
  String call(BuildContext context, {String defaultValue = ''}) {
    final value = Provider.of<_Provider>(context).value(this) ?? '';
    return value.isEmpty ? defaultValue : value;
  }

  String getStatic({String defaultValue = ''}) {
    final configName = _staticConfig?.config?.getString(name) ?? '';
    return configName.isEmpty ? defaultValue : configName;
  }
}

final experimentsProvider = ChangeNotifierProvider.value(value: _Provider());

class _Provider extends ChangeNotifier {
  _Provider() {
    setup();
  }
  RemoteConfig config;

  Future setup() async {
    config = await _config;
    notifyListeners();
  }

  String value(Experiment experiment) {
    if (config == null) {
      return null;
    }
    _prime();
    final value = config.getString(experiment.name);
    logger.d("Experiment ${experiment.name}: $value");
    return value;
  }

  Future _prime() async {
    await config.fetch(expiration: isDev ? 0.seconds : 1.hours);
    if (await config.activateFetched()) {
      logger.d("Remote config updated");
      notifyListeners();
    }
  }
}
