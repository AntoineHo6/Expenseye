import 'package:expense_app/Pages/icons_page.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/edit_add_expense_model.dart';
import 'package:expense_app/Utils/expense_category.dart';
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
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 3.0,
      onPressed: () => _openIconsPage(context, _editAddExpenseModel),
      child: Icon(
        _expenseModel.catToIconData(category),
        color: CategoryProperties.properties[category]['color'],
      ),
    );
  }

  void _openIconsPage(
      BuildContext context, EditAddExpenseModel _editAddExpenseModel) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IconsPage()),
    );

    if (result != null) {
      _editAddExpenseModel.category = result;
      _editAddExpenseModel.infoChanged(null);
    }
  }
}
