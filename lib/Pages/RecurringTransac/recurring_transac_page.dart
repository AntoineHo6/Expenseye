import 'package:Expenseye/Components/RecurringTransac/my_divider.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Models/recurring_transac.dart';
import 'package:Expenseye/Pages/RecurringTransac/AddRecurringTransac/add_recurring_transac_home_page.dart';
import 'package:Expenseye/Pages/RecurringTransac/edit_recurring_transac_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecurringTransacPage extends StatefulWidget {
  @override
  _RecurringTransacPageState createState() => _RecurringTransacPageState();
}

class _RecurringTransacPageState extends State<RecurringTransacPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context).translate('recurringTransactions')),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRecurringTransacHomePage(),
                ),
              );
            },
            child: const Icon(Icons.add),
            shape: const CircleBorder(
              side: const BorderSide(color: Colors.transparent),
            ),
            elevation: 2,
          ),
        ],
      ),
      body: FutureBuilder<List<RecurringTransac>>(
        future: Provider.of<DbModel>(context).queryRecurringTransacs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              List<List<RecurringTransac>> recurringTransacsByCategoryType =
                  _splitTransacsByCategoryType(snapshot.data);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('expenses'),
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          MyDivider(),
                          Column(
                            children: _recurringTransacs(
                              context,
                              recurringTransacsByCategoryType[0],
                              TransacType.expense,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              AppLocalizations.of(context).translate('incomes'),
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          MyDivider(),
                          Column(
                            children: _recurringTransacs(
                              context,
                              recurringTransacsByCategoryType[1],
                              TransacType.income,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)
                      .translate('addYourFirstRecurringTransaction'),
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            }
          } else {
            return const Align(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  List<List<RecurringTransac>> _splitTransacsByCategoryType(
      List<RecurringTransac> recurringTransacs) {
    List<List<RecurringTransac>> recurringTransacsByCategoryType = new List(2);
    recurringTransacsByCategoryType[0] = new List(); // expenses
    recurringTransacsByCategoryType[1] = new List(); // incomes

    for (RecurringTransac recurringTransac in recurringTransacs) {
      if (DbModel.catMap[recurringTransac.category].type ==
          TransacType.expense) {
        recurringTransacsByCategoryType[0].add(recurringTransac);
      } else {
        recurringTransacsByCategoryType[1].add(recurringTransac);
      }
    }

    return recurringTransacsByCategoryType;
  }

  List<Widget> _recurringTransacs(
    BuildContext context,
    List<RecurringTransac> recurringTransacs,
    TransacType type,
  ) {
    final settingsNotifier =
        Provider.of<SettingsNotifier>(context, listen: false);

    return recurringTransacs.map(
      (recurringTransac) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: RaisedButton(
            highlightColor: DbModel.catMap[recurringTransac.category].color
                .withOpacity(0.2),
            splashColor: DbModel.catMap[recurringTransac.category].color
                .withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () =>
                _openEditRecurringTransacPage(context, recurringTransac),
            child: ListTile(
              leading: Icon(
                DbModel.catMap[recurringTransac.category].iconData,
                color: DbModel.catMap[recurringTransac.category].color,
              ),
              title: Text(
                recurringTransac.name,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              subtitle: _subtitleText(context, recurringTransac),
              trailing: Text(
                type == TransacType.expense
                    ? '- ${recurringTransac.amount.toStringAsFixed(2)} \$'
                    : '+ ${recurringTransac.amount.toStringAsFixed(2)} \$',
                style: TextStyle(
                  color: ColorChooserFromTheme.transacColorTypeChooser(
                    type,
                    settingsNotifier.getTheme(),
                  ),
                ),
              ),
              isThreeLine: true,
            ),
          ),
        );
      },
    ).toList();
  }

  void _openEditRecurringTransacPage(
      BuildContext context, RecurringTransac recurringTransac) async {
    int action = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRecurringTransacPage(recurringTransac),
      ),
    );

    if (action != null) {
      final snackBar = SnackBar(
        content: action == 1
            ? Text(AppLocalizations.of(context).translate('succEdited'))
            : Text(AppLocalizations.of(context).translate('succDeleted')),
        backgroundColor: Colors.grey.withOpacity(0.5),
      );

      Scaffold.of(context).showSnackBar(snackBar);

      // update page
      setState(() {});
    }
  }

  Widget _subtitleText(
      BuildContext context, RecurringTransac recurringTransac) {
    String periodicityTitle;
    periodicityTitle =
        PeriodicityHelper.getString(context, recurringTransac.periodicity);

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: '$periodicityTitle\n',
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
              fontStyle: FontStyle.italic,
            ),
          ),
          TextSpan(
            text: '${AppLocalizations.of(context).translate('nextDueDate')}: ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 12,
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          TextSpan(
            text:
                '${DateTimeUtil.formattedDate(context, recurringTransac.dueDate)}',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 13,
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
        ],
      ),
    );
  }
}
