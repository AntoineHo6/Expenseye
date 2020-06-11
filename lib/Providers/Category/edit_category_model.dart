import 'package:Expenseye/Components/EditAdd/Category/color_picker_dialog.dart';
import 'package:Expenseye/Components/Global/confirmation_dialog.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/icons.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCategoryModel extends ChangeNotifier {
  String oldCategoryId;
  bool didInfoChange = false;
  bool isNameInvalid = false;
  Color color;
  ItemType type;
  int selectedIconIndex;

  EditCategoryModel(Category oldCategory) {
    initSelectedIconIndex(oldCategory);
    color = oldCategory.color;
    type = oldCategory.type;
    oldCategoryId = oldCategory.id;
  }

  void initSelectedIconIndex(Category oldCategory) {
    List<IconData> icons = (oldCategory.type == ItemType.expense)
        ? MyIcons.expenseIcons
        : MyIcons.incomeIcons;

    selectedIconIndex = icons.indexWhere(
        (iconData) => iconData.codePoint == oldCategory.iconData.codePoint);

    notifyListeners();
  }

  void checkNameInvalid(String newName) {
    newName = newName.trim();

    if (DbModel.catMap.containsKey(newName.toLowerCase()) || newName.isEmpty) {
      isNameInvalid = true;
    } else {
      isNameInvalid = false;
    }

    notifyListeners();
  }

  void changeSelectedIcon(int index) {
    selectedIconIndex = index;
    notifyListeners();
  }

  Future<void> openColorPickerDialog(context) async {
    final Color pickedColor = await showDialog(
      context: context,
      child: ColorPickerDialog(color),
    );
    if (pickedColor != null) {
      color = pickedColor;
    }
    notifyListeners();
  }

  Future<void> updateCategory(BuildContext context, String newName) async {
    if (selectedIconIndex != null && !isNameInvalid) {
      newName = newName.trim();
      Category updatedCategory = Category(
        id: newName.toLowerCase(),
        name: newName,
        iconData: (type == ItemType.expense)
            ? MyIcons.expenseIcons[selectedIconIndex]
            : MyIcons.incomeIcons[selectedIconIndex],
        color: color,
        type: type,
      );

      await DatabaseHelper.instance
          .updateItemsAndRecItemsCategory(oldCategoryId, updatedCategory.id);
      await DatabaseHelper.instance.deleteCategory(oldCategoryId);
      await DatabaseHelper.instance.insertCategory(updatedCategory);
      await Provider.of<DbModel>(context, listen: false)
          .initUserCategoriesMap();

      Navigator.pop(context);
    }
  }

  Future<void> delete(BuildContext context) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        AppLocalizations.of(context).translate('confirmDeleteCategory'),
      ),
    );

    if (confirmed != null && confirmed) {
      await Provider.of<DbModel>(context, listen: false).deleteItemsByCategory(oldCategoryId);
      await DatabaseHelper.instance.deleteRecurringItemsByCategory(oldCategoryId);
      await Provider.of<DbModel>(context, listen: false).deleteCategory(oldCategoryId);

      Navigator.pop(context);
    }
  }
}
