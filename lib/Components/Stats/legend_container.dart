import 'package:Expenseye/Components/Global/colored_dot.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:Expenseye/Utils/item_category.dart';
import 'package:flutter/material.dart';

class LegendContainer extends StatelessWidget {
  final List<ExpenseGroup> data;

  LegendContainer(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data.map(
          (expenseGroup) {
            if (expenseGroup.total > 0) {
              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ColoredDot(
                      color: Categories.map[expenseGroup.category].color,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        Categories.map[expenseGroup.category].name,
                      ),
                    ),
                  ],
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
