import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData iconData;
  final Color color;
  final ItemType type;

  const Category(
      {@required this.name,
      @required this.iconData,
      @required this.color,
      @required this.type});
}

class Categories {
  static const List<Category> list = [
    Category(
        name: Strings.food,
        iconData: Icons.restaurant,
        color: Color(0xffff8533),
        type: ItemType.expense),
    Category(
        name: Strings.salary,
        iconData: Icons.attach_money,
        color: Colors.green,
        type: ItemType.income),
  ];
}
