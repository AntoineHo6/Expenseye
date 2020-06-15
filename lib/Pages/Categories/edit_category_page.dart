import 'package:Expenseye/Components/EditAdd/delete_btn.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Providers/Category/edit_category_model.dart';
import 'package:Expenseye/Providers/Global/theme_notifier.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/Resources/my_icons.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCategoryPage extends StatefulWidget {
  final Category category;

  EditCategoryPage(this.category);

  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditCategoryModel(widget.category),
      child: Consumer<EditCategoryModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.category.name),
            actions: <Widget>[
              DeleteBtn(
                onPressed: () async => await model.delete(context),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: BottomNavButton(
              color: Theme.of(context).buttonColor,
              text: AppLocalizations.of(context).translate('saveCaps'),
              onPressed: () async =>
                  await model.updateCategory(context, _nameController.text),
            ),
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
                        isNameInvalid: model.isNameInvalid,
                        onChanged: model.checkNameInvalid,
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
                            color: model.color,
                            onPressed: () async =>
                                await model.openColorPickerDialog(context),
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
                  children: _iconList(model),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _iconList(EditCategoryModel model) {
    final List<IconData> icons = (model.type == ItemType.expense)
        ? MyIcons.expenseIcons
        : MyIcons.incomeIcons;

    List<Widget> pageIcons = List.generate(
      icons.length,
      (index) {
        // if is the selected icon
        if (model.selectedIconIndex != null &&
            index == model.selectedIconIndex) {
          return Container(
            decoration: BoxDecoration(
              color: model.color,
              borderRadius: const BorderRadius.all(
                const Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(2),
            child: RaisedButton(
              onPressed: () => model.changeSelectedIcon(index),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      icons[index],
                      size: 35,
                      color: model.color,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        // other unselected icons
        return RaisedButton(
          onPressed: () => model.changeSelectedIcon(index),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Icon(
                  icons[index],
                  size: 35,
                  color: model.color,
                ),
              ),
            ],
          ),
        );
      },
    );

    return pageIcons;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nameController.text = widget.category.name;
    super.initState();
  }
}
