import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconsPage extends StatefulWidget {
  @override
  _IconsPageState createState() => _IconsPageState();
}

class _IconsPageState extends State<IconsPage> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.icons),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: List.generate(
          ExpenseCategory.values.length,
          (index) {
            return Container(
              color: Colors.amber,
              padding: const EdgeInsets.all(30),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return Icon(_expenseModel.indexToIconData(index),
                      size: constraint.biggest.height);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

/**
 * TODO: categories: food, transportation, shopping, entertainment, personal,
 * TODO:             medical, home, travel, people, others
 */
