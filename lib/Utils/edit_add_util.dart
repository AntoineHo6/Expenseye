import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Enums/periodicity_error.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class EditAddUtil {
  static PeriodicityError checkDueDateForError(
      Periodicity periodicity, DateTime dueDate) {
    if (DateTime.now().difference(dueDate).inDays > 62) {
      return PeriodicityError.above62DaysInPast;
    } else if ((periodicity == Periodicity.monthly ||
            periodicity == Periodicity.yearly) &&
        dueDate.day > 28) {
      return PeriodicityError.above28th;
    } else {
      return PeriodicityError.none;
    }
  }

  static String getDueDateErrorMsg(
      BuildContext context, PeriodicityError error) {
    String errorMsg;
    switch (error) {
      case PeriodicityError.none:
        break;
      case PeriodicityError.above28th:
        errorMsg =
            AppLocalizations.of(context).translate('errorSelectDayBetween1-28');
        break;
      case PeriodicityError.above62DaysInPast:
        errorMsg = AppLocalizations.of(context)
            .translate('errorSelectDayWithin62DaysInThePast');
        break;
    }

    return errorMsg;
  }
}
