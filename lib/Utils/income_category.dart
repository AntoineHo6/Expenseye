import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

enum IncomeCategory {
  salary,
  gift,
  business,
  insurance,
  refund,
  other
}

class IncomeCatProperties {
  static const Map<IncomeCategory, Map<String, Object>> properties = {
    IncomeCategory.salary: {
      'string': Strings.salary,
      'iconData': Icons.attach_money,
      'color': Colors.green
    },
    IncomeCategory.gift: {
      'string': Strings.gift,
      'iconData': Icons.card_giftcard,
      'color': Color(0xffb84dff)
    },
    IncomeCategory.business: {
      'string': Strings.business,
      'iconData': Icons.work,
      'color': Color(0xff1a8cff),
    },
    IncomeCategory.insurance: {
      'string': Strings.insurance,
      'iconData': Icons.account_balance,
      'color': Color(0xff6666ff),
    },
    IncomeCategory.refund: {
      'string': Strings.refund,
      'iconData': Icons.swap_vertical_circle,
      'color': Color(0xff66ffff),
    },
    IncomeCategory.other: {
      'string': Strings.others,
      'iconData': Icons.folder_open,
      'color': Colors.white,
    },
  };
}