import 'package:Expenseye/Components/Stats/expense_group_list_tile.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryStatsContainer extends StatelessWidget {
  final List<ExpenseGroup> data;
  final double totalCost;

  CategoryStatsContainer({@required this.data, @required this.totalCost});

  @override
  Widget build(BuildContext context) {
    //final _dbModel = Provider.of<DbModel>(context);

    return Container(
      decoration: BoxDecoration(
        color: MyColors.black06dp,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(right: 20, bottom: 7),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  '${totalCost.toStringAsFixed(2)} \$',
                  textAlign: TextAlign.end,
                ),
              )),
          Column(
            children: data.map(
              (expenseGroup) {
                if (expenseGroup.total > 0) {
                  return Card(
                    color: MyColors.black02dp,
                    child: ExpenseGroupListTile(
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
