import 'package:flutter/material.dart';

// TODO: change to simplky AppBarBtn
class AppBarBtn extends StatelessWidget {
  final Function onPressed;
  final Icon icon;

  AppBarBtn({
    @required this.onPressed,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: this.icon,
      shape: const CircleBorder(
        side: const BorderSide(color: Colors.transparent),
      ),
      elevation: 2,
    );
  }
}
