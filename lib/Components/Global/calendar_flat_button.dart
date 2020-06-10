import 'package:flutter/material.dart';

// TODO: rename to CalendarBtn
class CalendarFlatButton extends StatelessWidget {
  final Function onPressed;

  CalendarFlatButton({this.onPressed});

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
