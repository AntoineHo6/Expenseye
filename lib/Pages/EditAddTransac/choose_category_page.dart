import 'package:Expenseye/Components/Categories/category_btn.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class ChooseCategoryPage extends StatelessWidget {
  final TransacType type;

  ChooseCategoryPage({@required this.type});

  @override
  Widget build(BuildContext context) {
    List<String> categorieKeys = new List();

    for (var key in DbModel.catMap.keys) {
      if (DbModel.catMap[key].type == type) {
        categorieKeys.add(key);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('categories')),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: List.generate(
                categorieKeys.length,
                (index) {
                  String key = categorieKeys[index];
                  return CategoryBtn(
                    category: DbModel.catMap[key],
                    onPressed: () => Navigator.pop(context, key),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Text(
              AppLocalizations.of(context).translate('createCustomCategoryMsg'),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }
}
