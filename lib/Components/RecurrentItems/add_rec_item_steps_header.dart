import 'package:flutter/material.dart';

class AddRecItemStepsHeader extends StatelessWidget {
  final String title;

  AddRecItemStepsHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: FittedBox(
        // fit: BoxFit.fitWidth,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
