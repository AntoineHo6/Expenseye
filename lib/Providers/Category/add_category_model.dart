import 'package:Expenseye/Components/EditAdd/Category/color_picker_dialog.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/Resources/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryModel extends ChangeNotifier {
  int selectedIconIndex;
  Color color = AppDarkThemeColors.secondary;
  bool isNameInvalid = false;
  bool isIconSelected = true;
  List<String> categoryIds = new List();

  AddCategoryModel() {
    DbModel.catMap.values.forEach(
      (category) {
        categoryIds.add(category.id);
      },
    );
  }

  void checkIfIconIsSelected() {
    if (selectedIconIndex == null) {
      isIconSelected = false;
    }
    else {
      isIconSelected = true;
    }
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

  void checkNameInvalid(String newName) {
    newName = newName.trim();
    if (categoryIds.contains(newName.toLowerCase()) || newName.isEmpty) {
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

  void changeColor(Color color) {
    this.color = color;
    notifyListeners();
  }

  void addNewCategory(BuildContext context, ItemType type, TextEditingController nameController) async {
    if (selectedIconIndex != null && !isNameInvalid) {
      Category newCategory = Category(
        id: nameController.text.toLowerCase().trim(),
        name: nameController.text.trim(),
        iconData: (type == ItemType.expense)
            ? MyIcons.expenseIcons[selectedIconIndex]
            : MyIcons.incomeIcons[selectedIconIndex],
        color: color,
        type: type,
      );

      DbModel.catMap[newCategory.id] = newCategory;
      await DatabaseHelper.instance.insertCategory(newCategory);

      await Provider.of<DbModel>(context, listen: false)
          .initUserCategoriesMap();

      Navigator.pop(context);
    }
  }
}
