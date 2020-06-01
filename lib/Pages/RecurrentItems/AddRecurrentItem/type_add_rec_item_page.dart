import 'package:Expenseye/Components/RecurrentItems/add_rec_item_steps_header.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Providers/RecurrentItems/add_recurrent_item_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeAddRecItemPage extends StatefulWidget {
  @override
  _TypeAddRecItemPageState createState() => _TypeAddRecItemPageState();
}

class _TypeAddRecItemPageState extends State<TypeAddRecItemPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  Widget build(BuildContext context) {
    _animationController.forward();

    return FadeTransition(
      opacity: _animation,
      child: Column(
        children: <Widget>[
          AddRecItemStepsHeader(
            title:
                '1. ${AppLocalizations.of(context).translate('selectTheType')}',
            percent: 0.2,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  color: MyColors.expenseColor,
                  child: ListTile(
                    title:
                        Text(AppLocalizations.of(context).translate('expense')),
                    onTap: () {
                      Provider.of<AddRecurrentItemModel>(context, listen: false)
                          .goNextFromTypePage(ItemType.expense);
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  color: MyColors.incomeColor,
                  child: ListTile(
                    title:
                        Text(AppLocalizations.of(context).translate('income')),
                    onTap: () {
                      Provider.of<AddRecurrentItemModel>(context, listen: false)
                          .goNextFromTypePage(ItemType.income);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
