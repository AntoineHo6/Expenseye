import 'package:flutter/material.dart';

class TotalBox extends StatelessWidget {
  final String title;
  final String total;
  final Color textColor;

  TotalBox({
    @required this.title,
    @required this.total,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              FittedBox(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const SizedBox(height: 5),
              FittedBox(
                child: Text(
                  total,
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
