import 'package:Expenseye/Components/EditAdd/category_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/date_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/EditAdd/amount_text_field.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Providers/EditAddTransac/add_transac_model.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class AddTransacDialog extends StatefulWidget {
  final DateTime initialDate;
  final TransacType type;

  AddTransacDialog(this.initialDate, this.type);

  @override
  _AddTransacDialogState createState() => _AddTransacDialogState();
}

class _AddTransacDialogState extends State<AddTransacDialog> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final settingsNotifier =
        Provider.of<SettingsNotifier>(context, listen: false);
    String title;
    Icon icon;
    if (widget.type == TransacType.expense) {
      title = AppLocalizations.of(context).translate('newExpense');
      icon = Icon(
        MdiIcons.currencyUsdCircle,
        color: ColorChooserFromTheme.transacColorTypeChooser(
          widget.type,
          settingsNotifier.getTheme(),
        ),
      );
    } else {
      title = AppLocalizations.of(context).translate('newIncome');
      icon = Icon(
        Icons.account_balance_wallet,
        color: ColorChooserFromTheme.transacColorTypeChooser(
          widget.type,
          settingsNotifier.getTheme(),
        ),
      );
    }

    return new ChangeNotifierProvider(
      create: (_) => new AddTransacModel(widget.initialDate, widget.type),
      child: Consumer<AddTransacModel>(
        builder: (context, model, child) => AlertDialog(
          title: Row(
            children: <Widget>[
              icon,
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  NameTextField(
                    controller: _nameController,
                    isNameInvalid: model.isNameInvalid,
                  ),
                  AmountTextField(
                    controller: _amountController,
                    isAmountInvalid: model.isAmountInvalid,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DatePickerBtn(
                    width: double.infinity,
                    height: 40,
                    date: model.date,
                    onPressed: () => model.chooseDate(
                      context,
                      widget.initialDate,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  CategoryPickerBtn(
                    width: double.infinity,
                    height: 40,
                    iconSize: 30,
                    iconBottomPosition: null,
                    categoryId: model.categoryId,
                    onPressed: () => model.openChooseCategoryPage(context),
                    borderSideColor: model.isCategoryMissingError
                        ? Theme.of(context).errorColor
                        : Colors.transparent,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  model.isCategoryMissingError
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('noCategorySelected'),
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context).translate('cancelCaps')),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              child: Text(AppLocalizations.of(context).translate('submitCaps')),
              onPressed: () => model.addTransac(
                context,
                _nameController.text.trim(),
                _amountController.text.trim(),
              ),
            ),
          ],
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
}
