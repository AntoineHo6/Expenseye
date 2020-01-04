import 'package:flutter/material.dart';

enum ExpenseCategory {
  food,
  transportation,
  shopping,
  entertainment,
  personal,
  medical,
  home,
  travel,
  people,
  others
}

// temp. move elsewhere later maybe
class CategoryProperties {
  static const Map<ExpenseCategory, Map<String, Object>> properties = {
    ExpenseCategory.food: {
      'iconData': Icons.restaurant,
      'color': Colors.red
    },
    ExpenseCategory.transportation: {
      'iconData': Icons.directions_car,
      'color': Colors.red
    },
    ExpenseCategory.shopping: {
      'iconData': Icons.shopping_cart,
      'color': Colors.red
    },
    ExpenseCategory.entertainment: {
      'iconData': Icons.movie,
      'color': Colors.red
    },
    ExpenseCategory.personal: {
      'iconData': Icons.face,
      'color': Colors.red
    },
    ExpenseCategory.medical: {
      'iconData': Icons.healing,
      'color': Colors.red
    },
    ExpenseCategory.home: {
      'iconData': Icons.home,
      'color': Colors.red
    },
    ExpenseCategory.travel: {
      'iconData': Icons.airplanemode_active,
      'color': Colors.red
    },
    ExpenseCategory.people: {
      'iconData': Icons.people,
      'color': Colors.red
    },
    ExpenseCategory.others: {
      'iconData': Icons.tab,
      'color': Colors.red
    }
  };
}
