/// Note: Only [requestLocationPermission] and [LocationBuilder] will request permissions. All other calls will not.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:pedantic/pedantic.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/extensions.dart';

enum Status {
  enabled,
  disabled,
  permanentlyDisabled,
  waiting,
}

extension StatusExt on Status {
  bool get isEnabled => this == Status.enabled;
  bool get done => !isWaiting;
  bool get isWaiting => this == Status.waiting;
  bool get isPermanentlyDisabled => this == Status.permanentlyDisabled;
}

const _ok = Status.enabled;

Status _status(bool s) => s ? _ok : Status.disabled;

/*
 * API
 */

/// Requests permissions, or returns true if already available.
Future<Status> get requestLocationPermissions async {
  if (await _enabled) {
    return _ok;
  }
  if ((await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.locationWhenInUse)) ==
      PermissionStatus.neverAskAgain) {
    return Status.permanentlyDisabled;
  }
  final permission = (await PermissionHandler()
          .requestPermissions([PermissionGroup.locationWhenInUse]))
      .values
      .firstOrNull;
  return _status(permission == PermissionStatus.granted);
}

/// Returns my current location, or expiring if a non-null location is not found in [duration].
/// Does not request permissions.
Future<LatLng> myLocation(
    [Duration duration = const Duration(hours: 1)]) async {
  if (myLocationStream.hasValue) {
    return myLocationStream.value;
  }
  unawaited(_put);
  return myLocationStream.withoutNulls.first
      .timeout(duration, onTimeout: () => null);
}

/// A widget which asks for permission once, and then provides locations as a
/// StreamBuilder. You can access the location via the parameter in [builder] or
/// via `LocationBuilder.of`, if you are a child of this widget.
class LocationBuilder extends StatefulWidget {
  const LocationBuilder({
    Key key,
    @required this.builder,
    this.waitDuration = const Duration(seconds: 3),
    this.locationUpdateCallback,
  }) : super(key: key);
  final Widget Function(
    BuildContext context,
    LatLng location,
    Status done,
  ) builder;

  final Duration waitDuration;
  final void Function(Status) locationUpdateCallback;
  @override
  _LocationBuilderState createState() => _LocationBuilderState();

  static LatLng of(BuildContext context, {bool listen = false}) =>
      Provider.of(context, listen: listen);
}

class _LocationBuilderState extends State<LocationBuilder> {
  final notifier = ValueNotifier(Status.waiting);

  @override
  void initState() {
    super.initState();
    if (myLocationStream.value != null) {
      return;
    }
    () async {
      final status = await requestLocationPermissions;
      if (status.isEnabled) {
        unawaited(_put);
        TAEvent.location_available();
        await sleep(widget.waitDuration);
      } else {
        TAEvent.location_unavailable();
      }
      if (widget.locationUpdateCallback != null) {
        widget.locationUpdateCallback(status);
      }
      notifier.value = status;
    }();
  }

  @override
  Widget build(BuildContext context) => StreamProvider<LatLng>.value(
      value: myLocationStream,
      initialData: myLocationStream.value,
      child: ValueListenableBuilder<Status>(
          valueListenable: notifier,
          builder: (context, status, _) {
            final location =
                Provider.of<LatLng>(context) ?? myLocationStream.value;
            return widget.builder(
                context, location, location != null ? _ok : status);
          }));
}

Future get putLocation async {
  if (await _enabled) {
    await _put;
  }
}

/*
 * IMPLEMENTATION
 */

final _controller = StreamController<LatLng>();
final _location = Location();
LatLng get _mock =>
    null; // !!!!! WARNING !!!!!! DO NOT COMMIT ANY CHANGES TO THIS LINE
Future get _put async =>
    _controller.add(_mock ?? (await _location.getLocation()).latLng);
Future<bool> get _enabled async =>
    await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse) ==
    PermissionStatus.granted;

final myLocationStream = () {
  () async {
    while (true) {
      if (await _enabled) {
        await _put;
      }
      await sleep(1.minutes);
    }
  }();
  const nowhere = LatLng(0, 0);
  return _controller.stream
      .distinct((a, b) => (a ?? nowhere).distanceMeters(b ?? nowhere) < 50)
      .startWith(null)
      .subscribe;
}();
