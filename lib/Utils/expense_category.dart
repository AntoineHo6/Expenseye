import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

enum ExpenseCategory {
  food,
  transportation,
  shopping,
  entertainment,
  activity,
  medical,
  home,
  travel,
  people,
  education,
  others
}

class CategoryProperties {
  static const Map<ExpenseCategory, Map<String, Object>> properties = {
    ExpenseCategory.food: {
      'string': Strings.food,
      'iconData': Icons.restaurant,
      'color': Color(0xffff8533)
    },
    ExpenseCategory.transportation: {
      'string': Strings.transportation,
      'iconData': Icons.directions_car,
      'color': Colors.yellow
    },
    ExpenseCategory.shopping: {
      'string': Strings.shopping,
      'iconData': Icons.shopping_cart,
      'color': Color(0xffac3973)
    },
    ExpenseCategory.entertainment: {
      'string': Strings.entertainment,
      'iconData': Icons.movie,
      'color': Color(0xff66ccff)
    },
    ExpenseCategory.activity: {
      'string': Strings.activity,
      'iconData': Icons.insert_emoticon,
      'color': Color(0xffff66cc)
    },
    ExpenseCategory.medical: {
      'string': Strings.medical,
      'iconData': Icons.healing,
      'color': Color(0xffff3333)
    },
    ExpenseCategory.home: {
      'string': Strings.home,
      'iconData': Icons.home,
      'color': Color(0xffcc9966)
    },
    ExpenseCategory.travel: {
      'string': Strings.travel,
      'iconData': Icons.airplanemode_active,
      'color': Color(0xff99e600)
    },
    ExpenseCategory.people: {
      'string': Strings.people,
      'iconData': Icons.people,
      'color': Color(0xff3377ff)
    },
    ExpenseCategory.education: {
      'string': Strings.education,
      'iconData': Icons.school,
      'color': Color(0xff9933ff)
    },
    ExpenseCategory.others: {
      'string': Strings.others,
      'iconData': Icons.tab,
      'color': Colors.white
    }
  };
}
