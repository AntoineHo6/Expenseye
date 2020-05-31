import 'package:Expenseye/Components/RecurrentItems/add_rec_item_steps_header.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Providers/RecurrentItems/add_recurrent_item_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PeriodicityAddRecItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddRecItemStepsHeader(AppLocalizations.of(context).translate('selectAPeriodicity')),
        Expanded(
          child: ListView(
            children: <Widget>[
              _listViewItem(
                context,
                AppLocalizations.of(context).translate('daily'),
                Periodicity.daily,
              ),
              _listViewItem(
                context,
                AppLocalizations.of(context).translate('weekly'),
                Periodicity.weekly,
              ),
              _listViewItem(
                context,
                AppLocalizations.of(context).translate('biWeekly'),
                Periodicity.biweekly,
              ),
              _listViewItem(
                context,
                AppLocalizations.of(context).translate('monthly'),
                Periodicity.monthly,
              ),
              _listViewItem(
                context,
                AppLocalizations.of(context).translate('yearly'),
                Periodicity.yearly,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _listViewItem(
      BuildContext context, String title, Periodicity periodicity) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      color: MyColors.black12dp,
      child: ListTile(
        title: Text(title),
        onTap: () {
          Provider.of<AddRecurrentItemModel>(context, listen: false)
              .goNextFromPeriodicityPage(periodicity);
        },
      ),
    );
  }
}
