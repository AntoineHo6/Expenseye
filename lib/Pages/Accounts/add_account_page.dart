import 'package:Expenseye/Components/EditAdd/amount_text_field.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Components/Global/subheader.dart';
import 'package:Expenseye/Providers/Accounts/add_account_notifier.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAccountPage extends StatefulWidget {
  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddAccountNotifier(),
      child: Consumer<AddAccountNotifier>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).translate('addAccount'),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: BottomNavButton(
              text: AppLocalizations.of(context).translate('addCaps'),
              onPressed: () => model.addAccount(
                context,
                _nameController.text,
                _balanceController.text,
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              SubHeader(
                title: AppLocalizations.of(context).translate('name'),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: NameTextField(
                  controller: _nameController,
                  isNameInvalid: model.isNameInvalid,
                ),
              ),
              SubHeader(
                title: AppLocalizations.of(context).translate('balance'),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: AmountTextField(
                  controller: _balanceController,
                  isAmountInvalid: model.isAmountInvalid,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }
}
