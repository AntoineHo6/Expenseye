import 'package:Expenseye/Components/Global/my_table_calendar.dart';
import 'package:Expenseye/Components/RecurringTransac/add_rec_transac_steps_header.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Enums/periodicity_error.dart';
import 'package:Expenseye/Providers/RecurringTransac/add_recurring_transac_model.dart';
import 'package:Expenseye/Utils/edit_add_rec_transac_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DateStepPage extends StatefulWidget {
  final Periodicity periodicity;

  DateStepPage(this.periodicity);

  @override
  _DateStepPageState createState() => _DateStepPageState();
}

class _DateStepPageState extends State<DateStepPage> with TickerProviderStateMixin {
  CalendarController _calendarController;
  bool monthlyPeriodicityError = false;
  AnimationController _animationController;
  Animation _animation;
  PeriodicityError error;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurringTransacModel>(context, listen: false);
    _animationController.forward();

    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: BottomNavButton(
            text: AppLocalizations.of(context).translate('nextCaps'),
            onPressed: () {
              selectedDate = _calendarController.focusedDay;
              error = EditAddRecTransacUtil.checkDueDateForError(
                _model.periodicity,
                _calendarController.focusedDay,
              );

              switch (error) {
                case PeriodicityError.none:
                  _model.goNextFromDatePage(_calendarController.focusedDay);
                  break;
                case PeriodicityError.above28th:
                case PeriodicityError.above62DaysInPast:
                  setState(() {
                    monthlyPeriodicityError = true;
                  });
                  break;
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AddRecTransacStepsHeader(
                title:
                    '${_model.step}. ${AppLocalizations.of(context).translate('selectAStartingDate')}',
                percent: 0.4998,
              ),
              _tableCalendar(context),
            ],
          ),
        ),
      ),
    );
  }

  Column _tableCalendar(BuildContext context) {
    return Column(
      children: <Widget>[
        monthlyPeriodicityError
            ? Text(
                EditAddRecTransacUtil.getDueDateErrorMsg(context, error),
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              )
            : Container(),
        MyTableCalendar(
          initialDate: selectedDate,
          calendarController: _calendarController,
        ),
      ],
    );
  }

  @override
  void initState() {
    _calendarController = CalendarController();
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
    _calendarController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
