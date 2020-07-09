import 'package:Expenseye/Components/EditAdd/amount_text_field.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/Global/app_bar_btn.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Components/Global/subheader.dart';
import 'package:Expenseye/Providers/Accounts/edit_account_notifier.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAccountPage extends StatefulWidget {
  final String accountId;

  EditAccountPage(this.accountId);

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditAccountNotifier(widget.accountId),
      child: Consumer<EditAccountNotifier>(
        builder: (context, notifier, child) => Scaffold(
          appBar: AppBar(
            title: Text(DbModel.accMap[widget.accountId].name),
            actions: <Widget>[
              AppBarBtn(
                onPressed: () => notifier.delete(context),
                icon: const Icon(Icons.delete_forever),
              )
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: BottomNavButton(
              color: Theme.of(context).buttonColor,
              disabledColor: Theme.of(context).buttonColor.withOpacity(0.8),
              text: AppLocalizations.of(context).translate('saveCaps'),
              onPressed: notifier.didInfoChange
                  ? () async => await notifier.editAccount(
                        context,
                        _nameController.text,
                        _amountController.text,
                      )
                  : null,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
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
                    isNameInvalid: notifier.isNameInvalid,
                    onChanged: notifier.infoChanged,
                  ),
                ),
                SubHeader(
                  title: AppLocalizations.of(context).translate('balance'),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: AmountTextField(
                    controller: _amountController,
                    isAmountInvalid: notifier.isAmountInvalid,
                    onChanged: notifier.infoChanged,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nameController.text = DbModel.accMap[widget.accountId].name;
    _amountController.text = DbModel.accMap[widget.accountId].balance.toString();
    super.initState();
  }
}
