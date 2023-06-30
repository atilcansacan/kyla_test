import 'package:flutter/material.dart';
import 'package:kyla_test/widgets_const/const_values.dart';

class RoundButtonWidget extends StatefulWidget {
  final Color color;
  final Icon icon;

  const RoundButtonWidget(this.color, this.icon, {Key? key}) : super(key: key);

  @override
  State<RoundButtonWidget> createState() => _RoundButtonWidgetState();
}

class _RoundButtonWidgetState extends State<RoundButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color,
      ),
      child: widget.icon,
    );
  }
}
