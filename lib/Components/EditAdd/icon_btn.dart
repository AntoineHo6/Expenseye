import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final String category;
  final Function function;

  const IconBtn(this.category, this.function);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      onPressed: function,
      child: Icon(
        ItemModel.categoriesMap[category].iconData,
        color: ItemModel.categoriesMap[category].color,
      ),
    );
  }
}
