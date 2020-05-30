import 'package:Expenseye/Components/Global/name_text_field.dart';
import 'package:Expenseye/Components/Global/price_text_field.dart';
import 'package:Expenseye/Components/RecurrentItems/bottom_nav_button.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Providers/RecurrentItems/add_recurrent_item_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameAmountAddRecItemPage extends StatefulWidget {
  @override
  _NameAmountAddRecItemPageState createState() =>
      _NameAmountAddRecItemPageState();
}

class _NameAmountAddRecItemPageState extends State<NameAmountAddRecItemPage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurrentItemModel>(context, listen: false);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: BottomNavButton(
          color: _model.type == ItemType.expense
              ? MyColors.expenseColor
              : MyColors.incomeColor,
          text: AppLocalizations.of(context).translate('nextCaps'),
          onPressed: () => _model.goNextFromNameAmountPage(
            _nameController.text,
            _amountController.text,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
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
              ],
            ),
          ],
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
