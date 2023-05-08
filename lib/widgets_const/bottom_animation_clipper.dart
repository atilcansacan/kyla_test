import 'dart:math';
import 'package:flutter/material.dart';

class BottomAnimationClipper extends CustomClipper<Path> {
  Size size;
  double topCircle;
  double curveHeight;
  double curveWidth;

  BottomAnimationClipper({
    required this.size,
    required this.topCircle,
    required this.curveHeight,
    required this.curveWidth,
  });
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    Offset topLeft = Offset(w * topCircle, curveHeight);
    Offset topRight = Offset(w * (1 - topCircle), curveHeight);
    Offset midLine = Offset(w * 0.5, curveHeight);

    path.moveTo(0, size.height);
    // Draws the left curve
    path.quadraticBezierTo(w * curveWidth, h * 0.99, topLeft.dx, topLeft.dy);
// Draws a small line to the center
    path.lineTo(midLine.dx, midLine.dy);
    // Draws a line to bottom of the page
    path.lineTo(w * .5, h);
    // Moves to top left corner of the shape
    path.moveTo(topLeft.dx, topLeft.dy);
    // after completing left shape moves to right bottom corner
    path.moveTo(w, h);
    // draws a symmetrical curve to the center
    path.quadraticBezierTo(
        w * (1 - curveWidth), h * 0.99, w * (1 - topCircle), curveHeight);
    // line to center
    path.lineTo(midLine.dx, midLine.dy);
    // line to bottom
    path.lineTo(w * .5, h);
    //Moves to left top corner
    path.moveTo(topLeft.dx, topLeft.dy);
    // Draws a half circle to top right corner

    final mid =
        Offset((topLeft.dx + topRight.dx) / 2, (topLeft.dy + topRight.dy) / 2);
    final radius = (topRight.dx - topLeft.dx) / 2;

    path.addArc(
      Rect.fromCircle(
        center: mid,
        radius: radius,
      ),
      pi,
      pi,
    );
    //  path.arcToPoint(topRight, radius: Radius.circular(buttonSize / 2));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
