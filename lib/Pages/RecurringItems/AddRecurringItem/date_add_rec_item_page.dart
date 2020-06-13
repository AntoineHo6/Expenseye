import 'package:Expenseye/Components/Global/my_table_calendar.dart';
import 'package:Expenseye/Components/RecurringItems/add_rec_item_steps_header.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Enums/periodicity_error.dart';
import 'package:Expenseye/Providers/RecurringItems/add_recurring_item_model.dart';
import 'package:Expenseye/Utils/edit_add_rec_item_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DateAddRecItemPage extends StatefulWidget {
  final Periodicity periodicity;

  DateAddRecItemPage(this.periodicity);

  @override
  _DateAddRecItemPageState createState() => _DateAddRecItemPageState();
}

class _DateAddRecItemPageState extends State<DateAddRecItemPage>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  bool monthlyPeriodicityError = false;
  AnimationController _animationController;
  Animation _animation;
  PeriodicityError error;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurringItemModel>(context, listen: false);
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
              error = EditAddRecItemUtil.checkDueDateForError(
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
              AddRecItemStepsHeader(
                title:
                    '3. ${AppLocalizations.of(context).translate('selectAStartingDate')}',
                percent: 0.6,
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
                EditAddRecItemUtil.getDueDateErrorMsg(context, error),
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
