import 'package:flutter/material.dart';

class BottomNavButton extends StatelessWidget {
  final Color color;
  final Color disabledColor;
  final String text;
  final Function onPressed;

  BottomNavButton({
    @required this.text,
    @required this.onPressed,
    this.color,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 10,
      color: this.color,
      padding: const EdgeInsets.symmetric(vertical: 20),
      textTheme: ButtonTextTheme.primary,
      child: Text(
        this.text,
      ),
      onPressed: this.onPressed,
      disabledColor: disabledColor,
    );
  }
}
