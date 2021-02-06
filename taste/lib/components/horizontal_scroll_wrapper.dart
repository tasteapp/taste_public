import 'package:flutter/material.dart';

class HorizontalScrollWrapper extends StatelessWidget {
  const HorizontalScrollWrapper({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final leftGradient = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: const [0, 0.4, 0.8],
        colors: [
          Colors.white.withOpacity(0.7),
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(0.0),
        ],
      ),
    );
    final rightGradient = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        stops: const [0, 0.4, 0.8],
        colors: [
          Colors.white.withOpacity(0.7),
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(0.0),
        ],
      ),
    );
    return Stack(
      children: [
        child,
        Align(
          alignment: const Alignment(-1.0, 0.0),
          child: Container(
            width: 20,
            decoration: leftGradient,
          ),
        ),
        Align(
          alignment: const Alignment(1.0, 0.0),
          child: Container(
            width: 20,
            decoration: rightGradient,
          ),
        ),
      ],
    );
  }
}
