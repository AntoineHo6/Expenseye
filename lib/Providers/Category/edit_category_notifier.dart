import 'package:Expenseye/Components/EditAdd/Category/color_picker_dialog.dart';
import 'package:Expenseye/Components/Global/confirmation_dialog.dart';
import 'package:Expenseye/Components/Global/load_dialog.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/Resources/my_icons.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCategoryNotifier extends ChangeNotifier {
  String oldCategoryId;
  bool didInfoChange = false;
  bool isNameInvalid = false;
  Color color;
  TransacType type;
  int selectedIconIndex;
  List<String> categoryNamesLowerCase = new List();

  EditCategoryNotifier(Category oldCategory) {
    initSelectedIconIndex(oldCategory);
    color = oldCategory.color;
    type = oldCategory.type;
    oldCategoryId = oldCategory.id;

    DbNotifier.catMap.values.forEach(
      (category) {
        categoryNamesLowerCase.add(category.name.toLowerCase());
      },
    );
  }

  void initSelectedIconIndex(Category oldCategory) {
    List<IconData> icons =
        (oldCategory.type == TransacType.expense) ? MyIcons.expenseIcons : MyIcons.incomeIcons;

    selectedIconIndex =
        icons.indexWhere((iconData) => iconData.codePoint == oldCategory.iconData.codePoint);

    notifyListeners();
  }

  void checkNameInvalid(String newName) {
    newName = newName.trim();

    if (categoryNamesLowerCase.contains(newName.toLowerCase()) || newName.isEmpty) {
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
        iconData: (type == TransacType.expense)
            ? MyIcons.expenseIcons[selectedIconIndex]
            : MyIcons.incomeIcons[selectedIconIndex],
        color: color,
        type: type,
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadDialog();
        },
      );

      await Provider.of<DbNotifier>(context, listen: false)
          .updateCategory(oldCategoryId, updatedCategory)
          .then(
            (value) => Navigator.pop(context), // pop out of the loading dialog
          );

      Navigator.pop(context); // pop out of the page
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadDialog();
        },
      );

      await Provider.of<DbNotifier>(context, listen: false).deleteCategory(oldCategoryId).then(
            (value) => Navigator.pop(context), // pop out of the loading dialog
          );

      Navigator.pop(context); // pop out of the page
    }
  }
}
