import 'package:expense_app/Components/Global/colored_dot_container.dart';
import 'package:expense_app/Utils/chart_util.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';

class LegendContainer extends StatelessWidget {
  final List<ExpenseGroup> data;

  LegendContainer({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data.map(
          (expenseGroup) {
            if (expenseGroup.total > 0) {
              return Container(
                margin: EdgeInsets.only(bottom: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ColoredDotContainer(
                      color: CategoryProperties
                          .properties[expenseGroup.category]['color'],
                    ),
                    SizedBox(width: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          CategoryProperties.properties[expenseGroup.category]
                              ['string'],
                          style: Theme.of(context).textTheme.subhead),
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
