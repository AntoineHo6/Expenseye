import 'package:Expenseye/Components/Categories/category_btn.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Pages/Categories/add_category_page.dart';
import 'package:Expenseye/Pages/Categories/edit_category_page.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  final TransacType type;
  final List<String> categoryKeys = new List();

  CategoriesPage(this.type);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    // user FutureBuilder to update when capMap does
    widget.categoryKeys.clear();
    for (var key in DbNotifier.catMap.keys) {
      if (DbNotifier.catMap[key].type == widget.type) {
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
                size: 35.0,
              ),
              shape: const CircleBorder(),
              elevation: 3,
              fillColor: Theme.of(context).primaryColor,
            ),
          );
        }

        return CategoryBtn(
          category: DbNotifier.catMap[widget.categoryKeys[index]],
          onPressed: () => _selectedCategory(DbNotifier.catMap[widget.categoryKeys[index]]),
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
