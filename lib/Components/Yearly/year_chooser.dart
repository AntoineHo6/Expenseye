import 'package:Expenseye/Providers/yearly_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearChooser extends StatefulWidget {
  @override
  _YearChooserState createState() => _YearChooserState();
}

class _YearChooserState extends State<YearChooser> {
  @override
  Widget build(BuildContext context) {
    final _yearlyModel = Provider.of<YearlyModel>(context);

    return Row(
      children: <Widget>[
        RaisedButton(
          textColor: Theme.of(context).textTheme.bodyText1.color,
          onPressed: () => _yearlyModel.decrementYear(),
          child: const Icon(Icons.chevron_left),
          shape: const CircleBorder(
            side: const BorderSide(color: Colors.transparent),
          ),
          elevation: 2,
        ),
        Text(
          _yearlyModel.year,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        RaisedButton(
          textColor: Theme.of(context).textTheme.bodyText1.color,
          onPressed: () => _yearlyModel.incrementYear(),
          child: const Icon(Icons.chevron_right),
          shape: const CircleBorder(
            side: const BorderSide(color: Colors.transparent),
          ),
          elevation: 2,
        ),
      ],
    );
  }
}
