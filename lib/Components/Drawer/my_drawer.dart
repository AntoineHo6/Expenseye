import 'package:Expenseye/Components/Drawer/my_drawer_header.dart';
import 'package:Expenseye/Pages/Categories/cat_home_page.dart';
import 'package:Expenseye/Pages/Monthly/monthly_home_page.dart';
import 'package:Expenseye/Pages/Yearly/yearly_home_page.dart';
import 'package:Expenseye/Pages/about_page.dart';
import 'package:Expenseye/Pages/RecurringItems/recurring_items_page.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).backgroundColor,
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            MyDrawerHeader(),
            ListTile(
              leading: Icon(
                MdiIcons.calendarBlank,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(AppLocalizations.of(context).translate('monthly')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openMonthlyPage(context);
              },
            ),
            ListTile(
              leading: Icon(
                MdiIcons.calendarBlankMultiple,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(AppLocalizations.of(context).translate('yearly')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openYearlyPage(context);
              },
            ),
            ListTile(
              leading: Icon(
                MdiIcons.viewGrid,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(AppLocalizations.of(context).translate('categories')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openCategoriesPage(context);
              },
            ),
            ListTile(
              leading: Icon(
                MdiIcons.calendarClock,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                  AppLocalizations.of(context).translate('recurringItems')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openRecurringItemsPage(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(AppLocalizations.of(context).translate('about')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openAboutPage(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openMonthlyPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MonthlyHomePage(date: DateTime.now())),
    );
  }

  void _openYearlyPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => YearlyHomePage()),
    );
  }

  void _openAboutPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutPage()),
    );
  }

  void _openCategoriesPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CatHomePage()),
    );
  }

  void _openRecurringItemsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecurringItemsPage()),
    );
  }
}
