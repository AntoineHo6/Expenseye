import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';

class IconsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black00dp,
      appBar: AppBar(
        title: Text(Strings.icons),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: List.generate(
          ExpenseCategory.values.length,
          (index) {
            return RaisedButton(
              color: MyColors.black02dp,
              onPressed: () =>
                  Navigator.pop(context, ExpenseCategory.values[index]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    CategoryProperties.properties[ExpenseCategory.values[index]]
                        ['iconData'],
                    color: CategoryProperties
                        .properties[ExpenseCategory.values[index]]['color'],
                    size: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      CategoryProperties
                          .properties[ExpenseCategory.values[index]]['string'],
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
