import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:flutter/material.dart';

class CategoryGroupListTile extends StatelessWidget {
  final CategoryGroup categoryGroup;
  final double totalCost;

  CategoryGroupListTile({
    @required this.categoryGroup,
    @required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        DbModel.catMap[categoryGroup.category].iconData,
        color: DbModel.catMap[categoryGroup.category].color,
      ),
      title: Text(
        DbModel.catMap[categoryGroup.category].name,
      ),
      subtitle: Text('${_calcPercentage()}\%'),
      trailing: Text(
        '${categoryGroup.total.toStringAsFixed(2)} \$',
      ),
    );
  }

  String _calcPercentage() {
    String percentage;

    try {
      percentage = (categoryGroup.total * 100 / totalCost).toStringAsFixed(1);
    } catch (e) {
      percentage = '-1';
    }

    return percentage;
  }
}
