import 'package:Expenseye/Components/Categories/category_btn.dart';
import 'package:Expenseye/Components/EditAdd/confirmation_dialog.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Pages/Categories/add_new_category_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Resources/Strings.dart';

class ItemsPage extends StatefulWidget {
  final ItemType type;
  final List<String> categoryKeys = new List();

  ItemsPage(this.type);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    widget.categoryKeys.clear();
    for (var key in DbModel.catMap.keys) {
      if (DbModel.catMap[key].type == widget.type) {
        widget.categoryKeys.add(key);
      }
    }

    return GridView.count(
      padding: const EdgeInsets.all(15),
      crossAxisSpacing: 7,
      mainAxisSpacing: 7,
      crossAxisCount: 4,
      children: List.generate(widget.categoryKeys.length + 1, (index) {
        if (index >= widget.categoryKeys.length) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: RawMaterialButton(
              onPressed: () => _openAddCategoryPage(context),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 35.0,
              ),
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: MyColors.black02dp,
            ),
          );
        }

        return CategoryBtn(
          category: DbModel.catMap[widget.categoryKeys[index]],
          onPressed: () => _selectedCategory(index),
        );
      }),
    );
  }

  void _openAddCategoryPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewCategoryPage(widget.type),
      ),
    );
  }

  void _selectedCategory(int index) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => DeleteConfirmDialog(Strings.confirmDeleteCategory),
    );

    if (confirmed != null && confirmed) {
      final _dbModel = Provider.of<DbModel>(context, listen: false);
      await _dbModel.deleteItemsByCategory(widget.categoryKeys[index]);
      await _dbModel.deleteCategory(widget.categoryKeys[index]);
    }
  }
}
