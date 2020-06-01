import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.white,
      thickness: 2,
      indent: 10,
      endIndent: 150,
    );
  }
}
