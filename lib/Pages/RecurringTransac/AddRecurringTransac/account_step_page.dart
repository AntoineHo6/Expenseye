import 'package:Expenseye/Components/RecurringTransac/add_rec_transac_steps_header.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/RecurringTransac/add_recurring_transac_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountStepPage extends StatefulWidget {
  @override
  _AccountStepPageState createState() => _AccountStepPageState();
}

class _AccountStepPageState extends State<AccountStepPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurringTransacModel>(context, listen: false);
    List<String> accountKeys = new List();

    for (var key in DbModel.accMap.keys) {
      accountKeys.add(key);
    }

    _animationController.forward();

    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AddRecTransacStepsHeader(
              title: '${_model.step}. ${AppLocalizations.of(context).translate('selectAnAccount')}',
              percent: 0.833,
            ),
            Expanded(
              child: ListView(
                children: accountKeys
                    .map(
                      (accountKey) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        child: RaisedButton(
                          onPressed: () =>
                              Provider.of<AddRecurringTransacModel>(context, listen: false)
                                  .goNextFromAccountStepPage(accountKey),
                          child: ListTile(
                            title: Text(DbModel.accMap[accountKey].name),
                          ),
                        ),
                      ),
                    )
                    .toList(),
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
