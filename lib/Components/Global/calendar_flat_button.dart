import 'package:flutter/material.dart';

class CalendarFlatButton extends StatelessWidget {
  final Function onPressed;

  CalendarFlatButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: Colors.white,
      onPressed: onPressed,
      child: const Icon(Icons.calendar_today),
      shape: const CircleBorder(
        side: const BorderSide(color: Colors.transparent),
      ),
    );
  }
}
