import 'package:flutter/material.dart';

class CalendarFlatButton extends StatelessWidget {
  final Function onPressed;

  CalendarFlatButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      
      textColor: Colors.white,
      onPressed: onPressed,
      child: const Icon(Icons.calendar_today),
    );
  }
}
