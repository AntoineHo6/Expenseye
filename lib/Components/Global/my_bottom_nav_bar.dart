import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class MyBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function onTap;

  MyBottomNavBar({@required this.currentIndex, this.onTap});

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedIconTheme: IconThemeData(color: Theme.of(context).indicatorColor),
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.list),
          title: Text(
            AppLocalizations.of(context).translate('transactions'),
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.pie_chart),
          title: Text(
            AppLocalizations.of(context).translate('stats'),
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
