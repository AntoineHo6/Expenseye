import 'package:Expenseye/Components/EditAdd/confirmation_dialog.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Pages/EditAdd/categories_page.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/Utils/item_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditItemModel extends ChangeNotifier {
  bool didInfoChange = false;
  bool isNameInvalid = false;
  bool isPriceInvalid = false;
  DateTime date;
  ItemCategory category;

  EditItemModel(this.date, this.category);

  // Will make the save button clickable
  void infoChanged(String text) {
    didInfoChange = true;
    notifyListeners();
  }

  // Will make the save button clickable
  void updateDate(DateTime newDate) {
    if (newDate != null) {
      date = newDate;
      infoChanged(null);
    }
  }

  void chooseDate(BuildContext context, DateTime initialDate) async {
    DateTime newDate = await DateTimeUtil.chooseDate(context, initialDate);
    updateDate(newDate);
  }

  void editItem(
      BuildContext context, int id, String newName, String newPrice) {
    bool areFieldsInvalid = _checkFieldsInvalid(newName, newPrice);

    // if all the fields are valid, update and quit
    if (!areFieldsInvalid) {
      Item newItem = new Item.withId(
          id, newName, double.parse(newPrice), date, 0, category);

      Provider.of<ItemModel>(context, listen: false)
          .editItem(newItem);
      Navigator.pop(context, 1);
    }
  }

  void delete(BuildContext context, int expenseId) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => DeleteConfirmDialog(),
    );

    if (confirmed != null && confirmed) {
      Provider.of<ItemModel>(context, listen: false)
          .deleteItem(expenseId);
      Navigator.pop(context, 2);
    }
  }

  /// On selected category in the CategoriesPage, update the current category
  /// in the model
  void openCategoriesPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriesPage(),
      ),
    );

    if (result != null) {
      category = result;
      infoChanged(null);
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
