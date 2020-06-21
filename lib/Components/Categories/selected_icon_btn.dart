import 'package:flutter/material.dart';

class SelectedIconBtn extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final IconData iconData;
  final double iconSize;

  SelectedIconBtn({
    @required this.onPressed,
    @required this.color,
    @required this.iconData,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          const Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(3),
      child: RaisedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Icon(
                iconData,
                size: iconSize,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
