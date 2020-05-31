import 'package:Expenseye/Components/Global/my_table_calendar.dart';
import 'package:Expenseye/Components/RecurrentItems/bottom_nav_button.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Providers/RecurrentItems/add_recurrent_item_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
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

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurrentItemModel>(context, listen: false);

    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: BottomNavButton(
            color: _model.type == ItemType.expense
                ? MyColors.expenseColor
                : MyColors.incomeColor,
            text: AppLocalizations.of(context).translate('nextCaps'),
            onPressed: () {
              if (_model.periodicity == Periodicity.monthly &&
                  _calendarController.focusedDay.day > 28) {
                setState(() {
                  monthlyPeriodicityError = true;
                });
              } else {
                _model.goNextFromDatePage(_calendarController.focusedDay);
              }
            },
          ),
        ),
        body: monthlyPeriodicityError
            ? _monthlyPeriodicityErrorPage(context)
            : _noMonthlyPeriodicityErrorPage());
  }

  MyTableCalendar _noMonthlyPeriodicityErrorPage() {
    return MyTableCalendar(
      initialDate: DateTime.now(),
      calendarController: _calendarController,
    );
  }

  Column _monthlyPeriodicityErrorPage(BuildContext context) {
    return Column(
      children: <Widget>[
        MyTableCalendar(
          initialDate: DateTime.now(),
          calendarController: _calendarController,
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            AppLocalizations.of(context)
                .translate('errorSelectDayBetween1-28'),
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
}
