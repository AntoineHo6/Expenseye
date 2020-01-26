import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

// enum ItemCategory {
//   // expenses
//   food,
//   transportation,
//   shopping,
//   entertainment,
//   activity,
//   medical,
//   home,
//   travel,
//   people,
//   education,
//   // income
//   salary,
//   gift,
//   business,
//   insurance,
//   realEstate,
//   investment,
//   refund,
//   others
// }

class ItemCategories {
  static const Map<String, Map<String, Object>> properties = {
    'food': {
      'string': Strings.food,
      'iconData': Icons.restaurant,
      'color': Color(0xffff8533),
      'type': ItemType.expense
    },
    'transportation': {
      'string': Strings.transportation,
      'iconData': Icons.directions_car,
      'color': Colors.yellow,
      'type': ItemType.expense
    },
    'shopping': {
      'string': Strings.shopping,
      'iconData': Icons.shopping_cart,
      'color': Color(0xffac3973),
      'type': ItemType.expense
    },
    'entertainment': {
      'string': Strings.entertainment,
      'iconData': Icons.movie,
      'color': Color(0xff66ccff),
      'type': ItemType.expense
    },
    'activity': {
      'string': Strings.activity,
      'iconData': Icons.insert_emoticon,
      'color': Color(0xffff66cc),
      'type': ItemType.expense
    },
    'medical': {
      'string': Strings.medical,
      'iconData': Icons.healing,
      'color': Color(0xffff3333),
      'type': ItemType.expense
    },
    'home': {
      'string': Strings.home,
      'iconData': Icons.home,
      'color': Color(0xffcc9966),
      'type': ItemType.expense
    },
    'travel': {
      'string': Strings.travel,
      'iconData': Icons.airplanemode_active,
      'color': Color(0xffcc6600),
      'type': ItemType.expense
    },
    'people': {
      'string': Strings.people,
      'iconData': Icons.people,
      'color': Color(0xff3377ff),
      'type': ItemType.expense
    },
    'education': {
      'string': Strings.education,
      'iconData': Icons.school,
      'color': Color(0xff9933ff),
      'type': ItemType.expense
    },
    'salary': {
      'string': Strings.salary,
      'iconData': Icons.attach_money,
      'color': Colors.green,
      'type': ItemType.income
    },
    'gift': {
      'string': Strings.gift,
      'iconData': Icons.card_giftcard,
      'color': Color(0xffb84dff),
      'type': ItemType.income
    },
    'business': {
      'string': Strings.business,
      'iconData': Icons.work,
      'color': Color(0xff1a8cff),
      'type': ItemType.income
    },
    'insurance': {
      'string': Strings.insurance,
      'iconData': Icons.account_balance,
      'color': Color(0xff6666ff),
      'type': ItemType.income
    },
    'realEstate': {
      'string': Strings.realEstate,
      'iconData': Icons.business,
      'color': Color(0xffccccff),
      'type': ItemType.income
    },
    'investment': {
      'string': Strings.investment,
      'iconData': Icons.trending_up,
      'color': Color(0xff00e673),
      'type': ItemType.income
    },
    'refund': {
      'string': Strings.refund,
      'iconData': Icons.swap_vertical_circle,
      'color': Color(0xff66ffff),
      'type': ItemType.income
    },
    'others': {
      'string': Strings.others,
      'iconData': Icons.folder_open,
      'color': Colors.white,
    },
  };
}
