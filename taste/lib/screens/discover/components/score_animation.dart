import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class ScoreAnimationWidget extends StatefulWidget {
  const ScoreAnimationWidget(
      {Key key, @required this.builder, @required this.enabled})
      : super(key: key);
  final bool enabled;
  final Widget Function(
      BuildContext context,
      Widget Function({Widget child}) target,
      void Function(int score) onScore) builder;

  @override
  _ScoreAnimationWidgetState createState() => _ScoreAnimationWidgetState();
}

int get _millis => 400;

class _ScoreAnimationWidgetState extends State<ScoreAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int _score;
  SequenceAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _animation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable:
              SizeTween(begin: const Size(0, 0), end: const Size(100, 100)),
          from: const Duration(milliseconds: 0),
          to: Duration(milliseconds: _millis),
          tag: "size",
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 0, end: 0.4),
          from: const Duration(milliseconds: 0),
          to: Duration(milliseconds: _millis ~/ 3),
          tag: "opacity",
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 0.4, end: 0),
          from: Duration(milliseconds: _millis ~/ 3),
          to: Duration(milliseconds: _millis),
          tag: "opacity",
        )
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        ({child}) => Stack(
          alignment: Alignment.center,
          children: [
            child,
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (c, w) => Text(
                  _score?.toString() ?? '',
                  style: TextStyle(
                    shadows: [
                      Shadow(
                          color: Colors.grey.withOpacity(
                              _animation['opacity'].value as double),
                          blurRadius:
                              (_animation['size'].value.height as double) / 7)
                    ],
                    fontWeight: FontWeight.w900,
                    fontSize: _animation['size'].value.height as double,
                    color: Colors.white
                        .withOpacity(_animation['opacity'].value as double),
                  ),
                ),
              ),
            ),
          ],
        ),
        widget.enabled
            ? (score) async {
                setState(() => _score = score);
                await _controller.forward();
                _controller.reset();
              }
            : (_) {},
      );
}
