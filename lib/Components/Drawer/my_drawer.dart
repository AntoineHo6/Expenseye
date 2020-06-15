import 'package:Expenseye/Components/Drawer/my_drawer_header.dart';
import 'package:Expenseye/Components/Global/local_notification.dart';
import 'package:Expenseye/Pages/Categories/cat_home_page.dart';
import 'package:Expenseye/Pages/Monthly/monthly_home_page.dart';
import 'package:Expenseye/Pages/Settings/settings_page.dart';
import 'package:Expenseye/Pages/Yearly/yearly_home_page.dart';
import 'package:Expenseye/Pages/RecurringItems/recurring_items_page.dart';
import 'package:Expenseye/Resources/Strings.dart';
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
              leading: const Icon(
                MdiIcons.calendarBlank,
              ),
              title: Text(AppLocalizations.of(context).translate('monthly')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openMonthlyPage(context);
              },
            ),
            ListTile(
              leading: const Icon(
                MdiIcons.calendarBlankMultiple,
              ),
              title: Text(AppLocalizations.of(context).translate('yearly')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openYearlyPage(context);
              },
            ),
            ListTile(
              leading: const Icon(
                MdiIcons.viewGrid,
              ),
              title: Text(AppLocalizations.of(context).translate('categories')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openCategoriesPage(context);
              },
            ),
            ListTile(
              leading: const Icon(
                MdiIcons.calendarClock,
              ),
              title: Text(
                  AppLocalizations.of(context).translate('recurringItems')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openRecurringItemsPage(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: Text(AppLocalizations.of(context).translate('settings')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openSettingsPage(context);
              },
            ),
            AboutListTile(
              icon: const Icon(Icons.info_outline),
              applicationName: 'Expenseye',
              applicationVersion: Strings.versionNumber,
              applicationLegalese:
                  '${AppLocalizations.of(context).translate('appBy')}\n\n${Strings.privacyLegalese}',
              applicationIcon: Image.asset(
                'assets/icon/icon.png',
                width: 40,
                height: 40,
                color: null,
              ),
            ),
            // TODO: temp
            ListTile(
              leading: const Icon(
                Icons.add_alert,
              ),
              title: Text('notifs'),
              onTap: () {
                Navigator.of(context).pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocalNotification(),
                  ),
                );
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
      MaterialPageRoute(
          builder: (context) => MonthlyHomePage(date: DateTime.now())),
    );
  }

  void _openYearlyPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => YearlyHomePage()),
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

  void _openSettingsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }
}
