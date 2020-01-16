import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

enum ItemCategory {
  // expenses
  food,
  transportation,
  shopping,
  entertainment,
  activity,
  medical,
  home,
  travel,
  people,
  // income
  salary,
  gift,
  business,
  insurance,
  refund,
  others
}

class ItemCatProperties {
  static const Map<ItemCategory, Map<String, Object>> properties = {
    ItemCategory.food: {
      'string': Strings.food,
      'iconData': Icons.restaurant,
      'color': Color(0xffff8533)
    },
    ItemCategory.transportation: {
      'string': Strings.transportation,
      'iconData': Icons.directions_car,
      'color': Colors.yellow
    },
    ItemCategory.shopping: {
      'string': Strings.shopping,
      'iconData': Icons.shopping_cart,
      'color': Color(0xff9999ff)
    },
    ItemCategory.entertainment: {
      'string': Strings.entertainment,
      'iconData': Icons.movie,
      'color': Color(0xff66ccff)
    },
    ItemCategory.activity: {
      'string': Strings.activity,
      'iconData': Icons.insert_emoticon,
      'color': Color(0xffff66cc)
    },
    ItemCategory.medical: {
      'string': Strings.medical,
      'iconData': Icons.healing,
      'color': Color(0xffff3333)
    },
    ItemCategory.home: {
      'string': Strings.home,
      'iconData': Icons.home,
      'color': Color(0xffcc9966)
    },
    ItemCategory.travel: {
      'string': Strings.travel,
      'iconData': Icons.airplanemode_active,
      'color': Color(0xff99e600)
    },
    ItemCategory.people: {
      'string': Strings.people,
      'iconData': Icons.people,
      'color': Color(0xff3377ff)
    },
    ItemCategory.salary: {
      'string': Strings.salary,
      'iconData': Icons.attach_money,
      'color': Colors.green
    },
    ItemCategory.gift: {
      'string': Strings.gift,
      'iconData': Icons.card_giftcard,
      'color': Color(0xffb84dff)
    },
    ItemCategory.business: {
      'string': Strings.business,
      'iconData': Icons.work,
      'color': Color(0xff1a8cff),
    },
    ItemCategory.insurance: {
      'string': Strings.insurance,
      'iconData': Icons.account_balance,
      'color': Color(0xff6666ff),
    },
    ItemCategory.refund: {
      'string': Strings.refund,
      'iconData': Icons.swap_vertical_circle,
      'color': Color(0xff66ffff),
    },
    ItemCategory.others: {
      'string': Strings.others,
      'iconData': Icons.folder_open,
      'color': Colors.white,
    },
  };
}
