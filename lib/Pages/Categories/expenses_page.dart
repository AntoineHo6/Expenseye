import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> expenseCategories = new List();

    for (var category in ItemModel.catMap.values) {
      if (category.type == ItemType.expense) {
        expenseCategories.add(category);
      }
    }

    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 4,
      children: List.generate(
        expenseCategories.length,
        (index) {
          
        }
      ),
    );
  }
}
