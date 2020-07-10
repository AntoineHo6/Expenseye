import 'package:Expenseye/Components/Categories/category_btn.dart';
import 'package:Expenseye/Components/RecurringTransac/add_rec_transac_steps_header.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/RecurringTransac/add_recurring_transac_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryStepPage extends StatefulWidget {
  @override
  _CategoryStepPageState createState() => _CategoryStepPageState();
}

class _CategoryStepPageState extends State<CategoryStepPage> with TickerProviderStateMixin {
  int selectedCategoryIndex;
  AnimationController _animationController;
  Animation _animation;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddRecurringTransacModel>(context, listen: false);
    List<String> categoryKeys = new List();

    for (var key in DbModel.catMap.keys) {
      if (DbModel.catMap[key].type == model.type) {
        categoryKeys.add(key);
      }
    }
    _animationController.forward();

    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: BottomNavButton(
            text: model.type == TransacType.expense
                ? AppLocalizations.of(context).translate('createRecurringExpense')
                : AppLocalizations.of(context).translate('createRecurringIncome'),
            onPressed: () async {
              if (selectedCategoryIndex != null) {
                await model.createRecurringTransac(context);
              } else {
                setState(() {
                  model.isCategorySelected = false;
                });
              }
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            AddRecTransacStepsHeader(
              title: '${model.step}. ${AppLocalizations.of(context).translate('selectACategory')}',
              percent: 1,
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
                crossAxisCount: 4,
                children: model.isCategorySelected
                    ? _categoriesList(categoryKeys, model)
                    : _errorCategoriesList(categoryKeys, model),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _errorCategoriesList(List<String> categoryKeys, AddRecurringTransacModel model) {
    return List.generate(
      categoryKeys.length,
      (index) {
        String key = categoryKeys[index];
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).errorColor,
            borderRadius: const BorderRadius.all(
              const Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(1.5),
          child: CategoryBtn(
            category: DbModel.catMap[key],
            onPressed: () {
              model.categoryId = DbModel.catMap[key].id;
              setState(() {
                model.isCategorySelected = true;
                selectedCategoryIndex = index;
              });
            },
          ),
        );
      },
    );
  }

  List<Widget> _categoriesList(List<String> categoryKeys, AddRecurringTransacModel model) {
    return List.generate(
      categoryKeys.length,
      (index) {
        String key = categoryKeys[index];
        if (selectedCategoryIndex != null && index == selectedCategoryIndex) {
          return Container(
            decoration: BoxDecoration(
              color: DbModel.catMap[key].color,
              borderRadius: const BorderRadius.all(
                const Radius.circular(13),
              ),
            ),
            padding: const EdgeInsets.all(4),
            child: CategoryBtn(
              category: DbModel.catMap[key],
              onPressed: () {
                model.categoryId = DbModel.catMap[key].id;
                setState(() => selectedCategoryIndex = index);
              },
            ),
          );
        }
        // other unselected categories
        return CategoryBtn(
          category: DbModel.catMap[key],
          onPressed: () {
            model.categoryId = DbModel.catMap[key].id;
            setState(() {
              model.isCategorySelected = true;
              selectedCategoryIndex = index;
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
