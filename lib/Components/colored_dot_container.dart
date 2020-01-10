import 'package:flutter/material.dart';

class ColoredDotContainer extends StatelessWidget {
  final color;
  final width;
  final height;

  ColoredDotContainer(
      {@required this.color, this.width = 8.0, this.height = 8.0})
      : assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 0.3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
