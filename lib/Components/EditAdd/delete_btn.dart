import 'package:flutter/material.dart';

class DeleteBtn extends StatelessWidget {
  final Function onPressed;

  DeleteBtn({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 8,
      textColor: Theme.of(context).textTheme.bodyText1.color,
      onPressed: onPressed,
      child: const Icon(Icons.delete_forever),
      shape: const CircleBorder(
        side: const BorderSide(color: Colors.transparent),
      ),
    );
  }
}
