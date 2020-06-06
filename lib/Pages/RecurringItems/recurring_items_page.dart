import 'package:Expenseye/Components/EditAddItem/confirmation_dialog.dart';
import 'package:Expenseye/Components/RecurringItems/my_divider.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Models/recurring_item.dart';
import 'package:Expenseye/Pages/RecurringItems/AddRecurringItem/add_recurring_item_home_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String expense = 'expense';
const String income = 'income';

class RecurringItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbModel = Provider.of<DbModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('recurringItems')),
        actions: <Widget>[
          RaisedButton(
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddRecurringItemHomePage()),
              );
            },
            child: const Icon(Icons.add),
            shape: const CircleBorder(
              side: const BorderSide(color: Colors.transparent),
            ),
            elevation: 8,
          ),
        ],
      ),
      body: FutureBuilder<List<RecurringItem>>(
        future: _dbModel.queryRecurringItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              List<List<RecurringItem>> recurringItemsByCategoryType =
                  _splitItemsByCategoryType(snapshot.data);
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
                            children: _recurringItemsContainers(
                              context,
                              recurringItemsByCategoryType[0],
                              ItemType.expense,
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
                            children: _recurringItemsContainers(
                              context,
                              recurringItemsByCategoryType[1],
                              ItemType.income,
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
                      .translate('addYourFirstRecurringItem'),
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

  List<List<RecurringItem>> _splitItemsByCategoryType(
      List<RecurringItem> recurringItems) {
    List<List<RecurringItem>> recurringItemsByCategoryType = new List(2);
    recurringItemsByCategoryType[0] = new List(); // expenses
    recurringItemsByCategoryType[1] = new List(); // incomes

    for (RecurringItem recurringItem in recurringItems) {
      if (DbModel.catMap[recurringItem.category].type == ItemType.expense) {
        recurringItemsByCategoryType[0].add(recurringItem);
      } else {
        recurringItemsByCategoryType[1].add(recurringItem);
      }
    }

    return recurringItemsByCategoryType;
  }

  List<Container> _recurringItemsContainers(BuildContext context,
      List<RecurringItem> recurringItems, ItemType itemType) {
    return recurringItems.map(
      (recurringItem) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: itemType == ItemType.expense
                ? MyColors.expenseBGColor
                : MyColors.incomeBGColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListTile(
            leading: Icon(
              DbModel.catMap[recurringItem.category].iconData,
              color: DbModel.catMap[recurringItem.category].color,
            ),
            title: Text(recurringItem.name),
            subtitle: _subtitleText(context, recurringItem),
            trailing: Text(
              '${recurringItem.value.toStringAsFixed(2)} \$',
            ),
            isThreeLine: true,
            onLongPress: () => _deleteRecurringItem(context, recurringItem),
          ),
        );
      },
    ).toList();
  }

  void _deleteRecurringItem(
      BuildContext context, RecurringItem recurringItem) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        AppLocalizations.of(context).translate('confirmDeleteMsg'),
      ),
    );

    if (confirmed != null && confirmed) {
      await Provider.of<DbModel>(context, listen: false)
          .deleteRecurringItem(recurringItem.id);
    }
  }

  Text _subtitleText(BuildContext context, RecurringItem recurringItem) {
    // TODO: use richText
    String periodicity;
    switch (recurringItem.periodicity) {
      case Periodicity.daily:
        periodicity = AppLocalizations.of(context).translate('daily');
        break;
      case Periodicity.weekly:
        periodicity = AppLocalizations.of(context).translate('weekly');
        break;
      case Periodicity.biweekly:
        periodicity = AppLocalizations.of(context).translate('biWeekly');
        break;
      case Periodicity.monthly:
        periodicity = AppLocalizations.of(context).translate('monthly');
        break;
      case Periodicity.yearly:
        periodicity = AppLocalizations.of(context).translate('yearly');
        break;
    }

    return Text(
      '$periodicity\n${AppLocalizations.of(context).translate('nextDueDate')}: ${DateTimeUtil.formattedDate(context, recurringItem.dueDate)}',
    );
  }
}
