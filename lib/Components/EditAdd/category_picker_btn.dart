import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:flutter/material.dart';

class CategoryPickerBtn extends StatelessWidget {
  final String categoryId;
  final Function onPressed;
  final double width;
  final double height;
  final double iconSize;
  final double iconBottomPosition;
  final Color borderSideColor;

  CategoryPickerBtn({
    @required this.onPressed,
    this.categoryId,
    this.width = 100,
    this.height = 50,
    this.iconSize = 70,
    this.iconBottomPosition = -25,
    this.borderSideColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    Color highlightColor;
    Color splashColor;
    IconData iconData;
    Color iconColor;
    if (categoryId == null) {
      highlightColor = Colors.transparent;
      splashColor = Colors.white.withOpacity(0.1);
      iconData = Icons.add;
      iconColor = Colors.white;
    } 
    else {
      highlightColor = DbModel.catMap[categoryId].color.withOpacity(0.1);
      splashColor = DbModel.catMap[categoryId].color.withOpacity(0.1);
      iconData = DbModel.catMap[categoryId].iconData;
      iconColor = DbModel.catMap[categoryId].color;
    }

    return RaisedButton(
      highlightColor: highlightColor,
      splashColor: splashColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderSideColor),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          overflow: Overflow.clip,
          children: <Widget>[
            Positioned(
              bottom: iconBottomPosition,
              child: Icon(
                iconData,
                color: iconColor,
                size: iconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
