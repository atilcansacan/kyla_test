import 'package:flutter/material.dart';
import 'package:kyla_test/widgets_const/const_values.dart';

class CenteredText extends StatelessWidget {
  const CenteredText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          'Events',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: centeredTextColor,
          ),
        ),
      ),
    );
  }
}
