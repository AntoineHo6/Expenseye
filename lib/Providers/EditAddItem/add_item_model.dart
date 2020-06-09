import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Pages/EditAddItem/choose_category_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddItemModel extends ChangeNotifier {
  bool isNameInvalid = false;
  bool isAmountInvalid = false;

  DateTime date;
  ItemType type;
  // TODO: rename to categoryId
  String category;

  AddItemModel(this.date, this.type) {
    type == ItemType.expense
        ? category = Strings.foodEN.toLowerCase()
        : category = Strings.salaryEN.toLowerCase();
  }

  // Will make the save button clickable
  void updateDate(DateTime newDate) {
    if (newDate != null) {
      date = newDate;
      notifyListeners();
    }
  }

  void chooseDate(BuildContext context, DateTime initialDate) async {
    DateTime newDate = await DateTimeUtil.chooseDate(context, initialDate);
    updateDate(newDate);
  }

  void addItem(BuildContext context, String newName, String newAmount) {
    // make sure to remove time before adding to db
    final DateTime newDate = DateTimeUtil.timeToZeroInDate(date);
    
    bool areFieldsInvalid = _checkFieldsInvalid(newName, newAmount);

    // if all the fields are valid, add and quit
    if (!areFieldsInvalid) {
      Item newItem =
          new Item(newName, double.parse(newAmount), newDate, type, category);

      Provider.of<DbModel>(context, listen: false).addItem(newItem);
      Navigator.pop(context, true);
    }
  }

  /// On selected category in the ChooseCategoryPage, update the current category
  /// in the model
  void openChooseCategoryPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseCategoryPage(type: type),
      ),
    );

    if (result != null) {
      category = result;
      notifyListeners();
    }
  }

  /// Will check and show error msg if a field is invalid.
  bool _checkFieldsInvalid(String newName, String newAmount) {
    // check NAME field
    isNameInvalid = newName.trim().isEmpty ? true : false;

    // check AMOUNT field
    try {
      double.parse(newAmount);
      isAmountInvalid = false;
    } on FormatException {
      isAmountInvalid = true;
    }

    notifyListeners();

    // update areFieldsInvalid
    if (!isNameInvalid && !isAmountInvalid) {
      return false;
    }
    return true;
  }
}
