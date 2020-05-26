import 'package:Expenseye/Components/Drawer/my_drawer_header.dart';
import 'package:Expenseye/Pages/Categories/cat_home_page.dart';
import 'package:Expenseye/Pages/Monthly/monthly_home_page.dart';
import 'package:Expenseye/Pages/Yearly/yearly_home_page.dart';
import 'package:Expenseye/Pages/about_page.dart';
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
              leading: Icon(MdiIcons.calendarBlank, color: Colors.white),
                title: Text(AppLocalizations.of(context).translate('monthly')),
                onTap: () {
                  Navigator.of(context).pop(context);
                  openMonthlyPage(context);
                }),
            ListTile(
              leading: Icon(MdiIcons.calendarBlankMultiple, color: Colors.white),
              title: Text(AppLocalizations.of(context).translate('yearly')),
              onTap: () {
                Navigator.of(context).pop(context);
                openYearlyPage(context);
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.viewGrid, color: Colors.white),
                title: Text(AppLocalizations.of(context).translate('categories')),
                onTap: () {
                  Navigator.of(context).pop(context);
                  openCategoriesPage(context);
                }),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.white),
                title: Text(AppLocalizations.of(context).translate('about')),
                onTap: () {
                  Navigator.of(context).pop(context);
                  openAboutPage(context);
                }),
          ],
        ),
      ),
    );
  }

  void openMonthlyPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MonthlyHomePage(DateTime.now())),
    );
  }

  void openYearlyPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => YearlyHomePage()),
    );
  }

  void openAboutPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutPage()),
    );
  }

  void openCategoriesPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CatHomePage()),
    );
  }
}
