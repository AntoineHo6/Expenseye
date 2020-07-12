import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AccountPickerBtn extends StatelessWidget {
  final String accountId;
  final Function onPressed;
  final double width;
  final double height;
  final double iconSize;
  final double spaceBetweenSize;
  final double fontSize;

  AccountPickerBtn({
    @required this.onPressed,
    @required this.accountId,
    this.width = 100,
    this.height = 50,
    this.iconSize = 20,
    this.fontSize = 15,
    this.spaceBetweenSize = 8,
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
              MdiIcons.wallet,
              size: iconSize,
            ),
            SizedBox(
              width: spaceBetweenSize,
            ),
            Text(
              DbNotifier.accMap[accountId].name,
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
