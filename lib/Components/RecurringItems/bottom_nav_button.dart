import 'package:flutter/material.dart';

class BottomNavButton extends StatelessWidget {
  final Color color; 
  final String text;
  final Function onPressed;

  BottomNavButton({@required this.text, @required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: this.color,
      padding: const EdgeInsets.symmetric(vertical: 20),
      textTheme: ButtonTextTheme.primary,
      child: Text(
        this.text,
      ),
      onPressed: this.onPressed,
    );
  }
}
