import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final IconData iconData;
  final double iconSize;

  IconBtn({
    @required this.onPressed,
    @required this.color,
    @required this.iconData,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
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
    );
  }
}
