import 'package:Expenseye/Components/Global/name_text_field.dart';
import 'package:Expenseye/Components/Global/price_text_field.dart';
import 'package:Expenseye/Providers/RecurrentItems/add_recurrent_item_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecurrentItemPage extends StatefulWidget {
  @override
  _AddRecurrentItemPageState createState() => _AddRecurrentItemPageState();
}

class _AddRecurrentItemPageState extends State<AddRecurrentItemPage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddRecurrentItemModel(),
      child: Consumer<AddRecurrentItemModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Add new recurrent Item'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _textFieldContainer(
                  AppLocalizations.of(context).translate('name'),
                  NameTextField(
                    controller: _nameController,
                    isNameInvalid: model.isNameInvalid,
                  ),
                ),
                _textFieldContainer(
                  AppLocalizations.of(context).translate('amount'), // TODO:
                  PriceTextField(
                    controller: _amountController,
                    isPriceInvalid: model.isPriceInvalid,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _textFieldContainer(String title, dynamic textField) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Text(
              '$title :',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          textField,
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
