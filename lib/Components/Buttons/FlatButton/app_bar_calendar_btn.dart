import 'package:flutter/material.dart';

class AppBarCalendarBtn extends StatelessWidget {
  final onPressed;

  const AppBarCalendarBtn({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: Colors.white,
      onPressed: onPressed,
      child: const Icon(Icons.calendar_today),
      shape: CircleBorder(
        side: const BorderSide(color: Colors.transparent),
      ),
    );
  }
}
