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
      'color': Color(0xffff9933)
    },
    ExpenseCategory.transportation: {
      'iconData': Icons.directions_car,
      'color': Colors.amber
    },
    ExpenseCategory.shopping: {
      'iconData': Icons.shopping_cart,
      'color': Color(0xff47d147)
    },
    ExpenseCategory.entertainment: {
      'iconData': Icons.movie,
      'color': Color(0xffcc66cc)
    },
    ExpenseCategory.personal: {
      'iconData': Icons.face,
      'color': Color(0xff66ccff)
    },
    ExpenseCategory.medical: {
      'iconData': Icons.healing,
      'color': Color(0xffff3333)
    },
    ExpenseCategory.home: {
      'iconData': Icons.home,
      'color': Color(0xffc68c53)
    },
    ExpenseCategory.travel: {
      'iconData': Icons.airplanemode_active,
      'color': Color(0xff99e600)
    },
    ExpenseCategory.people: {
      'iconData': Icons.people,
      'color': Color(0xff3377ff)
    },
    ExpenseCategory.others: {
      'iconData': Icons.tab,
      'color': Color(0xff669999)
    }
  };
}
