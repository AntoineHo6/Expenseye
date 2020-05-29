import 'package:Expenseye/Components/Global/name_text_field.dart';
import 'package:Expenseye/Components/Global/price_text_field.dart';
import 'package:Expenseye/Providers/RecurrentItems/add_recurrent_item_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameAmountAddRecItemPage extends StatefulWidget {
  @override
  _NameAmountAddRecItemPageState createState() => _NameAmountAddRecItemPageState();
}

class _NameAmountAddRecItemPageState extends State<NameAmountAddRecItemPage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurrentItemModel>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _textFieldContainer(
            AppLocalizations.of(context).translate('name'),
            NameTextField(
              controller: _nameController,
              isNameInvalid: _model.isNameInvalid,
            ),
          ),
          _textFieldContainer(
            AppLocalizations.of(context).translate('amount'),
            PriceTextField(
              controller: _amountController,
              isPriceInvalid: _model.isAmountInvalid,
            ),
          ),
          RaisedButton(
            textTheme: ButtonTextTheme.primary,
            child: Text(
              AppLocalizations.of(context).translate('next'),
            ),
            onPressed: () => _model.goDateRecItemPage(
              context,
              _nameController.text,
              _amountController.text,
            ),
          ),
        ],
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
