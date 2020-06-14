import 'package:Expenseye/Components/Global/confirmation_dialog.dart';
import 'package:Expenseye/Enums/periodicity_error.dart';
import 'package:Expenseye/Models/recurring_item.dart';
import 'package:Expenseye/Pages/EditAddItem/choose_category_page.dart';
import 'package:Expenseye/Pages/RecurringItems/periodicity_picker_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/theme_notifier.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/Utils/edit_add_rec_item_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRecurringItemModel extends ChangeNotifier {
  RecurringItem recurringItem;
  bool didInfoChange = false;
  bool isNameInvalid = false;
  bool isAmountInvalid = false;

  EditRecurringItemModel(this.recurringItem);

  void delete(BuildContext context) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        AppLocalizations.of(context).translate('confirmDeleteMsg'),
      ),
    );

    if (confirmed != null && confirmed) {
      await Provider.of<DbModel>(context, listen: false)
          .deleteRecurringItem(recurringItem.id);
      Navigator.pop(context, 2);
    }
  }

  // Will make the save button clickable
  void infoChanged(String text) {
    didInfoChange = true;
    notifyListeners();
  }

  void chooseDate(BuildContext context) async {
    DateTime newDate = await DateTimeUtil.chooseDate(
      context,
      recurringItem.dueDate,
      Provider.of<ThemeNotifier>(context, listen: false).getTheme(),
    );
    if (newDate != null) {
      recurringItem.dueDate = newDate;
      infoChanged(null);
    }
  }

  /// On selected category in the ChooseCategoryPage, update the current category
  /// in the model
  Future<void> openChooseCategoryPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseCategoryPage(
          type: DbModel.catMap[recurringItem.category].type,
        ),
      ),
    );

    if (result != null) {
      recurringItem.category = result;
      infoChanged(null);
    }
  }

  Future<void> openPeriodicityPickerPage(BuildContext context) async {
    final pickedPeriodicity = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PeriodicityPickerPage(),
      ),
    );

    if (pickedPeriodicity != null) {
      recurringItem.periodicity = pickedPeriodicity;
      infoChanged(null);
    }
  }

  Future<void> editRecurringItem(
      BuildContext context, String newName, String newAmount) async {
    newName = newName.trim();
    PeriodicityError periodicityError = EditAddRecItemUtil.checkDueDateForError(
      recurringItem.periodicity,
      recurringItem.dueDate,
    );

    bool areFieldsInvalid = _checkFieldsInvalid(newName, newAmount);
    bool isDueDateValid = _isDueDateValid(periodicityError);

    // if all the fields are valid, update and quit
    if (!areFieldsInvalid && isDueDateValid) {
      recurringItem.name = newName;
      recurringItem.amount = double.parse(newAmount);
      await Provider.of<DbModel>(context, listen: false)
          .editRecurringItem(recurringItem);
      Navigator.pop(context, 1);
    } else if (!isDueDateValid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '${AppLocalizations.of(context).translate('anErrorHasOccurred')}',
            ),
            content: Text(
              EditAddRecItemUtil.getDueDateErrorMsg(context, periodicityError),
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Theme.of(context).textTheme.bodyText1.color,
                child: Text(
                  AppLocalizations.of(context).translate('confirmCaps'),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }

  bool _isDueDateValid(PeriodicityError periodicityError) {
    bool isDueDateValid;
    switch (periodicityError) {
      case PeriodicityError.none:
        isDueDateValid = true;
        break;
      case PeriodicityError.above28th:
      case PeriodicityError.above62DaysInPast:
        isDueDateValid = false;
        break;
    }

    return isDueDateValid;
  }

  // Will check and show error msg if a field is invalid.
  bool _checkFieldsInvalid(String newName, String newAmount) {
    // check NAME field
    isNameInvalid = newName.isEmpty ? true : false;

    // check AMOUNT field
    try {
      double.parse(newAmount);
      isAmountInvalid = false;
    } on FormatException {
      isAmountInvalid = true;
    }

    notifyListeners();

    // update areFieldsInvalid
    if (!isNameInvalid && !isAmountInvalid) {
      return false;
    }
    return true;
  }
}
