import 'package:flutter/material.dart';

class SubHeader extends StatelessWidget {
  final String title;

  SubHeader({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '$title :',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
