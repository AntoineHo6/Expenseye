import 'package:Expenseye/Models/Category.dart';
import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final Category category;
  final Function function;

  IconBtn(this.category, this.function);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      onPressed: function,
      child: Icon(
        category.iconData,
        color: category.color,
      ),
    );
  }
}
