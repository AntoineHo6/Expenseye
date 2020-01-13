import 'package:expense_app/Components/Stats/expense_group_list_tile.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/chart_util.dart';
import 'package:flutter/material.dart';

// rename to container
class CategoryStatsContainer extends StatelessWidget {
  final List<ExpenseGroup> data;
  final double totalCost;

  CategoryStatsContainer({@required this.data, @required this.totalCost})
      : assert(data != null),
        assert(totalCost != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.black06dp,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
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
    );
  }
}