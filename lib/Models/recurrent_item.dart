import 'package:Expenseye/Enums/recurrent_item_type.dart';
import 'package:Expenseye/Resources/Strings.dart';

class RecurrentItem {
  int id;
  String name;
  double value;
  DateTime date;  // corresponds to the next date the item is due for
  int isAdded;
  RecurrentItemType type; // daily, weekly, bi-weekly, monthly, yearly
  String category;

  RecurrentItem(
      this.name, this.value, this.date, this.isAdded, this.category, this.type);

  RecurrentItem.withId(this.id, this.name, this.value, this.date, this.isAdded,
      this.category, this.type);
  
  RecurrentItem.fromMap(Map<String, dynamic> map) {
    id = map[Strings.recurrentItemColumnId];
    name = map[Strings.recurrentItemColumnName];
    value = map[Strings.recurrentItemColumnValue];
    date = DateTime.parse(map[Strings.recurrentItemColumnDate]);
    isAdded = map[Strings.recurrentItemColumnIsAdded];
    type = RecurrentItemType.values[map[Strings.recurrentItemColumnType]];
    category = map[Strings.recurrentItemColumnCategory];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      Strings.recurrentItemColumnName: name,
      Strings.recurrentItemColumnValue: value,
      Strings.recurrentItemColumnDate: date.toIso8601String(),
      Strings.recurrentItemColumnIsAdded: isAdded,
      Strings.recurrentItemColumnType: type.index,
      Strings.recurrentItemColumnCategory: category
    };
    if (id != null) {
      map[Strings.recurrentItemColumnId] = id;
    }
    return map;
  }
}
