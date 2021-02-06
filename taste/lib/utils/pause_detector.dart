import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// PauseDetector triggers [didPause] every time the following sequence occurs:
/// 1. [child] enters view (after being out of view).
/// 2. [child] becomes at least 50% visible.
/// 3. After which, the [child] stays visible for at least [minimumPause].
/// 4. After which, [didPause] will not retrigger until [child] exits and
///    reenters.
///
/// These heuristics can be made more nuanced by modifying
/// [_PauseDetectorState.onVisibilityChanged].
class PauseDetector extends StatefulWidget {
  const PauseDetector(
      {@required Key key,
      @required this.didPause,
      @required this.child,
      this.minimumPause = const Duration(seconds: 1)})
      : super(key: key);
  final Widget child;
  final VoidCallback didPause;
  final Duration minimumPause;

  @override
  _PauseDetectorState createState() => _PauseDetectorState();
}

class _PauseDetectorState extends State<PauseDetector> {
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: onVisibilityChanged,
      key: widget.key,
      child: widget.child,
    );
  }

  void onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction <= 0) {
      /// [child] left view. Cancel the active [timer] to prevent
      /// [widget.didPause] from triggering, since [child] did not stay in view
      /// for long enough.
      timer?.cancel();

      /// Set [timer] to null to allow the pause to possibly retrigger.
      timer = null;
      return;
    }

    /// We only start timing a widget after 0.5 visibility reached.
    /// If it barely enters, we ignore it.
    if (info.visibleFraction < 0.5) {
      return;
    }
    if (timer != null) {
      /// [timer] was already trigger for this re-entry event.
      return;
    }

    /// Trigger [widget.didPause], unless cancelled by an exit event.
    timer = Timer(widget.minimumPause, widget.didPause);
  }
}
