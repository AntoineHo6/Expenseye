import 'package:Expenseye/Components/Categories/category_btn.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Pages/Categories/add_category_page.dart';
import 'package:Expenseye/Pages/Categories/edit_category_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  final ItemType type;
  final List<String> categoryKeys = new List();

  CategoriesPage(this.type);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    widget.categoryKeys.clear();
    for (var key in DbModel.catMap.keys) {
      if (DbModel.catMap[key].type == widget.type) {
        widget.categoryKeys.add(key);
      }
    }

    return GridView.count(
      padding: const EdgeInsets.all(10),
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
          onPressed: () =>
              _selectedCategory(DbModel.catMap[widget.categoryKeys[index]]),
        );
      }),
    );
  }

  Future<void> _openAddCategoryPage(context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCategoryPage(widget.type),
      ),
    ).then((value) {
      setState(() {}); // to update categories when a new one is added
    });
  }

  Future<void> _selectedCategory(Category category) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCategoryPage(category),
      ),
    ).then((value) {
      setState(() {});
    });
  }
}
