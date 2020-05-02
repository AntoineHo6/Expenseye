import 'package:Expenseye/Models/Category.dart';
import 'package:flutter/material.dart';

class CategoryBtn extends StatelessWidget {
  final Category category;
  final Function onPressed;
  final Function onLongPress;

  CategoryBtn({@required this.category, this.onPressed, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onLongPress: onLongPress,
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            category.iconData,
            color: category.color,
            size: 35,
          ),
          const SizedBox(
            height: 10,
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              category.name,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
        ],
      ),
    );
  }
}
