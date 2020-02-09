import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/Resources/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddNewCategoryPage extends StatefulWidget {
  @override
  _AddNewCategoryPageState createState() => _AddNewCategoryPageState();

  final ItemType type;

  AddNewCategoryPage(this.type);
}

class _AddNewCategoryPageState extends State<AddNewCategoryPage> {
  Color pickerColor = Color(0xff443a49);
  Color currentColor = MyColors.secondary;

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    bool isNameInvalid = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.type == ItemType.expense ? Strings.expense : Strings.income),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: NameTextField(
                      controller: _nameController,
                      isNameInvalid: isNameInvalid),
                ),
                const SizedBox(
                  width: 30,
                ),
                ButtonTheme(
                  minWidth: 50,
                  height: 40,
                  child: RaisedButton(
                    elevation: 10,
                    color: currentColor,
                    onPressed: () => _openColorPickerDialog(context),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(15),
              crossAxisSpacing: 7,
              mainAxisSpacing: 7,
              crossAxisCount: 5,
              children: List.generate(
                MyIcons.expenseIcons.length,
                (index) {
                  return RaisedButton(
                    onPressed: () => print('joe'),
                    child: Icon(
                      MyIcons.expenseIcons[index],
                      size: 35,
                      color: currentColor,
                    ),
                  );
                },
              ),
            ),
          ),
          RaisedButton(
            child: const Text(
              Strings.addCaps,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => print('s'),
          ),
        ],
      ),
    );
  }

  void _changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void _openColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: _changeColor,
            enableLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text(Strings.confirmCaps),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
