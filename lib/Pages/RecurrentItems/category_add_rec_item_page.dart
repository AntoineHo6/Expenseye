import 'package:Expenseye/Components/Categories/category_btn.dart';
import 'package:Expenseye/Components/RecurrentItems/bottom_nav_button.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Expenseye/Providers/RecurrentItems/add_recurrent_item_model.dart';

class CategoryAddRecItemPage extends StatefulWidget {
  @override
  _CategoryAddRecItemPageState createState() => _CategoryAddRecItemPageState();
}

class _CategoryAddRecItemPageState extends State<CategoryAddRecItemPage> {
  int selectedIconIndex;

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurrentItemModel>(context, listen: false);
    List<String> categorieKeys = new List();

    for (var key in DbModel.catMap.keys) {
      if (DbModel.catMap[key].type == _model.type) {
        categorieKeys.add(key);
      }
    }

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: BottomNavButton(
          color: _model.type == ItemType.expense ? Colors.red : Colors.green,
          text: AppLocalizations.of(context).translate('createRecurrentItem'),
          onPressed: () {
            if (selectedIconIndex != null) {
              _model.createRecurrentItem(context);
            }
          },
        ),
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
                  if (selectedIconIndex != null && index == selectedIconIndex) {
                    return Container(
                      color: DbModel.catMap[key].color,
                      padding: const EdgeInsets.all(4),
                      child: CategoryBtn(
                        category: DbModel.catMap[key],
                        onPressed: () {
                          _model.category = DbModel.catMap[key].id;
                          setState(() => selectedIconIndex = index);
                        },
                      ),
                    );
                  }
                  // other unselected categories
                  return CategoryBtn(
                    category: DbModel.catMap[key],
                    onPressed: () {
                      _model.category = DbModel.catMap[key].id;
                      setState(() => selectedIconIndex = index);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
