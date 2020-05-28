import 'package:Expenseye/Components/RecurrentItems/my_divider.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Enums/recurrent_item_type.dart';
import 'package:Expenseye/Models/recurrent_item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecurrentItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbModel = Provider.of<DbModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('recurrentItems')),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => null,
            child: const Icon(Icons.add),
            shape: const CircleBorder(
              side: const BorderSide(color: Colors.transparent),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<RecurrentItem>>(
        future: _dbModel.queryRecurrentItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              List<List<RecurrentItem>> recurrentItemsByCategoryType =
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
                            children: _recurrentItemsContainers(
                              context,
                              recurrentItemsByCategoryType[0],
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
                            children: _recurrentItemsContainers(
                              context,
                              recurrentItemsByCategoryType[1],
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
                child: Text(AppLocalizations.of(context).translate('noData')),
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
}

List<List<RecurrentItem>> _splitItemsByCategoryType(
    List<RecurrentItem> recurrentItems) {
  List<List<RecurrentItem>> recurrentItemsByCategoryType = new List(2);
  recurrentItemsByCategoryType[0] = new List(); // expenses
  recurrentItemsByCategoryType[1] = new List(); // incomes

  for (RecurrentItem recurrentItem in recurrentItems) {
    if (DbModel.catMap[recurrentItem.category].type == ItemType.expense) {
      recurrentItemsByCategoryType[0].add(recurrentItem);
    } else {
      recurrentItemsByCategoryType[1].add(recurrentItem);
    }
  }

  return recurrentItemsByCategoryType;
}

List<Container> _recurrentItemsContainers(BuildContext context,
    List<RecurrentItem> recurrentItems, ItemType itemType) {
  return recurrentItems.map(
    (recurrentItem) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: itemType == ItemType.expense
              ? MyColors.expenseColor
              : MyColors.incomeColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          leading: Icon(
            DbModel.catMap[recurrentItem.category].iconData,
            color: DbModel.catMap[recurrentItem.category].color,
          ),
          title: Text(recurrentItem.name),
          subtitle: _subtitleText(context, recurrentItem),
          trailing: Text(
            '${recurrentItem.value.toStringAsFixed(2)} \$',
          ),
          isThreeLine: true,
        ),
      );
    },
  ).toList();
}

Text _subtitleText(BuildContext context, RecurrentItem recurrentItem) {
  // TODO: use richText
  String type;
  switch (recurrentItem.type) {
    case RecurrentItemType.daily:
      type = AppLocalizations.of(context).translate('daily');
      break;
    case RecurrentItemType.weekly:
      type = AppLocalizations.of(context).translate('weekly');
      break;
    case RecurrentItemType.biweekly:
      type = AppLocalizations.of(context).translate('biWeekly');
      break;
    case RecurrentItemType.monthly:
      type = AppLocalizations.of(context).translate('monthly');
      break;
    case RecurrentItemType.yearly:
      type = type = AppLocalizations.of(context).translate('yearly');
      break;
  }

  return Text(
    '$type\n${AppLocalizations.of(context).translate('nextDueDate')}: ${DateTimeUtil.formattedDate(context, recurrentItem.date)}',
  );
}

// ListView(
//   children: <Widget>[
//     Container(
//       color: Colors.white30,
//       child: ListTile(
//         leading: Icon(Icons.fastfood, color: Colors.white),
//         title: Text('Burger'),
//         subtitle: Text('weekly\nNext payment: May 31st, 2020'),
//         trailing: Text('20 \$'),
//         isThreeLine: true,
// onTap: () => {
//                         _dbModel.insertRecurrentItem(
//                           RecurrentItem(
//                             'asd',
//                             12,
//                             DateTimeUtil.timeToZeroInDate(DateTime.now()),
//                             0,
//                             'food',
//                             RecurrentItemType.monthly,
//                           ),
//                         )
//                       },
//       ),
//     ),
//   ],
// ),
