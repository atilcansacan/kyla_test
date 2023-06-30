import 'package:flutter/material.dart';
import 'package:kyla_test/widgets_const/const_values.dart';
import 'package:kyla_test/widgets_const/round_button.dart';

class AnimatedButton extends StatefulWidget {
  final int duration;
  final Color color;
  final Icon icon;
  final Animation animation;
  final double yPosition;

  const AnimatedButton({
    Key? key,
    required this.duration,
    required this.color,
    required this.icon,
    required this.animation,
    required this.yPosition,
  }) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animation,
        builder: (context, Widget? child) {
          return Transform.rotate(
            angle: (7 * widget.animation.value).toDouble(),
            child: SizedBox(
              height: buttonSize,
              child: FittedBox(
                child: RoundButtonWidget(widget.color, widget.icon),
              ),
            ),
          );
        });
  }
}
