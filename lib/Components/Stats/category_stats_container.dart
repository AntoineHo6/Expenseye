import 'package:Expenseye/Components/Stats/item_group_list_tile.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class CategoryStatsContainer extends StatelessWidget {
  final List<CategoryGroup> data;
  final double totalCost;
  final Function changeCurrentSort;

  CategoryStatsContainer({
    @required this.data,
    @required this.totalCost,
    @required this.changeCurrentSort,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: PopupMenuButton(
                    onSelected: changeCurrentSort,
                    color: Theme.of(context).buttonColor,
                    icon: const Icon(Icons.sort),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'Name',
                          child: Text('Name'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Amount',
                          child: Text('Amount'),
                        ),
                      ];
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(
                    '${AppLocalizations.of(context).translate('total')}:  ${totalCost.toStringAsFixed(2)} \$',
                  ),
                ),
              ],
            ),
            Column(
              children: data.map(
                (expenseGroup) {
                  if (expenseGroup.total > 0) {
                    return Card(
                      color: Theme.of(context).buttonColor,
                      child: ItemGroupListTile(
                        expenseGroup: expenseGroup,
                        totalCost: totalCost,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
