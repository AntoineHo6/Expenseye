import 'package:Expenseye/Components/Global/my_table_calendar.dart';
import 'package:Expenseye/Components/RecurrentItems/bottom_nav_button.dart';
import 'package:Expenseye/Providers/RecurrentItems/add_recurrent_item_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DateAddRecItemPage extends StatefulWidget {
  @override
  _DateAddRecItemPageState createState() => _DateAddRecItemPageState();
}

class _DateAddRecItemPageState extends State<DateAddRecItemPage>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<AddRecurrentItemModel>(context, listen: false);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: BottomNavButton(
          color: MyColors.secondaryDarker,
          text: AppLocalizations.of(context).translate('nextCaps'),
          onPressed: () =>
              _model.goNextFromDatePage(_calendarController.focusedDay),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyTableCalendar(
              initialDate: DateTime.now(),
              calendarController: _calendarController,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
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
