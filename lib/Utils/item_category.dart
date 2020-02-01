import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class Categories {
  static const Map<String, Category> map = {
    // * Default Expenses
    Strings.food: Category(
      name: Strings.food,
      iconData: Icons.restaurant,
      color: Color(0xffff8533),
      type: ItemType.expense,
    ),
    Strings.transportation: Category(
      name: Strings.transportation,
      iconData: Icons.directions_car,
      color: Colors.yellow,
      type: ItemType.expense,
    ),
    Strings.shopping: Category(
      name: Strings.shopping,
      iconData: Icons.shopping_cart,
      color: Color(0xffac3973),
      type: ItemType.expense,
    ),
    Strings.entertainment: Category(
      name: Strings.entertainment,
      iconData: Icons.movie,
      color: Color(0xff66ccff),
      type: ItemType.expense,
    ),
    Strings.activity: Category(
      name: Strings.activity,
      iconData: Icons.insert_emoticon,
      color: Color(0xffff66cc),
      type: ItemType.expense,
    ),
    Strings.medical: Category(
      name: Strings.medical,
      iconData: Icons.healing,
      color: Color(0xffff3333),
      type: ItemType.expense,
    ),
    Strings.home: Category(
      name: Strings.home,
      iconData: Icons.home,
      color: Color(0xffcc9966),
      type: ItemType.expense,
    ),
    Strings.travel: Category(
      name: Strings.travel,
      iconData: Icons.airplanemode_active,
      color: Color(0xffcc6600),
      type: ItemType.expense,
    ),
    Strings.people: Category(
      name: Strings.people,
      iconData: Icons.people,
      color: Color(0xff3377ff),
      type: ItemType.expense,
    ),
    Strings.education: Category(
      name: Strings.education,
      iconData: Icons.school,
      color: Color(0xff9933ff),
      type: ItemType.expense,
    ),
    // * Default Incomes
    Strings.salary: Category(
      name: Strings.salary,
      iconData: Icons.attach_money,
      color: Colors.green,
      type: ItemType.income,
    ),
    Strings.gift: Category(
      name: Strings.gift,
      iconData: Icons.card_giftcard,
      color: Color(0xffb84dff),
      type: ItemType.income,
    ),
    Strings.business: Category(
      name: Strings.business,
      iconData: Icons.work,
      color: Color(0xff1a8cff),
      type: ItemType.income,
    ),
    Strings.insurance: Category(
      name: Strings.insurance,
      iconData: Icons.account_balance,
      color: Color(0xff6666ff),
      type: ItemType.income,
    ),
    Strings.realEstate: Category(
      name: Strings.realEstate,
      iconData: Icons.business,
      color: Color(0xffccccff),
      type: ItemType.income,
    ),
    Strings.investment: Category(
      name: Strings.investment,
      iconData: Icons.trending_up,
      color: Color(0xff00e673),
      type: ItemType.income,
    ),
    Strings.refund: Category(
      name: Strings.refund,
      iconData: Icons.swap_vertical_circle,
      color: Color(0xff66ffff),
      type: ItemType.income,
    ),
    Strings.others: Category(
      name: Strings.others,
      iconData: Icons.folder_open,
      color: Colors.white,
      // TODO: add new type: hybrid
    ),
  };
}
