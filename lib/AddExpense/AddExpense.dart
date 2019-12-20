import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:expense_app_beginner/Blocs/TodayBloc.dart';
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
          controller: _nameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: Strings.name,
            errorText: _isNameInvalid
                ? Strings.name + ' ' + Strings.cantBeEmpty
                : null,
          ),
        ),
        TextField(
          controller: _priceController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: Strings.price,
            errorText: _isPriceInvalid
                ? Strings.price + ' ' + Strings.cantBeEmpty
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
    setState(() {
      _nameController.text.isEmpty
          ? _isNameInvalid = true
          : _isNameInvalid = false;
      _priceController.text.isEmpty
          ? _isPriceInvalid = true
          : _isPriceInvalid = false;
    });

    if (!_isNameInvalid && !_isPriceInvalid) {
      Provider.of<TodayBloc>(context, listen: false).addExpense(
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
