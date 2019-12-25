import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:expense_app_beginner/ChangeNotifiers/Global/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpense createState() => _AddExpense();
}

class _AddExpense extends State<AddExpense> {
  // Name TextField
  final _nameController = TextEditingController();
  bool _isNameInvalid = false;

  // Price TextField
  final _priceController = TextEditingController();
  bool _isPriceInvalid = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Strings.newExpense),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          maxLength: 50,
          controller: _nameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: Strings.name,
            errorText:
                _isNameInvalid ? Strings.name + ' ' + Strings.isInvalid : null,
          ),
        ),
        TextField(
          maxLength: 10,
          controller: _priceController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: Strings.price,
            errorText: _isPriceInvalid
                ? Strings.price + ' ' + Strings.isInvalid
                : null,
          ),
          keyboardType: TextInputType.number,
        ),
      ]),
      actions: <Widget>[
        new FlatButton(
          child: new Text(Strings.cancelCaps),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text(Strings.submitCaps),
          onPressed: () {
            _addNewExpense();
          },
        ),
      ],
    );
  }

  void _addNewExpense() {
    // check NAME field
    _nameController.text.isEmpty
        ? _isNameInvalid = true
        : _isNameInvalid = false;

    // check PRICE field
    try {
      double.parse(_priceController.text);
      _isPriceInvalid = false;
    } on FormatException {
      _isPriceInvalid = true;
    }
    setState(() {});
    
    // if both fields have valid values
    if (!_isNameInvalid && !_isPriceInvalid) {
      Provider.of<ExpenseModel>(context).addExpense(
          _nameController.text, double.parse(_priceController.text));

      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}

/**
 * TODO: Make textFields custom widgets for reusability and reduce code lines
 * TODO: add date and time for expense
 * TODO: Check if price is also invalid
 */
