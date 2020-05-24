import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/Resources/icons.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  bool isNameInvalid = true;

  @override
  Widget build(BuildContext context) {
    final title = widget.type == ItemType.expense
        ? AppLocalizations.of(context).translate('expense')
        : AppLocalizations.of(context).translate('income');

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 12),
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text(
                  AppLocalizations.of(context).translate('addCaps'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (selectedIconIndex != null && isNameInvalid == false)
                    ? () => _addNewCategory(context)
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkNameInvalid(String newName) {
    setState(() {
      if (DbModel.catMap.containsKey(newName.toLowerCase())) {
        isNameInvalid = true;
      } else if (newName.isEmpty) {
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
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            showLabel: false,
            enableAlpha: true,
            onColorChanged: _changeColor,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
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

  void _addNewCategory(BuildContext context) async {
    final DatabaseHelper dbHelper = DatabaseHelper.instance;

    Category newCategory = Category(
      id: _nameController.text.toLowerCase(),
      name: _nameController.text,
      iconData: (widget.type == ItemType.expense)
          ? MyIcons.expenseIcons[selectedIconIndex]
          : MyIcons.incomeIcons[selectedIconIndex],
      color: currentColor,
      type: widget.type,
    );

    DbModel.catMap[newCategory.id] = newCategory;
    await dbHelper.insertCategory(newCategory);

    Navigator.pop(context);
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
            color: MyColors.secondary,
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
