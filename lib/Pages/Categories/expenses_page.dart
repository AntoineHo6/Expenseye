import 'package:Expenseye/Components/Categories/category_btn.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> expenseKeys = new List();

    for (var key in ItemModel.catMap.keys) {
      if (ItemModel.catMap[key].type == ItemType.expense) {
        expenseKeys.add(key);
      }
    }

    return GridView.count(
      padding: const EdgeInsets.all(15),
      crossAxisSpacing: 7,
      mainAxisSpacing: 7,
      crossAxisCount: 4,
      children: List.generate(expenseKeys.length + 1, (index) {
        if (index >= expenseKeys.length) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: RawMaterialButton(
              onPressed: () => print('open add expense page'),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 35.0,
              ),
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: MyColors.black02dp,
            ),
          );
        }
        

        return CategoryBtn(
            category: ItemModel.catMap[expenseKeys[index]],
            onPressed: () => print('john'));
      }),
    );
  }
}
