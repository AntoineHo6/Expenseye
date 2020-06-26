import 'package:Expenseye/Enums/periodicity.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PeriodicityPickerBtn extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double height;
  final Periodicity periodicity;
  final double spaceBetweenSize;
  final double fontSize;
  final double iconSize;

  PeriodicityPickerBtn({
    @required this.onPressed,
    this.width = 100,
    this.height = 80,
    this.spaceBetweenSize = 8,
    this.periodicity,
    this.fontSize = 15,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              MdiIcons.calendarClock,
              size: iconSize,
            ),
            SizedBox(
              width: spaceBetweenSize,
            ),
            Text(
              PeriodicityHelper.getString(context, periodicity),
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
