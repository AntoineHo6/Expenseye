import 'package:Expenseye/Components/Categories/icon_btn.dart';
import 'package:Expenseye/Components/Categories/selected_icon_btn.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Providers/Category/add_category_model.dart';
import 'package:Expenseye/Resources/my_icons.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryPage extends StatefulWidget {
  final TransacType type;

  AddCategoryPage(this.type);

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final title = widget.type == TransacType.expense
        ? AppLocalizations.of(context).translate('expense')
        : AppLocalizations.of(context).translate('income');

    return ChangeNotifierProvider(
      create: (_) => AddCategoryModel(),
      child: Consumer<AddCategoryModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: BottomNavButton(
              text: AppLocalizations.of(context).translate('addCaps'),
              onPressed: () {
                model.checkNameInvalid(_nameController.text);
                model.checkIfIconIsSelected();
                model.addNewCategory(context, widget.type, _nameController);
              },
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
                  children: model.isIconSelected
                      ? _iconList(model)
                      : _errorIconList(model),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _errorIconList(AddCategoryModel model) {
    final List<IconData> icons = (widget.type == TransacType.expense)
        ? MyIcons.expenseIcons
        : MyIcons.incomeIcons;

    List<Widget> pageIcons = List.generate(
      icons.length,
      (index) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).errorColor,
            borderRadius: const BorderRadius.all(
              const Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(1.5),
          child: IconBtn(
            onPressed: () {
              model.changeSelectedIcon(index);
              model.checkIfIconIsSelected();
            },
            color: model.color,
            iconData: icons[index],
          ),
        );
      },
    );

    return pageIcons;
  }

  List<Widget> _iconList(AddCategoryModel model) {
    final List<IconData> icons = (widget.type == TransacType.expense)
        ? MyIcons.expenseIcons
        : MyIcons.incomeIcons;

    List<Widget> pageIcons = List.generate(
      icons.length,
      (index) {
        // if is the selected icon
        if (model.selectedIconIndex != null &&
            index == model.selectedIconIndex) {
          return SelectedIconBtn(
            onPressed: () => model.changeSelectedIcon(index),
            iconData: icons[index],
            color: model.color,
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
                  size: 30,
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
}
