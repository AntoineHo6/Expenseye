import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:flutter/material.dart';

// TODO: might remove
class IconBtn extends StatelessWidget {
  final String category;
  final Function function;

  IconBtn(this.category, this.function);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      onPressed: function,
      child: Icon(
        ItemModel.catMap[category].iconData,
        color: ItemModel.catMap[category].color,
      ),
    );
  }
}
