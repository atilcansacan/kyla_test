import 'package:flutter/material.dart';
import 'package:kyla_test/widgets_const/bottom_animation_clipper.dart';

class BottomAnimation extends StatefulWidget {
  final AnimationController controller;
  final Animation<double> animation;
  final double height;
  final double topCircle;
  final double width;

  const BottomAnimation({
    super.key,
    required this.controller,
    required this.animation,
    required this.height,
    required this.topCircle,
    required this.width,
  });

  @override
  BottomAnimationState createState() => BottomAnimationState();
}

class BottomAnimationState extends State<BottomAnimation>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: AnimatedBuilder(
        animation: widget.animation,
        builder: (context, child) {
          return ClipPath(
            clipper: BottomAnimationClipper(
              size: size,
              curveHeight: widget.height,
              curveWidth: widget.width,
              topCircle: widget.topCircle,
            ),
            child: child,
          );
        },
        child: Container(
          height: size.height * widget.animation.value,
          width: size.width,
          color: Colors.blue,
        ),
      ),
    );
  }
}
