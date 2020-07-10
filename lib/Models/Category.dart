import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/mdi_icon_data.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class Category {
  String id;
  String name;
  IconData iconData;
  Color color;
  TransacType type;

  Category({
    @required this.id,
    @required this.name,
    @required this.iconData,
    @required this.color,
    @required this.type,
  });

  Category.fromMap(Map<String, dynamic> map) {
    id = map[Strings.categoryColumnId];
    name = map[Strings.categoryColumnName];
    iconData = MdiIconData(
      int.parse(map[Strings.categoryColumnIconCodePoint], radix: 16),
    );
    color = Color(int.parse(map[Strings.categoryColumnColor], radix: 16));
    type = TransacType.values[map[Strings.categoryColumnType]];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.categoryColumnId: id,
      Strings.categoryColumnName: name,
      Strings.categoryColumnIconCodePoint: iconData.codePoint.toRadixString(16),
      Strings.categoryColumnColor: color.value.toRadixString(16),
      Strings.categoryColumnType: type.index
    };
    return map;
  }
}
