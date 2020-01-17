import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/item_category.dart';

class Item {
  int id;
  String name;
  double value;
  DateTime date;
  ItemCategory category;
  int type;

  Item(this.name, this.value, this.date, this.type, this.category);

  Item.withId(
      this.id, this.name, this.value, this.date, this.type, this.category);

  Item.fromMap(Map<String, dynamic> map) {
    id = map[Strings.itemColumnId];
    name = map[Strings.itemColumnName];
    value = map[Strings.itemColumnValue];
    date = DateTime.parse(map[Strings.itemColumnDate]);
    category = ItemCategory.values[map[Strings.itemColumnCategory]];
    type = map[Strings.itemColumnType];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.itemColumnName: name,
      Strings.itemColumnValue: value,
      Strings.itemColumnDate: date.toIso8601String(),
      Strings.itemColumnCategory: category.index,
      Strings.itemColumnType: type
    };
    if (id != null) {
      map[Strings.itemColumnId] = id;
    }
    return map;
  }
}
