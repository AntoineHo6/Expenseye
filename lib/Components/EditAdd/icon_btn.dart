import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final ExpenseCategory category;
  final Function function;

  const IconBtn(this.category, this.function);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: MyColors.black02dp,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 3.0,
      onPressed: function,
      child: Icon(
        CategoryProperties.properties[category]['iconData'],
        color: CategoryProperties.properties[category]['color'],
      ),
    );
  }
}
