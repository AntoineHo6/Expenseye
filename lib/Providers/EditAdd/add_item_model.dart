import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Pages/EditAdd/categories_page.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddItemModel extends ChangeNotifier {
  bool isNameInvalid = false;
  bool isPriceInvalid = false;

  DateTime date;
  ItemType type;
  String category;

  AddItemModel(this.date, this.type) {
    type == ItemType.expense
        ? category = Strings.food
        : category = Strings.salary;
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

  void addItem(BuildContext context, String newName, String newPrice) {
    // make sure to remove time before adding to db
    final DateTime newDate = DateTimeUtil.timeToZeroInDate(date);

    bool areFieldsInvalid = _checkFieldsInvalid(newName, newPrice);

    // if all the fields are valid, add and quit
    if (!areFieldsInvalid) {
      Item newItem =
          new Item(newName, double.parse(newPrice), newDate, type, category);

      Provider.of<ItemModel>(context, listen: false).addItem(newItem);
      Navigator.pop(context, true);
    }
  }

  /// On selected category in the CategoriesPage, update the current category
  /// in the model
  void openCategoriesPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriesPage(type: type),
      ),
    );

    if (result != null) {
      category = result;
      notifyListeners();
    }
  }

  /// Will check and show error msg if a field is invalid.
  bool _checkFieldsInvalid(String newName, String newPrice) {
    // check NAME field
    isNameInvalid = newName.isEmpty ? true : false;

    // check PRICE field
    try {
      double.parse(newPrice);
      isPriceInvalid = false;
    } on FormatException {
      isPriceInvalid = true;
    }

    notifyListeners();

    // update areFieldsInvalid
    if (!isNameInvalid && !isPriceInvalid) {
      return false;
    }
    return true;
  }
}
