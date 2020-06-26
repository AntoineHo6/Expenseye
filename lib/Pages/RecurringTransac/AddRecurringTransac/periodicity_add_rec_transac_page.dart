import 'package:Expenseye/Components/RecurringTransac/add_rec_transac_steps_header.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Providers/RecurringTransac/add_recurring_transac_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PeriodicityAddRecTransacPage extends StatefulWidget {
  @override
  _PeriodicityAddRecTransacPageState createState() =>
      _PeriodicityAddRecTransacPageState();
}

class _PeriodicityAddRecTransacPageState extends State<PeriodicityAddRecTransacPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurringTransacModel>(context, listen: false);
    _animationController.forward();

    return FadeTransition(
      opacity: _animation,
      child: Column(
        children: <Widget>[
          AddRecTransacStepsHeader(
            title:
                '2. ${AppLocalizations.of(context).translate('selectAPeriodicity')}',
            percent: 0.4,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _listViewTransac(
                    context,
                    AppLocalizations.of(context).translate('daily'),
                    Periodicity.daily,
                    _model.type),
                _listViewTransac(
                    context,
                    AppLocalizations.of(context).translate('weekly'),
                    Periodicity.weekly,
                    _model.type),
                _listViewTransac(
                    context,
                    AppLocalizations.of(context).translate('biWeekly'),
                    Periodicity.biweekly,
                    _model.type),
                _listViewTransac(
                    context,
                    AppLocalizations.of(context).translate('monthly'),
                    Periodicity.monthly,
                    _model.type),
                _listViewTransac(
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

  Widget _listViewTransac(BuildContext context, String title,
      Periodicity periodicity, TransacType type) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: RaisedButton(
        onPressed: () =>
            Provider.of<AddRecurringTransacModel>(context, listen: false)
                .goNextFromPeriodicityPage(periodicity),
        child: ListTile(
          title: Text(title),
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
