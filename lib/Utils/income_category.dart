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
      'color': null
    },
    IncomeCategory.gift: {
      'string': Strings.gift,
      'iconData': Icons.card_giftcard,
      'color': null
    }
  }
}