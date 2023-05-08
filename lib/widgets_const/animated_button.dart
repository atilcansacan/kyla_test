import 'package:flutter/material.dart';
import 'package:kyla_test/widgets_const/const_values.dart';
import 'package:kyla_test/widgets_const/round_button.dart';

class AnimatedButton extends StatefulWidget {
  final double yPosition;
  final int duration;
  final void Function() onTap;
  final void Function(DraggableDetails) onDragEnd;
  final void Function(DragUpdateDetails) onDragUpdate;
  final void Function() onDragStarted;
  final Color color;
  final Icon icon;
  final Animation animation;

  const AnimatedButton({
    Key? key,
    required this.yPosition,
    required this.duration,
    required this.onTap,
    required this.onDragEnd,
    required this.onDragUpdate,
    required this.onDragStarted,
    required this.color,
    required this.icon,
    required this.animation,
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
          return AnimatedPositioned(
            left: (MediaQuery.of(context).size.width / 2) - (buttonSize / 2),
            top: widget.yPosition,
            duration: Duration(milliseconds: widget.duration),
            child: Transform.rotate(
              angle: (11 * widget.animation.value).toDouble(),
              child: Draggable(
                feedback: Container(),
                axis: Axis.vertical,
                onDragEnd: widget.onDragEnd,
                onDragStarted: widget.onDragStarted,
                onDragUpdate: widget.onDragUpdate,
                child: SizedBox(
                  height: buttonSize,
                  child: FittedBox(
                    child: GestureDetector(
                        onTap: widget.onTap,
                        child: RoundButtonWidget(
                            widget.yPosition, widget.color, widget.icon)),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
