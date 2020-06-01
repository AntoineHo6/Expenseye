import 'package:Expenseye/Components/RecurringItems/add_rec_item_steps_header.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Providers/RecurringItems/add_recurring_item_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PeriodicityAddRecItemPage extends StatefulWidget {
  @override
  _PeriodicityAddRecItemPageState createState() =>
      _PeriodicityAddRecItemPageState();
}

class _PeriodicityAddRecItemPageState extends State<PeriodicityAddRecItemPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurringItemModel>(context, listen: false);
    _animationController.forward();

    return FadeTransition(
      opacity: _animation,
      child: Column(
        children: <Widget>[
          AddRecItemStepsHeader(
            title:
                '2. ${AppLocalizations.of(context).translate('selectAPeriodicity')}',
            percent: 0.4,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _listViewItem(
                    context,
                    AppLocalizations.of(context).translate('daily'),
                    Periodicity.daily,
                    _model.type),
                _listViewItem(
                    context,
                    AppLocalizations.of(context).translate('weekly'),
                    Periodicity.weekly,
                    _model.type),
                _listViewItem(
                    context,
                    AppLocalizations.of(context).translate('biWeekly'),
                    Periodicity.biweekly,
                    _model.type),
                _listViewItem(
                    context,
                    AppLocalizations.of(context).translate('monthly'),
                    Periodicity.monthly,
                    _model.type),
                _listViewItem(
                    context,
                    AppLocalizations.of(context).translate('yearly'),
                    Periodicity.yearly,
                    _model.type),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _listViewItem(BuildContext context, String title,
      Periodicity periodicity, ItemType type) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      color: type == ItemType.expense
          ? MyColors.expenseColor
          : MyColors.incomeColor,
      child: ListTile(
        title: Text(title),
        onTap: () {
          Provider.of<AddRecurringItemModel>(context, listen: false)
              .goNextFromPeriodicityPage(periodicity);
        },
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
