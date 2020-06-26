import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/EditAdd/amount_text_field.dart';
import 'package:Expenseye/Components/RecurringTransac/add_rec_transac_steps_header.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Providers/RecurringTransac/add_recurring_transac_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameAmountAddRecTransacPage extends StatefulWidget {
  @override
  _NameAmountAddRecTransacPageState createState() =>
      _NameAmountAddRecTransacPageState();
}

class _NameAmountAddRecTransacPageState extends State<NameAmountAddRecTransacPage>
    with TickerProviderStateMixin {
  TextEditingController _nameController;
  TextEditingController _amountController;
  AnimationController _animationController;
  Animation _animation;

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurringTransacModel>(context, listen: false);
    _animationController.forward();

    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: BottomNavButton(
            text: AppLocalizations.of(context).translate('nextCaps'),
            onPressed: () => _model.goNextFromNameAmountPage(
              _nameController.text.trim(),
              _amountController.text.trim(),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AddRecTransacStepsHeader(
                title: '4. ${AppLocalizations.of(context).translate('chooseANameAndAnAmount')}',
                percent: 0.8,
              ),
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
                    AmountTextField(
                      controller: _amountController,
                      isAmountInvalid: _model.isAmountInvalid,
                    ),
                  ),
                ],
              ),
            ],
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
  void initState() {
    _nameController = TextEditingController();
    _amountController = TextEditingController();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
