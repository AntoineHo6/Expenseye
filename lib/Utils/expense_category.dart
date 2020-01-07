import 'package:expense_app/Resources/Strings.dart';
import 'package:flutter/material.dart';

// TODO: add hobbie?
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
      'string': Strings.food,
      'iconData': Icons.restaurant,
      'color': Color(0xffff9933)
    },
    ExpenseCategory.transportation: {
      'string': Strings.transportation,
      'iconData': Icons.directions_car,
      'color': Colors.amber
    },
    ExpenseCategory.shopping: {
      'string': Strings.shopping,
      'iconData': Icons.shopping_cart,
      'color': Color(0xff47d147)
    },
    ExpenseCategory.entertainment: {
      'string': Strings.entertainment,
      'iconData': Icons.movie,
      'color': Color(0xffcc66cc)
    },
    ExpenseCategory.personal: {
      'string': Strings.personal,
      'iconData': Icons.face,
      'color': Color(0xff66ccff)
    },
    ExpenseCategory.medical: {
      'string': Strings.medical,
      'iconData': Icons.healing,
      'color': Color(0xffff3333)
    },
    ExpenseCategory.home: {
      'string': Strings.home,
      'iconData': Icons.home,
      'color': Color(0xffc68c53)
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
    ExpenseCategory.others: {
      'string': Strings.others,
      'iconData': Icons.tab,
      'color': Color(0xff669999)
    }
  };
}
