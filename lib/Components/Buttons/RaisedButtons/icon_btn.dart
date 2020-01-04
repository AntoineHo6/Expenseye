import 'package:expense_app/Pages/icons_page.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/edit_add_expense_model.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconBtn extends RaisedButton {
  final ExpenseCategory category;

  const IconBtn(this.category);

  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);
    final _editAddExpenseModel = Provider.of<EditAddExpenseModel>(context);

    return RaisedButton(
      color: MyColors.blueberry,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 3.0,
      onPressed: () => _openIconsPage(context, _editAddExpenseModel),
      child: Icon(_expenseModel.indexToIconData(category.index)),
    );
  }

  void _openIconsPage(
      BuildContext context, EditAddExpenseModel _editAddExpenseModel) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IconsPage()),
    );

    _editAddExpenseModel.category = result;
    _editAddExpenseModel.infoChanged(null);
  }
}
