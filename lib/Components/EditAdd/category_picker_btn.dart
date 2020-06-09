import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:flutter/material.dart';

class CategoryPickerBtn extends StatelessWidget {
  // TODO rename vars
  final String categoryId;
  final Function onPressed;
  final double minWidth;
  final double height;
  final double iconSize;
  final double iconBottomPosition;
  final double borderRadiusSize;

  CategoryPickerBtn({
    @required this.categoryId,
    @required this.onPressed,
    this.minWidth = 100,
    this.height = 50,
    this.iconSize = 70,
    this.iconBottomPosition = -25,
    this.borderRadiusSize = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: minWidth,
      height: height,
      buttonColor: Theme.of(context).buttonColor,
      textTheme: ButtonTextTheme.primary,
      child: RaisedButton(
        highlightColor: DbModel.catMap[categoryId].color.withOpacity(0.2),
        splashColor: DbModel.catMap[categoryId].color.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusSize),
        ),
        onPressed: onPressed,
        child: SizedBox(
          width: minWidth,
          height: height,
          child: Stack(
            alignment: Alignment.center,
            overflow: Overflow.clip,
            children: <Widget>[
              Positioned(
                bottom: iconBottomPosition,
                child: Icon(
                  DbModel.catMap[categoryId].iconData,
                  color: DbModel.catMap[categoryId].color,
                  size: iconSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
