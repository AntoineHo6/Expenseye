import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Resources/Strings.dart';

class Item {
  int id;
  String name;
  double value;
  DateTime date;
  String category;
  ItemType type;  // TODO: DEPRECATED

  Item(this.name, this.value, this.date, this.type, this.category);

  Item.withId(
      this.id, this.name, this.value, this.date, this.type, this.category);

  Item.fromMap(Map<String, dynamic> map) {
    id = map[Strings.itemColumnId];
    name = map[Strings.itemColumnName];
    value = map[Strings.itemColumnValue];
    date = DateTime.parse(map[Strings.itemColumnDate]);
    category = map[Strings.itemColumnCategory];
    type = ItemType.values[map[Strings.itemColumnType]];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.itemColumnName: name,
      Strings.itemColumnValue: value,
      Strings.itemColumnDate: date.toIso8601String(),
      Strings.itemColumnCategory: category,
      Strings.itemColumnType: type.index
    };
    if (id != null) {
      map[Strings.itemColumnId] = id;
    }
    return map;
  }
}
