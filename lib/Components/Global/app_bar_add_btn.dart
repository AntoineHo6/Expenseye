import 'package:flutter/material.dart';

class AppBarAddBtn extends StatelessWidget {
  final Function onPressed;

  AppBarAddBtn({
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
      shape: const CircleBorder(
        side: const BorderSide(color: Colors.transparent),
      ),
      elevation: 2,
    );
  }
}
