import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final String category;
  final Function function;

  IconBtn(this.category, this.function);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      onPressed: function,
      child: Icon(
        DbModel.catMap[category].iconData,
        color: DbModel.catMap[category].color,
      ),
    );
  }
}
