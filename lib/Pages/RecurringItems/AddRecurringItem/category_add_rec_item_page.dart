import 'package:Expenseye/Components/Categories/category_btn.dart';
import 'package:Expenseye/Components/RecurringItems/add_rec_item_steps_header.dart';
import 'package:Expenseye/Components/RecurringItems/bottom_nav_button.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Expenseye/Providers/RecurringItems/add_recurring_item_model.dart';

class CategoryAddRecItemPage extends StatefulWidget {
  @override
  _CategoryAddRecItemPageState createState() => _CategoryAddRecItemPageState();
}

class _CategoryAddRecItemPageState extends State<CategoryAddRecItemPage>
    with TickerProviderStateMixin {
  int selectedIconIndex;
  AnimationController _animationController;
  Animation _animation;

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurringItemModel>(context, listen: false);
    List<String> categorieKeys = new List();

    for (var key in DbModel.catMap.keys) {
      if (DbModel.catMap[key].type == _model.type) {
        categorieKeys.add(key);
      }
    }
    _animationController.forward();

    return FadeTransition(
      opacity: _animation,
          child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: BottomNavButton(
            color: _model.type == ItemType.expense ? MyColors.expenseColor : MyColors.incomeColor,
            text: AppLocalizations.of(context).translate('createRecurringItem'),
            onPressed: () {
              if (selectedIconIndex != null) {
                _model.createRecurringItem(context);
              }
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            AddRecItemStepsHeader(
              title: '5. ${AppLocalizations.of(context).translate('selectACategory')}',
              percent: 1,
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 4,
                children: List.generate(
                  categorieKeys.length,
                  (index) {
                    String key = categorieKeys[index];
                    if (selectedIconIndex != null && index == selectedIconIndex) {
                      return Container(
                        color: DbModel.catMap[key].color,
                        padding: const EdgeInsets.all(4),
                        child: CategoryBtn(
                          category: DbModel.catMap[key],
                          onPressed: () {
                            _model.category = DbModel.catMap[key];
                            setState(() => selectedIconIndex = index);
                          },
                        ),
                      );
                    }
                    // other unselected categories
                    return CategoryBtn(
                      category: DbModel.catMap[key],
                      onPressed: () {
                        _model.category = DbModel.catMap[key];
                        setState(() => selectedIconIndex = index);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
