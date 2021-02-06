import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:taste/utils/utils.dart';

SequenceAnimation builder(AnimationController controller) {
  return SequenceAnimationBuilder()
      .addAnimatable(
        animatable: ColorTween(
            begin: const Color(0x00e57373), end: const Color(0xaae57373)),
        from: const Duration(milliseconds: 0),
        to: const Duration(milliseconds: 300),
        tag: "color",
      )
      .addAnimatable(
        animatable:
            SizeTween(begin: const Size(0, 0), end: const Size(200, 200)),
        from: const Duration(milliseconds: 0),
        to: const Duration(milliseconds: 300),
        tag: "size",
      )
      .addAnimatable(
        animatable: Tween<double>(begin: 0, end: 1),
        from: const Duration(milliseconds: 0),
        to: const Duration(milliseconds: 150),
        tag: "opacity",
      )
      .addAnimatable(
        animatable: Tween<double>(begin: 1, end: 0),
        from: const Duration(milliseconds: 150),
        to: const Duration(milliseconds: 300),
        tag: "opacity",
      )
      .animate(controller);
}

class Heart extends AnimatedWidget {
  Heart({Key key, AnimationController controller})
      : sequenceAnimation = builder(controller),
        super(key: key, listenable: controller);
  final SequenceAnimation sequenceAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: listenable,
        builder: (c, w) {
          return Icon(Icons.favorite,
              size: sequenceAnimation['size'].value.height as double,
              color: (sequenceAnimation['color'].value as Color)
                  .withOpacity(sequenceAnimation['opacity'].value as double));
        });
  }
}

class DoubleTapHeartWidget extends StatefulWidget {
  const DoubleTapHeartWidget({Key key, this.onDoubleTap, this.child})
      : super(key: key);
  final Function() onDoubleTap;
  final Widget child;

  @override
  _DoubleTapHeartWidgetState createState() => _DoubleTapHeartWidgetState();
}

class _DoubleTapHeartWidgetState extends State<DoubleTapHeartWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onDoubleTap: () {
        TAEvent.double_tap_heart();
        controller.forward().then((_) => controller.reset());
        widget.onDoubleTap();
      },
      child: Stack(alignment: Alignment.center, children: [
        widget.child,
        Center(child: Heart(controller: controller))
      ]));
}
