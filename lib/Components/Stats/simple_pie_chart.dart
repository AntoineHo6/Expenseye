import 'package:Expenseye/Providers/Global/theme_notifier.dart';
import 'package:Expenseye/Resources/Themes/my_theme_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: rename
class SimplePieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimplePieChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

    return new charts.PieChart(
      seriesList,
      animate: animate,
      // Add an [ArcLabelDecorator] configured to render labels outside of the
      // arc with a leader line.
      //
      // Text style for inside / outside can be controlled independently by
      // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
      //
      // Example configuring different styles for inside/outside:
      //       new charts.ArcLabelDecorator(
      //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
      //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
      defaultRenderer: new charts.ArcRendererConfig(
        arcRendererDecorators: [
          new charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.outside,
            outsideLabelStyleSpec: charts.TextStyleSpec(
              fontSize: 11,
              color: themeNotifier.getTheme() == MyThemeData.lightTheme
                  ? charts.MaterialPalette.black
                  : charts.MaterialPalette.white,
            ),
          )
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return charts.PieChart(seriesList, animate: animate);
  // }
}
