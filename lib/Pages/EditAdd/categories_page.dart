import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/item_category.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          ItemCategory.values.length,
          (index) {
            return RaisedButton(
              onPressed: () =>
                  Navigator.pop(context, ItemCategory.values[index]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    ItemCatProperties.properties[ItemCategory.values[index]]
                        ['iconData'],
                    color: ItemCatProperties
                        .properties[ItemCategory.values[index]]['color'],
                    size: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      ItemCatProperties
                          .properties[ItemCategory.values[index]]['string'],
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
