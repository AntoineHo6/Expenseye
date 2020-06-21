import 'package:Expenseye/Components/Stats/item_group_list_tile.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class CategoryStatsContainer extends StatelessWidget {
  final List<CategoryGroup> data;
  final double totalCost;

  CategoryStatsContainer({@required this.data, @required this.totalCost});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).cardColor,
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () => null,
            child: Icon(Icons.sort),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, bottom: 7),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                '${AppLocalizations.of(context).translate('total')}:  ${totalCost.toStringAsFixed(2)} \$',
                textAlign: TextAlign.end,
              ),
            ),
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
    );
  }
}
