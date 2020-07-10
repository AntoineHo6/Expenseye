import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:flutter/material.dart';

class CategoryPickerBtn extends StatelessWidget {
  final String categoryId;
  final Function onPressed;
  final double width;
  final double height;
  final double iconSize;
  final double iconBottomPosition;
  final bool isInError;

  CategoryPickerBtn({
    @required this.onPressed,
    this.categoryId,
    this.width = 100,
    this.height = 50,
    this.iconSize = 70,
    this.iconBottomPosition = -25,
    this.isInError = false,
  });

  @override
  Widget build(BuildContext context) {
    Color highlightColor;
    Color splashColor;
    IconData iconData;
    Color iconColor;
    if (categoryId == null) {
      highlightColor = Theme.of(context).focusColor.withOpacity(0.2);
      splashColor = Theme.of(context).focusColor.withOpacity(0.2);
      iconData = Icons.category;
      iconColor = Theme.of(context).focusColor;
    } else {
      highlightColor = DbModel.catMap[categoryId].color.withOpacity(0.2);
      splashColor = DbModel.catMap[categoryId].color.withOpacity(0.2);
      iconData = DbModel.catMap[categoryId].iconData;
      iconColor = DbModel.catMap[categoryId].color;
    }

    return RaisedButton(
      highlightColor: highlightColor,
      splashColor: splashColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: isInError ? Theme.of(context).errorColor : Colors.transparent),
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
