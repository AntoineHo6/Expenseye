import 'package:flutter/material.dart';

class CalendarBtn extends StatelessWidget {
  final Function onPressed;

  CalendarBtn({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      textColor: Theme.of(context).textTheme.bodyText1.color,
      onPressed: onPressed,
      child: const Icon(Icons.calendar_today),
      shape: const CircleBorder(
        side: const BorderSide(color: Colors.transparent),
      ),
      elevation: 8,
    );
  }
}
