import 'package:Expenseye/Components/RecurringItems/my_divider.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Models/recurring_item.dart';
import 'package:Expenseye/Pages/RecurringItems/AddRecurringItem/add_recurring_item_home_page.dart';
import 'package:Expenseye/Pages/RecurringItems/edit_recurring_item_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecurringItemsPage extends StatefulWidget {
  @override
  _RecurringItemsPageState createState() => _RecurringItemsPageState();
}

class _RecurringItemsPageState extends State<RecurringItemsPage> {
  @override
  Widget build(BuildContext context) {
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
        future: Provider.of<DbModel>(context).queryRecurringItems(),
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
                            children: _recurringItems(
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
                            children: _recurringItems(
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

  List<Widget> _recurringItems(BuildContext context,
      List<RecurringItem> recurringItems, ItemType itemType) {
    return recurringItems.map(
      (recurringItem) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: RaisedButton(
            color:
                DbModel.catMap[recurringItem.category].type == ItemType.expense
                    ? MyColors.expenseBGColor
                    : MyColors.incomeBGColor,
            highlightColor:
                DbModel.catMap[recurringItem.category].color.withOpacity(0.2),
            splashColor:
                DbModel.catMap[recurringItem.category].color.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            // onPressed: () => _deleteRecurringItem(context, recurringItem),
            onPressed: () => _openEditRecurringItemPage(context, recurringItem),
            child: ListTile(
              leading: Icon(
                DbModel.catMap[recurringItem.category].iconData,
                color: DbModel.catMap[recurringItem.category].color,
              ),
              title: Text(
                recurringItem.name,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              subtitle: _subtitleText(context, recurringItem),
              trailing: Text(
                '${recurringItem.value.toStringAsFixed(2)} \$',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              isThreeLine: true,
            ),
          ),
        );
      },
    ).toList();
  }

  void _openEditRecurringItemPage(
      BuildContext context, RecurringItem recurringItem) async {
    int action = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRecurringItemPage(recurringItem),
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

  Text _subtitleText(BuildContext context, RecurringItem recurringItem) {
    // TODO: use richText
    String periodicityTitle;
    periodicityTitle =
        PeriodicityHelper.getString(context, recurringItem.periodicity);

    return Text(
      '$periodicityTitle\n${AppLocalizations.of(context).translate('nextDueDate')}: ${DateTimeUtil.formattedDate(context, recurringItem.dueDate)}',
    );
  }
}
