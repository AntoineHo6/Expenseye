import 'package:Expenseye/Enums/item_type.dart';
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
