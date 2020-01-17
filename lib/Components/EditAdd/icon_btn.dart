import 'package:Expenseye/Utils/item_category.dart';
import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final ItemCategory category;
  final Function function;

  const IconBtn(this.category, this.function);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      onPressed: function,
      child: Icon(
        ItemCatProperties.properties[category]['iconData'],
        color: ItemCatProperties.properties[category]['color'],
      ),
    );
  }
}
