import 'package:Expenseye/Components/Categories/category_btn.dart';
import 'package:Expenseye/Components/EditAddItem/confirmation_dialog.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Pages/Categories/add_new_category_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final _dbModel = Provider.of<DbModel>(context);

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
          onLongPress: () => _selectedCategory(index, _dbModel),
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
    ).then((value) {
      setState(() {});  // to update categories when a new one is added
    });
  }

  void _selectedCategory(int index, DbModel dbModel) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        AppLocalizations.of(context).translate('confirmDeleteCategory'),
      ),
    );

    if (confirmed != null && confirmed) {
      await dbModel.deleteItemsByCategory(widget.categoryKeys[index]);
      await dbModel.deleteCategory(widget.categoryKeys[index]);
    }
  }
}
