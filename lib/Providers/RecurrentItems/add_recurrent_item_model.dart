import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Pages/RecurrentItems/date_add_rec_item_page.dart';
import 'package:flutter/material.dart';

class AddRecurrentItemModel extends ChangeNotifier {
  String name;
  double amount;
  bool isNameInvalid = false;
  bool isAmountInvalid = false;
  ItemType type;

  AddRecurrentItemModel(this.type);

  void goDateRecItemPage(BuildContext context, String name, String amount) {
    bool areFieldsInvalid = _checkFieldsInvalid(name, amount);

    if (!areFieldsInvalid) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DateAddRecItemPage(),
        ),
      );
    }
  }

  // Will check and show error msg if a field is invalid.
  bool _checkFieldsInvalid(String name, String amount) {
    // check NAME field
    this.isNameInvalid = name.isEmpty ? true : false;

    // check PRICE field
    try {
      double.parse(amount);
      this.isAmountInvalid = false;
    } on FormatException {
      this.isAmountInvalid = true;
    }

    notifyListeners();

    // update areFieldsInvalid
    if (!isNameInvalid && !isAmountInvalid) {
      this.name = name;
      this.amount = double.parse(amount);
      return false;
    }
    return true;
  }
}
