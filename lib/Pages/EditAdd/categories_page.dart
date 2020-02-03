import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  final ItemType type;

  CategoriesPage({@required this.type});

  @override
  Widget build(BuildContext context) {
    List<String> categorieKeys = new List();

    for (var key in ItemModel.catMap.keys) {
      if (ItemModel.catMap[key].type == type) {
        categorieKeys.add(key);
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
          categorieKeys.length,
          (index) {
            String key = categorieKeys[index];
            return RaisedButton(
              onPressed: () => Navigator.pop(context, key),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    ItemModel.catMap[key].iconData,
                    color: ItemModel.catMap[key].color,
                    size: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      ItemModel.catMap[key].name,
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
