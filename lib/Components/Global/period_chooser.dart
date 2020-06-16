import 'package:flutter/material.dart';

class PeriodChooser extends StatelessWidget {
  final String text;
  final Function onPressedLeft;
  final Function onPressedRight;

  PeriodChooser({@required this.text, this.onPressedLeft, this.onPressedRight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ButtonTheme(
          minWidth: 30,
          child: RaisedButton(
            onPressed: onPressedLeft,
            color: Theme.of(context).buttonColor,
            child: const Icon(Icons.chevron_left),
            shape: const CircleBorder(
              side: const BorderSide(color: Colors.transparent),
            ),
            elevation: 2,
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        ButtonTheme(
          minWidth: 30,
          child: RaisedButton(
            onPressed: onPressedRight,
            color: Theme.of(context).buttonColor,
            child: const Icon(Icons.chevron_right),
            shape: const CircleBorder(
              side: const BorderSide(color: Colors.transparent),
            ),
            elevation: 2,
          ),
        ),
      ],
    );
  }
}
