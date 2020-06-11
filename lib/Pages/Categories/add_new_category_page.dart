import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/Resources/icons.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

// TODO: refactor. Move business logic to a provider
class AddNewCategoryPage extends StatefulWidget {
  final ItemType type;

  AddNewCategoryPage(this.type);

  @override
  _AddNewCategoryPageState createState() => _AddNewCategoryPageState();
}

class _AddNewCategoryPageState extends State<AddNewCategoryPage> {
  Color pickerColor = Color(0xff443a49);
  Color currentColor = MyColors.secondary;
  int selectedIconIndex;
  final _nameController = TextEditingController();
  bool isNameInvalid = false;
  List<String> categoryNamesLowerCase = new List();

  @override
  Widget build(BuildContext context) {
    DbModel.catMap.values.forEach(
      (category) {
        categoryNamesLowerCase.add(category.name.toLowerCase());
      },
    );

    final title = widget.type == ItemType.expense
        ? AppLocalizations.of(context).translate('expense')
        : AppLocalizations.of(context).translate('income');

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: BottomNavButton(
            color: widget.type == ItemType.expense
                ? MyColors.expenseColor
                : MyColors.incomeColor,
            text: AppLocalizations.of(context).translate('addCaps'),
            onPressed: () {
              _checkNameInvalid(_nameController.text);
              _addNewCategory(context, isNameInvalid);
            }),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 13),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: NameTextField(
                    controller: _nameController,
                    isNameInvalid: isNameInvalid,
                    onChanged: _checkNameInvalid,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: <Widget>[
                    Text(AppLocalizations.of(context).translate('color')),
                    ButtonTheme(
                      minWidth: 50,
                      height: 40,
                      child: RaisedButton(
                        hoverElevation: 50,
                        color: currentColor,
                        onPressed: () => _openColorPickerDialog(context),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 5,
              children: _iconList(),
            ),
          ),
        ],
      ),
    );
  }

  void _checkNameInvalid(String newName) {
    newName = newName.trim();
    setState(() {
      if (categoryNamesLowerCase.contains(newName.toLowerCase()) ||
          newName.isEmpty) {
        isNameInvalid = true;
      } else {
        isNameInvalid = false;
      }
    });
  }

  void _changeSelectedIcon(int index) {
    setState(() => selectedIconIndex = index);
  }

  void _changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void _openColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(AppLocalizations.of(context).translate('pickAColor')),
        // TODO: CHECK THE PIXEL OVERFLOW ON BOTTOM PROBLEM
        content: ColorPicker(
          pickerColor: pickerColor,
          showLabel: false,
          enableAlpha: true,
          onColorChanged: _changeColor,
          pickerAreaHeightPercent: 0.8,
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            child: Text(AppLocalizations.of(context).translate('cancelCaps')),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            textColor: Colors.white,
            child: Text(AppLocalizations.of(context).translate('confirmCaps')),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _addNewCategory(BuildContext context, bool isNameInvalid) async {
    if (selectedIconIndex != null && !isNameInvalid) {
      final DatabaseHelper dbHelper = DatabaseHelper.instance;

      Category newCategory = Category(
        name: _nameController.text.trim(),
        iconData: (widget.type == ItemType.expense)
            ? MyIcons.expenseIcons[selectedIconIndex]
            : MyIcons.incomeIcons[selectedIconIndex],
        color: currentColor,
        type: widget.type,
      );

      DbModel.catMap[newCategory.id] = newCategory;
      await dbHelper.insertCategory(newCategory);

      await Provider.of<DbModel>(context, listen: false)
          .initUserCategoriesMap();

      Navigator.pop(context);
    }
  }

  List<Widget> _iconList() {
    final List<IconData> icons = (widget.type == ItemType.expense)
        ? MyIcons.expenseIcons
        : MyIcons.incomeIcons;

    List<Widget> pageIcons = List.generate(
      icons.length,
      (index) {
        // if is the selected icon
        if (selectedIconIndex != null && index == selectedIconIndex) {
          return Container(
            color: currentColor,
            padding: const EdgeInsets.all(2),
            child: RaisedButton(
              onPressed: () => _changeSelectedIcon(index),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      icons[index],
                      size: 35,
                      color: currentColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        // other unselected icons
        return RaisedButton(
          onPressed: () => _changeSelectedIcon(index),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Icon(
                  icons[index],
                  size: 35,
                  color: currentColor,
                ),
              ),
            ],
          ),
        );
      },
    );

    return pageIcons;
  }
}
