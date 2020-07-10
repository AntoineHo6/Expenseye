import 'package:Expenseye/Components/RecurringTransac/add_rec_transac_steps_header.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Providers/RecurringTransac/add_recurring_transac_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeStepPage extends StatefulWidget {
  @override
  _TypeStepPageState createState() => _TypeStepPageState();
}

class _TypeStepPageState extends State<TypeStepPage> with TickerProviderStateMixin {
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
            title: '${_model.step}. ${AppLocalizations.of(context).translate('selectTheType')}',
            percent: 0.1666,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: RaisedButton(
                    onPressed: () => Provider.of<AddRecurringTransacModel>(
                      context,
                      listen: false,
                    ).goNextFromTypePage(TransacType.expense),
                    child: ListTile(
                      title: Text(AppLocalizations.of(context).translate('expense')),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: RaisedButton(
                    onPressed: () => Provider.of<AddRecurringTransacModel>(
                      context,
                      listen: false,
                    ).goNextFromTypePage(TransacType.income),
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
