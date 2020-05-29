import 'package:Expenseye/Components/Drawer/my_drawer_header.dart';
import 'package:Expenseye/Pages/Categories/cat_home_page.dart';
import 'package:Expenseye/Pages/Monthly/monthly_home_page.dart';
import 'package:Expenseye/Pages/Yearly/yearly_home_page.dart';
import 'package:Expenseye/Pages/about_page.dart';
import 'package:Expenseye/Pages/RecurrentItems/recurrent_items_page.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: MyColors.black00dp,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            MyDrawerHeader(),
            ListTile(
              leading: Icon(MdiIcons.calendarBlank, color: MyColors.secondary),
              title: Text(AppLocalizations.of(context).translate('monthly')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openMonthlyPage(context);
              },
            ),
            ListTile(
              leading:
                  Icon(MdiIcons.calendarBlankMultiple, color: MyColors.secondary),
              title: Text(AppLocalizations.of(context).translate('yearly')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openYearlyPage(context);
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.viewGrid, color: MyColors.secondary),
              title: Text(AppLocalizations.of(context).translate('categories')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openCategoriesPage(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.autorenew, color: MyColors.secondary),
              title: Text(
                  AppLocalizations.of(context).translate('recurrentItems')),
              onTap: () {
                Navigator.of(context).pop(context);
                _openRecurrentItemsPage(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: MyColors.secondary),
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

  // TODO: make these functions private
  void _openMonthlyPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MonthlyHomePage(DateTime.now())),
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

  void _openRecurrentItemsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecurrentItemsPage()),
    );
  }
}
