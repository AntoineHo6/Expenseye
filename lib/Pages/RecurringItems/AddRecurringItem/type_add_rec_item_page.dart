import 'package:Expenseye/Components/RecurringItems/add_rec_item_steps_header.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Providers/RecurringItems/add_recurring_item_model.dart';
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
                  child: RaisedButton(
                    onPressed: () => Provider.of<AddRecurringItemModel>(context,
                            listen: false)
                        .goNextFromTypePage(ItemType.expense),
                    child: ListTile(
                      title: Text(
                          AppLocalizations.of(context).translate('expense')),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: RaisedButton(
                    onPressed: () => Provider.of<AddRecurringItemModel>(context,
                            listen: false)
                        .goNextFromTypePage(ItemType.income),
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context).translate('income'),
                      ),
                    ),
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
