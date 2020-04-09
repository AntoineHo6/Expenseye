import 'package:flutter/material.dart';

class ColoredDot extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  ColoredDot({@required this.color, this.width = 8.0, this.height = 8.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
