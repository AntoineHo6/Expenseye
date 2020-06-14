import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

// TODO: rename
class SimplePieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimplePieChart(this.seriesList, {this.animate});

  // @override
  // Widget build(BuildContext context) {
  //   return new charts.PieChart(
  //     seriesList,
  //     animate: animate,
  //     // Add an [ArcLabelDecorator] configured to render labels outside of the
  //     // arc with a leader line.
  //     //
  //     // Text style for inside / outside can be controlled independently by
  //     // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
  //     //
  //     // Example configuring different styles for inside/outside:
  //     //       new charts.ArcLabelDecorator(
  //     //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
  //     //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
  //     defaultRenderer: new charts.ArcRendererConfig(
  //       arcRendererDecorators: [
  //         new charts.ArcLabelDecorator(
  //           labelPosition: charts.ArcLabelPosition.outside,
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(seriesList, animate: animate);
  }
}
