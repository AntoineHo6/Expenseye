import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class PeriodicityPickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('periodicity')),
      ),
      body: ListView(
        children: <Widget>[
          _PeriodicityBtn(
            periodicity: Periodicity.daily,
          ),
          _PeriodicityBtn(
            periodicity: Periodicity.weekly,
          ),
          _PeriodicityBtn(
            periodicity: Periodicity.biweekly,
          ),
          _PeriodicityBtn(
            periodicity: Periodicity.monthly,
          ),
          _PeriodicityBtn(
            periodicity: Periodicity.yearly,
          ),
        ],
      ),
    );
  }
}

class _PeriodicityBtn extends StatelessWidget {
  final Periodicity periodicity;

  _PeriodicityBtn({this.periodicity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: RaisedButton(
        padding: const EdgeInsets.all(20),
        onPressed: () => Navigator.pop(context, periodicity),
        child: Text(
          PeriodicityHelper.getString(context, periodicity),
          style: Theme.of(context).textTheme.headline6,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
