import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

enum Periodicity {
  daily,
  weekly,
  biweekly,
  monthly,
  yearly,
}

class PeriodicityHelper {
  static String getString(BuildContext context, Periodicity periodicity) {
    switch (periodicity) {
      case Periodicity.daily:
        return AppLocalizations.of(context).translate('daily');
        break;
      case Periodicity.weekly:
        return AppLocalizations.of(context).translate('weekly');
        break;
      case Periodicity.biweekly:
        return AppLocalizations.of(context).translate('biWeekly');
        break;
      case Periodicity.monthly:
        return AppLocalizations.of(context).translate('monthly');
        break;
      case Periodicity.yearly:
        return AppLocalizations.of(context).translate('yearly');
        break;
      default:
        return "";
    }
  }
}
