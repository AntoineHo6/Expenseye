import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class Category {
  int id;
  String name;
  IconData iconData;
  Color color;
  ItemType type;

  Category({
    @required this.name,
    @required this.iconData,
    @required this.color,
    @required this.type,
  });

  Category.withId({
    @required this.id,
    @required this.name,
    @required this.iconData,
    @required this.color,
    @required this.type,
  });

  Category.fromMap(Map<String, dynamic> map) {
    id = map[Strings.categoryColumnId];
    name = map[Strings.categoryColumnName];
    iconData = _MdiIconData(
        int.parse(map[Strings.categoryColumnIconCodePoint], radix: 16));
    color = Color(int.parse(map[Strings.categoryColumnColor], radix: 16));
    type = ItemType.values[map[Strings.categoryColumnType]];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.categoryColumnName: name,
      Strings.categoryColumnIconCodePoint: iconData.codePoint.toRadixString(16),
      Strings.categoryColumnColor: color.value.toRadixString(16),
      Strings.categoryColumnType: type.index
    };
    if (id != null) {
      map[Strings.categoryColumnId] = id;
    }
    return map;
  }
}

class _MdiIconData extends IconData {
  const _MdiIconData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'Material Design Icons',
          fontPackage: 'material_design_icons_flutter',
        );
}
