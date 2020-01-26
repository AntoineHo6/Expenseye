import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/item_category.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  final ItemType type;

  CategoriesPage({@required this.type});

  @override
  Widget build(BuildContext context) {
    List<String> categories = new List();

    if(type == ItemType.expense) {
      for (var item in ItemCategories.properties.values) {
        if ()
      }
    }
    

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.icons),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: List.generate(
          categories.length,
          (index) {
            return RaisedButton(
              onPressed: () => Navigator.pop(context, categories[index]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    ItemCatProperties.properties[categories[index]]['iconData'],
                    color: ItemCatProperties.properties[categories[index]]
                        ['color'],
                    size: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      ItemCatProperties.properties[categories[index]]['string'],
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
